Return-Path: <SRS0=BI5g=7I=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFAEC433E0
	for <linux-pci@archiver.kernel.org>; Tue, 26 May 2020 09:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8AFA2073B
	for <linux-pci@archiver.kernel.org>; Tue, 26 May 2020 09:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731605AbgEZJMd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 26 May 2020 05:12:33 -0400
Received: from foss.arm.com ([217.140.110.172]:47960 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728682AbgEZJMd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 May 2020 05:12:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B2D51FB;
        Tue, 26 May 2020 02:12:32 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 52AC53F52E;
        Tue, 26 May 2020 02:12:30 -0700 (PDT)
Date:   Tue, 26 May 2020 10:12:27 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Huacai Chen <chenhc@lemote.com>,
        Paul Burton <paulburton@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH v10 5/5] MIPS: Loongson64: Switch to generic PCI driver
Message-ID: <20200526091227.GB19547@e121166-lin.cambridge.arm.com>
References: <20200427060551.1372591-1-jiaxun.yang@flygoat.com>
 <20200514131650.3587281-1-jiaxun.yang@flygoat.com>
 <20200514131650.3587281-5-jiaxun.yang@flygoat.com>
 <20200522142550.GB15261@alpha.franken.de>
 <20200522152210.GA15567@e121166-lin.cambridge.arm.com>
 <20200522223656.GA22313@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522223656.GA22313@alpha.franken.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, May 23, 2020 at 12:36:56AM +0200, Thomas Bogendoerfer wrote:
> On Fri, May 22, 2020 at 04:22:11PM +0100, Lorenzo Pieralisi wrote:
> > On Fri, May 22, 2020 at 04:25:50PM +0200, Thomas Bogendoerfer wrote:
> > > On Thu, May 14, 2020 at 09:16:41PM +0800, Jiaxun Yang wrote:
> > > > We can now enable generic PCI driver in Kconfig, and remove legacy
> > > > PCI driver code.
> > > > 
> > > > Radeon vbios quirk is moved to the platform folder to fit the
> > > > new structure.
> > > > 
> > > > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > > > --
> > > > v9: Fix licenses tag
> > > > ---
> > > >  arch/mips/Kconfig                  |   1 +
> > > >  arch/mips/loongson64/Makefile      |   2 +-
> > > >  arch/mips/loongson64/vbios_quirk.c |  29 ++++++++
> > > >  arch/mips/pci/Makefile             |   1 -
> > > >  arch/mips/pci/fixup-loongson3.c    |  71 ------------------
> > > >  arch/mips/pci/ops-loongson3.c      | 116 -----------------------------
> > > >  6 files changed, 31 insertions(+), 189 deletions(-)
> > > >  create mode 100644 arch/mips/loongson64/vbios_quirk.c
> > > >  delete mode 100644 arch/mips/pci/fixup-loongson3.c
> > > >  delete mode 100644 arch/mips/pci/ops-loongson3.c
> > > 
> > > Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > 
> > This patch (so the series) does not apply to v5.7-rc1 which is our
> > baseline. I reiterate the point, isn't it better to take the whole
> > series through the MIPS tree ?
> 
> sounds better then
> 
> > Failing that, the series has to
> > be rebased (or split differently so that it can be taken through
> > different trees), just let me know.
> 
> so let's take via mips-next. So can I add your Acked-by to the
> first three patches ?

I have acked patch 2, you have all required ACKs to get this series via
the MIPS tree now, apologies for the delay.

Thanks,
Lorenzo
