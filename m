Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752915AbdASX7W (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Jan 2017 18:59:22 -0500
Date: Thu, 19 Jan 2017 17:52:55 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Richard, Joseph" <Joseph.Richard@windriver.com>
Cc: Rajat Jain <rajatja@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Hotplugging PCI device with large BAR
Message-ID: <20170119235255.GB6619@bhelgaas-glaptop.roam.corp.google.com>
References: <7B6A2AE64F40F245AE81F245059F0C3651381A56@ALA-MBA.corp.ad.wrs.com>
 <20170117144128.GB22776@bhelgaas-glaptop.roam.corp.google.com>
 <CACK8Z6Fsory5iBV_PBoRX5je8Wf6f3_tzbQ=50GTkkg+dwEzaw@mail.gmail.com>
 <7B6A2AE64F40F245AE81F245059F0C3651381C7F@ALA-MBA.corp.ad.wrs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <7B6A2AE64F40F245AE81F245059F0C3651381C7F@ALA-MBA.corp.ad.wrs.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 19, 2017 at 10:58:15PM +0000, Richard, Joseph wrote:
> Hello,
> We have been able to work around this be setting pci=nocrs on the kernel cmdline.
> 
> Without pci=nocrs set, we see the following in the startup log:
> [    0.476681] PCI host bridge to bus 0000:00
> [    0.477214] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    0.477882] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7]
> [    0.478591] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff]
> [    0.479311] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff]
> [    0.480109] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfebfffff]
> [    0.480901] pci_bus 0000:00: root bus resource [mem 0x300000000-0x37fffffff]
> 
> With pci=nocrs set, we see the following in the startup log, and the device is initialized correctly:
> [    0.477580] PCI host bridge to bus 0000:00
> [    0.478123] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    0.478771] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
> [    0.479527] pci_bus 0000:00: root bus resource [mem 0x00000000-0x3fffffffffff]

You didn't include enough of the dmesg log to know for sure what's
happening, but based on what we have seen, your 00:0c.0 device
requires 2GB of MMIO space:

  pci 0000:00:0c.0: BAR 2: failed to assign [mem size 0x80000000 64bit pref]

According to _CRS, the only host bridge window large enough would be
this:

  pci_bus 0000:00: root bus resource [mem 0x300000000-0x37fffffff]

The fact that we didn't put it there probably means there's already
some other device using part of that space.

If you ignore _CRS, we probably put the device at
0x3800000000-0x3fffffffff.  Apparently that works, but it's not really
safe to use space outside what the BIOS tells us is ours to use.

If BIOS knows the window really is 0x3000000000-0x3fffffffff, it
should change the _CRS method to reflect that, and then things would
work without using pci=nocrs.

> Is this something that should be expected when hot-plugging devices with large BARs?  Is it possible to modify the root bus resource when hot-plugging, or is it fixed after booting?

It is theoretically possible to modify the root bus resource when
hot-plugging, but that would require Linux to support it (it currently
does not, and I don't know of anybody working on it) and a host bridge
_SRS method from the BIOS.

> From: Rajat Jain [mailto:rajatja@google.com] 
> Sent: Tuesday, January 17, 2017 1:47 PM
> To: Bjorn Helgaas
> Cc: Richard, Joseph; linux-pci@vger.kernel.org
> Subject: Re: Hotplugging PCI device with large BAR
> 
> 
> 
> On Tue, Jan 17, 2017 at 6:41 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Mon, Jan 16, 2017 at 11:29:26PM +0000, Richard, Joseph wrote:
> > Hello,
> > I am trying to hotplug a device with a large BAR to a KVM guest, but it is failing to map the memory for the BAR.
> >
> > From dmesg, here is the output when hotplugging the device, with the failure on BAR 2:
> > [  891.614017] ACPI: \_SB_.PCI0.S60_: ACPI_NOTIFY_DEVICE_CHECK event
> > [  891.614036] ACPI: \_SB_.PCI0.S60_: Device check in hotplug_event()
> > [  891.614100] pci 0000:00:0c.0: [1af4:1110] type 00 class 0x050000
> > [  891.614277] pci 0000:00:0c.0: reg 0x10: [mem 0x00000000-0x00000fff]
> > [  891.614391] pci 0000:00:0c.0: reg 0x14: [mem 0x00000000-0x00000fff]
> > [  891.614557] pci 0000:00:0c.0: reg 0x18: [mem 0x00000000-0x7fffffff 64bit pref]
> > [  891.614670] pci 0000:00:0c.0: reg 0x20: [mem 0x00000000-0x000fffff pref]
> > [  891.614780] pci 0000:00:0c.0: reg 0x24: [mem 0x00000000-0x000fffff pref]
> > [  891.615277] pci 0000:00:0c.0: BAR 2: no space for [mem size 0x80000000 64bit pref]
> > [  891.615279] pci 0000:00:0c.0: BAR 2: failed to assign [mem size 0x80000000 64bit pref]
> > [  891.615281] pci 0000:00:0c.0: BAR 4: assigned [mem 0xc0300000-0xc03fffff pref]
> > [  891.617759] pci 0000:00:0c.0: BAR 5: assigned [mem 0xc0400000-0xc04fffff pref]
> > [  891.620473] pci 0000:00:0c.0: BAR 0: assigned [mem 0xc0202000-0xc0202fff]
> > [  891.623148] pci 0000:00:0c.0: BAR 1: assigned [mem 0xc0203000-0xc0203fff]
> >
> > When the node is rebooted, the allocation gets fixed.
> > Also, when a similar device has previously been removed, it can allocate the memory that has previously been used for that device to this device, so allocation will succeed
> > Note, this is on a guest that has 9.8GB of RAM.  The same result was also observed on guests with lower amounts of RAM.
> 
> This is a weakness of the PCI core -- we don't deal well with resource
> allocation issues.
> 
> To really see what's going on we would need to see more of the dmesg
> (preferably the entire log), which would show the available address
> space.
> 
> In this case, the device (00:0c.0) is on a root bus, so it's a
> question of what the host bridge windows are and how space is
> assigned to the other devices on the root bus.
> 
> The way this was dealt in one of my previous orgs, was to change the BIOS to "reserve" enough memory space at the ports where we know the platform would need later (due to anticipated hot-pluggable devices). 
>  
> 
> Since it works after a reboot, I suspect the BIOS is assigning things
> differently when the device is present at boot-time.  The BIOS may
> also be able to increase the host bridge window sizes.  The dmesg logs
> showing the hotplug and a subsequent reboot would show what's
> happening.
> 
> Linux could theoretically do something similar at hotplug-time, but it
> is complicated by the fact that other devices may already be operating
> (and thus difficult to move), and the fact that we don't currently
> have support for changing host bridge windows (and any such support
> would rely on firmware support, i.e., a host bridge _SRS method).
> 
> Bjorn
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
