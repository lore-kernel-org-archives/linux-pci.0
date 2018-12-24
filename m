Return-Path: <SRS0=h2G5=PB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C65C43387
	for <linux-pci@archiver.kernel.org>; Mon, 24 Dec 2018 11:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FAC62173C
	for <linux-pci@archiver.kernel.org>; Mon, 24 Dec 2018 11:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbeLXLkf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 24 Dec 2018 06:40:35 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:14320 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725298AbeLXLkf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Dec 2018 06:40:35 -0500
X-UUID: 17015e1a01b24be7a11b9848953f31e2-20181224
X-UUID: 17015e1a01b24be7a11b9848953f31e2-20181224
Received: from mtkcas35.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 555504384; Mon, 24 Dec 2018 19:40:31 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 24 Dec
 2018 19:40:29 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 24 Dec 2018 19:40:28 +0800
Message-ID: <1545651628.5634.57.camel@mhfsdcap03>
Subject: Re: [PATCH 2/2] PCI: mediatek: Add controller support for MT7629
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <ryder.lee@mediatek.com>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <linux-pci@vger.kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <youlin.pei@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <honghui.zhang@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>, <jianjun.wang@mediatek.com>
Date:   Mon, 24 Dec 2018 19:40:28 +0800
In-Reply-To: <20181220182043.GC183878@google.com>
References: <1544058553-10936-1-git-send-email-jianjun.wang@mediatek.com>
         <1544058553-10936-3-git-send-email-jianjun.wang@mediatek.com>
         <20181213145517.GB4701@google.com> <1545034779.8528.8.camel@mhfsdcap03>
         <20181217143247.GK20725@google.com>
         <20181217154645.GA24864@e107981-ln.cambridge.arm.com>
         <1545124764.25199.3.camel@mhfsdcap03> <20181220182043.GC183878@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2018-12-20 at 12:20 -0600, Bjorn Helgaas wrote:
> On Tue, Dec 18, 2018 at 05:19:24PM +0800, Jianjun Wang wrote:
> > On Mon, 2018-12-17 at 15:46 +0000, Lorenzo Pieralisi wrote:
> > > On Mon, Dec 17, 2018 at 08:32:47AM -0600, Bjorn Helgaas wrote:
> > > > On Mon, Dec 17, 2018 at 04:19:39PM +0800, Jianjun Wang wrote:
> > > > > On Thu, 2018-12-13 at 08:55 -0600, Bjorn Helgaas wrote:
> > > > > > On Thu, Dec 06, 2018 at 09:09:13AM +0800, Jianjun Wang wrote:
> > > > > > > The read value of BAR0 is 0xffff_ffff, it's size will be
> > > > > > > calculated as 4GB in arm64 but bogus alignment values at
> > > > > > > arm32, the pcie device and devices behind this bridge will
> > > > > > > not be enabled. Fix it's BAR0 resource size to guarantee
> > > > > > > the pcie devices will be enabled correctly.
> > > > > > 
> > > > > > So this is a hardware erratum?  Per spec, a memory BAR has
> > > > > > bit 0 hardwired to 0, and an IO BAR has bit 1 hardwired to
> > > > > > 0.
> > > > > 
> > > > > Yes, it only works properly on 64bit platform.
> > > > 
> > > > I don't understand.  BARs are supposed to work the same
> > > > regardless of whether it's a 32- or 64-bit platform.  If this is
> > > > a workaround for a hardware defect, please just say that
> > > > explicitly.
> > > 
> > > I do not understand this either. First thing to do is to describe
> > > the problem properly so that we can actually find a solution to
> > > it.
> > 
> > This BAR0 is a 64-bit memory BAR, the HW default values for this BAR
> > is 0xffff_ffff_0000_0000 and it could not be changed except by
> > config write operation.
> 
> If you literally get 0xffff_ffff_0000_0000 when reading the BAR, that
> is out of spec because the low-order 4 bits of a 64-bit memory BAR
> cannot all be zero.
> 
> A 64-bit BAR consumes two DWORDS in config space.  For a 64-bit BAR0,
> the DWORD at 0x10 contains the low-order bits, and the DWORD at 0x14
> contains the upper 32 bits.  Bits 0-3 of the low-order DWORD (the
> one at 0x10) are read-only, and in this case should contain the value
> 0b1100 (0xc).  That means the range is prefetchable (bit 3 == 1) and
> the BAR is 64 bits (bits 2:1 == 10).

Sorry, I have confused the HW default value and the read value of BAR
size. The hardware default value is 0xffff_ffff_0000_000c, it's a 64-bit
BAR with prefetchable range.

When we start to decoding the BAR, the read value of BAR0 at 0x10 is
0x0c, and the value at 0x14 is 0xffff_ffff, so the read value of BAR
size is 0xffff_ffff_0000_0000, which will be decoded to 0xffff_ffff, and
it will be set to the end value of BAR0 resource in the pci_dev.
> 
> > The calculated BAR size will be 0 in 32-bit platform since the
> > phys_addr_t is a 32bit value in 32-bit platform.
> 
> Either (1) this is a hardware defect that feeds incorrect data to the
> BAR size calculation, or (2) there's a problem in the BAR size
> calculation code.  We need to figure out which one and work around or
> fix it correctly.

The BAR size is calculated by the code (res->end - res->start + 1) is
fine, I think it's a hardware defect because that we can not change the
hardware default value or just disable it since we don't using it.

> 
> > Actually MediaTek's HW does not using this BAR0, just omit it when
> > assign resource is totally fine.
> 
> It's totally fine to work around hardware defects, but we have to
> clearly understand the problem so we do it correctly.  For example, we
> probably can't just clear out the BAR0 resource in the pci_dev,
> because the BAR in the hardware device still contains a value, and if
> we enable memory decoding for the device, it will still respond to the
> region described by the BAR.

The BAR0 resource value in the pci_dev is depend on the hardware value,
it can be cleared out after all devices have been scanned, but we should
set it's size bigger than MMIO space, so the software will think it's a
invalid resource and won't assign a resource for it.

Thanks.
> 
> > When assign the resource for each device, software will check the
> > resource alignment first, and the resource of length zero will be
> > regarded as a bogus alignment resource, it will be ignored and won't
> > claim a resource parent for it.
> > 
> > When drivers try to enable the PCIe devices, the software will enable
> > it's resources, but it will return an error number when found a
> > unclaimed resource, in that case, the flow of enable devices will be
> > interrupted and PCIe devices won't work properly.
> > 
> > Thanks.
> > 


