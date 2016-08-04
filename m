Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33077 "EHLO
	mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759179AbcHDWsv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Aug 2016 18:48:51 -0400
Received: by mail-qk0-f196.google.com with SMTP id x189so14009621qkd.0
        for <linux-pci@vger.kernel.org>; Thu, 04 Aug 2016 15:48:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1470348549-10855-1-git-send-email-keith.busch@intel.com>
References: <1470348549-10855-1-git-send-email-keith.busch@intel.com>
From: Myron Stowe <myron.stowe@gmail.com>
Date: Thu, 4 Aug 2016 16:48:29 -0600
Message-ID: <CAL-B5D2H96XyvXUYxq23BVvHeb-UMi3hYzw6u_mRNPR_S5xYXQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] vmd: Fix infinite loop executing irq's
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jon Derrick <jonathan.derrick@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 4, 2016 at 4:09 PM, Keith Busch <keith.busch@intel.com> wrote:
> We can't initialize the list head on deletion as this causes the node
> to point to itself, looping infinitely if the vmd IRQ handler happens
> to be servicing that node.
>
> The list initialization supposed to fix a bug from multiple calls to
> disable the same IRQ. We can fix this instead just checking if the
> previous pointer indicates it was already deleted.
>

Should this have one or possibly more"fixes" lines here?

???Fixes: 97e9230 ("x86/PCI: VMD: Initialize list item in IRQ disable")???

> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  arch/x86/pci/vmd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/pci/vmd.c b/arch/x86/pci/vmd.c
> index e88b417..2294907 100644
> --- a/arch/x86/pci/vmd.c
> +++ b/arch/x86/pci/vmd.c
> @@ -136,8 +136,8 @@ static void vmd_irq_disable(struct irq_data *data)
>         data->chip->irq_mask(data);
>
>         raw_spin_lock_irqsave(&list_lock, flags);
> -       list_del_rcu(&vmdirq->node);
> -       INIT_LIST_HEAD_RCU(&vmdirq->node);
> +       if (vmdirq->node.prev != LIST_POISON2)
> +               list_del_rcu(&vmdirq->node);
>         raw_spin_unlock_irqrestore(&list_lock, flags);
>  }
>
> --
> 2.7.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
