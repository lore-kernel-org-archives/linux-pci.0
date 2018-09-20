Return-Path: <SRS0=Tpvo=MC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A509CECE562
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 02:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 360182150E
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 02:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iMjvtx60"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 360182150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbeITIAD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:00:03 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37353 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbeITIAD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Sep 2018 04:00:03 -0400
Received: by mail-io1-f68.google.com with SMTP id v14-v6so6164906iob.4
        for <linux-pci@vger.kernel.org>; Wed, 19 Sep 2018 19:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3TiVAVMkw0T+kKR+mzSFt5oEgh576sFdxF7wx/cMnmQ=;
        b=iMjvtx60uBq/4/ENAnbhc5GyloItTk33igwbGEiX1DdXqM/EKb69H2ZwkJ/nBInCic
         gP86TZO53f/Hm4eS6xwp0dqglUpsjGhTjhd+ipoEB6jZ2tGDvdQCdlVSzvAL35HN2vg4
         gEGw2vzkSCOh/W1zuyRd4tO68U8WtaqIyByI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3TiVAVMkw0T+kKR+mzSFt5oEgh576sFdxF7wx/cMnmQ=;
        b=RTtO0uuVbZKuqr3kam6Tz8gaZrP0bUSudTaAPbxdEktS0iOkvL1cZEenUHxWMX5mVR
         lSJbsm+kYtZ2nl48kfBtH0Xyrs2x5X9KjQMhdQrhgrsm8gLMkwI8/7SOeGX2rRWcWNCx
         lisRxiH9qjWzyNjKbyEGgi7KSamzT+h7FXREAzevq3/4OAIUzEi+6G3+Lab8NXw4uVZa
         AxtgO4y8F2SOuo8+pAmdVRL/FxNYcO2/P+GBKcbdgXyJs9XgNvv8AzT5q9s35P4oPOIG
         XpOtLSOnWduFPvw/H46XYabzVw0hPo6izHWp4MVfkpeKrZKbJX1L0NRRnqCmD8a0L1Wv
         xDlQ==
X-Gm-Message-State: ABuFfogTZCvmw7YK5ciRRN/3/IH7YCx8QR5pBMuFGOz8IDXX/Wfcdsjo
        uVN3WAWF/17zMN/uX3dKty01LISRoOGAfrHeRqECOA==
X-Google-Smtp-Source: ACcGV63ZHpYVwGYO3o3gK1fXORWG0tlUftLpg4xrEtUyFsT1pR1CP3siPpKbKWelYv8biWKjNN1gE6uPIZha31GTWWI=
X-Received: by 2002:a6b:3787:: with SMTP id e129-v6mr839916ioa.60.1537409952784;
 Wed, 19 Sep 2018 19:19:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:2848:0:0:0:0:0 with HTTP; Wed, 19 Sep 2018 19:19:12
 -0700 (PDT)
In-Reply-To: <1537367527-20773-5-git-send-email-jim2101024@gmail.com>
References: <1537367527-20773-1-git-send-email-jim2101024@gmail.com> <1537367527-20773-5-git-send-email-jim2101024@gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 19 Sep 2018 19:19:12 -0700
Message-ID: <CAKv+Gu_d-r0ubyqZcDzERYd5FVTSpjBk++iACHqVgtHrOK0F7A@mail.gmail.com>
Subject: Re: [PATCH v5 04/12] PCI: brcmstb: add dma-range mapping for inbound traffic
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 19 September 2018 at 07:31, Jim Quinlan <jim2101024@gmail.com> wrote:
> The Broadcom STB PCIe host controller is intimately related to the
> memory subsystem.  This close relationship adds complexity to how cpu
> system memory is mapped to PCIe memory.  Ideally, this mapping is an
> identity mapping, or an identity mapping off by a constant.  Not so in
> this case.
>
> Consider the Broadcom reference board BCM97445LCC_4X8 which has 6 GB
> of system memory.  Here is how the PCIe controller maps the
> system memory to PCIe memory:
>
>   memc0-a@[        0....3fffffff] <=> pci@[        0....3fffffff]
>   memc0-b@[100000000...13fffffff] <=> pci@[ 40000000....7fffffff]
>   memc1-a@[ 40000000....7fffffff] <=> pci@[ 80000000....bfffffff]
>   memc1-b@[300000000...33fffffff] <=> pci@[ c0000000....ffffffff]
>   memc2-a@[ 80000000....bfffffff] <=> pci@[100000000...13fffffff]
>   memc2-b@[c00000000...c3fffffff] <=> pci@[140000000...17fffffff]
>

So is describing this as

dma-ranges = <0x0 0x0 0x0 0x0 0x0 0x40000000>,
             <0x0 0x40000000 0x1 0x0 0x0 0x40000000>,
             <0x0 0x80000000 0x0 0x40000000 0x0 0x40000000>,
             <0x0 0xc0000000 0x3 0x0 0x0 0x40000000>,
             <0x1 0x0 0x0 0x80000000 0x0 0x40000000>,
             <0x1 0x40000000 0x0 0xc0000000 0x0 0x40000000>;

