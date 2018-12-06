Return-Path: <SRS0=KO/x=OP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3ED2C04EBF
	for <linux-pci@archiver.kernel.org>; Thu,  6 Dec 2018 01:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C59205C9
	for <linux-pci@archiver.kernel.org>; Thu,  6 Dec 2018 01:40:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1C59205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbeLFBkZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 5 Dec 2018 20:40:25 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:23265 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727712AbeLFBkZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Dec 2018 20:40:25 -0500
X-UUID: f14a2ebd3ef64324a3750387f62be4d8-20181206
X-UUID: f14a2ebd3ef64324a3750387f62be4d8-20181206
Received: from mtkcas32.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 174642803; Thu, 06 Dec 2018 09:40:20 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 6 Dec 2018 09:40:18 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 6 Dec 2018 09:40:18 +0800
Message-ID: <1544060418.20681.0.camel@mtkswgap22>
Subject: Re: [PATCH 0/2] PCI: mediatek: Add support for MT7629
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Jianjun Wang <jianjun.wang@mediatek.com>
CC:     <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <matthias.bgg@gmail.com>,
        <linux-pci@vger.kernel.org>, <mark.rutland@arm.com>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <honghui.zhang@mediatek.com>, <youlin.pei@mediatek.com>
Date:   Thu, 6 Dec 2018 09:40:18 +0800
In-Reply-To: <1544058553-10936-1-git-send-email-jianjun.wang@mediatek.com>
References: <1544058553-10936-1-git-send-email-jianjun.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2018-12-06 at 09:09 +0800, Jianjun Wang wrote:
> These series patches modify pcie-mediatek.c and dt-bindings compatible
> string to support MT7629 PCIe host.
> 
> There was something wrong with the mail server's permission setting, sorry
> for sent these mails repeatedly.
> 
> Jianjun Wang (2):
>   dt-bindings: PCI: Add support for MT7629
>   PCI: mediatek: Add controller support for MT7629
> 
>  .../devicetree/bindings/pci/mediatek-pcie.txt |  1 +
>  drivers/pci/controller/pcie-mediatek.c        | 26 +++++++++++++++++++
>  include/linux/pci_ids.h                       |  1 +
>  3 files changed, 28 insertions(+)
> 


Acked-by: Ryder Lee <ryder.lee@mediatek.com> for the series.

