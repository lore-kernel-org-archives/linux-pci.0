Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:58158 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751838Ab3FJTkV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 10 Jun 2013 15:40:21 -0400
Date: Mon, 10 Jun 2013 21:39:58 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Yinghai Lu <yinghai@kernel.org>
cc: Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Gordeev <agordeev@redhat.com>
Subject: Re: [PATCH v3 10/27] genirq: Split __irq_reserve_irqs from
 irq_alloc_descs
In-Reply-To: <1370644273-10495-11-git-send-email-yinghai@kernel.org>
Message-ID: <alpine.LFD.2.02.1306102125410.22970@ionos>
References: <1370644273-10495-1-git-send-email-yinghai@kernel.org> <1370644273-10495-11-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 7 Jun 2013, Yinghai Lu wrote:
>  /**
> - * irq_alloc_descs - allocate and initialize a range of irq descriptors
> - * @irq:	Allocate for specific irq number if irq >= 0
> + * __irq_reserve_descs - reserve and initialize a range of irq descriptors

Did you even bother to run docbook ?

No you didn't. Otherwise you'd have noticed that documentation for
__irq_reserve_descs is not the right thing for a function named
__irq_reserve_irqs.

> + * __irq_reserve_descs - reserve and initialize a range of irq descriptors

The function only reserves a range of irq descriptors and does not
initialize them.

> +
> +/**
> + * irq_alloc_descs - allocate and initialize a range of irq descriptors

Again you document non matching function names.

> +int __ref
> +__irq_alloc_descs(int irq, unsigned int from, unsigned int cnt, int node,
> +		  struct module *owner)

Sloppy as usual along with a sucky changelog as usual.....

Thanks,

	tglx
