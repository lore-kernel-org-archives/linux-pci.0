Return-Path: <SRS0=2mbU=OH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E236C43610
	for <linux-pci@archiver.kernel.org>; Wed, 28 Nov 2018 20:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C447120832
	for <linux-pci@archiver.kernel.org>; Wed, 28 Nov 2018 20:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VlnoUrwV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C447120832
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbeK2HDK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 29 Nov 2018 02:03:10 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54395 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbeK2HDJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Nov 2018 02:03:09 -0500
Received: by mail-wm1-f66.google.com with SMTP id z18so3941472wmc.4
        for <linux-pci@vger.kernel.org>; Wed, 28 Nov 2018 12:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/AQ7HD5jj7jwHClH+T1p5mi+UkMnW6XmrNEd0NA5XW0=;
        b=VlnoUrwVFLbxMUq38tF/ATsnPOIyYIPOueMjAobxjciEHqyCR9jjSi1ioUqhqse+8Y
         MQ9ogf/zx61kQ0aT7jPh/DH3fvUwHTFRH57Rc4t35+qn+YsW7SzV+iRkH6kYyYBRzoc9
         NpKmcP2rU/ot8oFgyEGjq8rDWCZFKQzTpj7DyPKVNPSj7NIMvy3Z2DVqftJcFv6Ll1LM
         WbE+a+eOlL2Yb85Oujgd5Ci8Ke5SUrYrXaWfd6sYlnQbDqEbYJLGLKrma5XvXFaeRrfg
         ERDTC/45Zgng02iYSkeeHXJTTZuUVEbVOkKh2yVKY2n4nQrnXcVDKdu3L9uJCYIy7uuN
         lbzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/AQ7HD5jj7jwHClH+T1p5mi+UkMnW6XmrNEd0NA5XW0=;
        b=PcCm9D2aI6Fvy34pMEeJQdYU6o8SuPHciwLC+FiWWwVIHDXcejq7LCnao4HzTnPi+7
         WqI8Q2we409Cgn6IDl5LJ+DQSJmReQknPf6HSxkbEilj6Ww3QgjcyMkUxGkjbmBqdyXD
         0YF99Gn7kb1+RQLd3BQsFwS42npBbLxXUOD3m6KYpp8gtir2UU1Aunl2wh8v0DNY24xb
         2LdruUy4sUnm2GCUgQxQCdmD7IjVloL1jFm0ius0am5NNrJHn6+N3I2BfPmUBL3vIZEr
         drRW1JufLoQzDcnELOBYlw070GuPxV91z7OXRHP/4sMjodsvw7o00kk3UjF1vo2GdDG6
         6lLw==
X-Gm-Message-State: AA+aEWY8611qoPSZQL72V2wjbO+4NaW6GIg56XK+iThzOPihjjpxamfi
        3QJzMeXMtesIQXpQELwVGNwx8tCn95hznoLjF8G/
X-Google-Smtp-Source: AFSGD/U1DMmAfieygMaCIxdK9dlHOkhr2dYg2YkOv4iZGEo2AcJcDt+VuSuKkm2Jg8ev+aZmGh8J0THVBPetw3dhOvg=
X-Received: by 2002:a7b:ca44:: with SMTP id m4mr3954949wml.76.1543435216303;
 Wed, 28 Nov 2018 12:00:16 -0800 (PST)
MIME-Version: 1.0
References: <20181128164503.6194-1-douliyangs@gmail.com>
In-Reply-To: <20181128164503.6194-1-douliyangs@gmail.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Wed, 28 Nov 2018 14:00:03 -0600
Message-ID: <CAErSpo5NCy6C7xqaWUNnC2uY+RRpZnbpOJUQxrz0aER-g6+XqQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3] genirq/affinity: Create and transfer more irq desc
 info by a new structure
To:     douliyangs@gmail.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        shivasharan.srikanteshwara@broadcom.com,
        Sumit Saxena <sumit.saxena@broadcom.com>, ming.lei@redhat.com,
        Christoph Hellwig <hch@lst.de>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc linux-pci]

