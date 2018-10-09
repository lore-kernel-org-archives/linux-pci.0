Return-Path: <SRS0=286E=MV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D878C67879
	for <linux-pci@archiver.kernel.org>; Tue,  9 Oct 2018 01:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F4D21476
	for <linux-pci@archiver.kernel.org>; Tue,  9 Oct 2018 01:44:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1F4D21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbeJII6w (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 9 Oct 2018 04:58:52 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:3540 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725887AbeJII6w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Oct 2018 04:58:52 -0400
X-UUID: 3b18bb3085924997ad06263f9c4b2f4e-20181009
X-UUID: 3b18bb3085924997ad06263f9c4b2f4e-20181009
Received: from mtkcas36.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <honghui.zhang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 758328591; Tue, 09 Oct 2018 09:44:15 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 9 Oct
 2018 09:44:13 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 9 Oct 2018 09:44:13 +0800
Message-ID: <1539049453.6246.6.camel@mhfsdcap03>
Subject: Re: [PATCH v6 0/9] PCI: mediatek: fixup find_port, enable_msi and
 add pm, module support
From:   Honghui Zhang <honghui.zhang@mediatek.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ryder.lee@mediatek.com>,
        <ulf.hansson@linaro.org>, <marc.zyngier@arm.com>,
        <matthias.bgg@gmail.com>, <devicetree@vger.kernel.org>,
        <yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
        <youlin.pei@mediatek.com>, <yt.shen@mediatek.com>,
        <sean.wang@mediatek.com>
Date:   Tue, 9 Oct 2018 09:44:13 +0800
In-Reply-To: <20181008173131.GN120535@bhelgaas-glaptop.roam.corp.google.com>
References: <1538969088-7136-1-git-send-email-honghui.zhang@mediatek.com>
         <20181008173131.GN120535@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 2018-10-08 at 12:31 -0500, Bjorn Helgaas wrote:
> On Mon, Oct 08, 2018 at 11:24:39AM +0800, honghui.zhang@mediatek.com wrote:
> 
> > Honghui Zhang (9):
> >   PCI: mediatek: Using slot's devfn for compare to fix
> >     mtk_pcie_find_port logic
> >   PCI: mediatek: Fixup class ID for MT7622 as PCI_CLASS_BRIDGE_PCI
> >   PCI: mediatek: Remove the redundant dev->pm_domain check
> >   PCI: mediatek: Convert to use pci_host_probe()
> >   PCI: mediatek: Move the mtk_pcie_startup_port_v2 function's define
> >     after mtk_pcie_setup_irq
> >   PCI: mediatek: Fixup enable msi logic by enable msi after clock
> >     enabled
> 
> s/msi/MSI/ (twice)
> 
> >   PCI: mediatek: Add system pm support for MT2712 and MT7622
> 
> s/pm/PM/
> 
> "msi" and "pm" are not English words, and capitalizing them tells the
> reader that they are acronyms or initialisms (like GIC and IRQ below).
> 

Thanks for the comments. Will fix those in the next version.

thanks.

> >   PCI: mediatek: Save the GIC IRQ in mtk_pcie_port
> >   PCI: mediatek: Add loadable kernel module support


