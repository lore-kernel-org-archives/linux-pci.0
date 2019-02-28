Return-Path: <SRS0=y4Wk=RD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBF9C43381
	for <linux-pci@archiver.kernel.org>; Thu, 28 Feb 2019 19:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80F8A218D9
	for <linux-pci@archiver.kernel.org>; Thu, 28 Feb 2019 19:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551383130;
	bh=/RwR7Vd4MgBS7yyYqr5ziP9x6V9Gr5SxjCW4IGuOd48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=avLt68qbFho15bqOtUjNNPRRH7pUotfclxpmKAcXOBJ0cTEaM6OXpJWY47uj9JRIr
	 WtNdybH1ViXLN+G36NARRLPG/CnFy3ZovsdjoXDV39egQCMc0SN0rtFyZoUlpG82co
	 TjKEGSSFXwQv1Pdnm4phYEY47hAfHmcH47L57aoQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbfB1Tp3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 28 Feb 2019 14:45:29 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41099 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfB1Tp3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Feb 2019 14:45:29 -0500
Received: by mail-oi1-f194.google.com with SMTP id e7so17502345oia.8;
        Thu, 28 Feb 2019 11:45:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xklEfVfv14D88Ra+s2gfpz8Nij58iGoBhwr3RtVa6Bs=;
        b=eeGhnPykV6yjB348xg+5VzX6xEhOOk1mFaJmJvcr0bJVaEOSoN/PaX1ausLa4FVXiR
         ATfZ0kuaN8rvlB/CfV4QnVmXQ0Tg+gVBjIepLmI7Tped7IS2Wteuir7vZOy8oRb9Ur65
         XoZsEWveE1Mx3wyoTJT+4CPCmoRFQ6IP7g0SWacKAwwOO/NemtmXTjOJt6ns+x2KraFF
         QdxoA8D/WfwbaAlX8u96CGWvn+dten7drkimwa7tT64ESKNdRM+PJC+4DnV8laFhkLkz
         LL0Zqoxz/h5P2PIDBFzq/ss3/PT2bZex8r1m/UFHusO/BYIUB81hngUUboU8yMLWGGJs
         RqQg==
X-Gm-Message-State: AHQUAuY4D34tNxH0gD+GVv/nqPft1RDMBaFY6Jhq9qLCiiOLq74JFvm2
        NQokh92xHgEmMFuHvpagsA==
X-Google-Smtp-Source: AHgI3Ib16t80D3+xgzGpVh7EGedxveO+EHIanYy8E/l3ymY7WU3Qkz2YdrODmspvsvslP9VY4H3rzQ==
X-Received: by 2002:aca:ed0f:: with SMTP id l15mr939343oih.76.1551383129069;
        Thu, 28 Feb 2019 11:45:29 -0800 (PST)
Received: from localhost ([2607:fb90:20de:307f:59ce:35b2:628:2365])
        by smtp.gmail.com with ESMTPSA id t66sm8192991oig.39.2019.02.28.11.45.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 11:45:27 -0800 (PST)
Date:   Thu, 28 Feb 2019 13:45:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Xiaowei Bao <xiaowei.bao@nxp.com>
Cc:     bhelgaas@google.com, Zhiqiang.Hou@nxp.com, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, leoyang.li@nxp.com,
        kishon@ti.com, lorenzo.pieralisi@arm.com,
        gregkh@linuxfoundation.org, l.subrahmanya@mobiveil.co.in,
        arnd@arndb.de, Minghuan.Lian@nxp.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: Re: [PATCH 2/6] dt-bindings: add DT binding for the layerscape PCIe
 GEN4 controller with EP mode
Message-ID: <20190228194526.GA2716@bogus>
References: <20190218094643.2692-1-xiaowei.bao@nxp.com>
 <20190218094643.2692-2-xiaowei.bao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190218094643.2692-2-xiaowei.bao@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 18 Feb 2019 17:46:39 +0800, Xiaowei Bao wrote:
> Add the documentation for the Device Tree binding for the layerscape
> PCIe GEN4 controller with EP mode.
> 
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> ---
> depends on: http://patchwork.ozlabs.org/project/linux-pci/list/?series=88754
> 
>  .../bindings/pci/layerscape-pci-gen4.txt           |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