not working for you? I haven't tried this myself, but since DT permits
describing the inbound mappings this way, we should fix the code if it
doesn't work at the moment.


> Although there are some "gaps" that can be added between the
> individual mappings by software, the permutation of memory regions for
> the most part is fixed by HW.  The solution of having something close
> to an identity mapping is not possible.
>
> The idea behind this HW design is that the same PCIe module can
> act as an RC or EP, and if it acts as an EP it concatenates all
> of system memory into a BAR so anything can be accessed.  Unfortunately,
> when the PCIe block is in the role of an RC it also presents this
> "BAR" to downstream PCIe devices, rather than offering an identity map
> between its system memory and PCIe space.
>
> Suppose that an endpoint driver allocs some DMA memory.  Suppose this
> memory is located at 0x6000_0000, which is in the middle of memc1-a.
> The driver wants a dma_addr_t value that it can pass on to the EP to
> use.  Without doing any custom mapping, the EP will use this value for
> DMA: the driver will get a dma_addr_t equal to 0x6000_0000.  But this
> won't work; the device needs a dma_addr_t that reflects the PCIe space
> address, namely 0xa000_0000.
>
> So, essentially the solution to this problem must modify the
> dma_addr_t returned by the DMA routines routines.  The method to do
> this is to redefine the __dma_to_phys() and __phys_to_dma() functions
> of the ARM, ARM64, and MIPS architectures.  This commit sets up the
> infrastructure in the Brcm PCIe controller to prepare for this, while
> there is three other subsequent commits to implement/redefine these
> two functions for the three target architectures.
>
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 130 ++++++++++++++++++++++++++++++----
>  include/soc/brcmstb/common.h          |  16 +++++
>  2 files changed, 133 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 9c87d10..abfa429 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -21,6 +21,7 @@
>  #include <linux/printk.h>
>  #include <linux/sizes.h>
>  #include <linux/slab.h>
> +#include <soc/brcmstb/common.h>
>  #include <soc/brcmstb/memory_api.h>
>  #include <linux/string.h>
>  #include <linux/types.h>
> @@ -321,6 +322,7 @@ static void __iomem *brcm_pcie_map_conf(struct pci_bus *bus, unsigned int devfn,
>         (((val) & ~reg##_##field##_MASK) | \
>          (reg##_##field##_MASK & (field_val << reg##_##field##_SHIFT)))
>
> +static struct of_pci_range *brcm_dma_ranges;
>  static phys_addr_t scb_size[BRCM_MAX_SCB];
>  static int num_memc;
>  static int num_pcie;
> @@ -599,6 +601,79 @@ static inline void brcm_pcie_perst_set(struct brcm_pcie *pcie,
>                 WR_FLD_RB(pcie->base, PCIE_MISC_PCIE_CTRL, PCIE_PERSTB, !val);
>  }
>
> +static int brcm_pcie_parse_map_dma_ranges(struct brcm_pcie *pcie)
> +{
> +       int i;
> +       struct of_pci_range_parser parser;
> +       struct device_node *dn = pcie->dn;
> +
> +       /*
> +        * Parse dma-ranges property if present.  If there are multiple
> +        * PCIe controllers, we only have to parse from one of them since
> +        * the others will have an identical mapping.
> +        */
> +       if (!of_pci_dma_range_parser_init(&parser, dn)) {
> +               struct of_pci_range *p;
> +               unsigned int max_ranges = (parser.end - parser.range)
> +                       / parser.np;
> +
> +               /* Add a null entry to indicate the end of the array */
> +               brcm_dma_ranges = kcalloc(max_ranges + 1,
> +                                         sizeof(struct of_pci_range),
> +                                         GFP_KERNEL);
> +               if (!brcm_dma_ranges)
> +                       return -ENOMEM;
> +
> +               p = brcm_dma_ranges;
> +               while (of_pci_range_parser_one(&parser, p))
> +                       p++;
> +       }
> +
> +       for (i = 0, num_memc = 0; i < BRCM_MAX_SCB; i++) {
> +               u64 size = brcmstb_memory_memc_size(i);
> +
> +               if (size == (u64)-1) {
> +                       dev_err(pcie->dev, "cannot get memc%d size", i);
> +                       return -EINVAL;
> +               } else if (size) {
> +                       scb_size[i] = roundup_pow_of_two_64(size);
> +                       num_memc++;
> +               } else {
> +                       break;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +dma_addr_t brcm_phys_to_dma(struct device *dev, phys_addr_t paddr)
> +{
> +       struct of_pci_range *p;
> +
> +       if (!dev || !dev_is_pci(dev))
> +               return (dma_addr_t)paddr;
> +       for (p = brcm_dma_ranges; p && p->size; p++)
> +               if (paddr >= p->cpu_addr && paddr < (p->cpu_addr + p->size))
> +                       return (dma_addr_t)(paddr - p->cpu_addr + p->pci_addr);
> +
> +       return (dma_addr_t)paddr;
> +}
> +
> +phys_addr_t brcm_dma_to_phys(struct device *dev, dma_addr_t dev_addr)
> +{
> +       struct of_pci_range *p;
> +
> +       if (!dev || !dev_is_pci(dev))
> +               return (phys_addr_t)dev_addr;
> +       for (p = brcm_dma_ranges; p && p->size; p++)
> +               if (dev_addr >= p->pci_addr
> +                   && dev_addr < (p->pci_addr + p->size))
> +                       return (phys_addr_t)
> +                               (dev_addr - p->pci_addr + p->cpu_addr);
> +
> +       return (phys_addr_t)dev_addr;
> +}
> +
>  static int brcm_pcie_add_controller(struct brcm_pcie *pcie)
>  {
>         int i, ret = 0;
> @@ -610,6 +685,10 @@ static int brcm_pcie_add_controller(struct brcm_pcie *pcie)
>                 goto done;
>         }
>
> +       ret = brcm_pcie_parse_map_dma_ranges(pcie);
> +       if (ret)
> +               goto done;
> +
>         /* Determine num_memc and their sizes */
>         for (i = 0, num_memc = 0; i < BRCM_MAX_SCB; i++) {
>                 u64 size = brcmstb_memory_memc_size(i);
> @@ -639,8 +718,13 @@ static int brcm_pcie_add_controller(struct brcm_pcie *pcie)
>  static void brcm_pcie_remove_controller(struct brcm_pcie *pcie)
>  {
>         mutex_lock(&brcm_pcie_lock);
> -       if (--num_pcie == 0)
> -               num_memc = 0;
> +       if (--num_pcie > 0)
> +               goto out;
> +
> +       kfree(brcm_dma_ranges);
> +       brcm_dma_ranges = NULL;
> +       num_memc = 0;
> +out:
>         mutex_unlock(&brcm_pcie_lock);
>  }
>
> @@ -747,11 +831,37 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
>          */
>         rc_bar2_size = roundup_pow_of_two_64(total_mem_size);
>
> -       /*
> -        * Set simple configuration based on memory sizes
> -        * only.  We always start the viewport at address 0.
> -        */
> -       rc_bar2_offset = 0;
> +       if (brcm_dma_ranges) {
> +               /*
> +                * The best-case scenario is to place the inbound
> +                * region in the first 4GB of pcie-space, as some
> +                * legacy devices can only address 32bits.
> +                * We would also like to put the MSI under 4GB
> +                * as well, since some devices require a 32bit
> +                * MSI target address.
> +                */
> +               if (total_mem_size <= 0xc0000000ULL &&
> +                   rc_bar2_size <= 0x100000000ULL) {
> +                       rc_bar2_offset = 0;
> +               } else {
> +                       /*
> +                        * The system memory is 4GB or larger so we
> +                        * cannot start the inbound region at location
> +                        * 0 (since we have to allow some space for
> +                        * outbound memory @ 3GB).  So instead we
> +                        * start it at the 1x multiple of its size
> +                        */
> +                       rc_bar2_offset = rc_bar2_size;
> +               }
> +
> +       } else {
> +               /*
> +                * Set simple configuration based on memory sizes
> +                * only.  We always start the viewport at address 0,
> +                * and set the MSI target address accordingly.
> +                */
> +               rc_bar2_offset = 0;
> +       }
>
>         tmp = lower_32_bits(rc_bar2_offset);
>         tmp = INSERT_FIELD(tmp, PCIE_MISC_RC_BAR2_CONFIG_LO, SIZE,
> @@ -969,7 +1079,6 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>         struct brcm_pcie *pcie;
>         struct resource *res;
>         void __iomem *base;
> -       u32 tmp;
>         struct pci_host_bridge *bridge;
>         struct pci_bus *child;
>
> @@ -986,11 +1095,6 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>                 return -EINVAL;
>         }
>
> -       if (of_property_read_u32(dn, "dma-ranges", &tmp) == 0) {
> -               dev_err(&pdev->dev, "cannot yet handle dma-ranges\n");
> -               return -EINVAL;
> -       }
> -
>         data = of_id->data;
>         pcie->reg_offsets = data->offsets;
>         pcie->reg_field_info = data->reg_field_info;
> diff --git a/include/soc/brcmstb/common.h b/include/soc/brcmstb/common.h
> index cfb5335..a7f19e0 100644
> --- a/include/soc/brcmstb/common.h
> +++ b/include/soc/brcmstb/common.h
> @@ -12,4 +12,20 @@
>
>  bool soc_is_brcmstb(void);
>
> +#if defined(CONFIG_PCIE_BRCMSTB)
> +dma_addr_t brcm_phys_to_dma(struct device *dev, phys_addr_t paddr);
> +phys_addr_t brcm_dma_to_phys(struct device *dev, dma_addr_t dev_addr);
> +#else
> +static inline dma_addr_t brcm_phys_to_dma(struct device *dev, phys_addr_t paddr)
> +{
> +       return (dma_addr_t)paddr;
> +}
> +
> +static inline phys_addr_t brcm_dma_to_phys(struct device *dev,
> +                                          dma_addr_t dev_addr)
> +{
> +       return (phys_addr_t)dev_addr;
> +}
> +#endif
> +
>  #endif /* __SOC_BRCMSTB_COMMON_H__ */
> --
> 1.9.0.138.g2de3478
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
