Return-Path: <SRS0=/yaj=M3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4D8C070C3
	for <linux-pci@archiver.kernel.org>; Mon, 15 Oct 2018 02:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11A7C20876
	for <linux-pci@archiver.kernel.org>; Mon, 15 Oct 2018 02:42:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11A7C20876
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbeJOKZm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Oct 2018 06:25:42 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:24889 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726273AbeJOKZm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Oct 2018 06:25:42 -0400
X-UUID: 715a07aacd5f4761a2341d188103026c-20181015
X-UUID: 715a07aacd5f4761a2341d188103026c-20181015
Received: from mtkcas32.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <honghui.zhang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 2112126248; Mon, 15 Oct 2018 10:42:25 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 15 Oct
 2018 10:42:23 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 15 Oct 2018 10:42:23 +0800
Message-ID: <1539571343.6246.74.camel@mhfsdcap03>
Subject: Re: [PATCH v6 2/9] PCI: mediatek: Fixup class ID for MT7622 as
 PCI_CLASS_BRIDGE_PCI
From:   Honghui Zhang <honghui.zhang@mediatek.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <youlin.pei@mediatek.com>, <devicetree@vger.kernel.org>,
        <ulf.hansson@linaro.org>, <ryder.lee@mediatek.com>,
        <marc.zyngier@arm.com>, <linux-pci@vger.kernel.org>,
        <sean.wang@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <yt.shen@mediatek.com>, <matthias.bgg@gmail.com>,
        <linux-mediatek@lists.infradead.org>, <bhelgaas@google.com>,
        <yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Mon, 15 Oct 2018 10:42:23 +0800
In-Reply-To: <20181012141202.GV5906@bhelgaas-glaptop.roam.corp.google.com>
References: <1538969088-7136-1-git-send-email-honghui.zhang@mediatek.com>
         <1538969088-7136-3-git-send-email-honghui.zhang@mediatek.com>
         <20181008172337.GA13538@e107981-ln.cambridge.arm.com>
         <1539054495.6246.31.camel@mhfsdcap03>
         <20181011113748.GA3574@e107981-ln.cambridge.arm.com>
         <1539331289.6246.61.camel@mhfsdcap03>
         <20181012102230.GA23257@e107981-ln.cambridge.arm.com>
         <20181012141202.GV5906@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 2018-10-12 at 09:12 -0500, Bjorn Helgaas wrote:
> On Fri, Oct 12, 2018 at 11:22:30AM +0100, Lorenzo Pieralisi wrote:
> > On Fri, Oct 12, 2018 at 04:01:29PM +0800, Honghui Zhang wrote:
> >> On Thu, 2018-10-11 at 12:38 +0100, Lorenzo Pieralisi wrote:
> >>> On Tue, Oct 09, 2018 at 11:08:15AM +0800, Honghui Zhang wrote:
> >>>> On Mon, 2018-10-08 at 18:23 +0100, Lorenzo Pieralisi wrote:
> >>>>> On Mon, Oct 08, 2018 at 11:24:41AM +0800, honghui.zhang@mediatek.com wrote:
> >>>>>> From: Honghui Zhang <honghui.zhang@mediatek.com>
> >>>>>> 
> >>>>>> The PCIe controller of MT7622 has TYPE 1 configuration
> >>>>>> space type, but the HW default class type values is
> >>>>>> invalid.
> >>>>>> 
> >>>>>> The commit 101c92dc80c8 ("PCI: mediatek: Set up vendor ID
> >>>>>> and class type for MT7622") have set the class ID for
> >>>>>> MT7622 as PCI_CLASS_BRIDGE_HOSTe, but it's not workable
> >>>>>> for MT7622:
> >>>>>> 
> >>>>>> In __pci_bus_assign_resources, the framework only setup
> >>>>>> bridge's resource window only if class type is
> >>>>>> PCI_CLASS_BRIDGE_PCI. Or it will leave the subordinary PCIe
> >>>>>> device's MMIO window un-touched.
> 
> I think __pci_bus_assign_resources() should be testing dev->hdr_type
> instead of dev->class.  The connection between "Header Type" and the
> layout of the rest of the header is very explicit (PCI r3.0 sec 6.1,
> PCIe r4.0 sec 7.5.1.1.9), and the reason for the switch statement in
> __pci_bus_assign_resources() is precisely to determine which layout to
> use.
> 
> There are several other uses of dev->class in setup-bus.c that I think
> should also be changed to use dev->hdr_type.
> 
> If we make these changes in setup-bus.c, I suspect the class code you
> assign won't matter too much.  There are a few other tests of the
> class code to figure out whether to leave certain things untouched.
> These seem a little hacky to me, but we're probably stuck with them
> for now, so you should look and see whether they apply to your
> situation.

If these change could be made in the PCI core, then the class code is no
matter what will be workable for MT7622.

As Lorenzo point it out, it's more reasonable for MT7622 to defined as a
PCI-to-PCI class code since the IP is defined as that. I intend to
following Lorenzo's suggest to update the commit message and re-send
this patch set for current solution.

> 
> >>>> And for MT7622, it integrated with block of internal control
> >>>> registers, type 1 configuration space, and is considered as a
> >>>> root complex.
> >>> 
> >>> I assume you mean a type 1 config header here. I do not think it
> >>> is mandatory for a host bridge to have a type 1 config header (and
> >>> related bridge windows + primary/secondary/subordinate bus
> >>> numbers) but I do not know how the IP you are programming is
> >>> designed.
> 
> It is definitely not mandatory for a host bridge to have a type 1
> header.  I'm not even sure that would make sense: the "Primary Bus
> Number" would not apply to a host bridge (since a host bridge's
> primary bus is some sort of CPU bus, not a PCI bus), and a type 1
> device cannot perform address translation between its primary and
> secondary buses, while a host bridge can.
> 
> A Root Port is a type 1 device where the primary bus is logically
> internal to the Root Complex.  A host bridge bridges from the CPU bus
> to that internal bus and might perform address translation.  The Root
> Port must be a PCI device.  A host bridge, being a bridge *to* the PCI
> domain, is not itself generally programmed via PCI config space and
> might not even be visible as a device in PCI config space.
> 
Thanks for the explain. Per my understanding, MT7622 is more like a
complex of Root Port and PCI-to-PCI bridge. It has type 1 header and has
the ability to translate address between its primary and secondary
buses. I guess apply the class type as PCI_CLASS_BRIDGE_PCI is
reasonable way to make its integrated internal bridge workable.

Thanks.
> Bjorn


