Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA91C433FE
	for <linux-pci@archiver.kernel.org>; Thu, 24 Nov 2022 14:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiKXO63 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 24 Nov 2022 09:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiKXO6Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 09:58:24 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F18125204;
        Thu, 24 Nov 2022 06:58:22 -0800 (PST)
Received: (Authenticated sender: thomas.petazzoni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 245BBFF808;
        Thu, 24 Nov 2022 14:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1669301899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R0aMYsPot2Cc7oq/Rax295Xkb9Vir2RNZBvjjC86qDQ=;
        b=RkQyHRUIq3cVAh2+AjZw3WMevLFXThJ7Tr/U63jUkglsa9tuz8M9ci/BsWcqxuallO+zEx
        Kk93ln2Ua86pPD+BP+bxzjynSqb3cwt96/ksNj4HA15O+r00QG5+A9QEAn3IiQMmGKGFGN
        gIBZ4Rrdr9mIOhCVZG/WwRdRgHXGzWSblbvk4+hsvIz44/uSi4FNyYqQ6KXUQnzp8qLiNG
        qZ29U9qBVqdJ5AOPApWqR1DB1IdlvuYjVQWfJd+BfVYWsrcAa+Sp31ndRD7nCCbMlsGyEU
        JQvN5BxcH2sO6plOXPi4ktfinr11BPTE9tuMcqNeQcTcgROB+bpKGLq4u7FLiw==
Date:   Thu, 24 Nov 2022 15:58:17 +0100
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Vadym Kochan <vadym.kochan@plvision.eu>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Elad Nachman <enachman@marvell.com>,
        Raz Adashi <raza@marvell.com>, Yuval Shaia <yshaia@marvell.com>
Subject: Re: [PATCH v2 2/3] PCI: armada8k: Add AC5 SoC support
Message-ID: <20221124155817.5f372417@windsurf>
In-Reply-To: <20221124135829.2551873-3-vadym.kochan@plvision.eu>
References: <20221124135829.2551873-1-vadym.kochan@plvision.eu>
        <20221124135829.2551873-3-vadym.kochan@plvision.eu>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

On Thu, 24 Nov 2022 15:58:27 +0200
Vadym Kochan <vadym.kochan@plvision.eu> wrote:


> -static int armada8k_pcie_start_link(struct dw_pcie *pci)
> -{
> -	u32 reg;
> -
> -	/* Start LTSSM */
> -	reg = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_CONTROL_REG);
> -	reg |= PCIE_APP_LTSSM_EN;
> -	dw_pcie_writel_dbi(pci, PCIE_GLOBAL_CONTROL_REG, reg);
> -
> -	return 0;
> -}

So this code is going away, but I don't see it being re-added anywhere.
I don't think anything in the code you are adding that sets the
LTSSM_EN bit in PCIE_GLOBAL_CONTROL_REG. Am I missing something?

Thomas
-- 
Thomas Petazzoni, co-owner and CEO, Bootlin
Embedded Linux and Kernel engineering and training
https://bootlin.com
