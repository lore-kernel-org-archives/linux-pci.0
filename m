Return-Path: <SRS0=H68a=MD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B11C433F4
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 18:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0146721523
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 18:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hD7NrFDO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0146721523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391184AbeIVAUF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Sep 2018 20:20:05 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34370 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391102AbeIVAUF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Sep 2018 20:20:05 -0400
Received: by mail-lj1-f195.google.com with SMTP id f8-v6so12635545ljk.1;
        Fri, 21 Sep 2018 11:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YrQvvcrtp+YsrQUUYV9NQjLrTZsOfxmULuttgxfa06w=;
        b=hD7NrFDOYqrJNnP4oVz+R6sil6Py/TE+Zcy8nbIoxuBBApAb3Qvjmb/Xo0gOIx/FMo
         GxtmBeCyauzftJ83A/wQcOLr82vcdirMoDfNcdSV1/WwJ4H2ql65YTkO3D2iHGnEDxi4
         88D93MZiqOF4MXdfLe+QejO92DddXiC3u5nJMIH2LNTIubXwk7JF0bjQTyHxi0J1PNAU
         UA2QbuMdTLn7FnuIROADYHYaUjq8wYArYPgapKGrrrT9MESBjbEK65YY9KL8pTZNqqFc
         7xOorUrAmFQDGX0gfSYUSr52RQZF7OS4eVR02VOFYrgXpqQplEL//vl2i5WEgGfbLUCU
         oc2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YrQvvcrtp+YsrQUUYV9NQjLrTZsOfxmULuttgxfa06w=;
        b=WpvE6XwU/EZIuLNGAG+ADsy/0EvGBjt6JCGOr8Y3a/ISfFlDEJmEkx0OEWobsFntd9
         30skTrz5uw08cN3e12p0WR3BClkSdpQMMqttTk37BmEG/uH54HjsdqKVyZjjVq9xL7Ao
         dy7lzEKnJh7Fo9GGSHvCfKXc1xww9lbE/dp5Su+++uncgjQJ70bKcX8egq7PjDwAWP9t
         5r2WykDH0bWQohJvfRGFxy41+ULooOZTfJ4UtsxXvF8pPyZD5FKzyWJVELoloQWMZmUO
         Ygzl3rl4D61qDDpttLa1VlJQ2nkuVfzlRMGDiUw7K9o42ZuPd5YjcW57RYMON336IthJ
         yxSA==
X-Gm-Message-State: ABuFfojxvkfPCdB/2VEXqTSes0bXTnpY8/F+yfXSzafx4pHsqbr3T3NU
        X8fUWfLrgGyg/4nUFYICDKMGKtoXjDlV0odZiyo=
X-Google-Smtp-Source: ACcGV627TlH8OZD6CAJAHXwx5Le9vBIw3W/yMKoNNlvUYEPvP36VzCVFIPTkSPZn4O0PgTorVreQ67zsI+Eyq7m5oJ0=
X-Received: by 2002:a2e:93c4:: with SMTP id p4-v6mr2922836ljh.150.1537554596501;
 Fri, 21 Sep 2018 11:29:56 -0700 (PDT)
MIME-Version: 1.0
References: <1537367527-20773-1-git-send-email-jim2101024@gmail.com>
 <1537367527-20773-12-git-send-email-jim2101024@gmail.com> <20180919144119.GB29096@lst.de>
In-Reply-To: <20180919144119.GB29096@lst.de>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Fri, 21 Sep 2018 14:29:45 -0400
Message-ID: <CANCKTBuk9KyabrL7u6RvCp4eu+3mT=9Dvo4wvo99KF6iKVwWRw@mail.gmail.com>
Subject: Re: [PATCH v5 11/12] ARM64: add dma remap for BrcmSTB PCIe
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 19, 2018 at 10:41 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Sep 19, 2018 at 10:32:06AM -0400, Jim Quinlan wrote:
> > +#if defined(CONFIG_ARM64)
>
> Please use plain #ifdef where possible.
>
> > +dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
> > +{
> > +     return brcm_phys_to_dma(dev, paddr);
> > +}
> > +
> > +phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t dev_addr)
> > +{
> > +     return brcm_dma_to_phys(dev, dev_addr);
> > +}
> > +#endif
>
> How is this going to work for a kernel with BrcmSTB built in, but running
> on a more standard arm64 SOC?

Sorry for the delay in my response.  It would work because the
dma_ranges would be empty/null and identity mapping would happen, but
yes, all __dma_to_phys and __phys_to_dma calls would be wasting time
going through the brcm functions.  We would have to take BRCMSTB=y out
of the defconfig.  Florian would probably NAK that idea.

Please remember that the reason for this approach is because in your
response to V4 you suggested that "Override phys_to_dma and
dma_to_phys as mips and x86 [sta2x11] do for similar situations"  and
"Overriding phys_to_dma and dma_to_phys is required if you need to
support swiotlb, and chances are with a broken PCIe controller on
arm64 or mips64 you eventuall will".

>
> I suspect we really just want a set of ranges hanging off struct device
> (conditional on a config option).  Each SoC can then fill it at boot
> time, and if it is non-NULL the DMA code will use it instead of
> calling __phys_to_dma and __dma_to_phys.  In fact the single range
> version could probably just replace the existing dma_pfn_offset
> field.
If this was a config option then BRCMSTB=y in defconfig would set this
for all ARM64, just like the above case, correct?  And would this work
with SWIOTLB?   Also, do you think others would use it, or would I be
adding code in the DMA API only because of one unusual PCIe host
controller design?   Keep in mind that although you didn't like the
approach of V4 --  which intercepted DMA ops to make the appropriate
mapping and was not compatible with SWIOTLB -- at least it kept the
code restricted to oru driver.

Thanks,
Jim
