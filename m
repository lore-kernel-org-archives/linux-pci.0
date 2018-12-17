Return-Path: <SRS0=7Kzx=O2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32201C43387
	for <linux-pci@archiver.kernel.org>; Mon, 17 Dec 2018 15:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 009AB2133F
	for <linux-pci@archiver.kernel.org>; Mon, 17 Dec 2018 15:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387663AbeLQPqx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:46:53 -0500
Received: from foss.arm.com ([217.140.101.70]:58974 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727617AbeLQPqx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Dec 2018 10:46:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC437A78;
        Mon, 17 Dec 2018 07:46:52 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A215A3F575;
        Mon, 17 Dec 2018 07:46:50 -0800 (PST)
Date:   Mon, 17 Dec 2018 15:46:45 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jianjun Wang <jianjun.wang@mediatek.com>, ryder.lee@mediatek.com,
        robh+dt@kernel.org, matthias.bgg@gmail.com,
        linux-pci@vger.kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, youlin.pei@mediatek.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        honghui.zhang@mediatek.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] PCI: mediatek: Add controller support for MT7629
Message-ID: <20181217154645.GA24864@e107981-ln.cambridge.arm.com>
References: <1544058553-10936-1-git-send-email-jianjun.wang@mediatek.com>
 <1544058553-10936-3-git-send-email-jianjun.wang@mediatek.com>
 <20181213145517.GB4701@google.com>
 <1545034779.8528.8.camel@mhfsdcap03>
 <20181217143247.GK20725@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217143247.GK20725@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 17, 2018 at 08:32:47AM -0600, Bjorn Helgaas wrote:
> On Mon, Dec 17, 2018 at 04:19:39PM +0800, Jianjun Wang wrote:
> > On Thu, 2018-12-13 at 08:55 -0600, Bjorn Helgaas wrote:
> > > On Thu, Dec 06, 2018 at 09:09:13AM +0800, Jianjun Wang wrote:
> > > > The read value of BAR0 is 0xffff_ffff, it's size will be calculated as 4GB
> > > > in arm64 but bogus alignment values at arm32, the pcie device and devices
> > > > behind this bridge will not be enabled. Fix it's BAR0 resource size to
> > > > guarantee the pcie devices will be enabled correctly.
> > > 
> > > So this is a hardware erratum?  Per spec, a memory BAR has bit 0 hardwired
> > > to 0, and an IO BAR has bit 1 hardwired to 0.
> > 
> > Yes, it only works properly on 64bit platform.
> 
> I don't understand.  BARs are supposed to work the same regardless of
> whether it's a 32- or 64-bit platform.  If this is a workaround for a
> hardware defect, please just say that explicitly.

I do not understand this either. First thing to do is to describe the
problem properly so that we can actually find a solution to it.

Lorenzo
