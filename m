Return-Path: <SRS0=2mbU=OH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8256C43441
	for <linux-pci@archiver.kernel.org>; Wed, 28 Nov 2018 21:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4B0A20832
	for <linux-pci@archiver.kernel.org>; Wed, 28 Nov 2018 21:28:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4B0A20832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbeK2Ib0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 29 Nov 2018 03:31:26 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:32983 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbeK2Ib0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Nov 2018 03:31:26 -0500
Received: from p4fea46ac.dip0.t-ipconnect.de ([79.234.70.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gS7Nd-0000m7-Oe; Wed, 28 Nov 2018 22:28:21 +0100
Date:   Wed, 28 Nov 2018 22:28:20 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Bjorn Helgaas <bhelgaas@google.com>
cc:     douliyangs@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        shivasharan.srikanteshwara@broadcom.com,
        Sumit Saxena <sumit.saxena@broadcom.com>, ming.lei@redhat.com,
        Christoph Hellwig <hch@lst.de>, linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH v3] genirq/affinity: Create and transfer more irq
 desc info by a new structure
In-Reply-To: <CAErSpo5NCy6C7xqaWUNnC2uY+RRpZnbpOJUQxrz0aER-g6+XqQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1811282226280.1879@nanos.tec.linutronix.de>
References: <20181128164503.6194-1-douliyangs@gmail.com> <CAErSpo5NCy6C7xqaWUNnC2uY+RRpZnbpOJUQxrz0aER-g6+XqQ@mail.gmail.com>
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

On Wed, 28 Nov 2018, Bjorn Helgaas wrote:
> On Wed, Nov 28, 2018 at 10:45 AM Dou Liyang <douliyangs@gmail.com> wrote:
> >         if (affd)
> > -               masks = irq_create_affinity_masks(nvec, affd);
> > -
> > +               affi_desc = irq_create_affinity_desc(nvec, affd);
> >
> >         /* MSI Entry Initialization */
> > -       entry = alloc_msi_entry(&dev->dev, nvec, masks);
> > +       entry = alloc_msi_entry(&dev->dev, nvec, affi_desc);
> 
> Can you split this into two or more patches?  Most of these changes
> are trivial and not very interesting, and the fact that they're all in
> one patch makes it hard to find and review the interesting bits.  For
> example,
> 
>   1) Rename all the local variables while keeping the type the same
> (or just leave the name the same; I think "affinity" would be a fine
> name, and I would be OK if we ended up with "struct irq_affinity_desc
> *masks" or "struct irq_affinity_desc *affinity").  This patch would
> obviously have no functional impact and would remove a lot of the
> trivial changes.
> 
>   2) Add "struct irq_affinity_desc" containing only "struct cpumask
> masks" and irq_create_affinity_desc() (or leave the name as
> irq_create_affinity_masks() and adjust the signature).  This would
> also have no functional impact and would be a fairly trivial patch.
> 
>   3) Add "flags" to struct irq_affinity_desc and the related code.
> This is the real meat of your patch, and with the above out of the
> way, it will be much smaller and it'll be obvious what the important
> changes are.

You beat me to it. I was going to ask the same thing. Albeit I'll go over
the conceptual stuff right now as I roughly know what it tries to achieve.

Thanks,

	tglx