On Wed, Nov 28, 2018 at 10:45 AM Dou Liyang <douliyangs@gmail.com> wrote:
>
> Now, Linux just spread the irq affinity to irqdesc core by a cpumask pointer.
> if an Vector's affinity is not NULL, it will be marked as managed.
>
> But, as Kashyap and Sumit reported, in MSI/-x subsystem, the pre/post vectors
> may be used to some extra reply queues for performance. their affinities are
> not NULL, but, they should be mapped as unmanaged interrupts. So, only
> transfering the irq affinity assignments is not enough
>
> Create a new structure named irq_affinity_desc, which include both the irq
> affinity masks and flags. Replace the cpumask pointer with a irq_affinity_desc
> pointer which allows to expand this in the future without touching all the
> functions ever again, just modify the data irq_affinity_desc structure.
>
> Reported-by: Kashyap Desai <kashyap.desai@broadcom.com>
> Reported-by: Sumit Saxena <sumit.saxena@broadcom.com>

Since you mention reports, are there URLs to mailing list archives you
can include?

> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Dou Liyang <douliyangs@gmail.com>
> ---
> Changelog:
>   v2 --> v3
>   - Create a new irq_affinity_desc pointer to transfer the info
>     suggested by tglx
>   - rebase to the tip irq/core branch
>
>   v1 --> v2
>   - Add a bitmap for marking if an interrupt is managed or not.
>   the size of bitmap is runtime allocation.
>
>   - Need more tests, Just test this patch in QEmu.
>
>   - v1: https://lkml.org/lkml/2018/9/13/366
>
>  drivers/pci/msi.c         | 29 ++++++++++++++--------------
>  include/linux/interrupt.h | 19 ++++++++++++++++---
>  include/linux/irq.h       |  3 ++-
>  include/linux/irqdomain.h |  7 ++++---
>  include/linux/msi.h       |  4 ++--
>  kernel/irq/affinity.c     | 40 +++++++++++++++++++++++++++++++++++++--
>  kernel/irq/devres.c       | 23 ++++++++++++++++++++--
>  kernel/irq/irqdesc.c      | 32 +++++++++++++++++++------------
>  kernel/irq/irqdomain.c    | 14 +++++++-------
>  kernel/irq/msi.c          | 21 ++++++++++----------
>  10 files changed, 135 insertions(+), 57 deletions(-)
>
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 265ed3e4c920..431449163316 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -534,16 +534,15 @@ static int populate_msi_sysfs(struct pci_dev *pdev)
>  static struct msi_desc *
>  msi_setup_entry(struct pci_dev *dev, int nvec, const struct irq_affinity *affd)
>  {
> -       struct cpumask *masks = NULL;
> +       struct irq_affinity_desc *affi_desc = NULL;
>         struct msi_desc *entry;
>         u16 control;
>
>         if (affd)
> -               masks = irq_create_affinity_masks(nvec, affd);
> -
> +               affi_desc = irq_create_affinity_desc(nvec, affd);
>
>         /* MSI Entry Initialization */
> -       entry = alloc_msi_entry(&dev->dev, nvec, masks);
> +       entry = alloc_msi_entry(&dev->dev, nvec, affi_desc);

Can you split this into two or more patches?  Most of these changes
are trivial and not very interesting, and the fact that they're all in
one patch makes it hard to find and review the interesting bits.  For
example,

  1) Rename all the local variables while keeping the type the same
(or just leave the name the same; I think "affinity" would be a fine
name, and I would be OK if we ended up with "struct irq_affinity_desc
*masks" or "struct irq_affinity_desc *affinity").  This patch would
obviously have no functional impact and would remove a lot of the
trivial changes.

  2) Add "struct irq_affinity_desc" containing only "struct cpumask
masks" and irq_create_affinity_desc() (or leave the name as
irq_create_affinity_masks() and adjust the signature).  This would
also have no functional impact and would be a fairly trivial patch.

  3) Add "flags" to struct irq_affinity_desc and the related code.
This is the real meat of your patch, and with the above out of the
way, it will be much smaller and it'll be obvious what the important
changes are.

