Return-Path: <SRS0=/yaj=M3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A44C28CF8
	for <linux-pci@archiver.kernel.org>; Mon, 15 Oct 2018 06:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE5B2086A
	for <linux-pci@archiver.kernel.org>; Mon, 15 Oct 2018 06:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DE5B2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbeJONtr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Oct 2018 09:49:47 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:38999 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726401AbeJONtr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Oct 2018 09:49:47 -0400
X-UUID: 84507e3de42a467bbddde0788015103e-20181015
X-UUID: 84507e3de42a467bbddde0788015103e-20181015
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 166524223; Mon, 15 Oct 2018 14:05:55 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 15 Oct 2018 14:05:54 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 15 Oct 2018 14:05:54 +0800
Message-ID: <1539583554.20626.2.camel@mtkswgap22>
Subject: Re: [PATCH v7 0/9] PCI: mediatek: fixup find_port, enable_msi and
 add PM, module support
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     <honghui.zhang@mediatek.com>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ulf.hansson@linaro.org>,
        <marc.zyngier@arm.com>, <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <yingjoe.chen@mediatek.com>,
        <eddie.huang@mediatek.com>, <youlin.pei@mediatek.com>,
        <yt.shen@mediatek.com>, <jianjun.wang@mediatek.com>
Date:   Mon, 15 Oct 2018 14:05:54 +0800
In-Reply-To: <1539582287-9171-1-git-send-email-honghui.zhang@mediatek.com>
References: <1539582287-9171-1-git-send-email-honghui.zhang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 2018-10-15 at 13:44 +0800, honghui.zhang@mediatek.com wrote:
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
> 
> Change since v6:
>  - Remove the pci_unmap_iospace when remove the device since the
>    devm_pci_remap_iospace is an devm_ version.
>  - Commit message changed for patch 2(Fix class type for MT7622 as PCI_CLASS_BRIDGE_PCI).
>  - Capitilizing "MSI" and "PM" in the patch title.
> 
> Change since v5:
>  - A bit improvement of mtk_pcie_find_port suggest by Lorenzo.
>  - Add fixup tags of fix enable MSI logic in patch 6.
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


You forgot to add my Acked-by tags in v7.

Acked-by: Ryder Lee <ryder.lee@mediatek.com> for the series.

Thanks.

