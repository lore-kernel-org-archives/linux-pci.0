Return-Path: <SRS0=IRPw=OW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9031EC67839
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 09:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BCFB20811
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 09:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZaGtW9/t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BCFB20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbeLMJRX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 13 Dec 2018 04:17:23 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35913 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbeLMJRW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Dec 2018 04:17:22 -0500
Received: by mail-wr1-f68.google.com with SMTP id u4so205128wrp.3
        for <linux-pci@vger.kernel.org>; Thu, 13 Dec 2018 01:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J9y68ZP9FLvJD7+DsuEi7azlVGsBu+pdfu6qn1+HeM8=;
        b=ZaGtW9/thiv3BbI5MrrBEaMkZveH+ALmjKCYEvVg+GkXcpGhLnWRJCcatQQEQuE50w
         ujjHrOS9to2hoHxxBjHSWMS7nKtLxbrdmSc2di7QRvmmsN3lC1SGU0Rqv+HcUCjWPkQ9
         OEsKnbj8ku1tZ3TQqtTiI3jH33UlwVX6zu3qk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J9y68ZP9FLvJD7+DsuEi7azlVGsBu+pdfu6qn1+HeM8=;
        b=jzwgbx7zM9KaKA0CCQmUsBH3QG2ELcAkdqeIql70EljkcyHQCOU5BS08noqp2T6cca
         Le29D5vHeu6onDDkJgNQ3hp3Akyo2LXd59gBV/PZjFqqptCShkHc8FSu/N+jug0HPlVb
         7AersGuIK5uCXHoo1r82jhjfCJT1EwU1Ck3X/jvGGCfnsaprSRVQDV9ofbImRpn227M6
         ERu0Q6z9YzheQRDz2Gd+Fz/9uKGQq+ulJIg6U+OI8dyVnhZhu3T12mHSekjg7bKOr2jL
         9uarK/Dq4UDVJeyitX7Qi+SO9OXpecNDvJQU938BtbYhd50oB/GNKbm3bPfTLqeTWl8m
         K2CA==
X-Gm-Message-State: AA+aEWbN51fWpJnRcVZwpVbONdObntNORUuF0r9sjPnzvs8/xmokak60
        MxqyL1KkFd8CUjwhIAgVI/5EBcpz2SDlYMsskeAACw==
X-Google-Smtp-Source: AFSGD/VQWIEVlyWgHdxErhci2keVs8n6HRE8qOoPdRSEzSCBDn12mbITsSAh76UiLzS//lBbvWzJSLSjnDpJdmefyVg=
X-Received: by 2002:adf:f052:: with SMTP id t18mr21522120wro.112.1544692640217;
 Thu, 13 Dec 2018 01:17:20 -0800 (PST)
MIME-Version: 1.0
References: <1544593569-8923-1-git-send-email-srinath.mannam@broadcom.com>
 <1544593569-8923-4-git-send-email-srinath.mannam@broadcom.com> <117bb87c4567d14f189642b685dd8813@codeaurora.org>
In-Reply-To: <117bb87c4567d14f189642b685dd8813@codeaurora.org>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Thu, 13 Dec 2018 14:47:08 +0530
Message-ID: <CABe79T4fqHoW4rww2jRNNaiirzOqm7dTvap3Eqi1w17SV4j+qQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] PCI: iproc: Add dma reserve resources to host
To:     poza@codeaurora.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci-owner@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Oza,

Thank you for the review.
Please find my comments in lined.

