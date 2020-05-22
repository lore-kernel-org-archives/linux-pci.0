Return-Path: <SRS0=d3wJ=7E=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D91CC433E1
	for <linux-pci@archiver.kernel.org>; Fri, 22 May 2020 14:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73EDB22E03
	for <linux-pci@archiver.kernel.org>; Fri, 22 May 2020 14:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730011AbgEVO2V (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 May 2020 10:28:21 -0400
Received: from elvis.franken.de ([193.175.24.41]:34554 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729971AbgEVO2U (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 May 2020 10:28:20 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1jc8ed-0006D2-01; Fri, 22 May 2020 16:28:07 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 55B2FC0175; Fri, 22 May 2020 16:25:50 +0200 (CEST)
Date:   Fri, 22 May 2020 16:25:50 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Huacai Chen <chenhc@lemote.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Paul Burton <paulburton@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH v10 5/5] MIPS: Loongson64: Switch to generic PCI driver
Message-ID: <20200522142550.GB15261@alpha.franken.de>
References: <20200427060551.1372591-1-jiaxun.yang@flygoat.com>
 <20200514131650.3587281-1-jiaxun.yang@flygoat.com>
 <20200514131650.3587281-5-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514131650.3587281-5-jiaxun.yang@flygoat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 14, 2020 at 09:16:41PM +0800, Jiaxun Yang wrote:
> We can now enable generic PCI driver in Kconfig, and remove legacy
> PCI driver code.
> 
> Radeon vbios quirk is moved to the platform folder to fit the
> new structure.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> --
> v9: Fix licenses tag
> ---
>  arch/mips/Kconfig                  |   1 +
>  arch/mips/loongson64/Makefile      |   2 +-
>  arch/mips/loongson64/vbios_quirk.c |  29 ++++++++
>  arch/mips/pci/Makefile             |   1 -
>  arch/mips/pci/fixup-loongson3.c    |  71 ------------------
>  arch/mips/pci/ops-loongson3.c      | 116 -----------------------------
>  6 files changed, 31 insertions(+), 189 deletions(-)
>  create mode 100644 arch/mips/loongson64/vbios_quirk.c
>  delete mode 100644 arch/mips/pci/fixup-loongson3.c
>  delete mode 100644 arch/mips/pci/ops-loongson3.c

Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
