Return-Path: <SRS0=j7M/=MU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D6FC677D4
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 17:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D021C2145D
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 17:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ulhjD4xQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D021C2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbeJIAoT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 8 Oct 2018 20:44:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:53996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbeJIAoT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Oct 2018 20:44:19 -0400
Received: from localhost (unknown [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09BD0213A2;
        Mon,  8 Oct 2018 17:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539019893;
        bh=KX2ZgCDGy6ZgsQvtEVci3+RbZ1rpqfiwmxMUNP/ewd4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ulhjD4xQ4fZkkcGaNBlcHUo+p0Q1/mB+OzdP5nuuX0W4kSMq0Qr4/jmgGzHSem/VC
         W9aFmG5WmCPzNtK64vIX5RMR4EMRVqHOZYtp1lv/TStw8f/WTuEAgG1FjRPYgyTMKj
         2iDOWwiCVeVjMLMIrSS6Zi1Id7A+un3AIzmULCMo=
Date:   Mon, 8 Oct 2018 12:31:31 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     honghui.zhang@mediatek.com
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryder.lee@mediatek.com,
        ulf.hansson@linaro.org, marc.zyngier@arm.com,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
        youlin.pei@mediatek.com, yt.shen@mediatek.com,
        sean.wang@mediatek.com
Subject: Re: [PATCH v6 0/9] PCI: mediatek: fixup find_port, enable_msi and
 add pm, module support
Message-ID: <20181008173131.GN120535@bhelgaas-glaptop.roam.corp.google.com>
References: <1538969088-7136-1-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538969088-7136-1-git-send-email-honghui.zhang@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 08, 2018 at 11:24:39AM +0800, honghui.zhang@mediatek.com wrote:

> Honghui Zhang (9):
>   PCI: mediatek: Using slot's devfn for compare to fix
>     mtk_pcie_find_port logic
>   PCI: mediatek: Fixup class ID for MT7622 as PCI_CLASS_BRIDGE_PCI
>   PCI: mediatek: Remove the redundant dev->pm_domain check
>   PCI: mediatek: Convert to use pci_host_probe()
>   PCI: mediatek: Move the mtk_pcie_startup_port_v2 function's define
>     after mtk_pcie_setup_irq
>   PCI: mediatek: Fixup enable msi logic by enable msi after clock
>     enabled

s/msi/MSI/ (twice)

>   PCI: mediatek: Add system pm support for MT2712 and MT7622

s/pm/PM/

"msi" and "pm" are not English words, and capitalizing them tells the
reader that they are acronyms or initialisms (like GIC and IRQ below).

>   PCI: mediatek: Save the GIC IRQ in mtk_pcie_port
>   PCI: mediatek: Add loadable kernel module support
