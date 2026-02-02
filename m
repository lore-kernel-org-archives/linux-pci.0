Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8142EAB6F
	for <linux-pci@vger.kernel.org>; Mon,  2 Feb 2026 20:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770064061; cv=none; b=TeDUpZQ9XiadKz7GNMxALGol8Mqs+lUZ5gOJ4wbMXsVxoxyORu+a25UlQNaWKTcbeMMg9FXaheUTDT2olTntTszAfLVtb5dEs+v+I7Slb8qjC5RDL2Mzyu1mgDsHXtS8iXb4y3lepoADdZ2EpCfV7sV+AOggO+ZYnPm2oMizKME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770064061; c=relaxed/simple;
	bh=4wFKOU1Gd/TGnBeAjA8MJhzEWteCa8QozDlw2EUwH0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rsq3WnN78cAdeFCvWgKJt7oRWgRCvug25PNNkgzSi0DUvMumGpmU3V3dxX9NEmTJtTInBcNTmTpC4N8y3wbIGY7fS25C0qj7b9JF2Indm/RZ9wX2l9KRCMSSaaOZDUr18VKYLCzH77KH7Kgq0AXpQ0/MvcZI+aiFPw3p+PSGmec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Se+OApIn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Se+OApIn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 796A9C116C6;
	Mon,  2 Feb 2026 20:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770064060;
	bh=4wFKOU1Gd/TGnBeAjA8MJhzEWteCa8QozDlw2EUwH0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Se+OApInnJlKbqhR6ClJ0uIMKAqQwiIyB0a9ExLAIbTc5pYZ8ZxpVA+K8WukNIxw8
	 LPB3T8k6Y7aZxNOka7yopSBvm7l3xShWN5scdIY+2NGcTgjSthrW1ypk/y1ljEnPxN
	 Za9Mgl/Sw/M/xxWIqZnnPBhM5PYdyIMbqVx34W5If88xF+jMOjUQdYvVg21LOKt2Rc
	 XFGvU68uxSP5dd4M3MFGbeDQyy24XhEAuLLVwF8IUEagW7ieVHJ/9+RknTyTIgnCA0
	 hHhblKYrMudzQv4s7F9kTtdn2Ti27TlH4JxzxJhpmz+hoO5rrMzAzmrVb3i6BED5XZ
	 fWnRbET3D+6Og==
Date: Mon, 2 Feb 2026 13:27:38 -0700
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-pci@vger.kernel.org, helgaas@kernel.org, alex@shazbot.org,
	lukas@wunner.de, dan.j.williams@intel.com,
	guojinhui.liam@bytedance.com, ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCHv2 3/4] pci: remove slot specific lock/unlock and
 save/restore
Message-ID: <aYEIuv2D2VL08oKz@kbusch-mbp>
References: <20260130165953.751063-1-kbusch@meta.com>
 <20260130165953.751063-4-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130165953.751063-4-kbusch@meta.com>

On Fri, Jan 30, 2026 at 08:59:52AM -0800, Keith Busch wrote:
> Fix this by properly locking and notifying the entire affected bus
> topology, not just specific matching slots. For architectures that
> support "slot" specific resets, this patch potentially introduces an
> insignificant amount of overhead, but is otherwise harmless.

I have an alternative proposal if anyone thinks this patch is concerning:
it would be simple to make a sentinal value for the "slot" number to
mean "all devices", and then the slot will claim every function found on
a bus. That's the behavior that pciehp wants anyway, since it only
creates a single slot for a bridge to a suborinate bus. If we set up
slots this way, the existing slot specific reset methods will work fine.

---
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index f59baa9129709..d80346d567049 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -79,7 +79,8 @@ static int init_slot(struct controller *ctrl)
 	snprintf(name, SLOT_NAME_SIZE, "%u", PSN(ctrl));
 
 	retval = pci_hp_initialize(&ctrl->hotplug_slot,
-				   ctrl->pcie->port->subordinate, 0, name);
+				   ctrl->pcie->port->subordinate,
+				   PCI_SLOT_ALL_DEVICES, name);
 	if (retval) {
 		ctrl_err(ctrl, "pci_hp_initialize failed: error %d\n", retval);
 		kfree(ops);
diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index 50fb3eb595fe6..e0fdbbfbc04fc 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -41,6 +41,9 @@ static ssize_t address_read_file(struct pci_slot *slot, char *buf)
 		return sysfs_emit(buf, "%04x:%02x\n",
 				  pci_domain_nr(slot->bus),
 				  slot->bus->number);
+	if (slot->number == PCI_SLOT_ALL_DEVICES)
+		return sysfs_emit(buf, "%04x:%02x:00\n",
+				  pci_domain_nr(slot->bus),
 
 	return sysfs_emit(buf, "%04x:%02x:%02x\n",
 			  pci_domain_nr(slot->bus),
@@ -73,7 +76,8 @@ static void pci_slot_release(struct kobject *kobj)
 
 	down_read(&pci_bus_sem);
 	list_for_each_entry(dev, &slot->bus->devices, bus_list)
-		if (PCI_SLOT(dev->devfn) == slot->number)
+		if (slot->number == PCI_SLOT_ALL_DEVICES ||
+		    PCI_SLOT(dev->devfn) == slot->number)
 			dev->slot = NULL;
 	up_read(&pci_bus_sem);
 
@@ -166,7 +170,8 @@ void pci_dev_assign_slot(struct pci_dev *dev)
 
 	mutex_lock(&pci_slot_mutex);
 	list_for_each_entry(slot, &dev->bus->slots, list)
-		if (PCI_SLOT(dev->devfn) == slot->number)
+		if (slot->number == PCI_SLOT_ALL_DEVICES ||
+		    PCI_SLOT(dev->devfn) == slot->number)
 			dev->slot = slot;
 	mutex_unlock(&pci_slot_mutex);
 }
@@ -188,7 +193,7 @@ static struct pci_slot *get_slot(struct pci_bus *parent, int slot_nr)
 /**
  * pci_create_slot - create or increment refcount for physical PCI slot
  * @parent: struct pci_bus of parent bridge
- * @slot_nr: PCI_SLOT(pci_dev->devfn) or -1 for placeholder
+ * @slot_nr: PCI_SLOT(pci_dev->devfn), -1 for placeholder, or PCI_SLOT_ALL_DEVICES
  * @name: user visible string presented in /sys/bus/pci/slots/<name>
  * @hotplug: set if caller is hotplug driver, NULL otherwise
  *
@@ -285,7 +297,8 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
 
 	down_read(&pci_bus_sem);
 	list_for_each_entry(dev, &parent->devices, bus_list)
-		if (PCI_SLOT(dev->devfn) == slot_nr)
+		if (slot_nr == PCI_SLOT_ALL_DEVICES ||
+		    PCI_SLOT(dev->devfn) == slot_nr)
 			dev->slot = slot;
 	up_read(&pci_bus_sem);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 864775651c6fa..d9f85025d97f5 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -72,12 +72,18 @@
 /* return bus from PCI devid = ((u16)bus_number) << 8) | devfn */
 #define PCI_BUS_NUM(x) (((x) >> 8) & 0xff)
 
+/*
+ * PCI_SLOT_ALL_DEVICES indicates a slot that covers all devices on the bus.
+ * Used for PCIe hotplug where the physical slot is the entire subordinate bus.
+ */
+#define PCI_SLOT_ALL_DEVICES	0xfe
+
 /* pci_slot represents a physical slot */
 struct pci_slot {
 	struct pci_bus		*bus;		/* Bus this slot is on */
--
