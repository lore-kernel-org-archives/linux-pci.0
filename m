Return-Path: <SRS0=KO/x=OP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FEEC04EB8
	for <linux-pci@archiver.kernel.org>; Thu,  6 Dec 2018 20:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D2C0214E0
	for <linux-pci@archiver.kernel.org>; Thu,  6 Dec 2018 20:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544129354;
	bh=Bv+kZq0KTage8x9eJjPNRosOdNFGkxzTlsV4NVZLOsc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kam85jHUxNU/lTg6TyvsGGk8B0H6OaZ8+3mMK0SLZZ3jN+F/qpetCvbKhzNqvrFit
	 +ocBmVoI96cf6R8pkjUJxDz5wQkB8uvjYSFBb1r8m/Th8a93r9hfh/oCnyNPZD9P2d
	 B6PR7pufK+QEft5K3qgr/Kb9sdqAtNrBvY0C2CtU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D2C0214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbeLFUtN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 6 Dec 2018 15:49:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:55492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbeLFUtN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Dec 2018 15:49:13 -0500
Received: from localhost (unknown [66.115.192.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 107B521479;
        Thu,  6 Dec 2018 20:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544129353;
        bh=Bv+kZq0KTage8x9eJjPNRosOdNFGkxzTlsV4NVZLOsc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ArlwgQnbhSVDLYp6TqRm/GrJ3bMhGM1Z/lp+40Tnjj/pgk15sp1KZD2rDzORUevoI
         7HRt6jzjP8sZnZaLmfubCE/izS1aLUpI1BpIR0N1vPv8P+uAJPwUltkFJAUTAtqLkI
         wK8+xxAQGBrLTeT6iK0fb0e26nG/UZSUR8XRdKA0=
Date:   Thu, 6 Dec 2018 14:49:12 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] MAINTAINERS: Remove Jianguo Sun from Hisilicon STB DWC
 entry
Message-ID: <20181206204912.GD247703@google.com>
References: <20181129182354.3273-1-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129182354.3273-1-lorenzo.pieralisi@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 29, 2018 at 06:23:54PM +0000, Lorenzo Pieralisi wrote:
> Jianguo Sun's email address reported in MAINTAINERS is not active any
> longer, remove it from the DWC Hisilicon STB entry.

s/Hisilicon/HiSilicon/

> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>

Probably makes sense for you to merge this, Lorenzo, along with the
HiSilicon code changes.

> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f4855974f325..5d7beffe9935 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11541,7 +11541,6 @@ F:	Documentation/devicetree/bindings/pci/kirin-pcie.txt
>  F:	drivers/pci/controller/dwc/pcie-kirin.c
>  
>  PCIE DRIVER FOR HISILICON STB
> -M:	Jianguo Sun <sunjianguo1@huawei.com>
>  M:	Shawn Guo <shawn.guo@linaro.org>
>  L:	linux-pci@vger.kernel.org
>  S:	Maintained
> -- 
> 2.19.2
> 
