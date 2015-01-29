Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:62337 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753144AbbA2WF7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jan 2015 17:05:59 -0500
From: "Allan, Bruce W" <bruce.w.allan@intel.com>
To: Israel Brewster <israel@ravnalaska.net>,
	Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: CentOS/Kernel 3.18.4/Thunderbolt2
Date: Thu, 29 Jan 2015 22:05:52 +0000
Message-ID: <804857E1F29AAC47BF68C404FC60A18465918C08@ORSMSX105.amr.corp.intel.com>
References: <262B8C88-E706-4538-99D8-4E5058BE646D@ravnalaska.net>
 <CAErSpo7f=qAPiNDAjVgVttJyVQhZmh1bd=9b+_Z7rgmtUUzL3Q@mail.gmail.com>
 <C6C9B327-6ED0-499F-A2C3-42F705760657@ravnalaska.net>
In-Reply-To: <C6C9B327-6ED0-499F-A2C3-42F705760657@ravnalaska.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-
> owner@vger.kernel.org] On Behalf Of Israel Brewster
> Sent: Thursday, January 29, 2015 1:21 PM
> To: Bjorn Helgaas
> Cc: linux-pci@vger.kernel.org
> Subject: Re: CentOS/Kernel 3.18.4/Thunderbolt2
> 
> On Jan 29, 2015, at 11:05 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> 
> > On Thu, Jan 29, 2015 at 1:46 PM, Israel Brewster <israel@ravnalaska.net>
> wrote:
> >> My company recently purchased and installed a new SuperMicro server
> with a Thunderbolt 2 (Falcon Ridge) card installed, specifically an AOC-TBT-
> DSL5320. I then installed CentOS 6, and, since to my understanding
> thunderbolt support is only in more recent kernels, I went ahead and
> upgraded the kernel to version 3.18.4 from ElRepo. However, I have not
> seen any indication yet that Thunderbolt is working - although I may just not
> be looking in the right place. Over on Google+ Greg Kroah-Hartman
> indicated that I need the PCI hot plug controller driver enabled, and
> Matthew Garrett indicated that I specifically need the ACPI PCI hotplug
> driver rather than the native PCIe hotplug driver. To check, I ran the
> following command:
> >>
> >> egrep -i HOTPLUG /boot/config-3.18.4-1.el6.elrepo.x86_64
> >>
> >> Which returned the following potentially relevant results:
> >>
> >> CONFIG_ACPI_HOTPLUG_CPU=y
> >> CONFIG_ACPI_HOTPLUG_MEMORY=y
> >> CONFIG_HOTPLUG_PCI_PCIE=y
> >> CONFIG_HOTPLUG_PCI=y
> >>
> >> but also the following:
> >>
> >> # CONFIG_HOTPLUG_PCI_ACPI is not set
> >> # CONFIG_HOTPLUG_PCI_CPCI is not set
> >>
> >> So perhaps that's the entire problem - that CONFIG_HOTPLUG_PCI_ACPI
> is not set? If so, what's going to be the easiest solution?
> >
> > Yep, if you need the ACPI PCI hotplug driver,
> CONFIG_HOTPLUG_PCI_ACPI
> > should be enabled.  I think you should be able to use "make
> > menuconfig" to enable it at:
> >
> >  Bus options
> >    Support for PCI Hotplug
> >      ACPI PCI Hotplug driver
> >
> > I'm not  RedHat/CentOS person, so I don't know the distro details, but
> > I would try "make install" as a starting point.
> 
> Well, I went ahead and downloaded the 3.18.4 source, copied my current
> config, ran make menuconfig, and enabled that option. Then I ran make
> rpm, which gave me a RPM that I installed and was able to boot from.
> However, while I do see the ACPI PCI Hotplug driver loading in the DMESG, I
> still don't see any indication of the thunderbolt controller or the drive I
> plugged in.
> 
> Is there any chance I'm just being stupid here? That things ARE working, but
> are identified differently than I am expecting, so I don't see them?

Not necessarily.  Is this a plug-in controller or on the mobo?  If the latter, does your system BIOS show any Thunderbolt security options, and if so, what is it set to?

