Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7ADC43334
	for <linux-pci@archiver.kernel.org>; Sun, 10 Jul 2022 22:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbiGJWvR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 10 Jul 2022 18:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGJWvQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 10 Jul 2022 18:51:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D88E0CC;
        Sun, 10 Jul 2022 15:51:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5ACEC60F79;
        Sun, 10 Jul 2022 22:51:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D24EC3411E;
        Sun, 10 Jul 2022 22:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657493474;
        bh=lW+Od0IjKFZ8vso8MyN8Tg1qsg/N0ER08j48rNcviNw=;
        h=Date:From:To:Subject:From;
        b=O+EWni3wKw21DnJTOczm7QKBy+6qdyULLW//goDSEctXTOZ6ix0PfuK9gypMWNw5q
         UPxtwBgov+CmZI4NAYLwytHKAn2RK5nnVgUfklccJiAbVlr007FSHOHJoBksgCOWYW
         q2yrki6Seksa0x4smyzE+NQmoyAhyNoZIRQepY2ocm7Jt2cCXWZSyoG5NvVFNMwHPA
         FNoJjTx34mTI+YHAt3o3fvdC+hfBlp6DBkNnArRtmmEI9Or17IEQMzSBdu5hcu7f6S
         8WTQK3yQaSbxyZCbegoY7vYYh2zGbp8l+xu3a/GWAS2HqcGw4KWpT6ZYc474DjGgNd
         FzNXQqQaOwIag==
Received: by pali.im (Postfix)
        id A865379D; Mon, 11 Jul 2022 00:51:11 +0200 (CEST)
Date:   Mon, 11 Jul 2022 00:51:08 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mauri Sandberg <maukka@ext.kapsi.fi>,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org
Subject: How to correctly define memory range of PCIe config space
Message-ID: <20220710225108.bgedria6igtqpz5l@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

Together with Mauri we are working on extending pci-mvebu.c driver to
support Orion PCIe controllers as these controllers are same as mvebu
controller.

There is just one big difference: Config space access on Orion is
different. mvebu uses classic Intel CFC/CF8 registers for indirect
config space access but Orion has direct memory mapped config space.
So Orion DTS files need to have this memory range for config space and
pci-mvebu.c driver have to read this range from DTS and properly map it.

So my question is: How to properly define config space range in device
tree file? In which device tree property and in which format? Please
note that this memory range of config space is PCIe root port specific
and it requires its own MBUS_ID() like memory range of PCIe MEM and PCIe
IO mapping. Please look e.g. at armada-385.dtsi how are MBUS_ID() used:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/armada-385.dtsi

Krzysztof, would you be able to help with proper definition of this
property, so it would be fine also for schema checkers or other
automatic testing tools?
