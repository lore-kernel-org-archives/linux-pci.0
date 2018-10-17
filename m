Return-Path: <SRS0=Zwnb=M5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E60EECDE32
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 15:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E56B121527
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 15:20:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E56B121527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbeJQXQM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:16:12 -0400
Received: from foss.arm.com ([217.140.101.70]:53452 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727948AbeJQXQM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Oct 2018 19:16:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A1DB80D;
        Wed, 17 Oct 2018 08:20:02 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (unknown [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 92C023F59C;
        Wed, 17 Oct 2018 08:19:59 -0700 (PDT)
Date:   Wed, 17 Oct 2018 16:19:54 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     honghui.zhang@mediatek.com
Cc:     bhelgaas@google.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryder.lee@mediatek.com,
        ulf.hansson@linaro.org, marc.zyngier@arm.com,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
        youlin.pei@mediatek.com, yt.shen@mediatek.com,
        jianjun.wang@mediatek.com, yong.wu@mediatek.com
Subject: Re: [PATCH v8 0/9] PCI: mediatek: fixup find_port, enable_msi and
 add PM, module support
Message-ID: <20181017151954.GA9374@e107981-ln.cambridge.arm.com>
References: <1539590940-13355-1-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539590940-13355-1-git-send-email-honghui.zhang@mediatek.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 15, 2018 at 04:08:51PM +0800, honghui.zhang@mediatek.com wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
> 
> This patchset includes misc patchs:
> 
> The patch 1 fixup the mtk_pcie_find_port logic which will cause system
> could not touch the EP's configuration space that connected to PCIe slot 1.
> 
> The patch 2 fixup the class type for MT7622.
> The patch 6 fixup the enable msi logic, the operation to enable MSI
> should be after system clock is enabled. Call mtk_pcie_enable_msi in
> mtk_pcie_startup_port_v2 since the clock was all enabled at that time.
> 
> The patch 7 was rebased and refactor of the v4 patch[1], changes are:
>  -Add PM support for MT7622.
>  -Using mtk_pcie_enable_port to re-establish the link when resumed.
>  -Rebased on this patchset.
> 
> The patch 9 add loadable kernel module support.
> 
> [1] https://patchwork.kernel.org/patch/10479079

I have pushed out (after basically rewriting all commit logs and
squashing two patches) this version of the patchset to my pci/mediatek
branch for v4.20, keeping in mind that you must follow-up with Bjorn on
this patch:

https://patchwork.ozlabs.org/patch/984668/

that we shall still consider for v4.21.

Lorenzo

> Change since v7:
>  - Add Acked-by tags from Ryder Lee.
>  - Add Fix tags for patch 2(Fix calss type for MT7622 as PCI_CLASS_BRIDGE_PCI)
>    and patch 6(Fixup enable MSI logic by enable MSI after clock enabled)
> 
> Change since v6:
>  - Remove the pci_unmap_iospace when remove the device since the
>    devm_pci_remap_iospace is an devm_ version.
>  - Commit message changed for patch 2(Fix class type for MT7622 as PCI_CLASS_BRIDGE_PCI).
>  - Capitilizing "MSI" and "PM" in the patch title.
> 
> Change since v5:
>  - A bit improvement of mtk_pcie_find_port suggest by Lorenzo.
>    MSI after clock enabled).
>  - Add Acked-by tags from Ryder.
> 
> Change since v4:
>  - Add patch 2 to fixup class type for MT7622.
>  - Add patch 3 to remove the redundant dev->pm_domain check
>  - Add patch 4 to covert to use pci_host_probe
>  - Add patch 5 to re-arrange the function define, this is a prepare patch for
>    fixup the enable_msi logic, no functional changed have been made by this one.
>  - Add patch 8 to save the GIC IRQ in mtk_pcie_port as a prepare patch for tear
>    down the irq when remove the kernel module.
>  - Re-arrange the find_port flow suggest by Lorenzo to make the code parse easier
>    for the patch 1.
>  - Remove the .pm_support in mtk_pcie_soc in patch 7 since if system pm was not
>    supported, then those pm callbacks will never be executed for MT7622. So the
>    .pm_support is not needed.
> 
> Change since v3:
>  - Remove pm_runtime_XXX ops in suspend and resume callbacks in the third patch.
>  - Rebase to 4.19-rc1.
> 
> Change since v2:
>  - Fix the list_for_each_entry_safe parameter error.
>  - Add Ryder's Acked-by flag.
> 
> Change since v1:
>  - A bit of code refact of the first patch suggested by Andy Shevchenko, and
>    commit message updated.
> 
> Honghui Zhang (9):
>   PCI: mediatek: Using slot's devfn for compare to fix
>     mtk_pcie_find_port logic
>   PCI: mediatek: Fix class type for MT7622 as PCI_CLASS_BRIDGE_PCI
>   PCI: mediatek: Remove the redundant dev->pm_domain check
>   PCI: mediatek: Convert to use pci_host_probe()
>   PCI: mediatek: Move the mtk_pcie_startup_port_v2 function's define
>     after mtk_pcie_setup_irq
>   PCI: mediatek: Fixup enable MSI logic by enable MSI after clock
>     enabled
>   PCI: mediatek: Add system PM support for MT2712 and MT7622
>   PCI: mediatek: Save the GIC IRQ in mtk_pcie_port
>   PCI: mediatek: Add loadable kernel module support
> 
>  drivers/pci/controller/Kconfig         |   2 +-
>  drivers/pci/controller/pcie-mediatek.c | 319 +++++++++++++++++++++------------
>  2 files changed, 204 insertions(+), 117 deletions(-)
> 
> -- 
> 2.6.4
> 
