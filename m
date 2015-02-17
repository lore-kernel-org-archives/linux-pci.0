Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:41558 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752371AbbBQWJU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 17 Feb 2015 17:09:20 -0500
Received: by mail-ob0-f172.google.com with SMTP id nt9so58597256obb.3
        for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2015 14:09:19 -0800 (PST)
Date: Tue, 17 Feb 2015 16:09:16 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-pci@vger.kernel.org,
	benh@kernel.crashing.org
Subject: Re: [PATCH RESEND v2 7/7] PCI/hotplug: PowerPC PowerNV PCI hotplug
 driver
Message-ID: <20150217220916.GA26424@google.com>
References: <1424157203-691-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1424157203-691-8-git-send-email-gwshan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1424157203-691-8-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 17, 2015 at 06:13:23PM +1100, Gavin Shan wrote:
> The patch intends to add standalone driver to support PCI hotplug
> for PowerPC PowerNV platform, which runs on top of skiboot firmware.
> The firmware identified hotpluggable slots and marked their device
> tree node with proper "ibm,slot-pluggable" and "ibm,reset-by-firmware".
> The driver simply scans device-tree to create/register PCI hotplug slot
> accordingly.
> 
> If the skiboot firmware doesn't support slot status retrieval, the PCI
> slot device node shouldn't have property "ibm,reset-by-firmware". In
> that case, none of valid PCI slots will be detected from device tree.
> The skiboot firmware doesn't export the capability to access attention
> LEDs yet and it's something for TBD.
> 
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ...

> +static int disable_slot(struct hotplug_slot *php_slot)
> +{
> +	struct powernv_php_slot *slot = php_slot->private;
> +
> +	if (slot->state != POWERNV_PHP_SLOT_STATE_POPULATED)
> +		return 0;
> +
> +	pci_lock_rescan_remove();
> +	pcibios_remove_pci_devices(slot->bus);
> +	pci_unlock_rescan_remove();
> +	vm_unmap_aliases();

What is vm_unmap_aliases() for?  I see this is probably copied from
rpaphp_core.c, where it was added by b4a26be9f6f8 ("powerpc/pseries: Flush
lazy kernel mappings after unplug operations").

But I don't know whether:

  - this is something specific to powerpc,
  - the lack of vm_unmap_aliases() in other hotplug paths is a bug,
  - the fact that we only do this on powerpc is covering up a
    powerpc bug somewhere

> +
> +	/* Detach the child hotpluggable slots */
> +	powernv_php_unregister(slot->dn);
> +
> +	/* Update slot state */
> +	slot->state = POWERNV_PHP_SLOT_STATE_REGISTER;
> +	return 0;
> +}
> 
