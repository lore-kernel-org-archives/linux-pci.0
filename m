Return-Path: <SRS0=ROz5=S4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4880C43219
	for <linux-pci@archiver.kernel.org>; Fri, 26 Apr 2019 15:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A239E2084F
	for <linux-pci@archiver.kernel.org>; Fri, 26 Apr 2019 15:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556292152;
	bh=obSQtL5XUn3iIY38QXNX7w3QDC/W+DfXQc5CZITuuNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=B9M/J+YhDv2CZlA2leEN2hx/6d6A7QCZGWLQ/7Jt2CSM9SRbKmMCPpPRDzJjD/rNj
	 H9Qnt7QxSJFAxAW3FP4IKjpAD3qAplRq2a2bR6D0Q/SIvBkdEwOMYbBEMnw1OQp2DJ
	 qg6RhgiUOA2RTmZvb22DhmkHybsIugqX5glmRkj4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbfDZPWb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:22:31 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34039 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbfDZPWb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Apr 2019 11:22:31 -0400
Received: by mail-oi1-f193.google.com with SMTP id v10so3253656oib.1;
        Fri, 26 Apr 2019 08:22:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gEQjs4gWYKzTcFdcNFpMqTicLOuyHmzyiI0OMOLN0zs=;
        b=Hq//Rx65lJ64lJ+WOs1QFlZIWdTx6gcV4+2e0VJ4YFP3Aeib/qybarC5uVyShSHxT5
         uL1HqZpplD/2zW9NxvT/Mi94tiQP7ejsd/edhLPc9Dnyy3onX42DmZvGTJiRfINIAGfJ
         fzazujMcDreFPVnpw/5rlnMwbIHAPXnr3Js3InW+cPOh+tHdyUt1P1e/aixrRtoRxwTX
         STH0MDGL0/krI8D/DJgx+YDEQ5JKN7MVobcWvd4KbNzkvYtLbr1+EiS8DC23hs9Veszh
         iHp/uw9FnLgu5tHJnjxLfkTvS0r5RhpG+RQOAWcYInzEQA4TwW23eqD1ziQx/agweYG0
         lPwQ==
X-Gm-Message-State: APjAAAW9mkyd05788I/AnB9mIJpDRjb7hsOWI0xhEwD502UDFlm4wvFx
        6ZsvCTiIDP/igXY/usLZaw==
X-Google-Smtp-Source: APXvYqxkgLUDPnqbHG2EUDQuzVMmPUf88BqDsEOx9VRUyXCu0x0uO2/3+QX8Of539cQc6sH5NfTzug==
X-Received: by 2002:aca:1204:: with SMTP id 4mr7377775ois.29.1556292150528;
        Fri, 26 Apr 2019 08:22:30 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i11sm10150564otl.27.2019.04.26.08.22.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 08:22:29 -0700 (PDT)
Date:   Fri, 26 Apr 2019 10:22:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        mark.rutland@arm.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, kishon@ti.com, catalin.marinas@arm.com,
        will.deacon@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, mperttunen@nvidia.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V5 09/16] Documentation/devicetree: Add PCIe
 supports-clkreq property
Message-ID: <20190426152229.GA8492@bogus>
References: <20190424052004.6270-1-vidyas@nvidia.com>
 <20190424052004.6270-10-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424052004.6270-10-vidyas@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 24, 2019 at 10:49:57AM +0530, Vidya Sagar wrote:
> Some host controllers need to know the existence of clkreq signal routing to
> downstream devices to be able to advertise low power features like ASPM L1
> substates. Without clkreq signal routing being present, enabling ASPM L1 sub
> states might lead to downstream devices falling off the bus. Hence a new device
> tree property 'supports-clkreq' is added to make such host controllers
> aware of clkreq signal routing to downstream devices.

Please be consistent with subjects (Use 'dt-bindings: ...')

With that change,

Reviewed-by: Rob Herring <robh@kernel.org>

> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> Changes since [v4]:
> * None
> 
> Changes since [v3]:
> * Rebased on top of linux-next top of the tree
> 
> Changes since [v2]:
> * None
> 
> Changes since [v1]:
> * This is a new patch in v2 series
> 
>  Documentation/devicetree/bindings/pci/pci.txt | 5 +++++
>  1 file changed, 5 insertions(+)