>         if (!entry)
>                 goto out;
>
> @@ -567,7 +566,7 @@ msi_setup_entry(struct pci_dev *dev, int nvec, const struct irq_affinity *affd)
>                 pci_read_config_dword(dev, entry->mask_pos, &entry->masked);
>
>  out:
> -       kfree(masks);
> +       kfree(affi_desc);
>         return entry;
>  }
>
> @@ -672,15 +671,15 @@ static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
>                               struct msix_entry *entries, int nvec,
>                               const struct irq_affinity *affd)
>  {
> -       struct cpumask *curmsk, *masks = NULL;
> +       struct irq_affinity_desc *cur_affi_desc, *affi_desc = NULL;
>         struct msi_desc *entry;
>         int ret, i;
>
>         if (affd)
> -               masks = irq_create_affinity_masks(nvec, affd);
> +               affi_desc = irq_create_affinity_desc(nvec, affd);
>
> -       for (i = 0, curmsk = masks; i < nvec; i++) {
> -               entry = alloc_msi_entry(&dev->dev, 1, curmsk);
> +       for (i = 0, cur_affi_desc = affi_desc; i < nvec; i++) {
> +               entry = alloc_msi_entry(&dev->dev, 1, cur_affi_desc);
>                 if (!entry) {
>                         if (!i)
>                                 iounmap(base);
> @@ -701,12 +700,12 @@ static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
>                 entry->mask_base                = base;
>
>                 list_add_tail(&entry->list, dev_to_msi_list(&dev->dev));
> -               if (masks)
> -                       curmsk++;
> +               if (affi_desc)
> +                       cur_affi_desc++;
>         }
>         ret = 0;
>  out:
> -       kfree(masks);
> +       kfree(affi_desc);
>         return ret;
>  }
>
> @@ -1264,7 +1263,7 @@ const struct cpumask *pci_irq_get_affinity(struct pci_dev *dev, int nr)
>
>                 for_each_pci_msi_entry(entry, dev) {
>                         if (i == nr)
> -                               return entry->affinity;
> +                               return &entry->affi_desc->masks;
>                         i++;
>                 }
>                 WARN_ON_ONCE(1);
> @@ -1272,11 +1271,11 @@ const struct cpumask *pci_irq_get_affinity(struct pci_dev *dev, int nr)
>         } else if (dev->msi_enabled) {
>                 struct msi_desc *entry = first_pci_msi_entry(dev);
>
> -               if (WARN_ON_ONCE(!entry || !entry->affinity ||
> +               if (WARN_ON_ONCE(!entry || !entry->affi_desc ||
>                                  nr >= entry->nvec_used))
>                         return NULL;
>
> -               return &entry->affinity[nr];
> +               return &entry->affi_desc[nr].masks;
>         } else {
>                 return cpu_possible_mask;
>         }
> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> index ca397ff40836..fec342eeca06 100644
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -257,6 +257,18 @@ struct irq_affinity {
>         int     *sets;
>  };
>
> +/**
> + * struct irq_affinity_desc - Description for kinds of irq assignements
> + *             which will be transferred to irqdesc core
> + * @masks:     cpumask of automatic irq affinity assignments
> + * @flags:     flags to differentiate between managed and
> + *             unmanaged interrupts
> + */
> +struct irq_affinity_desc {
> +       struct cpumask masks;
> +       unsigned int    flags;

Looks like "flags" is indented with tab but "masks" uses space?

> +};
> +
>  #if defined(CONFIG_SMP)
>
>  extern cpumask_var_t irq_default_affinity;
> @@ -303,7 +315,8 @@ extern int irq_set_affinity_hint(unsigned int irq, const struct cpumask *m);
>  extern int
>  irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify);
>
> -struct cpumask *irq_create_affinity_masks(int nvec, const struct irq_affinity *affd);
> +struct irq_affinity_desc *
> +irq_create_affinity_desc(int nvec, const struct irq_affinity *affd);
>  int irq_calc_affinity_vectors(int minvec, int maxvec, const struct irq_affinity *affd);
>
>  #else /* CONFIG_SMP */
> @@ -337,8 +350,8 @@ irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify)
>         return 0;
>  }
>
> -static inline struct cpumask *
> -irq_create_affinity_masks(int nvec, const struct irq_affinity *affd)
> +static inline struct irq_affinity_desc *
> +irq_create_affinity_desc(int nvec, const struct irq_affinity *affd)
>  {
>         return NULL;
>  }
> diff --git a/include/linux/irq.h b/include/linux/irq.h
> index c9bffda04a45..b5b992a1b825 100644
> --- a/include/linux/irq.h
> +++ b/include/linux/irq.h
> @@ -27,6 +27,7 @@
>  struct seq_file;
>  struct module;
>  struct msi_msg;
> +struct irq_affinity_desc;
>  enum irqchip_irq_state;
>
>  /*
> @@ -834,7 +835,7 @@ struct cpumask *irq_data_get_effective_affinity_mask(struct irq_data *d)
>  unsigned int arch_dynirq_lower_bound(unsigned int from);
>
>  int __irq_alloc_descs(int irq, unsigned int from, unsigned int cnt, int node,
> -                     struct module *owner, const struct cpumask *affinity);
> +               struct module *owner, const struct irq_affinity_desc *affi_desc);
>
>  int __devm_irq_alloc_descs(struct device *dev, int irq, unsigned int from,
>                            unsigned int cnt, int node, struct module *owner,
> diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
> index 068aa46f0d55..1e181a01342b 100644
> --- a/include/linux/irqdomain.h
> +++ b/include/linux/irqdomain.h
> @@ -43,6 +43,7 @@ struct irq_chip;
>  struct irq_data;
>  struct cpumask;
>  struct seq_file;
> +struct irq_affinity_desc;
>
>  /* Number of irqs reserved for a legacy isa controller */
>  #define NUM_ISA_INTERRUPTS     16
> @@ -266,7 +267,7 @@ extern bool irq_domain_check_msi_remap(void);
>  extern void irq_set_default_host(struct irq_domain *host);
>  extern int irq_domain_alloc_descs(int virq, unsigned int nr_irqs,
>                                   irq_hw_number_t hwirq, int node,
> -                                 const struct cpumask *affinity);
> +                                 const struct irq_affinity_desc *affi_desc);
>
>  static inline struct fwnode_handle *of_node_to_fwnode(struct device_node *node)
>  {
> @@ -448,8 +449,8 @@ static inline struct irq_domain *irq_domain_add_hierarchy(struct irq_domain *par
>  }
>
>  extern int __irq_domain_alloc_irqs(struct irq_domain *domain, int irq_base,
> -                                  unsigned int nr_irqs, int node, void *arg,
> -                                  bool realloc, const struct cpumask *affinity);
> +                       unsigned int nr_irqs, int node, void *arg,
> +                       bool realloc, const struct irq_affinity_desc *affi_desc);
>  extern void irq_domain_free_irqs(unsigned int virq, unsigned int nr_irqs);
>  extern int irq_domain_activate_irq(struct irq_data *irq_data, bool early);
>  extern void irq_domain_deactivate_irq(struct irq_data *irq_data);
> diff --git a/include/linux/msi.h b/include/linux/msi.h
> index 0e9c50052ff3..5dfcc4ec137d 100644
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -76,7 +76,7 @@ struct msi_desc {
>         unsigned int                    nvec_used;
>         struct device                   *dev;
>         struct msi_msg                  msg;
> -       struct cpumask                  *affinity;
> +       struct irq_affinity_desc        *affi_desc;
>
>         union {
>                 /* PCI MSI/X specific data */
> @@ -136,7 +136,7 @@ static inline void pci_write_msi_msg(unsigned int irq, struct msi_msg *msg)
>  #endif /* CONFIG_PCI_MSI */
>
>  struct msi_desc *alloc_msi_entry(struct device *dev, int nvec,
> -                                const struct cpumask *affinity);
> +                                const struct irq_affinity_desc *affi_desc);
>  void free_msi_entry(struct msi_desc *entry);
>  void __pci_read_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
>  void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
> diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
> index 08c904eb7279..67c44438bd97 100644
> --- a/kernel/irq/affinity.c
> +++ b/kernel/irq/affinity.c
> @@ -221,14 +221,14 @@ static int irq_build_affinity_masks(const struct irq_affinity *affd,
>         return ret;
>  }
>
> -/**
> +/*
>   * irq_create_affinity_masks - Create affinity masks for multiqueue spreading
>   * @nvecs:     The total number of vectors
>   * @affd:      Description of the affinity requirements
>   *
>   * Returns the masks pointer or NULL if allocation failed.
>   */
> -struct cpumask *
> +static struct cpumask *
>  irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
>  {
>         int affvecs = nvecs - affd->pre_vectors - affd->post_vectors;
> @@ -292,6 +292,42 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
>         return masks;
>  }
>
> +/**
> + * irq_create_affinity_desc - Create affinity desc for multiqueue spreading
> + * @nvec:      The total number of vectors
> + * @affd:      Description of the affinity requirements
> + *
> + * Returns the irq_affinity_desc pointer or NULL if allocation failed.
> + */
> +struct irq_affinity_desc *
> +irq_create_affinity_desc(int nvec, const struct irq_affinity *affd)
> +{
> +       struct irq_affinity_desc *cur_affi_desc, *affi_desc = NULL;
> +       struct cpumask *curmask, *masks = NULL;
> +       int i;
> +
> +       masks = irq_create_affinity_masks(nvec, affd);
> +       if (masks) {
> +               affi_desc = kcalloc(nvec, sizeof(*affi_desc), GFP_KERNEL);
> +               if (!affi_desc)
> +                       return NULL;
> +
> +               curmask = masks;
> +               cur_affi_desc = affi_desc;
> +               for (i = 0; i < nvec; i++) {
> +                       cpumask_copy(&cur_affi_desc->masks, curmask);
> +                       if (i >= affd->pre_vectors &&
> +                                       i < nvec - affd->post_vectors)
> +                               cur_affi_desc->flags = 1;
> +                       curmask++;
> +                       cur_affi_desc++;
> +               }
> +               kfree(masks);
> +       }
> +
> +       return affi_desc;

This would be simpler as:

  masks = irq_create_affinity_masks(...);
  if (!masks)
    return NULL;

  affi_desc = kcalloc(...);
  if (!affi_desc) {
    kfree(masks);   # this fixes a leak in your original patch
    return NULL;
  }
  ...

> +}
> +
>  /**
>   * irq_calc_affinity_vectors - Calculate the optimal number of vectors
>   * @minvec:    The minimum number of vectors available
> diff --git a/kernel/irq/devres.c b/kernel/irq/devres.c
> index 6a682c229e10..2335b89d9bde 100644
> --- a/kernel/irq/devres.c
> +++ b/kernel/irq/devres.c
> @@ -181,14 +181,33 @@ int __devm_irq_alloc_descs(struct device *dev, int irq, unsigned int from,
>                            unsigned int cnt, int node, struct module *owner,
>                            const struct cpumask *affinity)
>  {
> +       struct irq_affinity_desc *cur_affi_desc, *affi_desc = NULL;

Unnecessary init.

> +       const struct cpumask *curmask;
>         struct irq_desc_devres *dr;
> -       int base;
> +       int base, i;
>
>         dr = devres_alloc(devm_irq_desc_release, sizeof(*dr), GFP_KERNEL);
>         if (!dr)
>                 return -ENOMEM;
>
> -       base = __irq_alloc_descs(irq, from, cnt, node, owner, affinity);
> +       if (affinity) {
> +               affi_desc = kcalloc(cnt, sizeof(*affi_desc), GFP_KERNEL);
> +               if (!affi_desc)
> +                       return -ENOMEM;
> +
> +               curmask = affinity;
> +               cur_affi_desc = affi_desc;
> +               for (i = 0; i < cnt; i++) {
> +                       cpumask_copy(&cur_affi_desc->masks, curmask);
> +                       cur_affi_desc->flags = 1;
> +                       curmask++;
> +                       cur_affi_desc++;
> +               }
> +       }
> +
> +       base = __irq_alloc_descs(irq, from, cnt, node, owner, affi_desc);
> +       kfree(affi_desc);
> +
>         if (base < 0) {
>                 devres_free(dr);
>                 return base;
> diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
> index 578d0e5f1b5b..c554958c547a 100644
> --- a/kernel/irq/irqdesc.c
> +++ b/kernel/irq/irqdesc.c
> @@ -449,29 +449,37 @@ static void free_desc(unsigned int irq)
>  }
>
>  static int alloc_descs(unsigned int start, unsigned int cnt, int node,
> -                      const struct cpumask *affinity, struct module *owner)
> +               const struct irq_affinity_desc *affi_desc, struct module *owner)
>  {
> +       const struct irq_affinity_desc *cur_affi_desc = affi_desc;
>         const struct cpumask *mask = NULL;
>         struct irq_desc *desc;
>         unsigned int flags;
>         int i;
>
>         /* Validate affinity mask(s) */
> -       if (affinity) {
> -               for (i = 0, mask = affinity; i < cnt; i++, mask++) {
> +       if (affi_desc) {
> +               for (i = 0; i < cnt; i++) {
> +                       mask = &cur_affi_desc->masks;
>                         if (cpumask_empty(mask))
>                                 return -EINVAL;
> +                       cur_affi_desc++;
>                 }
>         }
>
> -       flags = affinity ? IRQD_AFFINITY_MANAGED | IRQD_MANAGED_SHUTDOWN : 0;
>         mask = NULL;
>
>         for (i = 0; i < cnt; i++) {
> -               if (affinity) {
> -                       node = cpu_to_node(cpumask_first(affinity));
> -                       mask = affinity;
> -                       affinity++;
> +               if (affi_desc && affi_desc->flags) {
> +                       flags =  IRQD_AFFINITY_MANAGED |
> +                               IRQD_MANAGED_SHUTDOWN;
> +               } else
> +                       flags = 0;
> +
> +               if (affi_desc) {
> +                       mask = &affi_desc->masks;
> +                       node = cpu_to_node(cpumask_first(mask));
> +                       affi_desc++;
>                 }
>                 desc = alloc_desc(start + i, node, flags, mask, owner);
>                 if (!desc)
> @@ -575,7 +583,7 @@ static void free_desc(unsigned int irq)
>  }
>
>  static inline int alloc_descs(unsigned int start, unsigned int cnt, int node,
> -                             const struct cpumask *affinity,
> +                             const struct irq_affinity_desc *affi_desc,
>                               struct module *owner)
>  {
>         u32 i;
> @@ -697,7 +705,7 @@ EXPORT_SYMBOL_GPL(irq_free_descs);
>   * @cnt:       Number of consecutive irqs to allocate.
>   * @node:      Preferred node on which the irq descriptor should be allocated
>   * @owner:     Owning module (can be NULL)
> - * @affinity:  Optional pointer to an affinity mask array of size @cnt which
> + * @affi_desc: Optional pointer to an affinity desc array of size @cnt which
>   *             hints where the irq descriptors should be allocated and which
>   *             default affinities to use
>   *
> @@ -705,7 +713,7 @@ EXPORT_SYMBOL_GPL(irq_free_descs);
>   */
>  int __ref
>  __irq_alloc_descs(int irq, unsigned int from, unsigned int cnt, int node,
> -                 struct module *owner, const struct cpumask *affinity)
> +               struct module *owner, const struct irq_affinity_desc *affi_desc)
>  {
>         int start, ret;
>
> @@ -738,7 +746,7 @@ __irq_alloc_descs(int irq, unsigned int from, unsigned int cnt, int node,
>                 if (ret)
>                         goto unlock;
>         }
> -       ret = alloc_descs(start, cnt, node, affinity, owner);
> +       ret = alloc_descs(start, cnt, node, affi_desc, owner);
>  unlock:
>         mutex_unlock(&sparse_irq_lock);
>         return ret;
> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
> index 3366d11c3e02..6fdfe835a96f 100644
> --- a/kernel/irq/irqdomain.c
> +++ b/kernel/irq/irqdomain.c
> @@ -969,22 +969,22 @@ const struct irq_domain_ops irq_domain_simple_ops = {
>  EXPORT_SYMBOL_GPL(irq_domain_simple_ops);
>
>  int irq_domain_alloc_descs(int virq, unsigned int cnt, irq_hw_number_t hwirq,
> -                          int node, const struct cpumask *affinity)
> +                          int node, const struct irq_affinity_desc *affi_desc)
>  {
>         unsigned int hint;
>
>         if (virq >= 0) {
>                 virq = __irq_alloc_descs(virq, virq, cnt, node, THIS_MODULE,
> -                                        affinity);
> +                                        affi_desc);
>         } else {
>                 hint = hwirq % nr_irqs;
>                 if (hint == 0)
>                         hint++;
>                 virq = __irq_alloc_descs(-1, hint, cnt, node, THIS_MODULE,
> -                                        affinity);
> +                                        affi_desc);
>                 if (virq <= 0 && hint > 1) {
>                         virq = __irq_alloc_descs(-1, 1, cnt, node, THIS_MODULE,
> -                                                affinity);
> +                                                affi_desc);
>                 }
>         }
>
> @@ -1265,7 +1265,7 @@ int irq_domain_alloc_irqs_hierarchy(struct irq_domain *domain,
>   * @node:      NUMA node id for memory allocation
>   * @arg:       domain specific argument
>   * @realloc:   IRQ descriptors have already been allocated if true
> - * @affinity:  Optional irq affinity mask for multiqueue devices
> + * @affi_desc: Optional irq affinity desc for multiqueue devices
>   *
>   * Allocate IRQ numbers and initialized all data structures to support
>   * hierarchy IRQ domains.
> @@ -1281,7 +1281,7 @@ int irq_domain_alloc_irqs_hierarchy(struct irq_domain *domain,
>   */
>  int __irq_domain_alloc_irqs(struct irq_domain *domain, int irq_base,
>                             unsigned int nr_irqs, int node, void *arg,
> -                           bool realloc, const struct cpumask *affinity)
> +                           bool realloc, const struct irq_affinity_desc *affi_desc)
>  {
>         int i, ret, virq;
>
> @@ -1300,7 +1300,7 @@ int __irq_domain_alloc_irqs(struct irq_domain *domain, int irq_base,
>                 virq = irq_base;
>         } else {
>                 virq = irq_domain_alloc_descs(irq_base, nr_irqs, 0, node,
> -                                             affinity);
> +                                             affi_desc);
>                 if (virq < 0) {
>                         pr_debug("cannot allocate IRQ(base %d, count %d)\n",
>                                  irq_base, nr_irqs);
> diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
> index 4ca2fd46645d..bdc96e59b503 100644
> --- a/kernel/irq/msi.c
> +++ b/kernel/irq/msi.c
> @@ -21,13 +21,14 @@
>   * alloc_msi_entry - Allocate an initialize msi_entry
>   * @dev:       Pointer to the device for which this is allocated
>   * @nvec:      The number of vectors used in this entry
> - * @affinity:  Optional pointer to an affinity mask array size of @nvec
> + * @affi_desc: Optional pointer to an affinity desc array size of @nvec
>   *
> - * If @affinity is not NULL then a an affinity array[@nvec] is allocated
> - * and the affinity masks from @affinity are copied.
> + * If @affinity is not NULL then an affinity desc array[@nvec] is allocated
> + * and the affinity masks from @affi_desc are copied.
>   */
>  struct msi_desc *
> -alloc_msi_entry(struct device *dev, int nvec, const struct cpumask *affinity)
> +alloc_msi_entry(struct device *dev, int nvec,
> +                               const struct irq_affinity_desc *affi_desc)
>  {
>         struct msi_desc *desc;
>
> @@ -38,10 +39,10 @@ alloc_msi_entry(struct device *dev, int nvec, const struct cpumask *affinity)
>         INIT_LIST_HEAD(&desc->list);
>         desc->dev = dev;
>         desc->nvec_used = nvec;
> -       if (affinity) {
> -               desc->affinity = kmemdup(affinity,
> -                       nvec * sizeof(*desc->affinity), GFP_KERNEL);
> -               if (!desc->affinity) {
> +       if (affi_desc) {
> +               desc->affi_desc = kmemdup(affi_desc,
> +                       nvec * sizeof(*desc->affi_desc), GFP_KERNEL);
> +               if (!desc->affi_desc) {
>                         kfree(desc);
>                         return NULL;
>                 }
> @@ -52,7 +53,7 @@ alloc_msi_entry(struct device *dev, int nvec, const struct cpumask *affinity)
>
>  void free_msi_entry(struct msi_desc *entry)
>  {
> -       kfree(entry->affinity);
> +       kfree(entry->affi_desc);
>         kfree(entry);
>  }
>
> @@ -416,7 +417,7 @@ int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
>
>                 virq = __irq_domain_alloc_irqs(domain, -1, desc->nvec_used,
>                                                dev_to_node(dev), &arg, false,
> -                                              desc->affinity);
> +                                              desc->affi_desc);
>                 if (virq < 0) {
>                         ret = -ENOSPC;
>                         if (ops->handle_error)
> --
> 2.17.2
>
