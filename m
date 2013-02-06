Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:41923 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751707Ab3BFPtP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 Feb 2013 10:49:15 -0500
Received: by mail-pa0-f43.google.com with SMTP id bh2so898948pad.30
        for <linux-pci@vger.kernel.org>; Wed, 06 Feb 2013 07:49:15 -0800 (PST)
Date: Wed, 6 Feb 2013 07:49:00 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	iommu@lists.linux-foundation.org
Subject: Re: PCI warning on boot 3.8.0-rc1
Message-ID: <20130206074900.02f04e3f@nehalam.linuxnetplumber.net>
In-Reply-To: <1360017684.11144.547.camel@bling.home>
References: <20130116143853.339dd89b@nehalam.linuxnetplumber.net>
	<CAErSpo5eOE_=Ob2jN7ACy0eJBOa8k36XqCbHnGTCs-wfiy8tiw@mail.gmail.com>
	<20130204103645.38ae2d5e@nehalam.linuxnetplumber.net>
	<1360009684.11144.539.camel@bling.home>
	<1360017684.11144.547.camel@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 04 Feb 2013 15:41:24 -0700
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Mon, 2013-02-04 at 13:28 -0700, Alex Williamson wrote:
> > On Mon, 2013-02-04 at 10:36 -0800, Stephen Hemminger wrote:
> > > > I think drivers/pci/search.c is identical between 3.7 and 3.8-rc1.  Is
> > > > this the first time you've turned on the IOMMU on that box?
> > > 
> > > It exists in 3.7 and earlier kernels, just haven't turned on same config.
> > > 
> > > > It's the same warning as in this bugzilla:
> > > > https://bugzilla.kernel.org/show_bug.cgi?id=44881, and there's a patch
> > > > there at https://bugzilla.kernel.org/show_bug.cgi?id=44881#c11, but
> > > > it's just a quirk that turns off VT-d if we find certain broken
> > > > bridges.  It doesn't look like you have any of those (although I don't
> > > > know what you have at 05:00.0).
> > > > 
> > > > Bjorn
> > > 
> > > This is a standard ASUS motherboard, and don't want to disable VT-d.
> > 
> > Stephen,
> > 
> > Can you give the lspci -vvv of device 5:00.0 to see if it's one we've
> > seen before?  Does the patch below help?
> > 
> > Bjorn, I think we need to quirk it somehow.  So far they've all been
> > PCI-to-PCI bridges attached to root ports where we expect it's actually
> > a PCIe-to-PCI bridge.  Seems like maybe we could have the same attached
> > to a downstream port.  The patch below avoids the WARN and gives us a
> > device, but of course pci_is_pcie reports wrong for this device and may
> > cause some trickle down breakage.  A more complete option might be to
> > add a is_pcie flag to the device that can be set independent of
> > pcie_cap.  We'd need to check all the callers for assumptions, but then
> > we could put the quirk in one place and hopefully fix everything.
> > Thoughts?  Thanks,
> 
> This latter approach seems like it might be easier than I expected since
> all the users are so well filtered through the access functions.  A
> quick look through who uses pci_is_pcie seems like this might be
> complete, but more eyes are required.  I'll upload this to the bz for
> those reporters to test as well.  Thoughts?  Thanks,
> 
> Alex

