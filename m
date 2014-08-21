Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hygieia.santi-shop.eu ([78.46.175.2]:60376 "EHLO
	hygieia.santi-shop.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754103AbaHUVel convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 21 Aug 2014 17:34:41 -0400
Date: Thu, 21 Aug 2014 23:34:35 +0200
From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
To: Andreas Noever <andreas.noever@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: DRI mailing list <dri-devel@lists.freedesktop.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Dave Airlie <airlied@linux.ie>,
	Matthew Garrett <matthew.garrett@nebula.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/2] x86, ia64: Move EFI_FB vga_default_device()
 initialization to pci_vga_fixup()
Message-ID: <20140821233435.19a9cffa@neptune.home>
In-Reply-To: <CAMxnaaUodONkqmdPWedN-Q1qheHiJAScFcG_XbX1--ZmiOQZDg@mail.gmail.com>
References: <20140514224339.7f8be3a9@neptune.home>
	<20140527234255.GJ11907@google.com>
	<20140602201650.35f0e936@neptune.home>
	<20140602201926.4d476818@neptune.home>
	<20140625005501.7ff7e982@neptune.home>
	<20140705171503.GC6247@google.com>
	<CAMxnaaXxAZAJAdr5AYYRZC_xKFCuyrfY=qpJu8x+P-S+osm5vw@mail.gmail.com>
	<CAMxnaaXGQe4vg9cY5e2KZBnG4F-z49OriwxEGUE-DCE6MKUryQ@mail.gmail.com>
	<20140810112654.1bf684d6@neptune.home>
	<CAMxnaaUsd+XHppMmPMXdFL13d1-OhLzoH_yjv_9abOx_uP=_Ug@mail.gmail.com>
	<20140810183411.19370721@neptune.home>
	<CAMxnaaVNpiSZmhQsHa_ZHJckgzG+xHyOL6hOT3Ts8GdcGN_A9g@mail.gmail.com>
	<20140816192135.34260115@neptune.home>
	<CAMxnaaWQoX9KMQVCKHTkeqSxGEybz5u1qU6AVBqzW3+mj_nJHQ@mail.gmail.com>
	<20140820075508.74f5b622@pluto>
	<20140820091152.76cd4e1a@pluto>
	<CAMxnaaUodONkqmdPWedN-Q1qheHiJAScFcG_XbX1--ZmiOQZDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 21 August 2014 Andreas Noever <andreas.noever@gmail.com> wrote:
> dmesg with your patches and vga_set_default_device commented out
> (after "vgaarb: Boot video device...") as otherwise the system won't
> boot.

