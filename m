Return-Path: <SRS0=Sdll=QA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7602C282C3
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 13:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B5DF21855
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 13:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbfAXNMS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 24 Jan 2019 08:12:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53234 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727798AbfAXNMS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Jan 2019 08:12:18 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EC6AE796E5;
        Thu, 24 Jan 2019 13:12:17 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DDD5B6CDB0;
        Thu, 24 Jan 2019 13:12:14 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Maya Nakamura <m.maya.nakamura@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        driverdev-devel@linuxdriverproject.org, haiyangz@microsoft.com,
        marcelo.cerri@canonical.com, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org, kys@microsoft.com,
        sthemmin@microsoft.com, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, mikelley@microsoft.com,
        Alexander.Levin@microsoft.com
Subject: Re: [PATCH 1/2] PCI: hv: Replace hv_vp_set with hv_vpset
In-Reply-To: <87ffdc2eb0642301516378feb1416cf7450bf6c1.1548232616.git.m.maya.nakamura@gmail.com>
References: <cover.1548232616.git.m.maya.nakamura@gmail.com> <87ffdc2eb0642301516378feb1416cf7450bf6c1.1548232616.git.m.maya.nakamura@gmail.com>
Date:   Thu, 24 Jan 2019 14:12:13 +0100
Message-ID: <87sgxi19oy.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 24 Jan 2019 13:12:18 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Maya Nakamura <m.maya.nakamura@gmail.com> writes:

> Remove a duplicate definition of VP set (hv_vp_set) and use the common
> definition (hv_vpset) that is used in other places.
>
> Signed-off-by: Maya Nakamura <m.maya.nakamura@gmail.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 9ba4d12c179c..da8b58d8630d 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -393,12 +393,6 @@ struct hv_interrupt_entry {
>  
>  #define HV_VP_SET_BANK_COUNT_MAX	5 /* current implementation limit */
>  
> -struct hv_vp_set {
> -	u64	format;			/* 0 (HvGenericSetSparse4k) */
> -	u64	valid_banks;
> -	u64	masks[HV_VP_SET_BANK_COUNT_MAX];
> -};
> -
>  /*
>   * flags for hv_device_interrupt_target.flags
>   */
> @@ -410,7 +404,7 @@ struct hv_device_interrupt_target {
>  	u32	flags;
>  	union {
>  		u64		 vp_mask;
> -		struct hv_vp_set vp_set;
> +		struct hv_vpset vp_set;
>  	};
>  };
>  
> @@ -460,12 +454,16 @@ struct hv_pcibus_device {
>  	struct msi_controller msi_chip;
>  	struct irq_domain *irq_domain;
>  
> -	/* hypercall arg, must not cross page boundary */
> -	struct retarget_msi_interrupt retarget_msi_interrupt_params;
> -
>  	spinlock_t retarget_msi_interrupt_lock;
>  
>  	struct workqueue_struct *wq;
> +
> +	/* hypercall arg, must not cross page boundary */
> +	struct retarget_msi_interrupt retarget_msi_interrupt_params;
> +
> +	/*
> +	 * Don't put anything here: retarget_msi_interrupt_params must be last
> +	 */


This change seems to be unrelated and not anyhow described in the commit
message - or did I miss something?

>  };
>  
>  /*
> @@ -955,12 +953,13 @@ static void hv_irq_unmask(struct irq_data *data)
>  		 */
>  		params->int_target.flags |=
>  			HV_DEVICE_INTERRUPT_TARGET_PROCESSOR_SET;
> -		params->int_target.vp_set.valid_banks =
> +		params->int_target.vp_set.valid_bank_mask =
>  			(1ull << HV_VP_SET_BANK_COUNT_MAX) - 1;
>  
>  		/*
>  		 * var-sized hypercall, var-size starts after vp_mask (thus
> -		 * vp_set.format does not count, but vp_set.valid_banks does).
> +		 * vp_set.format does not count, but vp_set.valid_bank_mask
> +		 * does).
>  		 */
>  		var_size = 1 + HV_VP_SET_BANK_COUNT_MAX;
>  
> @@ -974,7 +973,7 @@ static void hv_irq_unmask(struct irq_data *data)
>  				goto exit_unlock;
>  			}
>  
> -			params->int_target.vp_set.masks[cpu_vmbus / 64] |=
> +			params->int_target.vp_set.bank_contents[cpu_vmbus / 64]	|=
>  				(1ULL << (cpu_vmbus & 63));
>  		}
>  	} else {

-- 
Vitaly
