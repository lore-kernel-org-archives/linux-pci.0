Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp02.au.ibm.com ([202.81.31.144]:47386 "EHLO
	e23smtp02.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621AbbBPWht (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 Feb 2015 17:37:49 -0500
Received: from /spool/local
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Tue, 17 Feb 2015 08:37:47 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id 11E3E2CE804E
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2015 09:37:45 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t1GMbaDG43974820
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2015 09:37:45 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t1GMbBwq011137
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2015 09:37:11 +1100
Date: Tue, 17 Feb 2015 09:36:47 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: cascardo@linux.vnet.ibm.com
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com
Subject: Re: [PATCH 0/4] Support registering specific reset handler
Message-ID: <20150216223647.GA5758@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1423803299-22356-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <20150216131427.GA4840@oc0812247204.ltc.br.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150216131427.GA4840@oc0812247204.ltc.br.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 16, 2015 at 11:14:27AM -0200, cascardo@linux.vnet.ibm.com wrote:
>On Fri, Feb 13, 2015 at 03:54:55PM +1100, Gavin Shan wrote:
>> VFIO PCI infrastructure depends on pci_reset_function() to do reset on
>> PCI devices so that they would be in clean state when host or guest grabs
>> them. Unfortunately, the function doesn't work (or not well) on some PCI
>> devices that require EEH PE reset.
>> 
>> The patchset extends the quirk for PCI device speicific reset methods to
>> allow dynamically registration. With it, we can translate reset requests
>> for those special PCI devcies to EEH PE reset, which is only avaialble on
>> 64-bits PowerPC platforms.
>> 
>
>Hi, Gavin.
>
>I like your approach overall. That allows us to confine these quirks to
>the platforms where they are relevant. I would make the quirks more
>specific, though, instead of doing them for all IBM and Mellanox
>devices.
>

Yeah, we need have more specific vendor/device IDs for PATCH[4/4]. Could
you please take a look on PATCH[4/4] and then suggest the specific devices
that requries the platform-dependent reset quirk? Especially the device IDs
for IBM/Mellanox we need put add quirks for.

>I wonder if we should not have some form of domain reset, where we would
>reset all the devices on the same group, and use that on vfio. Grouping
>the devices would then be made platform-dependent, as well as the reset
>method. On powernv, we would group by IOMMU group and issue a
>fundamental reset.
>

I'm assuming "domain reset" is PE reset, which is the specific reset handler
tries to do on PowerNV platform. The reason why we need platform specific
reset handler is some adapters can't support function level reset methods
(except pci_dev_specific_reset()) in __pci_dev_reset().

Thanks,
Gavin

>Cascardo.
>
>> Gavin Shan (4):
>>   PCI: Rename struct pci_dev_reset_methods
>>   PCI: Introduce list for device reset methods
>>   PCI: Allow registering reset method
>>   powerpc/powernv: Register PCI dev specific reset handlers
>> 
>>  arch/powerpc/platforms/powernv/pci.c |  61 +++++++++++++++
>>  drivers/pci/pci.h                    |   3 +-
>>  drivers/pci/quirks.c                 | 139 ++++++++++++++++++++++++++++++-----
>>  include/linux/pci.h                  |   9 +++
>>  4 files changed, 192 insertions(+), 20 deletions(-)
>> 
>> -- 
>> 1.8.3.2
>> 