On Thu, Dec 13, 2018 at 11:33 AM <poza@codeaurora.org> wrote:
>
> On 2018-12-12 11:16, Srinath Mannam wrote:
> > IPROC host has the limitation that it can use
> > only those address ranges given by dma-ranges
> > property as inbound address.
> > So that the memory address holes in dma-ranges
> > should be reserved to allocate as DMA address.
> >
> > All such reserved addresses are created as resource
> > entries and add to dma_resv list of pci host bridge.
> >
> > These dma reserve resources created by parsing
> > dma-ranges parameter.
> >
> > Ex:
> > dma-ranges = < \
> >   0x43000000 0x00 0x80000000 0x00 0x80000000 0x00 0x80000000 \
> >   0x43000000 0x08 0x00000000 0x08 0x00000000 0x08 0x00000000 \
> >   0x43000000 0x80 0x00000000 0x80 0x00000000 0x40 0x00000000>
> >
> > In the above example of dma-ranges, memory address from
> > 0x0 - 0x80000000,
> > 0x100000000 - 0x800000000,
> > 0x1000000000 - 0x8000000000 and
> > 0x10000000000 - 0xffffffffffffffff.
> > are not allowed to use as inbound addresses.
> > So that we need to add these address range to dma_resv
> > list to reserve their IOVA address ranges.
> >
> > Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> > ---
> >  drivers/pci/controller/pcie-iproc.c | 49
> > +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 49 insertions(+)
> >
> > diff --git a/drivers/pci/controller/pcie-iproc.c
> > b/drivers/pci/controller/pcie-iproc.c
> > index 3160e93..43e465a 100644
> > --- a/drivers/pci/controller/pcie-iproc.c
> > +++ b/drivers/pci/controller/pcie-iproc.c
> > @@ -1154,25 +1154,74 @@ static int iproc_pcie_setup_ib(struct
> > iproc_pcie *pcie,
> >       return ret;
> >  }
> >
> > +static int
> > +iproc_pcie_add_dma_resv_range(struct device *dev, struct list_head
> > *resources,
> > +                           uint64_t start, uint64_t end)
> > +{
> > +     struct resource *res;
> > +
> > +     res = devm_kzalloc(dev, sizeof(struct resource), GFP_KERNEL);
> > +     if (!res)
> > +             return -ENOMEM;
> > +
> > +     res->start = (resource_size_t)start;
> > +     res->end = (resource_size_t)end;
> > +     pci_add_resource_offset(resources, res, 0);
> > +
> > +     return 0;
> > +}
> > +
> >  static int iproc_pcie_map_dma_ranges(struct iproc_pcie *pcie)
> >  {
> > +     struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
> >       struct of_pci_range range;
> >       struct of_pci_range_parser parser;
> >       int ret;
> > +     uint64_t start, end;
> > +     LIST_HEAD(resources);
> >
> >       /* Get the dma-ranges from DT */
> >       ret = of_pci_dma_range_parser_init(&parser, pcie->dev->of_node);
> >       if (ret)
> >               return ret;
> >
> > +     start = 0;
> >       for_each_of_pci_range(&parser, &range) {
> > +             end = range.pci_addr;
> > +             /* dma-ranges list expected in sorted order */
> > +             if (end < start) {
> > +                     ret = -EINVAL;
> > +                     goto out;
> > +             }
> >               /* Each range entry corresponds to an inbound mapping region */
> >               ret = iproc_pcie_setup_ib(pcie, &range, IPROC_PCIE_IB_MAP_MEM);
> >               if (ret)
> >                       return ret;
> > +
> > +             if (end - start) {
> > +                     ret = iproc_pcie_add_dma_resv_range(pcie->dev,
> > +                                                         &resources,
> > +                                                         start, end);
> > +                     if (ret)
> > +                             goto out;
> > +             }
> > +             start = range.pci_addr + range.size;
> >       }
> >
> > +     end = ~0;
> Hi Srinath,
>
> this series is based on following patch sets.
>
> https://lkml.org/lkml/2017/5/16/19
> https://lkml.org/lkml/2017/5/16/23
> https://lkml.org/lkml/2017/5/16/21,
>
Yes, this patch series is done based on the inputs of the patches you
sent earlier.

> some comments to be adapted from the patch-set I did.
>
> end = ~0;
> you should consider DMA_MASK, to see iproc controller is in 32 bit or 64
> bit system.
> please check following code snippet.
>
> if (tmp_dma_addr < DMA_BIT_MASK(sizeof(dma_addr_t) * 8)) {
> +                       lo = iova_pfn(iovad, tmp_dma_addr);
> +                       hi = iova_pfn(iovad,
> +                                     DMA_BIT_MASK(sizeof(dma_addr_t) * 8) - 1);
> +                       reserve_iova(iovad, lo, hi);
> +               }
>
> Also if this controller is integrated to 64bit platform, but decide to
> restrict DMA to 32 bit for some reason, the code should address such
> scenarios.
> so it is always safe to do
>
> #define BITS_PER_BYTE 8
> DMA_BIT_MASK(sizeof(dma_addr_t) * BITS_PER_BYTE)
> so please use kernle macro to find the end of DMA region.
>
this change done with the assumption, that end_address is max bus
address(~0) instead
pcie RC dma mask.
Even dma-ranges has 64bit size dma-mask of PCIe host is forced to 32bit.
// in of_dma_configure function
    dev->coherent_dma_mask = DMA_BIT_MASK(32);
And dma-mask of endpoint was set to 64bit in their drivers. also SMMU supported
dma mask is 48-bit.
But here requirement is all address ranges except dma-ranges address
between 0x0 - ~0x0
have to be reserved.
as you suggested I will change ~0 to DMA_BIT_MASK macro it will look
more cleaner.
>
> Also ideally according to SBSA v5
>
> 8.3 PCI Express device view of memory
>
> Transactions from a PCI express device will either directly address the
> memory system of the base server system
> or be presented to a SMMU for optional address translation and
> permission policing.
> In systems that are compatible with level 3 or above of the SBSA, the
> addresses sent by PCI express devices
> must be presented to the memory system or SMMU unmodified. In a system
> where the PCI express does not use
> an SMMU, the PCI express devices have the same view of physical memory
> as the PEs. In a system with a
> SMMU for PCI express there are no transformations to addresses being
> sent by PCI express devices before they
> are presented as an input address to the SMMU.
>
> which is a limitation of iproc controller, please list the limitation in
> detail as it violates SBSA.
Inbound address sent by pcie devices to the host will not be translate
(unchanged) before it comes to
SMMU or directly to PE. but the there is limitation that, few address
ranges are not allowed by
IPROC PCIe RC and those were filtered out. That is the reason forces
this change request.
I will append these details in commit message.

Regards,
Srinath.
>
> Regards,
> Oza.
>
> > +     if (end - start) {
> > +             ret = iproc_pcie_add_dma_resv_range(pcie->dev, &resources,
> > +                                                 start, end);
> > +             if (ret)
> > +                     goto out;
> > +     }
> > +
> > +     list_splice_init(&resources, &host->dma_resv);
> > +
> >       return 0;
> > +out:
> > +     pci_free_resource_list(&resources);
> > +     return ret;
> >  }
> >
> >  static int iproce_pcie_get_msi(struct iproc_pcie *pcie,
>
>
>
>
>
