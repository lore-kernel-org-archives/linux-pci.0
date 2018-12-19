Return-Path: <SRS0=4gsO=O4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5F7C43387
	for <linux-pci@archiver.kernel.org>; Wed, 19 Dec 2018 12:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BAA4214AE
	for <linux-pci@archiver.kernel.org>; Wed, 19 Dec 2018 12:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gPDmYItp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbeLSMz5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 19 Dec 2018 07:55:57 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42422 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbeLSMz5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Dec 2018 07:55:57 -0500
Received: by mail-ed1-f66.google.com with SMTP id y20so10724721edw.9
        for <linux-pci@vger.kernel.org>; Wed, 19 Dec 2018 04:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MAfLH1EZQD20uBK2TrTBmxwRXAyaLXXO4enNZzYPr/8=;
        b=gPDmYItpFdcr21u1CT34XRBw6ywAnTTNDlJFdQgGGbktlqmyouWbHkNvDMgkAuYu0s
         ihYBqQAmbPbPC863GYv4Br1QO+xs8SVWpLboRMxxWERT+p8kaPgs6TKVIMaEOVezK/dx
         hN884LoXy5fgj8ujdR/GM9OelCcLCVQyM7Q7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MAfLH1EZQD20uBK2TrTBmxwRXAyaLXXO4enNZzYPr/8=;
        b=ro2+51Qw+UiehKaq7PGwagibsHVDFBDjkIzc9iOFk1+sJICWEF9JgMwlD3+NjEUvA1
         IN/uw5mStBFIj1ptoOqYwbCdcpgHUd96HORlGmjJP59Igf/GKBfJXhRmCPLPzZnBiOAN
         /ZGcCJ4CtMmZV/GF2JXJ8OJM+CkNnAHtABW1/SuvJXTv9sMy5gYWbtJWcSRWXCFBzLYt
         /tyGAx/JCaXqPhfGkaWUElscNd7bQSIl8APltbCtji3GROYf/vSuGimZnidD8FSp5IOg
         KWSO6je+JgacwJMYCtDPrFzolJv4AKo5XcdjJWeEPcwSSFFtIvfTU/fKT3wYETQWkMf3
         ODaA==
X-Gm-Message-State: AA+aEWZY5twSlKnNeH3KMz/6CVy2ASCuveDDl+auuWLqHOQuiS0yY22/
        6Lx1A3YaZz1T6U73csE7sdcnk1XQyUzyEd0DG2uXDg==
X-Google-Smtp-Source: AFSGD/W3zUR6Cezuo3357ZqX6XnYZtbnLT349w886skhrgUaJ7P00H5UH4Ic0FAENvdIn+VEctrsb91K5YoFRd0bejM=
X-Received: by 2002:a50:ab82:: with SMTP id u2mr20165164edc.111.1545224155167;
 Wed, 19 Dec 2018 04:55:55 -0800 (PST)
MIME-Version: 1.0
References: <20181204155122.6327-1-douliyangs@gmail.com> <alpine.DEB.2.21.1812191136550.1651@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1812191136550.1651@nanos.tec.linutronix.de>
From:   Sumit Saxena <sumit.saxena@broadcom.com>
Date:   Wed, 19 Dec 2018 18:25:44 +0530
Message-ID: <CAL2rwxq8kKMtPY6SvWzMCUUfYGSJyjjSFCKu4zvLpRyWvQtWNw@mail.gmail.com>
Subject: Re: [PATCH 0/3] irq/core: Fix and expand the irq affinity descriptor
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     douliyangs@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>, douliyang1@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 19, 2018 at 4:23 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Tue, 4 Dec 2018, Dou Liyang wrote:
>
> > Now,  Spreading the interrupt affinity info by a cpumask pointer is not
> > enough, meets a problem[1] and hard to expand in the future.
> >
> > Fix it by:
> >
> >      +-----------------------------------+
> >      |                                   |
> >      |     struct cpumask *affinity      |
> >      |                                   |
> >      +-----------------------------------+
> >                        |
> >     +------------------v-------------------+
> >     |                                      |
> >     | struct irq_affinity_desc {           |
> >     |     struct cpumask   mask;           |
> >     |     unsigned int     is_managed : 1; |
> >     | };                                   |
> >     |                                      |
> >     +--------------------------------------+
> >
>
> So, I've applied that lot for 4.21 (or whatever number it will be). That's
> only the first step for solving Kashyap's problem.
>
> IIRC, then Kashap wanted to get initial interrupt spreading for these extra
> magic interrupts as well, but not have them marked managed.
>
> That's trivial to do now with the two queued changes in that area:
>
>   - The rework above
>
>   - The support for interrupt sets from Jens
>
> Just adding a small bitfield to struct irq_affinity which allows to tell
> the core that a particular interrupt set is not managed does the trick.
>
> Untested patch below.
>
> Kashyap, is that what you were looking for and if so, does it work?
Thomas,
We could not test these patches as they did net get applied to latest
linux-block tree cleanly.

Our requirement is: 1. extra interrupts should be un-managed and 2.
should be spread to CPUs of local NUMA node.
If interrupts are un-managed but not spread as per our requirement,
then still driver/userspace apps can manage by spreading
them as required by calling API- irq_set_affinity_hint().

