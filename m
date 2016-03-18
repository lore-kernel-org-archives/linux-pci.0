Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:57147 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752526AbcCRXDM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 18 Mar 2016 19:03:12 -0400
Date: Fri, 18 Mar 2016 23:05:36 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Murali Karicheri <m-karicheri2@ti.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: PCI IO resource question.
Message-ID: <20160318230536.GA3264@red-moon>
References: <56E987B8.1090904@ti.com>
 <20160316164531.GA28797@localhost>
 <56E9A12F.50008@ti.com>
 <20160316192904.GA2703@localhost>
 <56E9BE6A.6090107@ti.com>
 <20160316214733.GA11542@localhost>
 <56EB217F.8070603@ti.com>
 <20160318112802.GA1810@red-moon>
 <56EC1A27.7000206@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56EC1A27.7000206@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 18, 2016 at 11:09:27AM -0400, Murali Karicheri wrote:
> On 03/18/2016 07:28 AM, Lorenzo Pieralisi wrote:
> > On Thu, Mar 17, 2016 at 05:28:31PM -0400, Murali Karicheri wrote:
> > 
> > [...]
> > 
> >>> The only ways I see that PCI_PROBE_ONLY can be set on ARM are if you have
> >>> "linux,pci-probe-only" in your DT or you boot with "pci=firmware".
> >>>
> >>> I expect you're in this path:
> >>>
> >>>   ahci_init_one
> >>>     pcim_enable_device
> >>>       pci_enable_device
> >>>         pci_enable_device_flags(dev, IORESOURCE_MEM | IORESOURCE_IO)
> >>>           # build "bars" mask
> >>>           do_pci_enable_device(dev, bars)
> >>>             pcibios_enable_device
> >>>               if (pci_has_flag(PCI_PROBE_ONLY))
> >>>                 return 0;
> >>>               pci_enable_resources
> >>>
> >>> Can you add a little debug code like this to verify that we're in this
> >>> path?
> >>
> >> Yes we are in the path.
> >>
> >>
> >> [    1.557561] ahci_init_one
> >> [    1.560214] ahci 0000:01:00.0: version 3.0
> >> [    1.564302] pcim_enable_device
> >> [    1.567349] pci_enable_device
> >> [    1.570340] pci_enable_device_flags
> >> [    1.573824] do_pci_enable_device
> >> [    1.577042] pcibios_enable_device
> >> [    1.580380] pci_enable_resources
> > 
> > So resources are actually enabled (ie PCI_PROBE_ONLY is not set)
> > and that makes sense otherwise you would not be able to use the
> > MEM resources anyway (ie they would not be enabled).
> > 
> > I suspect the PCI dev IO resources were reset in reset_resource() in
> > assign_requested_resource_sorted(), hence the bar mask that is built
> > in pci_enable_device_flags() does not contain the IO resources,
> > it would be helpful if you can print the bar mask passed to
> > pcibios_enable_device() (ie the mask parameter).
> 
> Here it is
> 
> [    1.556507] ahci_init_one
> [    1.559124] ahci 0000:01:00.0: version 3.0
> [    1.563246] pcim_enable_device
> [    1.566294] pci_enable_device
> [    1.569252] pci_enable_device_flags
> [    1.572766] do_pci_enable_device
> [    1.575985] pcibios_enable_device 60
> [    1.579551] pci_enable_resources
> 
> I know that some of our customers use PCIe SATA from u-boot and would
> like to honor the assignment in Linux space.. I believe they use
> PCI_PROBE_ONLY by setting the bootarg. So Keystone PCI should work in
> both cases.

Please, tell us more about it, what does "would like to honour" mean ?

Do they (ab)use pci=firmware bootarg just to keep FW PCIe SATA settings ?

There are two ways of setting PCI_PROBE_ONLY on ARM/ARM64 (unfortunately):

- DT chosen node
- pci=firmware (on arm 32-bit platforms only)

PCIe designware does not check the DT chosen node property, so you are
telling me that some customers are abusing pci=firmware command line, that
was never meant to be used on platforms other than ARM IXP2000 systems
(see Documentation/kernel-parameters.txt).

Usage of PCI_PROBE_ONLY on ARM has been controversial and is completely
ill-defined, so we are trying to get rid of its usage.

Now, commit ed00c83cd490 ("PCI: designware: Remove PCI_PROBE_ONLY handling")
removed, after mailing list initial investigation and patch review

http://www.spinics.net/lists/linux-pci/msg48248.html

PCI_PROBE_ONLY handling from PCIe designware, which means that even if
you pass pci=firmware parameter on the command line (wrongly, see above)
the kernel reassigns resources and set-up PCIe settings.

Does this trigger issues on Keystone ? Or the systems that set that
bootarg work even if the flag is ignored ? I want to understand and
I really would like to avoid asking Bjorn to revert that commit for
what looks like an abuse, I prefer finding a workaround if this is
really an issue.

For the records, I am about to send a patch to remove pci=firmware
to Russell patch system, so I really have to know what to expect
on Keystone:

http://www.spinics.net/lists/linux-pci/msg49328.html

Please let me know, I ultimately want to implement code that on ARM
carries out proper PCI resources allocation (claiming firmware and
assign resources that fails to be claimed - ie they are not configured
by FW properly), removing PCI_PROBE_ONLY handling is a stepping stone
to get there.

Thank you for your patience,
Lorenzo
