Return-Path: <SRS0=yvM8=O5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7383C43387
	for <linux-pci@archiver.kernel.org>; Thu, 20 Dec 2018 18:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB2F3218EA
	for <linux-pci@archiver.kernel.org>; Thu, 20 Dec 2018 18:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545330051;
	bh=xOUnmiNRx5wLcPgA8iSEH0hBpM+bMV4YzNGQIl86Ftw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mmxzXec6vKx1lUX29uWYBAQ5liu+cqz+F9twujHteuSbPJFpCh5+257q/HdVPqDvr
	 Ym2d90/qN59MUaojItQtCmacCq/JJWDSK9si2sEVXjOezM03gVdNaAgnQ/w0UjLQV+
	 /Pjo5QfOQrVjwwuH8SHGt9v/cdF0A8MDYV1NVm3c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388689AbeLTSUq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:20:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:55284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729178AbeLTSUp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Dec 2018 13:20:45 -0500
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6556218D9;
        Thu, 20 Dec 2018 18:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545330044;
        bh=xOUnmiNRx5wLcPgA8iSEH0hBpM+bMV4YzNGQIl86Ftw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=As0NrL4Jd7yKG7guJpbus72PT70Ir4V6cEelpFtEU53Dway9QBZrH1mtcx9xrrJnz
         0bnW71MnlNW+dJjSu7F7+455x3xqy500vH5/yEIJfeQl67qJcEE1nr0rj1MA9OgUGk
         FSD8xToTZpIf9V+tLTEHYdJkQLI7WsheYtT5Me44=
Date:   Thu, 20 Dec 2018 12:20:43 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        ryder.lee@mediatek.com, robh+dt@kernel.org, matthias.bgg@gmail.com,
        linux-pci@vger.kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, youlin.pei@mediatek.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        honghui.zhang@mediatek.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] PCI: mediatek: Add controller support for MT7629
Message-ID: <20181220182043.GC183878@google.com>
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
User-Agent: Mutt/1.10.1 (2018-07-13)
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
> > > > > > The read value of BAR0 is 0xffff_ffff, it's size will be
> > > > > > calculated as 4GB in arm64 but bogus alignment values at
> > > > > > arm32, the pcie device and devices behind this bridge will
> > > > > > not be enabled. Fix it's BAR0 resource size to guarantee
> > > > > > the pcie devices will be enabled correctly.
> > > > > 
> > > > > So this is a hardware erratum?  Per spec, a memory BAR has
> > > > > bit 0 hardwired to 0, and an IO BAR has bit 1 hardwired to
> > > > > 0.
> > > > 
> > > > Yes, it only works properly on 64bit platform.
> > > 
> > > I don't understand.  BARs are supposed to work the same
> > > regardless of whether it's a 32- or 64-bit platform.  If this is
> > > a workaround for a hardware defect, please just say that
> > > explicitly.
> > 
> > I do not understand this either. First thing to do is to describe
> > the problem properly so that we can actually find a solution to
> > it.
> 
> This BAR0 is a 64-bit memory BAR, the HW default values for this BAR
> is 0xffff_ffff_0000_0000 and it could not be changed except by
> config write operation.

If you literally get 0xffff_ffff_0000_0000 when reading the BAR, that
is out of spec because the low-order 4 bits of a 64-bit memory BAR
cannot all be zero.

A 64-bit BAR consumes two DWORDS in config space.  For a 64-bit BAR0,
the DWORD at 0x10 contains the low-order bits, and the DWORD at 0x14
contains the upper 32 bits.  Bits 0-3 of the low-order DWORD (the
one at 0x10) are read-only, and in this case should contain the value
0b1100 (0xc).  That means the range is prefetchable (bit 3 == 1) and
the BAR is 64 bits (bits 2:1 == 10).

> The calculated BAR size will be 0 in 32-bit platform since the
> phys_addr_t is a 32bit value in 32-bit platform.

Either (1) this is a hardware defect that feeds incorrect data to the
BAR size calculation, or (2) there's a problem in the BAR size
calculation code.  We need to figure out which one and work around or
fix it correctly.

> Actually MediaTek's HW does not using this BAR0, just omit it when
> assign resource is totally fine.

It's totally fine to work around hardware defects, but we have to
clearly understand the problem so we do it correctly.  For example, we
probably can't just clear out the BAR0 resource in the pci_dev,
because the BAR in the hardware device still contains a value, and if
we enable memory decoding for the device, it will still respond to the
region described by the BAR.

> When assign the resource for each device, software will check the
> resource alignment first, and the resource of length zero will be
> regarded as a bogus alignment resource, it will be ignored and won't
> claim a resource parent for it.
> 
> When drivers try to enable the PCIe devices, the software will enable
> it's resources, but it will return an error number when found a
> unclaimed resource, in that case, the flow of enable devices will be
> interrupted and PCIe devices won't work properly.
> 
> Thanks.
> 
