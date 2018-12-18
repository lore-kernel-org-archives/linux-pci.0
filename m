Return-Path: <SRS0=EJXn=O3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A477C43387
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 15:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5695F2133F
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 15:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbeLRPck (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 18 Dec 2018 10:32:40 -0500
Received: from foss.arm.com ([217.140.101.70]:48238 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726717AbeLRPck (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Dec 2018 10:32:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFCF8A78;
        Tue, 18 Dec 2018 07:32:39 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 85AB23F5C0;
        Tue, 18 Dec 2018 07:32:37 -0800 (PST)
Date:   Tue, 18 Dec 2018 15:32:32 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, ryder.lee@mediatek.com,
        robh+dt@kernel.org, matthias.bgg@gmail.com,
        linux-pci@vger.kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, youlin.pei@mediatek.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        honghui.zhang@mediatek.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] PCI: mediatek: Add controller support for MT7629
Message-ID: <20181218153232.GA6715@e107981-ln.cambridge.arm.com>
References: <1544058553-10936-1-git-send-email-jianjun.wang@mediatek.com>
 <1544058553-10936-3-git-send-email-jianjun.wang@mediatek.com>
 <20181213145517.GB4701@google.com>
 <1545034779.8528.8.camel@mhfsdcap03>
 <20181217143247.GK20725@google.com>
 <20181217154645.GA24864@e107981-ln.cambridge.arm.com>
 <1545124764.25199.3.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545124764.25199.3.camel@mhfsdcap03>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 18, 2018 at 05:19:24PM +0800, Jianjun Wang wrote:
> On Mon, 2018-12-17 at 15:46 +0000, Lorenzo Pieralisi wrote:
> > On Mon, Dec 17, 2018 at 08:32:47AM -0600, Bjorn Helgaas wrote:
> > > On Mon, Dec 17, 2018 at 04:19:39PM +0800, Jianjun Wang wrote:
> > > > On Thu, 2018-12-13 at 08:55 -0600, Bjorn Helgaas wrote:
> > > > > On Thu, Dec 06, 2018 at 09:09:13AM +0800, Jianjun Wang wrote:
> > > > > > The read value of BAR0 is 0xffff_ffff, it's size will be calculated as 4GB
> > > > > > in arm64 but bogus alignment values at arm32, the pcie device and devices
> > > > > > behind this bridge will not be enabled. Fix it's BAR0 resource size to
> > > > > > guarantee the pcie devices will be enabled correctly.
> > > > > 
> > > > > So this is a hardware erratum?  Per spec, a memory BAR has bit 0 hardwired
> > > > > to 0, and an IO BAR has bit 1 hardwired to 0.
> > > > 
> > > > Yes, it only works properly on 64bit platform.
> > > 
> > > I don't understand.  BARs are supposed to work the same regardless of
> > > whether it's a 32- or 64-bit platform.  If this is a workaround for a
> > > hardware defect, please just say that explicitly.
> > 
> > I do not understand this either. First thing to do is to describe the
> > problem properly so that we can actually find a solution to it.
> > 
> > Lorenzo
> 
> This BAR0 is a 64-bit memory BAR, the HW default values for this BAR is
> 0xffff_ffff_0000_0000 and it could not be changed except by config write
> operation.
> 
> The calculated BAR size will be 0 in 32-bit platform since the
> phys_addr_t is a 32bit value in 32-bit platform.
> 
> Actually MediaTek's HW does not using this BAR0, just omit it when
> assign resource is totally fine.
> 
> When assign the resource for each device, software will check the
> resource alignment first, and the resource of length zero will be
> regarded as a bogus alignment resource, it will be ignored and won't
> claim a resource parent for it.
> 
> When drivers try to enable the PCIe devices, the software will enable
> it's resources, but it will return an error number when found a
> unclaimed resource, in that case, the flow of enable devices will be
> interrupted and PCIe devices won't work properly.

As a starting point, please provide kernel logs for both 64-bit and
32-bit platforms (without this patch applied) and also a:

cat /proc/iomem

and

lspci

output for both configurations.

Thanks,
Lorenzo
