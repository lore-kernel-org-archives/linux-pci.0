Return-Path: <SRS0=4zPb=NS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE41AC32789
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 03:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A15E20827
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 03:19:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A15E20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbeKGMrq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 7 Nov 2018 07:47:46 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:39630 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726298AbeKGMrq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Nov 2018 07:47:46 -0500
X-UUID: c661d7ac04f8473ead57c116eafc541e-20181107
X-UUID: c661d7ac04f8473ead57c116eafc541e-20181107
Received: from mtkcas36.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <honghui.zhang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 478219995; Wed, 07 Nov 2018 11:19:06 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 7 Nov
 2018 11:19:04 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 7 Nov 2018 11:19:04 +0800
Message-ID: <1541560744.11281.15.camel@mhfsdcap03>
Subject: Re: [PATCH] PCI: mediatek: Use
 devm_of_pci_get_host_bridge_resources() to parse DT
From:   Honghui Zhang <honghui.zhang@mediatek.com>
To:     Ryder Lee <ryder.lee@mediatek.com>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        Youlin Pei =?UTF-8?Q?=28=E8=A3=B4=E5=8F=8B=E6=9E=97=29?= 
        <youlin.pei@mediatek.com>,
        Jianjun Wang =?UTF-8?Q?=28=E7=8E=8B=E5=BB=BA=E5=86=9B=29?= 
        <Jianjun.Wang@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 7 Nov 2018 11:19:04 +0800
In-Reply-To: <1541140583.10519.1.camel@mtkswgap22>
References: <1539833014-1738-1-git-send-email-honghui.zhang@mediatek.com>
         <1541140583.10519.1.camel@mtkswgap22>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 2018-11-02 at 14:36 +0800, Ryder Lee wrote:
> On Thu, 2018-10-18 at 11:23 +0800, Honghui Zhang (张洪辉) wrote:
> > From: Honghui Zhang <honghui.zhang@mediatek.com>
> > 
> > Use the devm_of_pci_get_host_bridge_resources() API in place of the PCI OF
> > DT parser.
> > 
> > Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> > ---
> >  drivers/pci/controller/pcie-mediatek.c | 109 +++++++++------------------------
> >  1 file changed, 29 insertions(+), 80 deletions(-)
> > 
[......]
> > 
> 
> Acked-by: Ryder Lee <ryder.lee@mediatek.com>
> 
> 

Hi, Lorenzo, could you help take a look at this patch?

Thanks.