On my hardware this gives:
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.8.0-rc6+ (shemminger@nehalam) (gcc version 4.7.2 (Debian 4.7.2-5) ) #3 SMP Tue Feb 5 20:34:31 PST 2013
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-3.8.0-rc6+ root=UUID=1772a2c4-c197-4b0a-84dd-9982243242b7 ro quiet pci=assign-busses
...
[    0.226369] ACPI: No dock devices found.
[    0.226373] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.226734] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3e])
[    0.226737] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.227337] pci_root PNP0A08:00: Requesting ACPI _OSC control (0x1d)
[    0.227688] pci_root PNP0A08:00: ACPI _OSC control (0x18) granted
[    0.229268] PCI host bridge to bus 0000:00
[    0.229271] pci_bus 0000:00: root bus resource [bus 00-3e]
[    0.229273] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7]
[    0.229275] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff]
[    0.229276] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff]
[    0.229278] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000d3fff]
[    0.229280] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x000d7fff]
[    0.229281] pci_bus 0000:00: root bus resource [mem 0x000d8000-0x000dbfff]
[    0.229283] pci_bus 0000:00: root bus resource [mem 0x000dc000-0x000dffff]
[    0.229286] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000e3fff]
[    0.229287] pci_bus 0000:00: root bus resource [mem 0x000e4000-0x000e7fff]
[    0.229289] pci_bus 0000:00: root bus resource [mem 0xdf200000-0xfeafffff]
[    0.229316] pci 0000:00:00.0: [8086:0150] type 00 class 0x060000
[    0.229386] pci 0000:00:01.0: [8086:0151] type 01 class 0x060400
[    0.229427] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.229470] pci 0000:00:02.0: [8086:0162] type 00 class 0x030000
[    0.229482] pci 0000:00:02.0: reg 10: [mem 0xf7800000-0xf7bfffff 64bit]
[    0.229490] pci 0000:00:02.0: reg 18: [mem 0xe0000000-0xefffffff 64bit pref]
[    0.229495] pci 0000:00:02.0: reg 20: [io  0xf000-0xf03f]
[    0.229560] pci 0000:00:14.0: [8086:1e31] type 00 class 0x0c0330
[    0.229584] pci 0000:00:14.0: reg 10: [mem 0xf7d00000-0xf7d0ffff 64bit]
[    0.229667] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.229693] pci 0000:00:16.0: [8086:1e3a] type 00 class 0x078000
[    0.229719] pci 0000:00:16.0: reg 10: [mem 0xf7d1a000-0xf7d1a00f 64bit]
[    0.229805] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    0.229844] pci 0000:00:1a.0: [8086:1e2d] type 00 class 0x0c0320
[    0.229868] pci 0000:00:1a.0: reg 10: [mem 0xf7d18000-0xf7d183ff]
[    0.229972] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    0.230002] pci 0000:00:1b.0: [8086:1e20] type 00 class 0x040300
[    0.230018] pci 0000:00:1b.0: reg 10: [mem 0xf7d10000-0xf7d13fff 64bit]
[    0.230098] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.230126] pci 0000:00:1c.0: [8086:1e10] type 01 class 0x060400
[    0.230217] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.230250] pci 0000:00:1c.4: [8086:1e18] type 01 class 0x060400
[    0.230340] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.230370] pci 0000:00:1c.5: [8086:244e] type 01 class 0x060401
[    0.230461] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
[    0.230498] pci 0000:00:1d.0: [8086:1e26] type 00 class 0x0c0320
[    0.230525] pci 0000:00:1d.0: reg 10: [mem 0xf7d17000-0xf7d173ff]
[    0.230629] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.230659] pci 0000:00:1f.0: [8086:1e44] type 00 class 0x060100
[    0.230799] pci 0000:00:1f.2: [8086:1e02] type 00 class 0x010601
[    0.230820] pci 0000:00:1f.2: reg 10: [io  0xf0b0-0xf0b7]
[    0.230828] pci 0000:00:1f.2: reg 14: [io  0xf0a0-0xf0a3]
[    0.230837] pci 0000:00:1f.2: reg 18: [io  0xf090-0xf097]
[    0.230845] pci 0000:00:1f.2: reg 1c: [io  0xf080-0xf083]
[    0.230853] pci 0000:00:1f.2: reg 20: [io  0xf060-0xf07f]
[    0.230862] pci 0000:00:1f.2: reg 24: [mem 0xf7d16000-0xf7d167ff]
[    0.230915] pci 0000:00:1f.2: PME# supported from D3hot
[    0.230936] pci 0000:00:1f.3: [8086:1e22] type 00 class 0x0c0500
[    0.230952] pci 0000:00:1f.3: reg 10: [mem 0xf7d15000-0xf7d150ff 64bit]
[    0.230976] pci 0000:00:1f.3: reg 20: [io  0xf040-0xf05f]
[    0.231054] pci_bus 0000:01: busn_res: can not insert [bus 01-ff] under [bus 00-3e] (conflicts with (null) [bus 00-3e])
[    0.231071] pci 0000:01:00.0: [8086:1528] type 00 class 0x020000
[    0.231084] pci 0000:01:00.0: reg 10: [mem 0xf0000000-0xf01fffff 64bit pref]
[    0.231108] pci 0000:01:00.0: reg 20: [mem 0xf0200000-0xf0203fff 64bit pref]
[    0.231115] pci 0000:01:00.0: reg 30: [mem 0xf7c00000-0xf7c7ffff pref]
[    0.231154] pci 0000:01:00.0: PME# supported from D0 D3hot
[    0.231185] pci 0000:01:00.0: reg 184: [mem 0x00000000-0x00003fff 64bit]
[    0.231200] pci 0000:01:00.0: reg 190: [mem 0x00000000-0x00003fff 64bit]
[    0.238547] pci 0000:00:01.0: PCI bridge to [bus 01-ff]
[    0.238565] pci 0000:00:01.0:   bridge window [mem 0xf7c00000-0xf7cfffff]
[    0.238568] pci 0000:00:01.0:   bridge window [mem 0xf0000000-0xf02fffff 64bit pref]
[    0.238571] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 02
[    0.238623] pci_bus 0000:03: busn_res: can not insert [bus 03-ff] under [bus 00-3e] (conflicts with (null) [bus 00-3e])
[    0.238628] pci 0000:00:1c.0: PCI bridge to [bus 03-ff]
[    0.238639] pci_bus 0000:03: busn_res: [bus 03-ff] end is updated to 03
[    0.238690] pci_bus 0000:04: busn_res: can not insert [bus 04-ff] under [bus 00-3e] (conflicts with (null) [bus 00-3e])
[    0.238719] pci 0000:04:00.0: [10ec:8168] type 00 class 0x020000
[    0.238740] pci 0000:04:00.0: reg 10: [io  0xe000-0xe0ff]
[    0.238777] pci 0000:04:00.0: reg 18: [mem 0xf0404000-0xf0404fff 64bit pref]
[    0.238800] pci 0000:04:00.0: reg 20: [mem 0xf0400000-0xf0403fff 64bit pref]
[    0.238902] pci 0000:04:00.0: supports D1 D2
[    0.238903] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.254537] pci 0000:00:1c.4: PCI bridge to [bus 04-ff]
[    0.254544] pci 0000:00:1c.4:   bridge window [io  0xe000-0xefff]
[    0.254566] pci 0000:00:1c.4:   bridge window [mem 0xf0400000-0xf04fffff 64bit pref]
[    0.254568] pci_bus 0000:04: busn_res: [bus 04-ff] end is updated to 04
[    0.254621] pci_bus 0000:05: busn_res: can not insert [bus 05-ff] under [bus 00-3e] (conflicts with (null) [bus 00-3e])
[    0.254647] WARNING: Your hardware is broken, device (null) appears to be a
[    0.254647]  Legacy PCI device attached directly to a PCIe device which is not a
[    0.254647]  PCIe-to-PCI bridge.  Per section 7.8 of the PCI Express 3.0 spec, the
[    0.254647]  PCI express capability structure is required for PCI express device
[    0.254647] functions.
[    0.254653] pci 0000:05:00.0: [1b21:1080] type 01 class 0x060401
[    0.266521] pci 0000:00:1c.5: PCI bridge to [bus 05-ff] (subtractive decode)
[    0.266540] pci 0000:00:1c.5:   bridge window [io  0x0000-0x0cf7] (subtractive decode)
[    0.266543] pci 0000:00:1c.5:   bridge window [io  0x0d00-0xffff] (subtractive decode)
[    0.266547] pci 0000:00:1c.5:   bridge window [mem 0x000a0000-0x000bffff] (subtractive decode)
[    0.266550] pci 0000:00:1c.5:   bridge window [mem 0x000d0000-0x000d3fff] (subtractive decode)
[    0.266554] pci 0000:00:1c.5:   bridge window [mem 0x000d4000-0x000d7fff] (subtractive decode)
[    0.266566] pci 0000:00:1c.5:   bridge window [mem 0x000d8000-0x000dbfff] (subtractive decode)
[    0.266567] pci 0000:00:1c.5:   bridge window [mem 0x000dc000-0x000dffff] (subtractive decode)
[    0.266569] pci 0000:00:1c.5:   bridge window [mem 0x000e0000-0x000e3fff] (subtractive decode)
[    0.266570] pci 0000:00:1c.5:   bridge window [mem 0x000e4000-0x000e7fff] (subtractive decode)
[    0.266572] pci 0000:00:1c.5:   bridge window [mem 0xdf200000-0xfeafffff] (subtractive decode)
[    0.266576] pci 0000:05:00.0: bridge configuration invalid ([bus 05-05]), reconfiguring
[    0.266715] pci 0000:05:00.0: PCI bridge to [bus 06-ff] (subtractive decode)
[    0.266739] pci 0000:05:00.0:   bridge window [??? 0x00000000 flags 0x0] (subtractive decode)
[    0.266740] pci 0000:05:00.0:   bridge window [??? 0x00000000 flags 0x0] (subtractive decode)
[    0.266742] pci 0000:05:00.0:   bridge window [??? 0x00000000 flags 0x0] (subtractive decode)
[    0.266744] pci 0000:05:00.0:   bridge window [??? 0x00000000 flags 0x0] (subtractive decode)
[    0.266745] pci 0000:05:00.0:   bridge window [io  0x0000-0x0cf7] (subtractive decode)
[    0.266747] pci 0000:05:00.0:   bridge window [io  0x0d00-0xffff] (subtractive decode)
[    0.266748] pci 0000:05:00.0:   bridge window [mem 0x000a0000-0x000bffff] (subtractive decode)
[    0.266750] pci 0000:05:00.0:   bridge window [mem 0x000d0000-0x000d3fff] (subtractive decode)
[    0.266752] pci 0000:05:00.0:   bridge window [mem 0x000d4000-0x000d7fff] (subtractive decode)
[    0.266753] pci 0000:05:00.0:   bridge window [mem 0x000d8000-0x000dbfff] (subtractive decode)
[    0.266755] pci 0000:05:00.0:   bridge window [mem 0x000dc000-0x000dffff] (subtractive decode)
[    0.266756] pci 0000:05:00.0:   bridge window [mem 0x000e0000-0x000e3fff] (subtractive decode)
[    0.266758] pci 0000:05:00.0:   bridge window [mem 0x000e4000-0x000e7fff] (subtractive decode)
[    0.266760] pci 0000:05:00.0:   bridge window [mem 0xdf200000-0xfeafffff] (subtractive decode)
[    0.266761] pci_bus 0000:06: busn_res: [bus 06-ff] end is updated to 06
[    0.266768] pci_bus 0000:05: busn_res: [bus 05-ff] end is updated to 06
[    0.266814] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
[    0.266887] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP05._PRT]
[    0.266946] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP06._PRT]
[    0.267008] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP06.P9PE._PRT]
[    0.267103] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEG0._PRT]
[    0.275012] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.275086] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.275157] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 *10 11 12 14 15)
[    0.275227] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 10 11 12 14 15)
[    0.275298] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.275369] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 *10 11 12 14 15)
[    0.275444] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 *4 5 6 10 11 12 14 15)
[    0.275514] ACPI: PCI Interrupt Link [LNKH] (IRQs *3 4 5 6 10 11 12 14 15)
[    0.275748] vgaarb: device added: PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
[    0.275754] vgaarb: loaded
[    0.275755] vgaarb: bridge control possible 0000:00:02.0
[    0.275888] SCSI subsystem initialized
[    0.275890] ACPI: bus type scsi registered
[    0.275938] libata version 3.00 loaded.
[    0.275947] ACPI: bus type usb registered





