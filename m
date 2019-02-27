Return-Path: <SRS0=6dzI=RC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A4DC43381
	for <linux-pci@archiver.kernel.org>; Wed, 27 Feb 2019 12:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88ED8213A2
	for <linux-pci@archiver.kernel.org>; Wed, 27 Feb 2019 12:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730145AbfB0Met (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 27 Feb 2019 07:34:49 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42033 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729963AbfB0Mes (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Feb 2019 07:34:48 -0500
Received: by mail-wr1-f66.google.com with SMTP id r5so17740343wrg.9
        for <linux-pci@vger.kernel.org>; Wed, 27 Feb 2019 04:34:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=aH1nxPjlEJ1ommeN6Q0Hi5p8PHdcZMF1mJPDmbqf5No=;
        b=QPLSWTf2ME47BYqUhEJWAqaj5QZFRKmCwLmTBuuGXRnDgLJrR/lfanzuPCDguKEEEW
         pTq4I/he8opKTs1gK5XYzSjIsp5tHoGkgeeTBtZCPpH28ctP/ABFLS5F90CTrVPrQFOP
         tw5bsBKfb83F9C+Gw+eB0wjdnUiKkxyQPv+yQjUx9KgtMM02USdpabR/f0zpyxubFXJ0
         qCMQIq308eQyH+tfzsizr5KjOg8viI7RrrC3NdKAkQ5c5pxsfktcTzAUauyfgzd0DxsD
         imzYi2Flbe4Bu3pEMnf2Bah2cCB08zxYRfHUM7AYPwtkIbXvG91eWVf9gqcn01UOSlhI
         UU8A==
X-Gm-Message-State: APjAAAU2CsrKdbG6nOl88yDL56rIJEu1vfQntBotCOnRDGbAlhu5uBSF
        7mjNxeH8+Feu/FKYaurPuBbABg==
X-Google-Smtp-Source: APXvYqzMbGElj2ebTa4Efnt1pu8q7aIdNUxqsYmLGqTXJM1RANOs6/cW2VPMzSudrxKIAk4uz0v5pQ==
X-Received: by 2002:adf:c752:: with SMTP id b18mr2267142wrh.105.1551270886889;
        Wed, 27 Feb 2019 04:34:46 -0800 (PST)
Received: from vitty.brq.redhat.com (ip-213-220-248-130.net.upcbroadband.cz. [213.220.248.130])
        by smtp.gmail.com with ESMTPSA id f68sm2830557wmg.5.2019.02.27.04.34.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Feb 2019 04:34:46 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Maya Nakamura <m.maya.nakamura@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        driverdev-devel@linuxdriverproject.org, haiyangz@microsoft.com,
        marcelo.cerri@canonical.com, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org, kys@microsoft.com,
        sthemmin@microsoft.com, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, mikelley@microsoft.com,
        Alexander.Levin@microsoft.com
Subject: Re: [PATCH v3 2/2] PCI: hv: Refactor hv_irq_unmask() to use cpumask_to_vpset()
In-Reply-To: <00e13af711510001e589c7b1ddd75beb99f58db5.1548745212.git.m.maya.nakamura@gmail.com>
References: <cover.1548745212.git.m.maya.nakamura@gmail.com> <00e13af711510001e589c7b1ddd75beb99f58db5.1548745212.git.m.maya.nakamura@gmail.com>
Date:   Wed, 27 Feb 2019 13:34:44 +0100
Message-ID: <87sgw9qujf.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Maya Nakamura <m.maya.nakamura@gmail.com> writes:

> Remove the duplicate implementation of cpumask_to_vpset() and use the
> shared implementation. Export hv_max_vp_index, which is required by
> cpumask_to_vpset().
>
> Apply changes to hv_irq_unmask() based on feedback.
>

I just noticed an issue with this patch, sorry I've missed it before. I
don't see the commit in Linus' tree, not sure if we should amend this
one or a follow-up patch is needed.

> Signed-off-by: Maya Nakamura <m.maya.nakamura@gmail.com>
> ---
> Changes in v3:
>  - Modify to catch all failures from cpumask_to_vpset().
>  - Correct the v2 change log about the commit message.
>
> Changes in v2:
>  - Remove unnecessary nr_bank initialization.
>  - Delete two unnecessary dev_err()'s.
>  - Unlock before returning.
>  - Update the commit message.
>
>  arch/x86/hyperv/hv_init.c           |  1 +
>  drivers/pci/controller/pci-hyperv.c | 38 +++++++++++++----------------
>  2 files changed, 18 insertions(+), 21 deletions(-)
>
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 7abb09e2eeb8..7f2eed1fc81b 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -96,6 +96,7 @@ void  __percpu **hyperv_pcpu_input_arg;
>  EXPORT_SYMBOL_GPL(hyperv_pcpu_input_arg);
>  
>  u32 hv_max_vp_index;
> +EXPORT_SYMBOL_GPL(hv_max_vp_index);
>  
>  static int hv_cpu_init(unsigned int cpu)
>  {
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index da8b58d8630d..a78def332bbc 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -391,8 +391,6 @@ struct hv_interrupt_entry {
>  	u32	data;
>  };
>  
> -#define HV_VP_SET_BANK_COUNT_MAX	5 /* current implementation limit */
> -
>  /*
>   * flags for hv_device_interrupt_target.flags
>   */
> @@ -908,12 +906,12 @@ static void hv_irq_unmask(struct irq_data *data)
>  	struct retarget_msi_interrupt *params;
>  	struct hv_pcibus_device *hbus;
>  	struct cpumask *dest;
> +	cpumask_var_t tmp;
>  	struct pci_bus *pbus;
>  	struct pci_dev *pdev;
>  	unsigned long flags;
>  	u32 var_size = 0;
> -	int cpu_vmbus;
> -	int cpu;
> +	int cpu, nr_bank;
>  	u64 res;
>  
>  	dest = irq_data_get_effective_affinity_mask(data);
> @@ -953,29 +951,27 @@ static void hv_irq_unmask(struct irq_data *data)
>  		 */
>  		params->int_target.flags |=
>  			HV_DEVICE_INTERRUPT_TARGET_PROCESSOR_SET;
> -		params->int_target.vp_set.valid_bank_mask =
> -			(1ull << HV_VP_SET_BANK_COUNT_MAX) - 1;
> +
> +		if (!alloc_cpumask_var(&tmp, GFP_KERNEL)) {

We can't use GFP_KERNEL here: this is happening under
hbus->retarget_msi_interrupt_lock spinlock, we should use GFP_ATOMIC
instead. It may, however, make sense to add the cpumask to a
pre-allocated structure (e.g. struct hv_pcibus_device) to make sure the
allocation never fails.

> +			res = 1;
> +			goto exit_unlock;
> +		}
> +
> +		cpumask_and(tmp, dest, cpu_online_mask);
> +		nr_bank = cpumask_to_vpset(&params->int_target.vp_set, tmp);
> +		free_cpumask_var(tmp);
> +
> +		if (nr_bank <= 0) {
> +			res = 1;
> +			goto exit_unlock;
> +		}
>  
>  		/*
>  		 * var-sized hypercall, var-size starts after vp_mask (thus
>  		 * vp_set.format does not count, but vp_set.valid_bank_mask
>  		 * does).
>  		 */
> -		var_size = 1 + HV_VP_SET_BANK_COUNT_MAX;
> -
> -		for_each_cpu_and(cpu, dest, cpu_online_mask) {
> -			cpu_vmbus = hv_cpu_number_to_vp_number(cpu);
> -
> -			if (cpu_vmbus >= HV_VP_SET_BANK_COUNT_MAX * 64) {
> -				dev_err(&hbus->hdev->device,
> -					"too high CPU %d", cpu_vmbus);
> -				res = 1;
> -				goto exit_unlock;
> -			}
> -
> -			params->int_target.vp_set.bank_contents[cpu_vmbus / 64]	|=
> -				(1ULL << (cpu_vmbus & 63));
> -		}
> +		var_size = 1 + nr_bank;
>  	} else {
>  		for_each_cpu_and(cpu, dest, cpu_online_mask) {
>  			params->int_target.vp_mask |=

-- 
Vitaly