Thanks,
Sumit
>
> Thanks,
>
>         tglx
>
> 8<-----------------
>
> Subject: genirq/affinity: Add support for non-managed affinity sets
> From: Thomas Gleixner <tglx@linutronix.de>
> Date: Tue, 18 Dec 2018 16:46:47 +0100
>
> Some drivers need an extra set of interrupts which are not marked managed,
> but should get initial interrupt spreading.
>
> Add a bitmap to struct irq_affinity which allows the driver to mark a
> particular set of interrupts as non managed. Check the bitmap during
> spreading and use the result to mark the interrupts in the sets
> accordingly.
>
> The unmanaged interrupts get initial spreading, but user space can change
> their affinity later on.
>
> Usage example:
>
>       struct irq_affinity affd = { .pre_vectors = 2 };
>       int sets[2];
>
>       /* Fill in sets[] */
>
>       affd.nr_sets = 2;
>       affd.sets = &sets;
>       affd.unmanaged_sets = 0x02;
>
>       ......
>
> So both sets are properly spread out, but the second set is not marked
> managed.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  include/linux/interrupt.h |   10 ++++++----
>  kernel/irq/affinity.c     |   24 ++++++++++++++----------
>  2 files changed, 20 insertions(+), 14 deletions(-)
>
> --- a/kernel/irq/affinity.c
> +++ b/kernel/irq/affinity.c
> @@ -99,7 +99,8 @@ static int __irq_build_affinity_masks(co
>                                       cpumask_var_t *node_to_cpumask,
>                                       const struct cpumask *cpu_mask,
>                                       struct cpumask *nmsk,
> -                                     struct irq_affinity_desc *masks)
> +                                     struct irq_affinity_desc *masks,
> +                                     bool managed)
>  {
>         int n, nodes, cpus_per_vec, extra_vecs, done = 0;
>         int last_affv = firstvec + numvecs;
> @@ -154,6 +155,7 @@ static int __irq_build_affinity_masks(co
>                         }
>                         irq_spread_init_one(&masks[curvec].mask, nmsk,
>                                                 cpus_per_vec);
> +                       masks[curvec].is_managed = managed;
>                 }
>
>                 done += v;
> @@ -176,7 +178,8 @@ static int __irq_build_affinity_masks(co
>  static int irq_build_affinity_masks(const struct irq_affinity *affd,
>                                     int startvec, int numvecs, int firstvec,
>                                     cpumask_var_t *node_to_cpumask,
> -                                   struct irq_affinity_desc *masks)
> +                                   struct irq_affinity_desc *masks,
> +                                   bool managed)
>  {
>         int curvec = startvec, nr_present, nr_others;
>         int ret = -ENOMEM;
> @@ -196,7 +199,8 @@ static int irq_build_affinity_masks(cons
>         /* Spread on present CPUs starting from affd->pre_vectors */
>         nr_present = __irq_build_affinity_masks(affd, curvec, numvecs,
>                                                 firstvec, node_to_cpumask,
> -                                               cpu_present_mask, nmsk, masks);
> +                                               cpu_present_mask, nmsk, masks,
> +                                               managed);
>
>         /*
>          * Spread on non present CPUs starting from the next vector to be
> @@ -211,7 +215,7 @@ static int irq_build_affinity_masks(cons
>         cpumask_andnot(npresmsk, cpu_possible_mask, cpu_present_mask);
>         nr_others = __irq_build_affinity_masks(affd, curvec, numvecs,
>                                                firstvec, node_to_cpumask,
> -                                              npresmsk, nmsk, masks);
> +                                              npresmsk, nmsk, masks, managed);
>         put_online_cpus();
>
>         if (nr_present < numvecs)
> @@ -268,10 +272,11 @@ irq_create_affinity_masks(int nvecs, con
>
>         for (i = 0, usedvecs = 0; i < nr_sets; i++) {
>                 int this_vecs = affd->sets ? affd->sets[i] : affvecs;
> +               bool managed = !test_bit(i, &affd->unmanaged_sets);
>                 int ret;
>
> -               ret = irq_build_affinity_masks(affd, curvec, this_vecs,
> -                                               curvec, node_to_cpumask, masks);
> +               ret = irq_build_affinity_masks(affd, curvec, this_vecs, curvec,
> +                                              node_to_cpumask, masks, managed);
>                 if (ret) {
>                         kfree(masks);
>                         masks = NULL;
> @@ -289,10 +294,6 @@ irq_create_affinity_masks(int nvecs, con
>         for (; curvec < nvecs; curvec++)
>                 cpumask_copy(&masks[curvec].mask, irq_default_affinity);
>
> -       /* Mark the managed interrupts */
> -       for (i = affd->pre_vectors; i < nvecs - affd->post_vectors; i++)
> -               masks[i].is_managed = 1;
> -
>  outnodemsk:
>         free_node_to_cpumask(node_to_cpumask);
>         return masks;
> @@ -316,6 +317,9 @@ int irq_calc_affinity_vectors(int minvec
>         if (affd->nr_sets) {
>                 int i;
>
> +               if (WARN_ON_ONCE(affd->nr_sets > BITS_PER_LONG))
> +                       return 0;
> +
>                 for (i = 0, set_vecs = 0;  i < affd->nr_sets; i++)
>                         set_vecs += affd->sets[i];
>         } else {
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -249,12 +249,14 @@ struct irq_affinity_notify {
>   *                     the MSI(-X) vector space
>   * @nr_sets:           Length of passed in *sets array
>   * @sets:              Number of affinitized sets
> + * @unmanaged_sets:    Bitmap to mark members of @sets as unmanaged
>   */
>  struct irq_affinity {
> -       int     pre_vectors;
> -       int     post_vectors;
> -       int     nr_sets;
> -       int     *sets;
> +       int             pre_vectors;
> +       int             post_vectors;
> +       int             nr_sets;
> +       int             *sets;
> +       unsigned long   unmanaged_sets;
>  };
>
>  /**
