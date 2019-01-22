Return-Path: <SRS0=s1t5=P6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56EFEC282C3
	for <linux-pci@archiver.kernel.org>; Tue, 22 Jan 2019 03:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 229E921726
	for <linux-pci@archiver.kernel.org>; Tue, 22 Jan 2019 03:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfAVDYD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 21 Jan 2019 22:24:03 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:64715 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726774AbfAVDYD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Jan 2019 22:24:03 -0500
X-UUID: 0f6feab502f948d4a5d4f1b429232ce1-20190122
X-UUID: 0f6feab502f948d4a5d4f1b429232ce1-20190122
Received: from mtkcas35.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 287871218; Tue, 22 Jan 2019 11:23:54 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 22 Jan 2019 11:23:53 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 22 Jan 2019 11:23:52 +0800
Message-ID: <1548127432.11442.1.camel@mtkswgap22>
Subject: Re: [v1,0/2] PCI: mediatek: Add support for MT7629
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Jianjun Wang <jianjun.wang@mediatek.com>
CC:     <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <mark.rutland@arm.com>,
        <matthias.bgg@gmail.com>, <linux-pci@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <honghui.zhang@mediatek.com>, <youlin.pei@mediatek.com>
Date:   Tue, 22 Jan 2019 11:23:52 +0800
In-Reply-To: <1548069062-12430-1-git-send-email-jianjun.wang@mediatek.com>
References: <1548069062-12430-1-git-send-email-jianjun.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 2019-01-21 at 19:11 +0800, Jianjun Wang wrote:
> These series patches modify pcie-mediatek.c and dt-bindings compatible
> string to support MT7629 PCIe host.
> 
> Jianjun Wang (2):
>   dt-bindings: PCI: Add support for MT7629
>   PCI: mediatek: Add controller support for MT7629
> 
>  .../devicetree/bindings/pci/mediatek-pcie.txt |  1 +
>  drivers/pci/controller/pcie-mediatek.c        | 28 +++++++++++++++++++
>  include/linux/pci_ids.h                       |  1 +
>  3 files changed, 30 insertions(+)
> 

Acked-by: Ryder Lee <ryder.lee@mediatek.com>


