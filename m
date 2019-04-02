Return-Path: <SRS0=JkSV=SE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5663CC4360F
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 16:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13B582064A
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 16:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L+dRcCXP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729546AbfDBQXp (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:23:45 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42632 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729232AbfDBQXp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Apr 2019 12:23:45 -0400
Received: by mail-io1-f66.google.com with SMTP id c4so11406484ioh.9
        for <linux-pci@vger.kernel.org>; Tue, 02 Apr 2019 09:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EAxC9Btkr7Gk8wWX2nBvviXnB1sBwtVZsT+WRzFCc20=;
        b=L+dRcCXPQHAApHqKjVBo00b0gDHceC/G9rpgCNBr9+ivQ+CpRtjjZxEM07Hc9Pv9QL
         NSHg86NUD/GAesbwtEPqjgsrrBwmiSe2gV36rslwRfbQFDiJzzaID1MmDHPmbe63rucy
         lVlpkZ9mPAHV3FrT427pbvdM7r8incVufXw11vObjorIguXLM/P7rfFrHNnKudaziD8v
         lWIZht05nqI/s3JIMtzRVMEvTVNvU7jqE5+sNY5GByDbCtlqe0opuxu9nha/EbDAeWyA
         3+Ro23tipZAjsIkKR9PiNDrLC9UkLLAsKoGpAWoiH3cVHpiSpPfR8u/MCipGfYltoei1
         Le1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EAxC9Btkr7Gk8wWX2nBvviXnB1sBwtVZsT+WRzFCc20=;
        b=ez5JwcNyPhpyWh9wC4tRWP3tSfkjelkutlIxXfiMLBI1npNiDAHGAiuJ84azzsbPzf
         TW6xKNo69mAwYzdHSKZXbfwZtqT0yx+7R+L5u/5uyyKbbOQ9AUIIwUsWdbd10QkAWn9f
         TquGqeMhznUXT5vkp9gNWHROUvX3lBsOuJILe5JVSYC8oNvE9VagvzMxHFdoe9X1sbi9
         oGjhmVSOwhwkX5+sRwA3CVGu6BIfDo3SLGTPhqJBFktfhGkclThZXhPfnQjyaDO4Ppzu
         9Ho3G0S7qn+iUFZ9N48XTyUUKMagrDlIm2wK5z47IHZMnEOlfFTjX/OwPCisqmfG9III
         rQfw==
X-Gm-Message-State: APjAAAVTDFYr0g2og3bvmIhT0isR/WXeaP3K+JFyoBRJQccynkH2AlO+
        CR4jsvK9XGR+2GrMK1QISsNJ3AXOC9LalvQAMUnXFw==
X-Google-Smtp-Source: APXvYqwWo1p15B4zgVrZ5YmdWvJVNWIJFU6HZjQ04W7M/XaksZHzLSmh+u2qUzIw1Pu255Rj/KD2S+JGbQidUzoZ+PU=
X-Received: by 2002:a6b:3b07:: with SMTP id i7mr34570392ioa.230.1554222224152;
 Tue, 02 Apr 2019 09:23:44 -0700 (PDT)
MIME-Version: 1.0
References: <1552304759-5394-1-git-send-email-bharat.kumar.gogada@xilinx.com>
In-Reply-To: <1552304759-5394-1-git-send-email-bharat.kumar.gogada@xilinx.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 2 Apr 2019 18:23:32 +0200
Message-ID: <CAKv+Gu-tFpvKm4PSyxNkXHFSStfVCqOzdWCZjFTXiosZhoVKXg@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: xilinx-nwl: Fix Multi MSI data programming
To:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 11 Mar 2019 at 12:46, Bharat Kumar Gogada
<bharat.kumar.gogada@xilinx.com> wrote:
>
> The current Multi MSI data programming fails if multiple end points
> requesting MSI and multi MSI are connected with switch, i.e the current
> multi MSI data being given is not considering the number of vectors
> being requested in case of multi MSI.
> Due to this if multiple end points are connected and requesting MSI
> and multi MSI combination, the multi MSI data is ending up using
> wrong MSI data, which might be used by different device.
>
> Fix Multi MSI data programming with required alignment by
> using number of vectors being requested.
>
> Fixes: ab597d35ef11 ("PCI: xilinx-nwl: Add support for Xilinx NWL PCIe
> Host Controller")
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> ---
> V2:
>  - Added more description of fix
> ---
>  drivers/pci/controller/pcie-xilinx-nwl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
> index 81538d7..36669c5 100644
> --- a/drivers/pci/controller/pcie-xilinx-nwl.c
> +++ b/drivers/pci/controller/pcie-xilinx-nwl.c
> @@ -484,7 +484,7 @@ static int nwl_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
>
>         mutex_lock(&msi->lock);
>         bit = bitmap_find_next_zero_area(msi->bitmap, INT_PCI_MSI_NR, 0,
> -                                        nr_irqs, 0);
> +                                        nr_irqs, nr_irqs - 1);

Are you sure nr_irqs is guaranteed to be a power of 2?

>         if (bit >= INT_PCI_MSI_NR) {
>                 mutex_unlock(&msi->lock);
>                 return -ENOSPC;
> --
> 2.7.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
