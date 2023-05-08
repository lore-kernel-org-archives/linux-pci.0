Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B21C7EE25
	for <linux-pci@archiver.kernel.org>; Mon,  8 May 2023 21:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbjEHVga (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 8 May 2023 17:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234162AbjEHVgV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 May 2023 17:36:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9C9903C;
        Mon,  8 May 2023 14:35:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB44C642F7;
        Mon,  8 May 2023 21:35:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E543FC433EF;
        Mon,  8 May 2023 21:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683581739;
        bh=lePxUD2RwGwx/yLwKafG9xCR8tb9Igp6SNSrOmIyFFY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=IFxsfNq46eOIc/XKbCOl1PWs29uP0l3dlW9g+C0zyqx8WFs65Icfu23RHbd52P+e+
         sCLg0SNrbY178672jUJ7m0Xi+t6okG1fyNP3UeqYwSZ0tq0dF0LbS2knRoyMzDZfG9
         2shZhHB2YYXpChiAdSNGwXhvypDBlxVjD6S0CwMXvBsDUSSZRfsAlDpwZWI+CIUWkW
         TK6p5NzVPsfXj/n37QwUQtP96PVPhF8ac6LCt3nipSoqPXxDJJNKlreDtlVJ3Erk6T
         1ya1mae9daXDmKhdo3o0Les67CmRAILAAPgcSNCOQj/oFWGbzw4TgQOgs6RHnpyeS3
         V4jvUPazBYeHQ==
Date:   Mon, 8 May 2023 16:35:37 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH fixes] dt-bindings: PCI: fsl,imx6q: fix assigned-clocks
 warning
Message-ID: <20230508213537.GA1193015@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508071837.68552-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 08, 2023 at 09:18:37AM +0200, Krzysztof Kozlowski wrote:
> assigned-clocks are a dependency of clocks, however the dtschema has
> limitation and expects clocks to be present in the binding using
> assigned-clocks, not in other referenced bindings.  The clocks were
> defined in common fsl,imx6q-pcie-common.yaml, which is referenced by fsl,imx6q-pcie-ep.yaml.  The fsl,imx6q-pcie-ep.yaml used assigned-clocks thus leading to warnings:

Weirdly long line here.  I think it's good to preserve longs lines in
warnings and error messages themselves, but in the normal text it
looks like an oversight.

>   Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.example.dtb: pcie-ep@33800000:
>     Unevaluated properties are not allowed ('assigned-clock-parents', 'assigned-clock-rates', 'assigned-clocks' were unexpected)
>   From schema: Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
