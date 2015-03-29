Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49078 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752388AbbC2NhB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 29 Mar 2015 09:37:01 -0400
Date: Sun, 29 Mar 2015 15:36:55 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 00/86] pci: export pci_ids.h and related cleanups
Message-ID: <1427635734-24786-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The macros in pci_ids.h are pretty useful for userspace
using the pci sysfs interface, e.g. to decode class
device and vendor sysfs files.

At the moment userspace is forced to duplicate these macros (e.g. QEMU does
this, so does gpxe, seabios, etc), it is better to export them in
/usr/include/linux/pci_ids.h so everyone can just include this header.

This patchset is structured as follows:
1. include/linux/pci_ids.h is moved to include/uapi/linux/pci_ids.h;
   a stub file is created in include/linux/pci_ids.h to avoid breaking
   bisect
2. all users are converted to use the new header
3. include/linux/pci_ids.h is removed
4. cleanups for several issues detected during step 2

The patchset was built on several architectures (mips/ppc/x86),
boot-tested on x86 only - build seems sufficient for this kind of
change.

I think the pci tree is the most appropriate for this patchset.
Please review it, and consider for 4.1.

Michael S. Tsirkin (86):
  pci: export pci_ids.h
  i2c/i801: linux/pci_ids.h -> uapi/linux/pci_ids.h
  mips/netlogic: use uapi/linux/pci_ids.h directly
  powerpc/pci: use uapi/linux/pci_ids.h directly
  x86/gart: use uapi/linux/pci_ids.h directly
  x86/microcode/amd: use uapi/linux/pci_ids.h directly
  x86/quirks: use uapi/linux/pci_ids.h directly
  x86/printk: use uapi/linux/pci_ids.h directly
  x86/calgary: use uapi/linux/pci_ids.h directly
  x86/apic/vsmp: use uapi/linux/pci_ids.h directly
  x86/mm/numa: use uapi/linux/pci_ids.h directly
  x86/pci/sta2x11: use uapi/linux/pci_ids.h directly
  acpi/video: use uapi/linux/pci_ids.h directly
  crypto/ccp: use uapi/linux/pci_ids.h directly
  crypto/geode: use uapi/linux/pci_ids.h directly
  dmaengine: use uapi/linux/pci_ids.h directly
  dma/ioat: use uapi/linux/pci_ids.h directly
  edac/amd: use uapi/linux/pci_ids.h directly
  edac/e7xxx: use uapi/linux/pci_ids.h directly
  edac/e752x: use uapi/linux/pci_ids.h directly
  edac/i3000: use uapi/linux/pci_ids.h directly
  edac/i3200: use uapi/linux/pci_ids.h directly
  edac/i5000: use uapi/linux/pci_ids.h directly
  edac/i5100: use uapi/linux/pci_ids.h directly
  edac/i5400: use uapi/linux/pci_ids.h directly
  edac/i7300: use uapi/linux/pci_ids.h directly
  edac/i7core: use uapi/linux/pci_ids.h directly
  edac/i82443bxgx: use uapi/linux/pci_ids.h directly
  edac/i82860: use uapi/linux/pci_ids.h directly
  edac/i82875p: use uapi/linux/pci_ids.h directly
  edac/i82975x: use uapi/linux/pci_ids.h directly
  edac/ie31200: use uapi/linux/pci_ids.h directly
  edac/pasemi: use uapi/linux/pci_ids.h directly
  edac/r82600: use uapi/linux/pci_ids.h directly
  edac/sbridge: use uapi/linux/pci_ids.h directly
  edac/x38_edac: use uapi/linux/pci_ids.h directly
  firewire/ohci: use uapi/linux/pci_ids.h directly
  gpio/sch: use uapi/linux/pci_ids.h directly
  i2c/i801: use uapi/linux/pci_ids.h directly
  ide/generic: use uapi/linux/pci_ids.h directly
  input/keyboard: use uapi/linux/pci_ids.h directly
  input/serio: use uapi/linux/pci_ids.h directly
  macintosh: use uapi/linux/pci_ids.h directly
  media/ddbridge: use uapi/linux/pci_ids.h directly
  media/ngene: use uapi/linux/pci_ids.h directly
  media/fintek: use uapi/linux/pci_ids.h directly
  media/ite: use uapi/linux/pci_ids.h directly
  media/nuvoton: use uapi/linux/pci_ids.h directly
  media/winbond: use uapi/linux/pci_ids.h directly
  memstick/r592: use uapi/linux/pci_ids.h directly
  cxl: use uapi/linux/pci_ids.h directly
  mtd/maps: use uapi/linux/pci_ids.h directly
  mtd/nand: use uapi/linux/pci_ids.h directly
  atheros/atlx: use uapi/linux/pci_ids.h directly
  chelsio/cxgb: use uapi/linux/pci_ids.h directly
  intel/ixgb: use uapi/linux/pci_ids.h directly
  brcm80211: use uapi/linux/pci_ids.h directly
  pci-label: use uapi/linux/pci_ids.h directly
  x86/thinkpad_acpi: use uapi/linux/pci_ids.h directly
  scsi/arcmsr: use uapi/linux/pci_ids.h directly
  scsi/qla1280: use uapi/linux/pci_ids.h directly
  staging/comedi: use uapi/linux/pci_ids.h directly
  staging/olpc: use uapi/linux/pci_ids.h directly
  tty/serial: comment update
  usb/dwc3: comment update
  usb/early: use uapi/linux/pci_ids.h directly
  usb/gadget: use uapi/linux/pci_ids.h directly
  usb/host: use uapi/linux/pci_ids.h directly
  usb/misc: use uapi/linux/pci_ids.h directly
  fbdev/gxt4500: use uapi/linux/pci_ids.h directly
  fbdev/i740fb: use uapi/linux/pci_ids.h directly
  fbdev/i810: use uapi/linux/pci_ids.h directly
  fbdev/riva: use uapi/linux/pci_ids.h directly
  w1: use uapi/linux/pci_ids.h directly
  watchdog: use uapi/linux/pci_ids.h directly
  sound/pci: use uapi/linux/pci_ids.h directly
  linux/pci: use uapi/linux/pci_ids.h directly
  linux/pci: drop include/linux/pci_ids.h
  x86/microcode/amd: drop pci_ids dependency
  crypto/ccp: drop linux/pci dependencies
  input/serio: drop pci_ids dependency
  media/fintek: drop pci_ids dependency
  brcm80211: drop pci dependency
  brcm80211: drop pci_ids include
  staging/olpc: drop pci dependencies
  usb/dwc3: move ids to pci_ids.h

 arch/powerpc/platforms/embedded6xx/mpc10x.h          |  4 ++--
 drivers/dma/intel_mid_dma_regs.h                     |  2 +-
 drivers/dma/ioat/dma.h                               |  2 +-
 drivers/edac/amd64_edac.h                            |  2 +-
 drivers/net/ethernet/chelsio/cxgb/common.h           |  2 +-
 drivers/net/wireless/brcm80211/include/brcm_hw_ids.h |  2 +-
 drivers/staging/comedi/comedidev.h                   |  2 +-
 include/linux/pci.h                                  |  2 +-
 include/{ => uapi}/linux/pci_ids.h                   |  8 ++++++++
 arch/mips/netlogic/xlp/ahci-init-xlp2.c              |  2 +-
 arch/mips/netlogic/xlp/usb-init-xlp2.c               |  2 +-
 arch/x86/kernel/aperture_64.c                        |  2 +-
 arch/x86/kernel/cpu/microcode/amd.c                  |  1 -
 arch/x86/kernel/early-quirks.c                       |  2 +-
 arch/x86/kernel/early_printk.c                       |  2 +-
 arch/x86/kernel/pci-calgary_64.c                     |  2 +-
 arch/x86/kernel/vsmp_64.c                            |  2 +-
 arch/x86/mm/amdtopology.c                            |  2 +-
 arch/x86/pci/sta2x11-fixup.c                         |  2 +-
 drivers/acpi/video.c                                 |  2 +-
 drivers/crypto/ccp/ccp-ops.c                         |  2 --
 drivers/crypto/ccp/ccp-pci.c                         |  2 +-
 drivers/crypto/geode-aes.c                           |  2 +-
 drivers/edac/amd76x_edac.c                           |  2 +-
 drivers/edac/amd8111_edac.c                          |  2 +-
 drivers/edac/amd8131_edac.c                          |  2 +-
 drivers/edac/e752x_edac.c                            |  2 +-
 drivers/edac/e7xxx_edac.c                            |  2 +-
 drivers/edac/i3000_edac.c                            |  2 +-
 drivers/edac/i3200_edac.c                            |  2 +-
 drivers/edac/i5000_edac.c                            |  2 +-
 drivers/edac/i5100_edac.c                            |  2 +-
 drivers/edac/i5400_edac.c                            |  2 +-
 drivers/edac/i7300_edac.c                            |  2 +-
 drivers/edac/i7core_edac.c                           |  2 +-
 drivers/edac/i82443bxgx_edac.c                       |  2 +-
 drivers/edac/i82860_edac.c                           |  2 +-
 drivers/edac/i82875p_edac.c                          |  2 +-
 drivers/edac/i82975x_edac.c                          |  2 +-
 drivers/edac/ie31200_edac.c                          |  2 +-
 drivers/edac/pasemi_edac.c                           |  2 +-
 drivers/edac/r82600_edac.c                           |  2 +-
 drivers/edac/sb_edac.c                               |  2 +-
 drivers/edac/x38_edac.c                              |  2 +-
 drivers/firewire/ohci.c                              |  2 +-
 drivers/gpio/gpio-sch.c                              |  2 +-
 drivers/i2c/busses/i2c-i801.c                        |  2 +-
 drivers/ide/ide-generic.c                            |  2 +-
 drivers/input/keyboard/hil_kbd.c                     |  2 +-
 drivers/input/keyboard/hilkbd.c                      |  2 +-
 drivers/input/serio/gscps2.c                         |  1 -
 drivers/macintosh/macio_asic.c                       |  2 +-
 drivers/media/pci/ddbridge/ddbridge-core.c           |  2 +-
 drivers/media/pci/ngene/ngene-cards.c                |  2 +-
 drivers/media/pci/ngene/ngene-i2c.c                  |  2 +-
 drivers/media/rc/fintek-cir.c                        |  1 -
 drivers/media/rc/ite-cir.c                           |  2 +-
 drivers/media/rc/nuvoton-cir.c                       |  2 +-
 drivers/media/rc/winbond-cir.c                       |  2 +-
 drivers/memstick/host/r592.c                         |  2 +-
 drivers/misc/cxl/pci.c                               |  2 +-
 drivers/mtd/maps/amd76xrom.c                         |  2 +-
 drivers/mtd/maps/ck804xrom.c                         |  2 +-
 drivers/mtd/maps/esb2rom.c                           |  2 +-
 drivers/mtd/maps/ichxrom.c                           |  2 +-
 drivers/mtd/maps/scb2_flash.c                        |  2 +-
 drivers/mtd/nand/r852.c                              |  2 +-
 drivers/net/ethernet/atheros/atlx/atl1.c             |  2 +-
 drivers/net/ethernet/atheros/atlx/atl2.c             |  2 +-
 drivers/net/ethernet/intel/ixgb/ixgb_hw.c            |  2 +-
 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c     |  2 --
 drivers/net/wireless/brcm80211/brcmfmac/sdio.c       |  1 -
 drivers/net/wireless/brcm80211/brcmsmac/main.c       |  2 +-
 drivers/pci/pci-label.c                              |  2 +-
 drivers/platform/x86/thinkpad_acpi.c                 |  2 +-
 drivers/scsi/arcmsr/arcmsr_hba.c                     |  2 +-
 drivers/scsi/qla1280.c                               |  2 +-
 drivers/staging/olpc_dcon/olpc_dcon.c                |  2 --
 drivers/tty/serial/8250/8250_pci.c                   |  2 +-
 drivers/usb/dwc3/dwc3-pci.c                          | 10 +---------
 drivers/usb/early/ehci-dbgp.c                        |  2 +-
 drivers/usb/gadget/udc/bdc/bdc_pci.c                 |  2 +-
 drivers/usb/host/u132-hcd.c                          |  2 +-
 drivers/usb/misc/ftdi-elan.c                         |  2 +-
 drivers/video/fbdev/gxt4500.c                        |  2 +-
 drivers/video/fbdev/i740fb.c                         |  2 +-
 drivers/video/fbdev/i810/i810_main.c                 |  2 +-
 drivers/video/fbdev/riva/nv_driver.c                 |  2 +-
 drivers/video/fbdev/riva/riva_hw.c                   |  2 +-
 drivers/w1/masters/matrox_w1.c                       |  2 +-
 drivers/watchdog/hpwdt.c                             |  2 +-
 sound/pci/ctxfi/xfi.c                                |  2 +-
 Documentation/PCI/pci.txt                            |  4 ++--
 Documentation/i2c/busses/i2c-i801                    |  2 +-
 include/uapi/linux/Kbuild                            |  1 +
 95 files changed, 97 insertions(+), 106 deletions(-)
 rename include/{ => uapi}/linux/pci_ids.h (99%)

-- 
MST

