Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142]:43952 "EHLO
	e23smtp09.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773AbbBTFyM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 20 Feb 2015 00:54:12 -0500
Received: from /spool/local
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Fri, 20 Feb 2015 15:54:09 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id EE8A72BB0047
	for <linux-pci@vger.kernel.org>; Fri, 20 Feb 2015 16:54:06 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t1K5rw8R44761214
	for <linux-pci@vger.kernel.org>; Fri, 20 Feb 2015 16:54:06 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t1K5rWJT005051
	for <linux-pci@vger.kernel.org>; Fri, 20 Feb 2015 16:53:33 +1100
Date: Fri, 20 Feb 2015 16:53:08 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: cascardo@linux.vnet.ibm.com
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/4] Support registering specific reset handler
Message-ID: <20150220055308.GA26047@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1423803299-22356-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <20150216131427.GA4840@oc0812247204.ltc.br.ibm.com>
 <20150216223647.GA5758@shangw>
 <20150219185746.GA4440@oc0812247204.ltc.br.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150219185746.GA4440@oc0812247204.ltc.br.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 19, 2015 at 04:57:47PM -0200, cascardo@linux.vnet.ibm.com wrote:
>On Tue, Feb 17, 2015 at 09:36:47AM +1100, Gavin Shan wrote:
>> On Mon, Feb 16, 2015 at 11:14:27AM -0200, cascardo@linux.vnet.ibm.com wrote:
>> >On Fri, Feb 13, 2015 at 03:54:55PM +1100, Gavin Shan wrote:
>> >> VFIO PCI infrastructure depends on pci_reset_function() to do reset on
>> >> PCI devices so that they would be in clean state when host or guest grabs
>> >> them. Unfortunately, the function doesn't work (or not well) on some PCI
>> >> devices that require EEH PE reset.
>> >> 
>> >> The patchset extends the quirk for PCI device speicific reset methods to
>> >> allow dynamically registration. With it, we can translate reset requests
>> >> for those special PCI devcies to EEH PE reset, which is only avaialble on
>> >> 64-bits PowerPC platforms.
>> >> 
>> >
>> >Hi, Gavin.
>> >
>> >I like your approach overall. That allows us to confine these quirks to
>> >the platforms where they are relevant. I would make the quirks more
>> >specific, though, instead of doing them for all IBM and Mellanox
>> >devices.
>> >
>> 
>> Yeah, we need have more specific vendor/device IDs for PATCH[4/4]. Could
>> you please take a look on PATCH[4/4] and then suggest the specific devices
>> that requries the platform-dependent reset quirk? Especially the device IDs
>> for IBM/Mellanox we need put add quirks for.
>> 
>> >I wonder if we should not have some form of domain reset, where we would
>> >reset all the devices on the same group, and use that on vfio. Grouping
>> >the devices would then be made platform-dependent, as well as the reset
>> >method. On powernv, we would group by IOMMU group and issue a
>> >fundamental reset.
>> >
>> 
>> I'm assuming "domain reset" is PE reset, which is the specific reset handler
>> tries to do on PowerNV platform. The reason why we need platform specific
>> reset handler is some adapters can't support function level reset methods
>> (except pci_dev_specific_reset()) in __pci_dev_reset().
>> 
>
>Well, in the case of Power servers, this would be the PE reset, I am not
>sure what this would be on other platforms. No other platform implements
>pci_set_pcie_reset_state, which I think would be one possible to
>implement such a reset.
>
>What I am saying is that we should consider doing this on all platforms
>and for all adapters, because this is not specific to Power and this is
>not specific to this particular set of adapters. Otherwise, one can
>simply program one adapter in the guest to write to host memory,
>shutdown, and since no reset will take place, the card will simply write
>to host memory when the guest is finished with and IOMMU is off.
>

Yes, I believe your way will make things simpler and we don't need the
code to support registering reset handler dynamically at atll. Please
confirm if following idea is what you're suggesting: 

- Introduce function drivers/pci/quirks.c::pci_dev_specific_reset(), which
  will be added to pci_dev_reset_methods[] for various vendor/device IDs.
- pci_dev_specific_reset() routes the reset (or probe) request to
  pci_set_pcie_reset_state(), which needs one more syntax for reset probing.
  In turn, pci_set_pcie_reset_state() calls pcibios_set_pcie_reset_state(),
  which returns -ETTY by default.

For PowerPC, pcibios_set_pcie_reset_state() will do PE reset, which can't
be ported to other platforms as it depends on PowerPC unique EEH feature.
So other platforms have to override this function and do things similar to
PowerPC PE reset there.

Thanks,
Gavin

>> >> Gavin Shan (4):
>> >>   PCI: Rename struct pci_dev_reset_methods
>> >>   PCI: Introduce list for device reset methods
>> >>   PCI: Allow registering reset method
>> >>   powerpc/powernv: Register PCI dev specific reset handlers
>> >> 
>> >>  arch/powerpc/platforms/powernv/pci.c |  61 +++++++++++++++
>> >>  drivers/pci/pci.h                    |   3 +-
>> >>  drivers/pci/quirks.c                 | 139 ++++++++++++++++++++++++++++++-----
>> >>  include/linux/pci.h                  |   9 +++
>> >>  4 files changed, 192 insertions(+), 20 deletions(-)
>> >> 
>> >> -- 
>> >> 1.8.3.2
>> >> 
>> 
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev

