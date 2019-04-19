Return-Path: <SRS0=PPlZ=SV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F3BC282DF
	for <linux-pci@archiver.kernel.org>; Fri, 19 Apr 2019 20:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB3F217F9
	for <linux-pci@archiver.kernel.org>; Fri, 19 Apr 2019 20:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555704480;
	bh=YJ6gM6cRP0XI2cm66rSap8Bm/o2FouiO08BaCkQjMCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gb6WPMtPRLd36IiE6bgY+PDcHaBES9BHuyKC//lY8K+7qMfrrW5C3eTTDAFmnxH67
	 B7rlrR++2Uey5PmM8yrxvw5XyBPHsiXmPAodIRDYf2A4xbkO29wShjZ6WOMepz3/5l
	 KlOJE5xD498aS199ZBN3ipFm6ZtkV3mKiRvtu4Aw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfDSUHt (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Apr 2019 16:07:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:34928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726187AbfDSUHt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Apr 2019 16:07:49 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E081A2171F;
        Fri, 19 Apr 2019 20:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555704467;
        bh=YJ6gM6cRP0XI2cm66rSap8Bm/o2FouiO08BaCkQjMCY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gM/rySOR3ij8TRVlG+j6Vis16lewaY79Zs6stFo0YbCQNbwrbbrvrn6cQGrqgq8wt
         dA6muVaR7W2FBG5/OZxNHCzj9YYum7/xQ+JUV7ffmY2hqQRVVkO2zx6lIVxcHKFzMa
         vM4oB1Rsej1FCCFA/Z5TdUqBE7DJ6YQZAG5tYXCw=
Date:   Fri, 19 Apr 2019 15:07:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc:     austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        okaya@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] PCI / ACPI: Remove the need for 'struct
 hotplug_params'
Message-ID: <20190419200745.GH173520@google.com>
References: <20190208162414.3996-1-mr.nuke.me@gmail.com>
 <20190208162414.3996-3-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208162414.3996-3-mr.nuke.me@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 08, 2019 at 10:24:12AM -0600, Alexandru Gagniuc wrote:
> We used to first parse all the _HPP and _HPX tables before using the
> information to program registers of PCIe devices. Up until HPX type 2,
> there was only one structure of each type, so we could cheat and store
> it on the stack.
> 
> With HPX type 3 we get an arbitrary number of entries, so the above
> model doesn't scale that well. Instead of parsing all tables at once,
> parse and program each entry separately. For _HPP and _HPX 0 thru 2,
> this is functionally equivalent. The change enables the upcoming _HPX3
> to integrate more easily.

I think this is tremendous!  It's going to simplify this code
dramatically.  Two comments below.

> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> ---
>  drivers/pci/pci-acpi.c      | 108 +++++++++++++++++++-----------------
>  drivers/pci/probe.c         |  16 ++----
>  include/linux/pci_hotplug.h |  18 +++---
>  3 files changed, 72 insertions(+), 70 deletions(-)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index b25e5fa9d1c9..95f4f86d2f34 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -119,7 +119,7 @@ phys_addr_t acpi_pci_root_get_mcfg_addr(acpi_handle handle)
>  }
>  
>  static acpi_status decode_type0_hpx_record(union acpi_object *record,
> -					   struct hotplug_params *hpx)
> +					   struct hpp_type0 *hpx0)
>  {
>  	int i;
>  	union acpi_object *fields = record->package.elements;
> @@ -132,12 +132,11 @@ static acpi_status decode_type0_hpx_record(union acpi_object *record,
>  		for (i = 2; i < 6; i++)
>  			if (fields[i].type != ACPI_TYPE_INTEGER)
>  				return AE_ERROR;
> -		hpx->t0 = &hpx->type0_data;
> -		hpx->t0->revision        = revision;
> -		hpx->t0->cache_line_size = fields[2].integer.value;
> -		hpx->t0->latency_timer   = fields[3].integer.value;
> -		hpx->t0->enable_serr     = fields[4].integer.value;
> -		hpx->t0->enable_perr     = fields[5].integer.value;
> +		hpx0->revision        = revision;
> +		hpx0->cache_line_size = fields[2].integer.value;
> +		hpx0->latency_timer   = fields[3].integer.value;
> +		hpx0->enable_serr     = fields[4].integer.value;
> +		hpx0->enable_perr     = fields[5].integer.value;
>  		break;
>  	default:
>  		printk(KERN_WARNING
> @@ -149,7 +148,7 @@ static acpi_status decode_type0_hpx_record(union acpi_object *record,
>  }
>  
>  static acpi_status decode_type1_hpx_record(union acpi_object *record,
> -					   struct hotplug_params *hpx)
> +					   struct hpp_type1 *hpx1)
>  {
>  	int i;
>  	union acpi_object *fields = record->package.elements;
> @@ -162,11 +161,10 @@ static acpi_status decode_type1_hpx_record(union acpi_object *record,
>  		for (i = 2; i < 5; i++)
>  			if (fields[i].type != ACPI_TYPE_INTEGER)
>  				return AE_ERROR;
> -		hpx->t1 = &hpx->type1_data;
> -		hpx->t1->revision      = revision;
> -		hpx->t1->max_mem_read  = fields[2].integer.value;
> -		hpx->t1->avg_max_split = fields[3].integer.value;
> -		hpx->t1->tot_max_split = fields[4].integer.value;
> +		hpx1->revision      = revision;
> +		hpx1->max_mem_read  = fields[2].integer.value;
> +		hpx1->avg_max_split = fields[3].integer.value;
> +		hpx1->tot_max_split = fields[4].integer.value;
>  		break;
>  	default:
>  		printk(KERN_WARNING
> @@ -178,7 +176,7 @@ static acpi_status decode_type1_hpx_record(union acpi_object *record,
>  }
>  
>  static acpi_status decode_type2_hpx_record(union acpi_object *record,
> -					   struct hotplug_params *hpx)
> +					   struct hpp_type2 *hpx2)
>  {
>  	int i;
>  	union acpi_object *fields = record->package.elements;
> @@ -191,24 +189,23 @@ static acpi_status decode_type2_hpx_record(union acpi_object *record,
>  		for (i = 2; i < 18; i++)
>  			if (fields[i].type != ACPI_TYPE_INTEGER)
>  				return AE_ERROR;
> -		hpx->t2 = &hpx->type2_data;
> -		hpx->t2->revision      = revision;
> -		hpx->t2->unc_err_mask_and      = fields[2].integer.value;
> -		hpx->t2->unc_err_mask_or       = fields[3].integer.value;
> -		hpx->t2->unc_err_sever_and     = fields[4].integer.value;
> -		hpx->t2->unc_err_sever_or      = fields[5].integer.value;
> -		hpx->t2->cor_err_mask_and      = fields[6].integer.value;
> -		hpx->t2->cor_err_mask_or       = fields[7].integer.value;
> -		hpx->t2->adv_err_cap_and       = fields[8].integer.value;
> -		hpx->t2->adv_err_cap_or        = fields[9].integer.value;
> -		hpx->t2->pci_exp_devctl_and    = fields[10].integer.value;
> -		hpx->t2->pci_exp_devctl_or     = fields[11].integer.value;
> -		hpx->t2->pci_exp_lnkctl_and    = fields[12].integer.value;
> -		hpx->t2->pci_exp_lnkctl_or     = fields[13].integer.value;
> -		hpx->t2->sec_unc_err_sever_and = fields[14].integer.value;
> -		hpx->t2->sec_unc_err_sever_or  = fields[15].integer.value;
> -		hpx->t2->sec_unc_err_mask_and  = fields[16].integer.value;
> -		hpx->t2->sec_unc_err_mask_or   = fields[17].integer.value;
> +		hpx2->revision      = revision;
> +		hpx2->unc_err_mask_and      = fields[2].integer.value;
> +		hpx2->unc_err_mask_or       = fields[3].integer.value;
> +		hpx2->unc_err_sever_and     = fields[4].integer.value;
> +		hpx2->unc_err_sever_or      = fields[5].integer.value;
> +		hpx2->cor_err_mask_and      = fields[6].integer.value;
> +		hpx2->cor_err_mask_or       = fields[7].integer.value;
> +		hpx2->adv_err_cap_and       = fields[8].integer.value;
> +		hpx2->adv_err_cap_or        = fields[9].integer.value;
> +		hpx2->pci_exp_devctl_and    = fields[10].integer.value;
> +		hpx2->pci_exp_devctl_or     = fields[11].integer.value;
> +		hpx2->pci_exp_lnkctl_and    = fields[12].integer.value;
> +		hpx2->pci_exp_lnkctl_or     = fields[13].integer.value;
> +		hpx2->sec_unc_err_sever_and = fields[14].integer.value;
> +		hpx2->sec_unc_err_sever_or  = fields[15].integer.value;
> +		hpx2->sec_unc_err_mask_and  = fields[16].integer.value;
> +		hpx2->sec_unc_err_mask_or   = fields[17].integer.value;
>  		break;
>  	default:
>  		printk(KERN_WARNING
> @@ -219,17 +216,18 @@ static acpi_status decode_type2_hpx_record(union acpi_object *record,
>  	return AE_OK;
>  }
>  
> -static acpi_status acpi_run_hpx(acpi_handle handle, struct hotplug_params *hpx)
> +static acpi_status acpi_run_hpx(struct pci_dev *dev, acpi_handle handle,
> +				const struct hotplug_program_ops *hp_ops)
>  {
>  	acpi_status status;
>  	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
>  	union acpi_object *package, *record, *fields;
> +	struct hpp_type0 hpx0;
> +	struct hpp_type1 hpx1;
> +	struct hpp_type2 hpx2;
>  	u32 type;
>  	int i;
>  
> -	/* Clear the return buffer with zeros */
> -	memset(hpx, 0, sizeof(struct hotplug_params));
> -
>  	status = acpi_evaluate_object(handle, "_HPX", NULL, &buffer);
>  	if (ACPI_FAILURE(status))
>  		return status;
> @@ -257,19 +255,25 @@ static acpi_status acpi_run_hpx(acpi_handle handle, struct hotplug_params *hpx)
>  		type = fields[0].integer.value;
>  		switch (type) {
>  		case 0:
> -			status = decode_type0_hpx_record(record, hpx);
> +			memset(&hpx0, 0, sizeof(hpx0));
> +			status = decode_type0_hpx_record(record, &hpx0);
>  			if (ACPI_FAILURE(status))
>  				goto exit;
> +			hp_ops->program_type0(dev, &hpx0);
>  			break;
>  		case 1:
> -			status = decode_type1_hpx_record(record, hpx);
> +			memset(&hpx1, 0, sizeof(hpx1));
> +			status = decode_type1_hpx_record(record, &hpx1);
>  			if (ACPI_FAILURE(status))
>  				goto exit;
> +			hp_ops->program_type1(dev, &hpx1);
>  			break;
>  		case 2:
> -			status = decode_type2_hpx_record(record, hpx);
> +			memset(&hpx2, 0, sizeof(hpx2));
> +			status = decode_type2_hpx_record(record, &hpx2);
>  			if (ACPI_FAILURE(status))
>  				goto exit;
> +			hp_ops->program_type2(dev, &hpx2);
>  			break;
>  		default:
>  			printk(KERN_ERR "%s: Type %d record not supported\n",
> @@ -283,14 +287,16 @@ static acpi_status acpi_run_hpx(acpi_handle handle, struct hotplug_params *hpx)
>  	return status;
>  }
>  
> -static acpi_status acpi_run_hpp(acpi_handle handle, struct hotplug_params *hpp)
> +static acpi_status acpi_run_hpp(struct pci_dev *dev, acpi_handle handle,
> +				const struct hotplug_program_ops *hp_ops)
>  {
>  	acpi_status status;
>  	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
>  	union acpi_object *package, *fields;
> +	struct hpp_type0 hpp0;
>  	int i;
>  
> -	memset(hpp, 0, sizeof(struct hotplug_params));
> +	memset(&hpp0, 0, sizeof(hpp0));
>  
>  	status = acpi_evaluate_object(handle, "_HPP", NULL, &buffer);
>  	if (ACPI_FAILURE(status))
> @@ -311,12 +317,13 @@ static acpi_status acpi_run_hpp(acpi_handle handle, struct hotplug_params *hpp)
>  		}
>  	}
>  
> -	hpp->t0 = &hpp->type0_data;
> -	hpp->t0->revision        = 1;
> -	hpp->t0->cache_line_size = fields[0].integer.value;
> -	hpp->t0->latency_timer   = fields[1].integer.value;
> -	hpp->t0->enable_serr     = fields[2].integer.value;
> -	hpp->t0->enable_perr     = fields[3].integer.value;
> +	hpp0.revision        = 1;
> +	hpp0.cache_line_size = fields[0].integer.value;
> +	hpp0.latency_timer   = fields[1].integer.value;
> +	hpp0.enable_serr     = fields[2].integer.value;
> +	hpp0.enable_perr     = fields[3].integer.value;
> +
> +	hp_ops->program_type0(dev, &hpp0);
>  
>  exit:
>  	kfree(buffer.pointer);
> @@ -328,7 +335,8 @@ static acpi_status acpi_run_hpp(acpi_handle handle, struct hotplug_params *hpp)
>   * @dev - the pci_dev for which we want parameters
>   * @hpp - allocated by the caller
>   */
> -int pci_get_hp_params(struct pci_dev *dev, struct hotplug_params *hpp)
> +int pci_acpi_program_hp_params(struct pci_dev *dev,
> +			       const struct hotplug_program_ops *hp_ops)
>  {
>  	acpi_status status;
>  	acpi_handle handle, phandle;
> @@ -351,10 +359,10 @@ int pci_get_hp_params(struct pci_dev *dev, struct hotplug_params *hpp)
>  	 * this pci dev.
>  	 */
>  	while (handle) {
> -		status = acpi_run_hpx(handle, hpp);
> +		status = acpi_run_hpx(dev, handle, hp_ops);
>  		if (ACPI_SUCCESS(status))
>  			return 0;
> -		status = acpi_run_hpp(handle, hpp);
> +		status = acpi_run_hpp(dev, handle, hp_ops);
>  		if (ACPI_SUCCESS(status))
>  			return 0;
>  		if (acpi_is_root_bridge(handle))
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 257b9f6f2ebb..527c209f0c94 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2131,8 +2131,11 @@ static void pci_configure_eetlp_prefix(struct pci_dev *dev)
>  
>  static void pci_configure_device(struct pci_dev *dev)
>  {
> -	struct hotplug_params hpp;
> -	int ret;
> +	static const struct hotplug_program_ops hp_ops = {
> +		.program_type0 = program_hpp_type0,
> +		.program_type1 = program_hpp_type1,
> +		.program_type2 = program_hpp_type2,
> +	};

What if we just moved program_hpp_type0(), etc from probe.c to
pci-acpi.c?  The only reason I see to have it in probe.c is for
pci_default_type0, and I think that is a pretty obtuse way of doing
default configuration.  I would have no problem at all just hardcoding
those defaults in probe.c and then potentially having them overwritten
by _HPP/_HPX.

If we moved program_hpp_type0(), etc to pci-acpi.c, we could get rid
of the function pointers and all the ACPI-related code would be in one
place.

>  	pci_configure_mps(dev);
>  	pci_configure_extended_tags(dev, NULL);
> @@ -2140,14 +2143,7 @@ static void pci_configure_device(struct pci_dev *dev)
>  	pci_configure_ltr(dev);
>  	pci_configure_eetlp_prefix(dev);
>  
> -	memset(&hpp, 0, sizeof(hpp));
> -	ret = pci_get_hp_params(dev, &hpp);
> -	if (ret)
> -		return;
> -
> -	program_hpp_type2(dev, hpp.t2);
> -	program_hpp_type1(dev, hpp.t1);
> -	program_hpp_type0(dev, hpp.t0);
> +	pci_acpi_program_hp_params(dev, &hp_ops);
>  }
>  
>  static void pci_release_capabilities(struct pci_dev *dev)
> diff --git a/include/linux/pci_hotplug.h b/include/linux/pci_hotplug.h
> index 7acc9f91e72b..c85378edf235 100644
> --- a/include/linux/pci_hotplug.h
> +++ b/include/linux/pci_hotplug.h
> @@ -124,26 +124,24 @@ struct hpp_type2 {
>  	u32 sec_unc_err_mask_or;
>  };
>  
> -struct hotplug_params {
> -	struct hpp_type0 *t0;		/* Type0: NULL if not available */
> -	struct hpp_type1 *t1;		/* Type1: NULL if not available */
> -	struct hpp_type2 *t2;		/* Type2: NULL if not available */
> -	struct hpp_type0 type0_data;
> -	struct hpp_type1 type1_data;
> -	struct hpp_type2 type2_data;
> +struct hotplug_program_ops {
> +	void (*program_type0)(struct pci_dev *dev, struct hpp_type0 *hpp);
> +	void (*program_type1)(struct pci_dev *dev, struct hpp_type1 *hpp);
> +	void (*program_type2)(struct pci_dev *dev, struct hpp_type2 *hpp);
>  };

I think a lot of this stuff is only used in drivers/pci, so it could
be moved from include/linux/pci_hotplug.h to drivers/pci/pci.h.

>  #ifdef CONFIG_ACPI
>  #include <linux/acpi.h>
> -int pci_get_hp_params(struct pci_dev *dev, struct hotplug_params *hpp);
> +int pci_acpi_program_hp_params(struct pci_dev *dev,
> +			       const struct hotplug_program_ops *hp_ops);
>  bool pciehp_is_native(struct pci_dev *bridge);
>  int acpi_get_hp_hw_control_from_firmware(struct pci_dev *bridge);
>  bool shpchp_is_native(struct pci_dev *bridge);
>  int acpi_pci_check_ejectable(struct pci_bus *pbus, acpi_handle handle);
>  int acpi_pci_detect_ejectable(acpi_handle handle);
>  #else
> -static inline int pci_get_hp_params(struct pci_dev *dev,
> -				    struct hotplug_params *hpp)
> +int pci_acpi_program_hp_params(struct pci_dev *dev,
> +			       const struct hotplug_program_ops *hp_ops);
>  {
>  	return -ENODEV;
>  }
> -- 
> 2.19.2
> 
