Return-Path: <SRS0=18Ni=NF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFD5C46475
	for <linux-pci@archiver.kernel.org>; Thu, 25 Oct 2018 21:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B714620834
	for <linux-pci@archiver.kernel.org>; Thu, 25 Oct 2018 21:52:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B714620834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbeJZG1M (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 26 Oct 2018 02:27:12 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37513 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbeJZG1M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Oct 2018 02:27:12 -0400
Received: by mail-oi1-f193.google.com with SMTP id e17-v6so8041220oib.4;
        Thu, 25 Oct 2018 14:52:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iqbQl5ihR/SM/+0e/deIgeI7mi+Rh+Z/cWXJhlKJTSk=;
        b=WJH6+QSRTx7PekurNxivYfhjp4m6tHun1lUqNNG5zQLn9g/wLoBDYcTJ8knZpdLXQn
         ePZCrpy2Xbyvw5dFISrm74nw4c/MQ8cVqdBnAhxphnZhSyvWf4Z5D64spdnJvYjUeGRS
         sdbuaySLMYaK+cxxFIr5+du1CnT/uzW9fTgUOrTKdgWcpIWD1b1P2AA692gGh7r+uVZj
         qPpbmbJQNiyse7Ul0LBa9ABAj1jQHoeAsk0l0v6wexYCjxRpotDze3H0JmtVmBKBN+4W
         eCeAjIW349c1qatL8RUnM3Limwrl53WPa2tFp2hkyw72OVMxCfv2H6HMmg2nIf5Dpopj
         XkSA==
X-Gm-Message-State: AGRZ1gKxmTfrj1qlSJW8ynL1yOd2swY6H1mDSXyss2IuXVJ0HkojtIW1
        3EZtfXWiMg6Zp0cxV+JkmA==
X-Google-Smtp-Source: AJdET5e/v/ewadxX7/s7dgp0flO1DICwZqrullxD2vkDwAhBG75EfP6NMelbZSwQqcD9Ihicu10SvQ==
X-Received: by 2002:aca:a6d1:: with SMTP id t78-v6mr598067oij.341.1540504367881;
        Thu, 25 Oct 2018 14:52:47 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n63-v6sm2822805oia.52.2018.10.25.14.52.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 14:52:47 -0700 (PDT)
Date:   Thu, 25 Oct 2018 16:52:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Xiaowei Bao <xiaowei.bao@nxp.com>
Cc:     bhelgaas@google.com, mark.rutland@arm.com, shawnguo@kernel.org,
        leoyang.li@nxp.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, minghuan.Lian@nxp.com,
        mingkai.hu@nxp.com, roy.zang@nxp.com, kstewart@linuxfoundation.org,
        cyrille.pitchen@free-electrons.com, pombredanne@nexb.com,
        shawn.lin@rock-chips.com, niklas.cassel@axis.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 3/6] PCI: layerscape: Add the EP mode support
Message-ID: <20181025215246.GA14861@bogus>
References: <20181025110901.5680-1-xiaowei.bao@nxp.com>
 <20181025110901.5680-3-xiaowei.bao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025110901.5680-3-xiaowei.bao@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 25, 2018 at 07:08:58PM +0800, Xiaowei Bao wrote:
> Add the EP mode support.
> 
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> ---
>  .../devicetree/bindings/pci/layerscape-pci.txt     |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> index 66df1e8..d3d7be1 100644
> --- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> @@ -13,12 +13,15 @@ information.
>  
>  Required properties:
>  - compatible: should contain the platform identifier such as:
> +  RC mode:
>          "fsl,ls1021a-pcie", "snps,dw-pcie"
>          "fsl,ls2080a-pcie", "fsl,ls2085a-pcie", "snps,dw-pcie"
>          "fsl,ls2088a-pcie"
>          "fsl,ls1088a-pcie"
>          "fsl,ls1046a-pcie"
>          "fsl,ls1012a-pcie"
> +  EP mode:
> +        "fsl,ls-pcie-ep"

You need SoC specific compatibles for the same reasons as the RC.

Rob
