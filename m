Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vb0-f54.google.com ([209.85.212.54]:43221 "EHLO
	mail-vb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754484Ab3ADTeU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 4 Jan 2013 14:34:20 -0500
Received: by mail-vb0-f54.google.com with SMTP id l1so16930498vba.27
        for <linux-pci@vger.kernel.org>; Fri, 04 Jan 2013 11:34:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1354746272.2355.102.camel@jtkirshe-mobl>
References: <20121205205724.13851.50508.stgit@bhelgaas.mtv.corp.google.com>
 <20121205205755.13851.77284.stgit@bhelgaas.mtv.corp.google.com>
 <1354745132.2355.98.camel@jtkirshe-mobl> <CAErSpo5EfAY7BTNFtq3DWggDhBisBPGhevOsZXa19jRLT4+b6Q@mail.gmail.com>
 <1354746272.2355.102.camel@jtkirshe-mobl>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 4 Jan 2013 12:33:57 -0700
Message-ID: <CAErSpo5K_Utkbc8eJANA9OUnBkSWka8-cSFAWLpL+35SLnQYBQ@mail.gmail.com>
Subject: Re: [PATCH 07/12] e1000e: Use standard #defines for PCIe Capability
 ASPM fields
To: jeffrey.t.kirsher@intel.com
Cc: linux-pci@vger.kernel.org,
	Alex Duyck <alexander.h.duyck@intel.com>,
	e1000-devel@lists.sourceforge.net,
	Don Skidmore <donald.c.skidmore@intel.com>,
	Peter P Waskiewicz Jr <peter.p.waskiewicz.jr@intel.com>,
	Bruce Allan <bruce.w.allan@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Greg Rose <gregory.v.rose@intel.com>,
	John Ronciak <john.ronciak@intel.com>,
	Carolyn Wyborny <carolyn.wyborny@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 5, 2012 at 3:24 PM, Jeff Kirsher
<jeffrey.t.kirsher@intel.com> wrote:
> On Wed, 2012-12-05 at 15:07 -0700, Bjorn Helgaas wrote:
>> On Wed, Dec 5, 2012 at 3:05 PM, Jeff Kirsher
>> <jeffrey.t.kirsher@intel.com> wrote:
>> > On Wed, 2012-12-05 at 13:57 -0700, Bjorn Helgaas wrote:
>> >> Use the standard #defines for PCIe Capability ASPM fields.
>> >>
>> >> Previously we used PCIE_LINK_STATE_L0S and PCIE_LINK_STATE_L1
>> >> directly, but
>> >> these are defined for the Linux ASPM interfaces, e.g.,
>> >> pci_disable_link_state(), and only coincidentally match the actual
>> >> register
>> >> bits.  PCIE_LINK_STATE_CLKPM, also part of that interface, does not
>> >> match
>> >> the register bit.
>> >>
>> >> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>> >> CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
>> >> CC: Jesse Brandeburg <jesse.brandeburg@intel.com>
>> >> CC: Bruce Allan <bruce.w.allan@intel.com>
>> >> CC: Carolyn Wyborny <carolyn.wyborny@intel.com>
>> >> CC: Don Skidmore <donald.c.skidmore@intel.com>
>> >> CC: Greg Rose <gregory.v.rose@intel.com>
>> >> CC: Peter P Waskiewicz Jr <peter.p.waskiewicz.jr@intel.com>
>> >> CC: Alex Duyck <alexander.h.duyck@intel.com>
>> >> CC: John Ronciak <john.ronciak@intel.com>
>> >> CC: e1000-devel@lists.sourceforge.net
>> >> ---
>> >>  drivers/net/ethernet/intel/e1000e/netdev.c |   11 +++++++++--
>> >>  1 files changed, 9 insertions(+), 2 deletions(-)
>> >
>> > Thanks I will add this patch to my queue for e1000e.  Since this is
>> > patch 7 of 12, are there PCI dependent patches in the series that need
>> > to be applied before?
>>
>> Yes.  It does depend on a previous patch that adds the #defines to
>> include/uapi/linux/pci_regs.h
>> (http://marc.info/?l=linux-pci&m=135474107109010&w=2).
>>
>> I plan to merge that during the v3.8 merge window, so you can merge it
>> after that.  Or, if it won't cause you conflicts, I can include the
>> e1000e change in my PCI tree.
>>
>> Bjorn
>
> yeah, it does not apply cleanly (because of patches currently in the
> queue from Bruce).  So I will take care of pushing your e1000e patch
> through Dave's tree.

The pci_regs.h change this depends on appeared in v3.8-rc2, so this
patch can be merged any time, at least as far as that particular
issue.
