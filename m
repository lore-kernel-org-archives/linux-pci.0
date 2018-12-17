Return-Path: <SRS0=7Kzx=O2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DA4C43387
	for <linux-pci@archiver.kernel.org>; Mon, 17 Dec 2018 14:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE0332146E
	for <linux-pci@archiver.kernel.org>; Mon, 17 Dec 2018 14:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545057170;
	bh=U3lJ6BneydpJBppucBLQPbsaaT46S5fpMxrOi3dnS5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WaU21VLDKQY+xKlUNl2m6IwkQfUSORE17Mi/Fcwfv35SAlMQwzhCf7BYFR3ynKd6b
	 FYhLOQdQWUxTtD1aCE69f/CmsczU2MFr6vg5cl0pDMzsS75q/6dKMbuA5EYORr4U3u
	 f7mwLF/C57mhFCO1oAV64jf+IKD3+9emqoy6z5Ak=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbeLQOct (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Dec 2018 09:32:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:55046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbeLQOct (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Dec 2018 09:32:49 -0500
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 496AB206A2;
        Mon, 17 Dec 2018 14:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545057168;
        bh=U3lJ6BneydpJBppucBLQPbsaaT46S5fpMxrOi3dnS5s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HepqszlaEMP64Nm+rnoLqwCkW2ORzS6Xlvc0jzE4+Q7WsoJ/TSzwUPvf6Z8lX9VCe
         0VAlGGVDGi+1KOZMBATBDoGm/VvvdkwE6IMazCj3sohexQHJ6w0kcLtikJmJN/mTX5
         XQg9bkFDLLNK/9QdtAq3ZZcTC5x9lURBuXw0vELg=
Date:   Mon, 17 Dec 2018 08:32:47 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     ryder.lee@mediatek.com, robh+dt@kernel.org,
        lorenzo.pieralisi@arm.com, matthias.bgg@gmail.com,
        linux-pci@vger.kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, youlin.pei@mediatek.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        honghui.zhang@mediatek.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] PCI: mediatek: Add controller support for MT7629
Message-ID: <20181217143247.GK20725@google.com>
References: <1544058553-10936-1-git-send-email-jianjun.wang@mediatek.com>
 <1544058553-10936-3-git-send-email-jianjun.wang@mediatek.com>
 <20181213145517.GB4701@google.com>
 <1545034779.8528.8.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545034779.8528.8.camel@mhfsdcap03>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 17, 2018 at 04:19:39PM +0800, Jianjun Wang wrote:
> On Thu, 2018-12-13 at 08:55 -0600, Bjorn Helgaas wrote:
> > On Thu, Dec 06, 2018 at 09:09:13AM +0800, Jianjun Wang wrote:
> > > The read value of BAR0 is 0xffff_ffff, it's size will be calculated as 4GB
> > > in arm64 but bogus alignment values at arm32, the pcie device and devices
> > > behind this bridge will not be enabled. Fix it's BAR0 resource size to
> > > guarantee the pcie devices will be enabled correctly.
> > 
> > So this is a hardware erratum?  Per spec, a memory BAR has bit 0 hardwired
> > to 0, and an IO BAR has bit 1 hardwired to 0.
> 
> Yes, it only works properly on 64bit platform.

I don't understand.  BARs are supposed to work the same regardless of
whether it's a 32- or 64-bit platform.  If this is a workaround for a
hardware defect, please just say that explicitly.

Bjorn
