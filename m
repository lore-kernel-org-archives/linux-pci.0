Return-Path: <SRS0=gM3E=DZ=rowland.harvard.edu=stern+5a55f586@kernel.org>
Return-Path: <SRS0=gM3E=DZ=rowland.harvard.edu=stern+5a55f586@kernel.org>
Date: Fri, 29 Dec 2017 11:14:51 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Paul Menzel <pmenzel+linux-pci@molgen.mpg.de>,
     <linux-pci@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
    David Woodhouse <dwmw2@infradead.org>,
    Andy Shevchenko <andy.shevchenko@gmail.com>,  <linux-usb@vger.kernel.org>
Subject: Re: `pci_apply_final_quirks()` taking half a second
In-Reply-To: <20171228212723.GB211339@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <Pine.LNX.4.44L0.1712291111580.24019-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Thu, 28 Dec 2017, Bjorn Helgaas wrote:

> On Tue, Dec 26, 2017 at 04:55:20PM +0100, Paul Menzel wrote:
> > Am 08.04.2017 um 17:41 schrieb Bjorn Helgaas:
> > >On Fri, Apr 07, 2017 at 11:07:15PM +0200, Paul Menzel wrote:
> > 
> > >>Measuring where time is spent during boot with `systemd-bootchart`
> > >>on an Asus A780FullHD, it turns out that half a second is spent in
> > >>`pci_apply_final_quirks()`.
> > >
> > >I agree, that seems like a crazy amount of time.
> > >
> > >Can you figure out how to turn on pr_debug() (via the dynamic debug
> > >mess or whatever) and boot with "initcall_debug"?  That should tell us
> > >how long each quirk took.
> > 
> > I am sorry for taking so long to reply. I finally added `dyndbg=file
> > quirks.c +p` to the command line of Linux 4.13.13. This is on
> > another AMD system (Asus F285M Pro).

> > Dez 26 16:21:46 asus-f2a85-pro kernel: pci fixup
> > quirk_usb_early_handoff+0x0/0x6b0 returned after 197 usecs for
> > 0000:00:10.0
> > Dez 26 16:21:46 asus-f2a85-pro kernel: pci fixup
> > quirk_usb_early_handoff+0x0/0x6b0 returned after 127 usecs for
> > 0000:00:10.1
> > Dez 26 16:21:46 asus-f2a85-pro kernel: pci fixup
> > quirk_usb_early_handoff+0x0/0x6b0 returned after 88643 usecs for
> > 0000:00:12.0
> > Dez 26 16:21:46 asus-f2a85-pro kernel: pci fixup
> > quirk_usb_early_handoff+0x0/0x6b0 returned after 137 usecs for
> > 0000:00:12.2
> > Dez 26 16:21:46 asus-f2a85-pro kernel: pci fixup
> > pci_fixup_amd_ehci_pme+0x0/0x30 returned after 1 usecs for
> > 0000:00:12.2
> > Dez 26 16:21:46 asus-f2a85-pro kernel: pci fixup
> > quirk_usb_early_handoff+0x0/0x6b0 returned after 85770 usecs for
> > 0000:00:13.0
> > Dez 26 16:21:46 asus-f2a85-pro kernel: pci fixup
> > quirk_usb_early_handoff+0x0/0x6b0 returned after 134 usecs for
> > 0000:00:13.2
> > Dez 26 16:21:46 asus-f2a85-pro kernel: pci fixup
> > pci_fixup_amd_ehci_pme+0x0/0x30 returned after 1 usecs for
> > 0000:00:13.2
> > Dez 26 16:21:46 asus-f2a85-pro kernel: pci fixup
> > quirk_usb_early_handoff+0x0/0x6b0 returned after 125 usecs for
> > 0000:03:00.0[…]
> > ```
> > 
> > So it’s `pci fixup quirk_usb_early_handoff` taking around 85 ms, and
> > that twice.
> 
> Wow.  That's pretty painful, but of course I don't know how to fix it.
> From looking at quirk_usb_early_handoff(), it may depend on BIOS
> details.  Maybe the USB folks will have some ideas.

Can we see the output from lspci?  It would help to know what the 12.0 
and 13.0 devices are.

Alan Stern
