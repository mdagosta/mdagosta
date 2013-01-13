import XMonad
import XMonad hiding (Tall)
import XMonad.Layout.LayoutHints
import XMonad.Layout.HintedTile
import Data.Bits ((.|.))
import System.Exit
import qualified Data.Map as M
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig
import XMonad.Util.CustomKeys
import XMonad.Util.Run
import XMonad.Actions.UpdatePointer

main = xmonad $ defaultConfig {
  borderWidth        = 2,
  terminal           = "aterm +sb -sl 50000",
  normalBorderColor  = "#cccccc",
  focusedBorderColor = "#cd8b00",
  focusFollowsMouse = True,
  logHook = updatePointer Nearest,
  layoutHook = myLayout,
  keys = customKeys delkeys inskeys}

  where
    delkeys :: XConfig l -> [(KeyMask, KeySym)]
    delkeys XConfig {modMask = modm} = 
      [ 
        (modm, xK_period),
        (modm, xK_q),
        (modm .|. shiftMask, xK_5),
        (modm, xK_l) 
      ] ++
      [ (modm .|. m, k) | (m, k) <- zip [0, shiftMask] [xK_w, xK_e, xK_r] ]

    inskeys :: XConfig l -> [((KeyMask, KeySym), X ())]
    inskeys conf@(XConfig {modMask = modm}) = 
      [
        ((mod1Mask .|. controlMask, xK_e), spawn "emacs"),
        ((mod1Mask .|. controlMask, xK_x), spawn "xemacs"),
        ((mod1Mask .|. controlMask, xK_f), spawn "firefox"),
        ((mod1Mask .|. controlMask, xK_g), spawn "google-chrome"),
        ((mod1Mask .|. controlMask, xK_l), spawn "gnome-screensaver-command -l"),
        ((modm .|. controlMask, xK_q), broadcastMessage ReleaseResources >> restart "xmonad" True),
        ((modm .|. controlMask, xK_comma), sendMessage (IncMasterN (-1))),
        ((modm, xK_j), sendMessage Expand)
      ]

myLayout = hintedTile XMonad.Layout.HintedTile.Tall ||| hintedTile XMonad.Layout.HintedTile.Wide ||| Full
   where
      hintedTile = HintedTile nmaster delta ratio TopLeft
      nmaster    = 1
      ratio      = 1/2
      delta      = 3/100
