Return-Path: <SRS0=6RWV=QG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD96C282DA
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 23:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1FB2218DA
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 23:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548889567;
	bh=8JaioISvV+UrbOysLb8J9mvbaXx1RT/tB3gVEDxv9b0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=T5x2DOg8j1cwhJFzqJy4jSXld6hzymYIQpLt9xilAhLrW3+bdZj1xlNw6/BJY0ndh
	 yyp0aP+xG2PZl/Ex+d+ngxA42R/T4vu9AuSv/9YM4BWLMYZt5tToHYKBRZEQQfWjhH
	 vhHjD0/hSodXRYZlLaDjTXqj1sD3j3GhM6ZRRbAM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbfA3XGH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:06:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:49070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbfA3XGG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Jan 2019 18:06:06 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F08120881;
        Wed, 30 Jan 2019 23:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548889565;
        bh=8JaioISvV+UrbOysLb8J9mvbaXx1RT/tB3gVEDxv9b0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R/XJ8srhS212cnBf+kAcqyT0XBDKhvLjpxHS7M0QrlzJ3Na0BsBiuKNZbnWIlqhjM
         c8yegt5CMGDZ34sWrMG74B2ZSkEAsY6mB4VpWyFQFYyygmB5CeEUSM+n7+Gk4bhrZL
         c8QqyfF6+Z4I9aiVV1+GGtmBke4l+VSaM7ADgsnk=
Date:   Wed, 30 Jan 2019 17:06:04 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        "# 3.4.x" <stable@vger.kernel.org>,
        Robin Leblon <robin.leblon@ncentric.com>,
        Olof Johansson <olof@lixom.net>,
        Koen Vandeputte <koen.vandeputte@ncentric.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 1/2] arm: cns3xxx: fix writing to wrong PCI registers
 after alignment
Message-ID: <20190130230604.GM229773@google.com>
References: <20190107134510.32494-1-koen.vandeputte@ncentric.com>
 <20190124115656.GA23362@e107981-ln.cambridge.arm.com>
 <47437c58-d7b3-f77c-7bc7-973373f1e78e@ncentric.com>
 <20190124162759.GA28871@e107981-ln.cambridge.arm.com>
 <CAK8P3a2ftPvdBnVacbGcxDpCW6CvBj3ZGBXuVQE46JocXewvgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2ftPvdBnVacbGcxDpCW6CvBj3ZGBXuVQE46JocXewvgQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 30, 2019 at 11:08:04PM +0100, Arnd Bergmann wrote:
> On Thu, Jan 24, 2019 at 5:29 PM Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> > On Thu, Jan 24, 2019 at 04:23:05PM +0100, Koen Vandeputte wrote:
> > > On 24.01.19 12:56, Lorenzo Pieralisi wrote:
> > > >On Mon, Jan 07, 2019 at 02:45:09PM +0100, Koen Vandeputte wrote:
> > > Purely for my information:
> > >
> > > Testing on a lot of devices here shows a huge improvement towards stability.
> > > Is it possible to get it merged sooner?
> > > Does "queued for 5.1" also mean that backporting to stables only will happen
> > > at 5.1_rc1 release?
> >
> > Yes, I will ask Bjorn if we can send them for one of the upcoming -rc*
> > (so effectively you will get them in v5.0 and propagated to stable
> > earlier), I do not think it is that urgent either though, let me handle
> > that.
> 
> We can take them through the soc tree if that's easier, but
> going through Bjorn's tree is also fine.

I have the following on my for-linus branch and I'll ask Linus to pull them
this week, so they will appear in v5.0:

  b8b592a3a8d1 ARM: cns3xxx: use actual size reads for PCIe
  b3a32f359397 ARM: cns3xxx: fix writing to wrong PCI registers after alignment

Neither is currently marked for stable, but I'll add that if you like.
They're already both marked as:

  Fixes: 802b7c06adc7 ("ARM: cns3xxx: Convert PCI to use generic config accessors")

which I think appeared in v4.0.

Bjorn
