Return-Path: <SRS0=EJXn=O3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26390C43387
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 15:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F401D20815
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 15:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbeLRP0G (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 18 Dec 2018 10:26:06 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:56376 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbeLRP0G (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Dec 2018 10:26:06 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gZHFx-00048u-P1; Tue, 18 Dec 2018 16:26:01 +0100
Date:   Tue, 18 Dec 2018 16:26:01 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dou Liyang <douliyangs@gmail.com>
cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        kashyap.desai@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, sumit.saxena@broadcom.com,
        ming.lei@redhat.com, hch@lst.de, bhelgaas@google.com,
        douliyang1@huawei.com
Subject: Re: [PATCH 2/3] irq/affinity: Add is_managed into struct
 irq_affinity_desc
In-Reply-To: <20181204155122.6327-3-douliyangs@gmail.com>
Message-ID: <alpine.DEB.2.21.1812181545340.14031@nanos.tec.linutronix.de>
References: <20181204155122.6327-1-douliyangs@gmail.com> <20181204155122.6327-3-douliyangs@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 4 Dec 2018, Dou Liyang wrote:
> diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
> index 1562a36e7c0f..d122575ba1b4 100644
> --- a/kernel/irq/affinity.c
> +++ b/kernel/irq/affinity.c
> @@ -289,6 +289,13 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
>  	for (; curvec < nvecs; curvec++)
>  		cpumask_copy(&masks[curvec].mask, irq_default_affinity);
>  
> +	/*  Setup complementary information */
> +	for (i = 0; i < nvecs; i++) {
> +		if (i >= affd->pre_vectors && i < nvecs - affd->post_vectors)
> +			masks[i].is_managed = 1;
> +		else
> +			masks[i].is_managed = 0;

Why want you clear the bit? The masks are allocated with kcalloc() so it's
clear already.

+	/* Mark the managed interrupts */
+	for (i = affd->pre_vectors; i < nvecs - affd->post_vectors; i++)
+		masks[i].is_managed = 1;
+

Is what I made it instead.

Thanks,

	tglx
