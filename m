Return-Path: <SRS0=2mbU=OH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06094C43441
	for <linux-pci@archiver.kernel.org>; Wed, 28 Nov 2018 22:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF07220832
	for <linux-pci@archiver.kernel.org>; Wed, 28 Nov 2018 22:03:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF07220832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbeK2JGY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 29 Nov 2018 04:06:24 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:33011 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbeK2JGY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Nov 2018 04:06:24 -0500
Received: from p4fea46ac.dip0.t-ipconnect.de ([79.234.70.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gS7vP-000170-I0; Wed, 28 Nov 2018 23:03:15 +0100
Date:   Wed, 28 Nov 2018 23:03:14 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dou Liyang <douliyangs@gmail.com>
cc:     LKML <linux-kernel@vger.kernel.org>, kashyap.desai@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, sumit.saxena@broadcom.com,
        ming.lei@redhat.com, Christoph Hellwig <hch@lst.de>,
        bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH v3] genirq/affinity: Create and transfer more irq
 desc info by a new structure
In-Reply-To: <20181128164503.6194-1-douliyangs@gmail.com>
Message-ID: <alpine.DEB.2.21.1811282228570.1879@nanos.tec.linutronix.de>
References: <20181128164503.6194-1-douliyangs@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Dou,

On Thu, 29 Nov 2018, Dou Liyang wrote:
> +/**
> + * struct irq_affinity_desc - Description for kinds of irq assignements
> + *		which will be transferred to irqdesc core

Please align this proper

 * struct irq_affinity_desc - Description for kinds of irq assignements
 *			      which will be transferred to irqdesc core

Aside of that, it's not interesting where these structs are going to be
transferred today because that might change tomorrow. So something like
this:

 * struct irq_affinity_desc - Interrupt affinity descriptor


> + * @masks:	cpumask of automatic irq affinity assignments

@mask: please. It's one cpumask per descriptor.

> + * @flags:	flags to differentiate between managed and
> + *		unmanaged interrupts

Again, that's the purpose today.

 * @flags:	Flags to convey complementary information

But see further down.

> + */
> +struct irq_affinity_desc {
> +	struct cpumask masks;
> +	unsigned int	flags;
> +};

Please align the member names vertically with tabs

struct irq_affinity_desc {
	struct cpumask	masks;
	unsigned int	flags;
};

> +/**
> + * irq_create_affinity_desc - Create affinity desc for multiqueue spreading
> + * @nvec:	The total number of vectors
> + * @affd:	Description of the affinity requirements
> + *
> + * Returns the irq_affinity_desc pointer or NULL if allocation failed.
> + */
> +struct irq_affinity_desc *
> +irq_create_affinity_desc(int nvec, const struct irq_affinity *affd)
> +{
> +	struct irq_affinity_desc *cur_affi_desc, *affi_desc = NULL;
> +	struct cpumask *curmask, *masks = NULL;
> +	int i;
> +
> +	masks = irq_create_affinity_masks(nvec, affd);
> +	if (masks) {
> +		affi_desc = kcalloc(nvec, sizeof(*affi_desc), GFP_KERNEL);

Why do you want to do that separate allocation here? Just let
irq_create_affinity_masks() allocate an array of affinity descriptors and
use that. There is no point in copying that stuff over and over. Setting
the flag field can be done in the existing function as well.

>  /**
>   * irq_calc_affinity_vectors - Calculate the optimal number of vectors
>   * @minvec:	The minimum number of vectors available
> diff --git a/kernel/irq/devres.c b/kernel/irq/devres.c
> index 6a682c229e10..2335b89d9bde 100644
> --- a/kernel/irq/devres.c
> +++ b/kernel/irq/devres.c
> @@ -181,14 +181,33 @@ int __devm_irq_alloc_descs(struct device *dev, int irq, unsigned int from,
>  			   unsigned int cnt, int node, struct module *owner,
>  			   const struct cpumask *affinity)
>  {
> +	struct irq_affinity_desc *cur_affi_desc, *affi_desc = NULL;
> +	const struct cpumask *curmask;
>  	struct irq_desc_devres *dr;
> -	int base;
> +	int base, i;
>  
>  	dr = devres_alloc(devm_irq_desc_release, sizeof(*dr), GFP_KERNEL);
>  	if (!dr)
>  		return -ENOMEM;
>  
> -	base = __irq_alloc_descs(irq, from, cnt, node, owner, affinity);
> +	if (affinity) {
> +		affi_desc = kcalloc(cnt, sizeof(*affi_desc), GFP_KERNEL);
> +		if (!affi_desc)
> +			return -ENOMEM;
> +
> +		curmask = affinity;
> +		cur_affi_desc = affi_desc;
> +		for (i = 0; i < cnt; i++) {
> +			cpumask_copy(&cur_affi_desc->masks, curmask);
> +			cur_affi_desc->flags = 1;

No magic constant's please for a flags field. You really want proper
constants for that, but I'd rather avoid the whole flags fiddling
completely. See below.

> +			curmask++;
> +			cur_affi_desc++;
> +		}

Can you please change the function signature and fixup the callers, if
there are any of them? Copying this over and over is horrible.

>  	for (i = 0; i < cnt; i++) {
> -		if (affinity) {
> -			node = cpu_to_node(cpumask_first(affinity));
> -			mask = affinity;
> -			affinity++;
> +		if (affi_desc && affi_desc->flags ) {

Please don't check flags for being !=0. Once we add other information than
the managed/non-managed decision to the flag field, then this will fall
apart.

To avoid issues like that please use explicit bits in the structure instead
of the opaque flags field:

struct irq_affinity_desc {
	struct cpumask	masks;
	unsigned int	managed : 1;
};

So if we add new things later they will have an explicit name and there is
absolute no conflict with existing code.

> +			flags =  IRQD_AFFINITY_MANAGED |
> +				IRQD_MANAGED_SHUTDOWN;
> +		} else
> +			flags = 0;

If you need braces for the if then the else path wants them as well.

> +
> +		if (affi_desc) {
> +			mask = &affi_desc->masks;
> +			node = cpu_to_node(cpumask_first(mask));
> +			affi_desc++;
>  		}

>  int irq_domain_alloc_descs(int virq, unsigned int cnt, irq_hw_number_t hwirq,
> -			   int node, const struct cpumask *affinity)
> +			   int node, const struct irq_affinity_desc *affi_desc)

You can spare a lot of pointless churn by just keeping the 'affinity' name
and only changing the struct type. The compiler will catch all places which
need to be fixed and 'affinity' is generic enough to be used with the new
struct type as well. As Bjorn said, even 'masks' is fine.

Other than the things I pointed out, the whole thing starts to look
palatable. Please split it up in the way Bjorn suggested and avoid the
extra hoops and loops where possible.

Thanks,

	tglx