Do you know more precisely where your system hangs when it does not boot?
That's the part I can't find in this thread.
Is it dead-locking/freezing or just booting without displaying anything
(though network coming up if connected, keyboard working (e.g. caps key).

Try blacklisting both i915 and nouveau modules (and each one individually)
an see how far your system gets. Also make sure your network comes up
automatically, so that even if display remains black you can check via
network if your system is alive and what it complains about.

> dmesg | grep vgaarb
> [    1.340118] vgaarb: PCI:0000:00:02.0 PCI_COMMAND=0007
> [    1.340119] vgaarb: Boot video device: PCI:0000:00:02.0
> [    1.340120] vgaarb: device added:
> PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
> [    1.340130] vgaarb: PCI:0000:01:00.0 PCI_COMMAND=0006
> [    1.340132] vgaarb: PCI:0000:01:00.0, bridge PCI:0000:00:01.0
> PCI_BRIDGE_CONTROL=0000
> [    1.340133] vgaarb: device added:
> PCI:0000:01:00.0,decodes=io+mem,owns=none,locks=none
> [    1.340135] vgaarb: loaded
> [    1.340136] vgaarb: bridge control possible 0000:01:00.0
> [    1.340136] vgaarb: no bridge control possible 0000:00:02.0
> [    3.798430] vgaarb: device changed decodes:
> PCI:0000:00:02.0,olddecodes=io+mem,decodes=none:owns=io+mem
> 
> 
> If the line is not commented out then vgaarb simply declares the first
> (enabled) device to be the default one, which is incorrect. And the
> overwrite logic in pci_fixup_video is not triggered, since a default
> device has already been set.

The initial selection I am doing does match the PCI_COMMAND flags
as set for the devices (or masked by parent bridge), but probably none
of them has active legacy VGA I/O ports.
So the question would rather be how to determine which I/O port is active
for the Intel graphics and adjust vgaarb's "decodes"/owns interpretation
on that basis (there is no I/O active for the nvidia one).
I'm thinking about selecting only device that decodes the legacy VGA I/O
range and not those with any some other I/O range.

The short-term fix probably is to just unconditionally perform the
screen_info check in pci_fixup_video() while leaving vgaarb's initial
card selection alone for legacy hardware. Thus replicating efifb's
original behavior (and also get back incorrect ROM_SHADOW flagging).
Corresponding patch below (on top of both patches in this series, but
should apply without them as well). As mentioned in the patch this
papers over the real issue.


A second step would then be to tune vgaarb's initial selection.
Bjorn, is it possible to verify which I/O ports are decoded by a PCI
device at the time of adding it to vgaarb? If so, how? I would like to
check for legacy VGA I/O range (0x03B0-0x03DF) and only let vgaarb set
a device as default if that I/O range is decoded by the device.

Bruno



> On Wed, Aug 20, 2014 at 9:11 AM, Bruno Prémont wrote:
> > On Wed, 20 Aug 2014 07:55:08 +0200 Bruno Prémont wrote:
> >> On Tue, 19 Aug 2014 17:45:00 +0200 Andreas Noever wrote:
> >> > On Sat, Aug 16, 2014 at 7:21 PM, Bruno Prémont wrote:
> >> > > This series improves on commit 20cde694027e (x86, ia64: Move EFI_FB
> >> > > vga_default_device() initialization to pci_vga_fixup()):
> >> > > - cleanup remaining but always-true #ifndefs
> >> > > - fix boot regression on dual-GPU Macs
> >> > >
> >> > > Andreas, can you please test this series? It is a modification from
> >> > > previous testing patch that should still work fine for you.
> >> > > That testing patch would have been failing X startup on old BIOS systems
> >> > > booted with vga=normal (or otherwise in VGA text mode).
> >> > >
> >> > >
> >> > > Greg, in case you have scheduled above-mentioned commit for your next
> >> > > stable iteration, please hold it back in the queue until this follow-up
> >> > > has landed and can be included within the same stable update as alone
> >> > > that patch regresses for Macs with dual-GPU and using efifb.
> >> > >
> >> > > Bruno
> >> >
> >> > Fails again (with and without efifb).
> >> >
> >> > The vga_set_default_device in vga_arbiter_add_pci_device is at fault.
> >> > It sets the boot video device to intel. Removing it makes the system
> >> > bootable again.
> >>
> >> Could you provide your whole kernel log? I would like to understand
> >> how your vga devices are setup and why it starts the wrong way.
> >>
> >> If you can grab kernel log from both working and failing setups it
> >> would be even better. The failing one is interesting for where exactly it
> >> starts failing at boot.
> >
> > While collecting debug logs, please apply following patch to get
> > PCI command and bridge control registers as configured when vgaarb looks
> > at them.

From: Bruno Prémont <bonbons@linux-vserver.org>
Subject: [PATCH] x86: Force selection of vga_default_device on screen_info

Apple dual-GPU systems get the wrong GPU choosen by vgaarb because the
built-in Intel GPU has I/O ports active and no bridge in front that
would block legacy VGA I/O ports. (though no legacy VGA is setup)

The wrong initial selection prevents system from booting properly.

The proper solution would be to improve vgaarb's initial device
selection. Until that has been done return to behavior that efifb
implemented before the move to pci_fixup_video.

The draw-back of this old operation mode is that a wrong device
gets the IORESOURCE_ROM_SHADOW flag set.

Signed-off-by: Bruno Prémont <bonbons@linux-vserver.org>
CC: Matthew Garrett <matthew.garrett@nebula.com>
CC: stable@vger.kernel.org # v3.5+
---
 arch/x86/pci/fixup.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index 5b392d2..fc509d5 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -326,7 +326,10 @@ static void pci_fixup_video(struct pci_dev *pdev)
 	struct pci_bus *bus;
 	u16 config;
 
-	if (!vga_default_device()) {
+	if (!vga_default_device() || 1) {
+		/* The `|| 1` condition papers over vgaarb initial GPU selection limitation
+		 * on Apple dual-GPU systems using EFI.
+		 */
 		resource_size_t start, end;
 		int i;
 
-- 
1.8.5.5

