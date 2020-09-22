Return-Path: <SRS0=cLGU=C7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA55EC4363D
	for <linux-pci@archiver.kernel.org>; Tue, 22 Sep 2020 14:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A19DC239A1
	for <linux-pci@archiver.kernel.org>; Tue, 22 Sep 2020 14:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600786368;
	bh=oqJeLFsA6VsNxyqMrg6nNJlpMSU2AWfAIp9i6bNafpA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=EGE6t4Q0P4aah2Fajn4NEd/C4dhNFWpURE6rTW6SOf3zpPFWY9lSKHc74DZ7MwZ2a
	 HcVxslLmM4byRxxUcSL5cyNydVePlHxOVYBOgdXYlBbnrNO/5WHNE+MPaUO9fhHhV9
	 W0V/5DKGMXNKR6/2ibpuRAI2FZ0cvKoGKiAGumJc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgIVOws (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 22 Sep 2020 10:52:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:41334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726640AbgIVOwr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Sep 2020 10:52:47 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18B002395C;
        Tue, 22 Sep 2020 14:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600786367;
        bh=oqJeLFsA6VsNxyqMrg6nNJlpMSU2AWfAIp9i6bNafpA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=N4JKeq8sTKtFA4NfW8agyf+pbMR85ieGitbD8s7LDVCEVOynsA1OME5d0aRMinOcK
         1fZBZlnngIr0Tot3lID84mPI1YmL4Wzn9UV8jIVE4mVHkZXDWGwfaWcB2jAZdI4ciJ
         7ChtGwGRwRNfJKTMXlnwmPRYS2dgfZDD2vBdCpXA=
Date:   Tue, 22 Sep 2020 09:52:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Toan Le <toan@os.amperecomputing.com>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Duc Dang <dhdang@apm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: xgene: Remove unused assignment to variable msi_val
Message-ID: <20200922145245.GA2201556@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200922030257.459898-1-kw@linux.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 22, 2020 at 03:02:57AM +0000, Krzysztof Wilczyński wrote:
> The value assigned to msi_val after the inner loop finishes its run is
> never used for anything, and it is also immediately overridden in the
> line that follows with the return value from the xgene_msi_int_read()
> function.
> 
> Since the value of msi_val following the inner loop completion is never
> used in any meaningful way the assignment can be removed.
> 
> Addresses-Coverity-ID: 1437183 ("Unused value")
> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
> ---
>  drivers/pci/controller/pci-xgene-msi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-xgene-msi.c b/drivers/pci/controller/pci-xgene-msi.c
> index 02271c6d17a1..2470782cb01a 100644
> --- a/drivers/pci/controller/pci-xgene-msi.c
> +++ b/drivers/pci/controller/pci-xgene-msi.c
> @@ -493,8 +493,8 @@ static int xgene_msi_probe(struct platform_device *pdev)
>  	 */
>  	for (irq_index = 0; irq_index < NR_HW_IRQS; irq_index++) {
>  		for (msi_idx = 0; msi_idx < IDX_PER_GROUP; msi_idx++)
> -			msi_val = xgene_msi_ir_read(xgene_msi, irq_index,
> -						    msi_idx);
> +			xgene_msi_ir_read(xgene_msi, irq_index, msi_idx);
> +

Interesting.  One might expect that throwing away the result of a read
means the read itself is pointless, but fortunately there's a comment
just above explaining that these registers are read-to-clear.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Assuming Toan acks this, Lorenzo will likely pick it up when he
returns next week.

>  		/* Read MSIINTn to confirm */
>  		msi_val = xgene_msi_int_read(xgene_msi, irq_index);
>  		if (msi_val) {
> -- 
> 2.28.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
