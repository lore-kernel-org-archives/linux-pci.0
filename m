Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140]:54892 "EHLO
	e23smtp07.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795AbbBRARZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 17 Feb 2015 19:17:25 -0500
Received: from /spool/local
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Wed, 18 Feb 2015 10:17:22 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id 6F35E2BB0051
	for <linux-pci@vger.kernel.org>; Wed, 18 Feb 2015 11:17:19 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t1I0HBAm8257782
	for <linux-pci@vger.kernel.org>; Wed, 18 Feb 2015 11:17:19 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t1I0Giwk008222
	for <linux-pci@vger.kernel.org>; Wed, 18 Feb 2015 11:16:45 +1100
Date: Wed, 18 Feb 2015 11:16:20 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
	linux-pci@vger.kernel.org, benh@kernel.crashing.org
Subject: Re: [PATCH RESEND v2 7/7] PCI/hotplug: PowerPC PowerNV PCI hotplug
 driver
Message-ID: <20150218001620.GA22042@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1424157203-691-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1424157203-691-8-git-send-email-gwshan@linux.vnet.ibm.com>
 <20150217220916.GA26424@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150217220916.GA26424@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 17, 2015 at 04:09:16PM -0600, Bjorn Helgaas wrote:
>On Tue, Feb 17, 2015 at 06:13:23PM +1100, Gavin Shan wrote:
>> The patch intends to add standalone driver to support PCI hotplug
>> for PowerPC PowerNV platform, which runs on top of skiboot firmware.
>> The firmware identified hotpluggable slots and marked their device
>> tree node with proper "ibm,slot-pluggable" and "ibm,reset-by-firmware".
>> The driver simply scans device-tree to create/register PCI hotplug slot
>> accordingly.
>> 
>> If the skiboot firmware doesn't support slot status retrieval, the PCI
>> slot device node shouldn't have property "ibm,reset-by-firmware". In
>> that case, none of valid PCI slots will be detected from device tree.
>> The skiboot firmware doesn't export the capability to access attention
>> LEDs yet and it's something for TBD.
>> 
>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> ...
>
>> +static int disable_slot(struct hotplug_slot *php_slot)
>> +{
>> +	struct powernv_php_slot *slot = php_slot->private;
>> +
>> +	if (slot->state != POWERNV_PHP_SLOT_STATE_POPULATED)
>> +		return 0;
>> +
>> +	pci_lock_rescan_remove();
>> +	pcibios_remove_pci_devices(slot->bus);
>> +	pci_unlock_rescan_remove();
>> +	vm_unmap_aliases();
>
>What is vm_unmap_aliases() for?  I see this is probably copied from
>rpaphp_core.c, where it was added by b4a26be9f6f8 ("powerpc/pseries: Flush
>lazy kernel mappings after unplug operations").
>
>But I don't know whether:
>
>  - this is something specific to powerpc,
>  - the lack of vm_unmap_aliases() in other hotplug paths is a bug,
>  - the fact that we only do this on powerpc is covering up a
>    powerpc bug somewhere
>

Yes, I copied this piece of code from rpaphp_core.c. I think Ben might
help to answer the questions as he added the patch. I had very quick
check on mm/vmalloc.c and it's reasonable to have vm_unmap_aliases()
here to flush TLB entries for ioremap() regions, which were unmapped
previously. if I'm correct. I don't think it's powerpc specific.

Thanks,
Gavin

>> +
>> +	/* Detach the child hotpluggable slots */
>> +	powernv_php_unregister(slot->dn);
>> +
>> +	/* Update slot state */
>> +	slot->state = POWERNV_PHP_SLOT_STATE_REGISTER;
>> +	return 0;
>> +}
>> 
>

