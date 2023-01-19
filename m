Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E84C678DD
	for <linux-pci@archiver.kernel.org>; Fri, 20 Jan 2023 04:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjATEuM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 19 Jan 2023 23:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjATEto (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Jan 2023 23:49:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C942FCE22C;
        Thu, 19 Jan 2023 20:43:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F88BB82021;
        Thu, 19 Jan 2023 03:28:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76FB9C433EF;
        Thu, 19 Jan 2023 03:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674098891;
        bh=lMuzsyB7e8AniltYWOXFa5R+/TsIeKzMyHeHn3aCSvc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BnesivjNNEIR2PY0nE3+W390zdBF6/au9JB81quCZtyShxZsHAeBuBAu/ptA5hH6S
         IUHJ+uLn8uawCyHagWpmdroT3ziU3cbw8YxPDBq2qDTqQihNAlWGSLNcELJPNXDFVk
         xH09UGtb59Hr6Obuz162qaXttSXItvT0kkPhAFs42f9nTkarFf4IjITLMgDKrvXRd+
         IQc3XrKY3B5ia7UB6SF3xnkhHZ7+RiWVMkr4X8Qbyzacyv3sXsev+Dmc3iVvq2otNA
         HhwhflUmcYJdnPmyz/24HuA0hs6tDvpcDqIpV38bnsLcb0omLi/5ZajAwzkjUiA3OI
         Nf9cu9ffhE1Hg==
Date:   Wed, 18 Jan 2023 19:28:09 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Madalin Bucur <madalin.bucur@nxp.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Thierry Reding <thierry.reding@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 1/7] phy: Add devm_of_phy_optional_get() helper
Message-ID: <20230118192809.2082b004@kernel.org>
In-Reply-To: <f53a1bcca637ceeafb04ce3540a605532d3bc34a.1674036164.git.geert+renesas@glider.be>
References: <cover.1674036164.git.geert+renesas@glider.be>
        <f53a1bcca637ceeafb04ce3540a605532d3bc34a.1674036164.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 18 Jan 2023 11:15:14 +0100 Geert Uytterhoeven wrote:
> Add an optional variant of devm_of_phy_get(), so drivers no longer have
> to open-code this operation.

For merging could you put this one on an immutable branch and then
everyone can pull + apply patches for callers from their section?
