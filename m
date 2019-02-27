Return-Path: <SRS0=6dzI=RC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64ACC43381
	for <linux-pci@archiver.kernel.org>; Wed, 27 Feb 2019 15:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF02921850
	for <linux-pci@archiver.kernel.org>; Wed, 27 Feb 2019 15:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfB0Pxm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 27 Feb 2019 10:53:42 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34645 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbfB0Pxm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Feb 2019 10:53:42 -0500
Received: by mail-wm1-f65.google.com with SMTP id o10so4712576wmc.1
        for <linux-pci@vger.kernel.org>; Wed, 27 Feb 2019 07:53:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=m7DVhD5wxdIIkLXCBI495iizwRTQSSHMEMP3dcoxXCk=;
        b=rYyjHfpTn8sKZlTycvUiKe0+AbY/shBxWL/tp+VOEfsTkKGIySqZnMLdR60K/MYUcc
         2KRrugIsPFdD9steu8/X0t+ALDhq8rrb1Xp4tZHUtk1/us/TsOkORh3ysgm5AiLoXFUc
         Fc+sBjH8XcJpvia5dIqedXsUmiTiLmPI7eqrGn1Sg+qRc0GZEyO5OE/lTcDxKZHsbYxW
         iOQsNhml2L51Bmg03FyOPeRxEitdip1q7nCrWQmowO1Zy7XYx9muyLzIYhzsiKZaT+3X
         lywlzbT4q8Zyhbn/rgGj9Hkyxs5fHzeLy7UK2neOSD2vCo4e9aBldlxj4UTXGUs63iEU
         Jr+w==
X-Gm-Message-State: APjAAAVh8brzg+fb4IrVl4guzTUT5g2SENuJHSB2FPlkO9aHax+R/tBr
        DagtI/vq+zkoEQQJ3IU7NYuN8g==
X-Google-Smtp-Source: AHgI3IaQHDVQ0/t16OJLTN03dMuGxs6bCy8tlv/WoO6cZwL1DwStleQzkSsgiFkL0hOvRuUT4hkV7w==
X-Received: by 2002:a1c:3c02:: with SMTP id j2mr2845763wma.72.1551282819633;
        Wed, 27 Feb 2019 07:53:39 -0800 (PST)
Received: from vitty.brq.redhat.com (ip-213-220-248-130.net.upcbroadband.cz. [213.220.248.130])
        by smtp.gmail.com with ESMTPSA id l21sm2170849wme.38.2019.02.27.07.53.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Feb 2019 07:53:38 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Maya Nakamura <m.maya.nakamura@gmail.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, kys@microsoft.com,
        sthemmin@microsoft.com, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, mikelley@microsoft.com,
        Alexander.Levin@microsoft.com, linux-kernel@vger.kernel.org,
        driverdev-devel@linuxdriverproject.org, haiyangz@microsoft.com,
        marcelo.cerri@canonical.com
Subject: Re: [PATCH v3 1/2] PCI: hv: Replace hv_vp_set with hv_vpset
In-Reply-To: <19aea785b78cf14c71f58bf278df17dc3adf8368.1548745212.git.m.maya.nakamura@gmail.com>
References: <cover.1548745212.git.m.maya.nakamura@gmail.com> <19aea785b78cf14c71f58bf278df17dc3adf8368.1548745212.git.m.maya.nakamura@gmail.com>
Date:   Wed, 27 Feb 2019 16:53:37 +0100
Message-ID: <87k1hlqlby.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Maya Nakamura <m.maya.nakamura@gmail.com> writes:

> Remove a duplicate definition of VP set (hv_vp_set) and use the common
> definition (hv_vpset) that is used in other places.
>
> Change the order of the members in struct hv_pcibus_device so that the
> declaration of retarget_msi_interrupt_params is the last member. Struct
> hv_vpset, which contains a flexible array, is nested two levels deep in
> struct hv_pcibus_device via retarget_msi_interrupt_params.
>
> Add a comment that retarget_msi_interrupt_params should be the last member
> of struct hv_pcibus_device.
>
> Signed-off-by: Maya Nakamura <m.maya.nakamura@gmail.com>
> ---
> Change in v3:
> - Correct the v2 change log.
>
> Change in v2:
> - Update the commit message.
>
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

One more thing here (and again sorry for being late): this structure is
being used as Hyper-V hypercall argument and these have special
requirements on alignment (8 bytes). struct retarget_msi_interrupt is
packed and depending on your environment/compiler you may or may not see
the issue but I has able to get HVCALL_RETARGET_INTERRUPT failing with
the return value of 4 (HV_STATUS_INVALID_ALIGNMENT).

I suggest we add __aligned(8) to 'struct retarget_msi_interrupt'
definition (I haven't tested this but should work). This is not a new
issue, it existed before your patch, but the code movement you do may
change the exposure.


> +	/*
> +	 * Don't put anything here: retarget_msi_interrupt_params must be last
> +	 */
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
