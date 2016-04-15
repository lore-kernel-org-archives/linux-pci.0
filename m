Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp03.au.ibm.com ([202.81.31.145]:40292 "EHLO
	e23smtp03.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447AbcDOBkQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2016 21:40:16 -0400
Received: from localhost
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Fri, 15 Apr 2016 11:40:13 +1000
Date: Fri, 15 Apr 2016 11:39:10 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alistair Popple <alistair@popple.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
	Gavin Shan <gwshan@linux.vnet.ibm.com>,
	devicetree@vger.kernel.org, aik@ozlabs.ru,
	linux-pci@vger.kernel.org, grant.likely@linaro.org,
	robherring2@gmail.com, bhelgaas@google.com, dja@axtens.net
Subject: Re: [PATCH v8 45/45] PCI/hotplug: PowerPC PowerNV PCI hotplug driver
Message-ID: <20160415013909.GA22105@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-46-git-send-email-gwshan@linux.vnet.ibm.com>
 <1907698.219Ro8drPf@new-mexico>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1907698.219Ro8drPf@new-mexico>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 15, 2016 at 10:47:52AM +1000, Alistair Popple wrote:
>Hi Gavin,
>
>I was reading through this to understand how it all works and noticed a couple
>of things, comments below.
>

Alistair, thanks for your time on review.

>
>On Wed, 17 Feb 2016 14:44:28 Gavin Shan wrote:
>
><snip>
>
>> +
>> +static void pnv_php_handle_poweron(struct pnv_php_slot *php_slot)
>> +{
>> +	void *fdt, *fdt1, *dt;
>> +	int confirm = PNV_PHP_POWER_CONFIRMED_SUCCESS;
>> +	int ret;
>> +
>> +	/* We don't know the FDT blob size. We try to get it through
>> +	 * maximal memory chunk and then copy it to another chunk that
>> +	 * fits the real size.
>> +	 */
>> +	fdt1 = kzalloc(0x10000, GFP_KERNEL);
>> +	if (!fdt1)
>> +		goto error;
>> +
>> +	ret = pnv_pci_get_device_tree(php_slot->dn->phandle, fdt1, 0x10000);
>> +	if (ret)
>> +		goto free_fdt1;
>> +
>> +	fdt = kzalloc(fdt_totalsize(fdt1), GFP_KERNEL);
>> +	if (!fdt)
>> +		goto free_fdt1;
>> +
>> +	/* Unflatten device tree blob */
>> +	memcpy(fdt, fdt1, fdt_totalsize(fdt1));
>> +	dt = of_fdt_unflatten_tree(fdt, php_slot->dn, NULL);
>> +	if (!dt) {
>> +		dev_warn(&php_slot->pdev->dev, "Cannot unflatten FDT\n");
>> +		goto free_fdt;
>> +	}
>> +
>> +	/* Initialize and apply the changeset */
>> +	of_changeset_init(&php_slot->ocs);
>> +	ret = pnv_php_populate_changeset(&php_slot->ocs, php_slot->dn);
>> +	if (ret) {
>> +		dev_warn(&php_slot->pdev->dev, "Error %d populating changeset\n",
>> +			 ret);
>> +		goto free_dt;
>> +	}
>> +
>> +	php_slot->dn->child = NULL;
>> +	ret = of_changeset_apply(&php_slot->ocs);
>> +	if (ret) {
>> +		dev_warn(&php_slot->pdev->dev, "Error %d applying changeset\n",
>> +			 ret);
>> +		goto destroy_changeset;
>> +	}
>> +
>> +	/* Add device node firmware data */
>> +	pnv_php_add_pdns(php_slot);
>> +	php_slot->fdt = fdt;
>> +	php_slot->dt  = dt;
>> +	goto out;
>
>Doesn't this leak memory from fdt1? I can't see where it gets freed in this
>case.
>

You're right that @fdt1 should be released here. I'll fix it in
next revision.

>> +destroy_changeset:
>> +	of_changeset_destroy(&php_slot->ocs);
>> +free_dt:
>> +	kfree(dt);
>> +	php_slot->dn->child = NULL;
>> +free_fdt:
>> +	kfree(fdt);
>> +free_fdt1:
>> +	kfree(fdt1);
>> +error:
>> +	confirm = PNV_PHP_POWER_CONFIRMED_FAIL;
>> +out:
>> +	/* Confirm status change */
>> +	php_slot->power_state_confirmed = confirm;
>> +	wake_up_interruptible(&php_slot->queue);
>> +}
>> +
>
><snip>
>
>> +
>> +static void __exit pnv_php_exit(void)
>> +{
>> +	struct device_node *dn;
>> +
>> +	for_each_compatible_node(dn, NULL, "ibm,ioda-phb")
>> +		pnv_php_unregister(dn);
>> +	for_each_compatible_node(dn, NULL, "ibm,ioda2-phb")
>> +		pnv_php_unregister(dn);
>> +
>> +	pnv_pci_hotplug_notifier_unregister(&php_msg_nb);
>
>Do you flush the workqueues anywhere? Usually you would stop work being queued 
>and call something like flush_workqueue() to ensure no work is still
>running/queued before unloading the module.
>

Good question. Yeah, I'll flush the workqueue before the module is going
to be unloaded.

Thanks,
Gavin

>- Alistair
>
>> +}
>> +
>> +module_init(pnv_php_init);
>> +module_exit(pnv_php_exit);
>> +
>> +MODULE_VERSION(DRIVER_VERSION);
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_AUTHOR(DRIVER_AUTHOR);
>> +MODULE_DESCRIPTION(DRIVER_DESC);
>> 
>

