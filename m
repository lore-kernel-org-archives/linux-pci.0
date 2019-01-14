Return-Path: <SRS0=hqs4=PW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C9BC43387
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 20:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 283802070B
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 20:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547496085;
	bh=UQEG3AkTNg/eXcqBGuu0XV28hBYeMsJX+w/ioWRBFvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ue9fy3C+YYSdY4brfCsSjxkHDkZyBfXbUcVoUe3qowZqcSitI233XWvAyJwPm3B4y
	 U/oB7HGLMAcOJM4wGRPmBS2fs4YyglnFU2ysx6FhVR2xzcFbUKg8KBhUGBrvLYdPEp
	 Bv+aorISCOo61af4SxUT3rtQKUYdTu9OoDC1Aw4c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfANUBY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:01:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:36996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726728AbfANUBY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Jan 2019 15:01:24 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 200C020656;
        Mon, 14 Jan 2019 20:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547496082;
        bh=UQEG3AkTNg/eXcqBGuu0XV28hBYeMsJX+w/ioWRBFvA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NnhpSX0f8zpIeyfuOnXVoeV/cv0HumEcS3LDiRv8Su2xH2Zd0V8KCp1wxpC5dH7aG
         Fkcd8fSrJ72KUxVgIzwsVVgMiUh1+yyXjSy4aD/8GPE48vxhxRoJev/7fPkYmM839D
         VOU5oBCYjfGPol3tttWjzUo2CUKlrP6hxqrhqEKM=
Date:   Mon, 14 Jan 2019 14:01:20 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc:     austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        okaya@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] PCI / ACPI: Implementing Type 3 _HPX records
Message-ID: <20190114200120.GA33971@google.com>
References: <20190110231136.31163-1-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110231136.31163-1-mr.nuke.me@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 10, 2019 at 05:11:27PM -0600, Alexandru Gagniuc wrote:
> _HPX Type 3 is intended to be more generic and allow configuration of
> settings not possible with Type 2 tables. For example, FW could ensure
> that the completion timeout value is set accordingly throughout the PCI
> tree; some switches require very special handling.
> 
> Type 3 can come in an arbitrary number of ACPI packages. With the older
> types we only ever had one descriptor. We could get lazy and store it
> on the stack. The current flow is to parse the HPX table
> --pci_get_hp_params()-- and then program the PCIe device registers.
> 
> In the current flow, we'll need to malloc(). Here's what I tried:
>  1) devm_kmalloc() on the pci_dev
>   This ended up giving me NULL dereference at boot time.

Yeah, I don't think devm_*() is going to work because that's part of the
driver binding model; this is in the PCI core and this use is not related
to the lifetime of a driver's binding to a device.

>  2) Add a cleanup function to be called after writing the PCIe registers
> 
> This RFC implements method 2. The HPX3 stuff is still NDA'd, but the
> housekeeping parts are in here. Is this a good way to do things? I'm not
> too sure about the need to call cleanup() on a stack variable. But if
> not that, then what else?

pci_get_hp_params() is currently exported, but only used inside
drivers/pci, so I think it could be unexported.

I don't remember if there's a reason why things are split between
pci_get_hp_params(), which runs _HPX or _HPP, and the program_hpp_type*()
functions.  If we could get rid of that split, we could get rid of struct
hotplug_params and do the configuration directly in the pci_get_hp_params()
path.  I think that would simplify the memory management.

Bjorn

> ---
>  drivers/pci/pci-acpi.c      | 88 +++++++++++++++++++++++++++++++++++++
>  drivers/pci/probe.c         | 29 ++++++++++++
>  include/linux/pci_hotplug.h | 17 +++++++
>  3 files changed, 134 insertions(+)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index e1949f7efd9c..2ce1b68ce688 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -219,6 +219,65 @@ static acpi_status decode_type2_hpx_record(union acpi_object *record,
>  	return AE_OK;
>  }
>  
> +static acpi_status parse_hpx3_register(struct hpp_type3 *hpx3,
> +				       union acpi_object *reg_fields)
> +{
> +	struct hpp_type3_register *hpx3_reg;
> +
> +	hpx3_reg = kzalloc(sizeof(*hpx3_reg), GFP_KERNEL);
> +	if (!hpx3_reg)
> +		return AE_NO_MEMORY;
> +
> +	/* Parse fields blurb */
> +
> +	list_add_tail(&hpx3_reg->list, &hpx3->regs);
> +	return AE_OK;
> +}
> +
> +static acpi_status decode_type3_hpx_record(union acpi_object *record,
> +					   struct hotplug_params *hpx)
> +{
> +	union acpi_object *fields = record->package.elements;
> +	u32 desc_count, expected_length, revision;
> +	union acpi_object *reg_fields;
> +	acpi_status ret;
> +	int i;
> +
> +	revision = fields[1].integer.value;
> +	switch (revision) {
> +	case 1:
> +		desc_count = fields[2].integer.value;
> +		expected_length = 3 + desc_count * 14;
> +
> +		if (record->package.count != expected_length)
> +			return AE_ERROR;
> +
> +		for (i = 2; i < expected_length; i++)
> +			if (fields[i].type != ACPI_TYPE_INTEGER)
> +				return AE_ERROR;
> +
> +		if (!hpx->t3) {
> +			INIT_LIST_HEAD(&hpx->type3_data.regs);
> +			hpx->t3 = &hpx->type3_data;
> +		}
> +
> +		for (i = 0; i < desc_count; i++) {
> +			reg_fields = fields + 3 + i * 14;
> +			ret = parse_hpx3_register(hpx->t3, reg_fields);
> +			if (ret != AE_OK)
> +				return ret;
> +		}
> +
> +		break;
> +	default:
> +		printk(KERN_WARNING
> +			"%s: Type 3 Revision %d record not supported\n",
> +			__func__, revision);
> +		return AE_ERROR;
> +	}
> +	return AE_OK;
> +}
> +
>  static acpi_status acpi_run_hpx(acpi_handle handle, struct hotplug_params *hpx)
>  {
>  	acpi_status status;
> @@ -271,6 +330,11 @@ static acpi_status acpi_run_hpx(acpi_handle handle, struct hotplug_params *hpx)
>  			if (ACPI_FAILURE(status))
>  				goto exit;
>  			break;
> +		case 3:
> +			status = decode_type3_hpx_record(record, hpx);
> +			if (ACPI_FAILURE(status))
> +				goto exit;
> +			break;
>  		default:
>  			printk(KERN_ERR "%s: Type %d record not supported\n",
>  			       __func__, type);
> @@ -368,6 +432,30 @@ int pci_get_hp_params(struct pci_dev *dev, struct hotplug_params *hpp)
>  }
>  EXPORT_SYMBOL_GPL(pci_get_hp_params);
>  
> +static int cleantup_type3_hpx_record(struct hpp_type3 *hpx3)
> +{
> +	struct hpp_type3_register *reg;
> +	struct list_head *entry, *temp;
> +
> +	list_for_each_safe(entry, temp, &hpp->t3->regs){
> +		reg = list_entry(entry, typeof(*reg), list);
> +		list_del(entry);
> +		kfree(reg);
> +	}
> +}
> +
> +/* pci_cleanup_hp_params
> + *
> + * @hpp - allocated by the caller
> + */
> +void pci_cleanup_hp_params(struct hotplug_params *hpp)
> +{
> +
> +	if (hpp->t3)
> +		cleanup_type3_hpx_record(hpp->t3);
> +}
> +EXPORT_SYMBOL_GPL(pci_cleanup_hp_params);
> +
>  /**
>   * pciehp_is_native - Check whether a hotplug port is handled by the OS
>   * @bridge: Hotplug port to check
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 257b9f6f2ebb..35ef7d1f4f3b 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1979,6 +1979,32 @@ static void program_hpp_type2(struct pci_dev *dev, struct hpp_type2 *hpp)
>  	 */
>  }
>  
> +static void program_hpp_type3_register(struct pci_dev *dev,
> +				       const struct hpp_type3_register *reg)
> +{
> +	/* Complicated ACPI-mandated blurb */
> +}
> +
> +static void program_hpp_type3(struct pci_dev *dev, struct hpp_type3 *hpp)
> +{
> +	struct hpp_type3_register *reg;
> +
> +	if (!hpp)
> +		return;
> +
> +	if (!pci_is_pcie(dev))
> +		return;
> +
> +	if (hpp->revision > 1) {
> +		pci_warn(dev, "PCIe settings rev %d not supported\n",
> +			 hpp->revision);
> +		return;
> +	}
> +
> +	list_for_each_entry(reg, &hpp->regs, list)
> +		program_hpp_type3_register(dev, reg);
> +}
> +
>  int pci_configure_extended_tags(struct pci_dev *dev, void *ign)
>  {
>  	struct pci_host_bridge *host;
> @@ -2145,9 +2171,12 @@ static void pci_configure_device(struct pci_dev *dev)
>  	if (ret)
>  		return;
>  
> +	program_hpp_type3(dev, hpp.t3);
>  	program_hpp_type2(dev, hpp.t2);
>  	program_hpp_type1(dev, hpp.t1);
>  	program_hpp_type0(dev, hpp.t0);
> +
> +	pci_cleanup_hp_params(&hpp);
>  }
>  
>  static void pci_release_capabilities(struct pci_dev *dev)
> diff --git a/include/linux/pci_hotplug.h b/include/linux/pci_hotplug.h
> index 7acc9f91e72b..479da87a3774 100644
> --- a/include/linux/pci_hotplug.h
> +++ b/include/linux/pci_hotplug.h
> @@ -124,18 +124,35 @@ struct hpp_type2 {
>  	u32 sec_unc_err_mask_or;
>  };
>  
> +/*
> + * PCI Express Setting Record (Type 3)
> + * The ACPI overlords can never get enough
> + */
> +struct hpp_type3_register {
> +	u32 crap_describing_entry_contents;
> +	struct list_head list;
> +};
> +
> +struct hpp_type3 {
> +	u32 revision;
> +	struct list_head regs;
> +};
> +
>  struct hotplug_params {
>  	struct hpp_type0 *t0;		/* Type0: NULL if not available */
>  	struct hpp_type1 *t1;		/* Type1: NULL if not available */
>  	struct hpp_type2 *t2;		/* Type2: NULL if not available */
> +	struct hpp_type3 *t3;		/* Type3: NULL if not available */
>  	struct hpp_type0 type0_data;
>  	struct hpp_type1 type1_data;
>  	struct hpp_type2 type2_data;
> +	struct hpp_type3 type3_data;
>  };
>  
>  #ifdef CONFIG_ACPI
>  #include <linux/acpi.h>
>  int pci_get_hp_params(struct pci_dev *dev, struct hotplug_params *hpp);
> +void pci_cleanup_hp_params(struct hotplug_params *hpp);
>  bool pciehp_is_native(struct pci_dev *bridge);
>  int acpi_get_hp_hw_control_from_firmware(struct pci_dev *bridge);
>  bool shpchp_is_native(struct pci_dev *bridge);
> -- 
> 2.19.2
> 
