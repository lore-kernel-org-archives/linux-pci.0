Return-Path: <SRS0=P0ok=QT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB714C169C4
	for <linux-pci@archiver.kernel.org>; Tue, 12 Feb 2019 03:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4673217FA
	for <linux-pci@archiver.kernel.org>; Tue, 12 Feb 2019 03:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfBLDM4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Feb 2019 22:12:56 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:28853 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726756AbfBLDMz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Feb 2019 22:12:55 -0500
X-UUID: aada839746f04a37a5fa680b2d52b2c8-20190212
X-UUID: aada839746f04a37a5fa680b2d52b2c8-20190212
Received: from mtkcas36.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <honghui.zhang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1132903972; Tue, 12 Feb 2019 11:12:46 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 12 Feb
 2019 11:12:44 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 12 Feb 2019 11:12:44 +0800
Message-ID: <1549941164.4980.64.camel@mhfsdcap03>
Subject: Re: [RFC PATCH] PCI/portdrv: Support for subtractive decode bridge
From:   Honghui Zhang <honghui.zhang@mediatek.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <youlin.pei@mediatek.com>, <lorenzo.pieralisi@arm.com>,
        <poza@codeaurora.org>, <fred@fredlawl.com>,
        <linux-pci@vger.kernel.org>, <rafael.j.wysocki@intel.com>,
        <linux-kernel@vger.kernel.org>, <jianjun.wang@mediatek.com>,
        <ryder.lee@mediatek.com>, <linux-mediatek@lists.infradead.org>,
        <matthias.bgg@gmail.com>, <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 12 Feb 2019 11:12:44 +0800
In-Reply-To: <20190207195230.GJ7268@google.com>
References: <1544758829-10327-1-git-send-email-honghui.zhang@mediatek.com>
         <20190207151816.GI7268@google.com> <20190207195230.GJ7268@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2019-02-07 at 13:52 -0600, Bjorn Helgaas wrote:
> On Thu, Feb 07, 2019 at 09:18:16AM -0600, Bjorn Helgaas wrote:
> > On Fri, Dec 14, 2018 at 11:40:29AM +0800, honghui.zhang@mediatek.com wrote:
> > > From: Honghui Zhang <honghui.zhang@mediatek.com>
> > > 
> > > The Class Code for subtractive decode PCI-to-PCI bridge is 060401h,
> > > change the class_mask values to make portdrv support this type bridge.
> > 
> > I assume you have a Root Port or Switch Port that supports subtractive
> > decode?  I'm trying to understand how such a device would work.
> > 
> > Out of curiosity, can you show the "lspci -vv" output for the device
> > and the downstream devices of interest?
> 
> Actually, since subtractive decode has to do with how the bridge
> interacts with its *peers*, what would be interesting is the host
> bridge window information from ACPI _CRS or DT and the lspci info for
> everything under that host bridge.
> 
> Assuming we're talking about a Root Port, I guess that would mean
> anything inside the host bridge windows but outside the positive
> decode windows (the normal PCI-PCI bridge apertures in the Root Ports)
> would be claimed by the subtractive decode Root Port?

Per my understanding, mediatek's Root Port does not claim anything, or
it's fine to assign no resource which is dedicated to this bridge. Those
information could be got through lspci output which is attached in the
last mail. All the resource it claimed is from the subordinate device,
bridge itself does not need any special resource.
> 
> I guess you would want this because this path ultimately leads to an
> ISA or similar bus where you don't know what resources the device
> actually consumes?
> 
I was not get to that far, I just want to start a discussion about this,
since spec does not forbidden subtractive bridge to support port
service.

Thanks.

> Bjorn


