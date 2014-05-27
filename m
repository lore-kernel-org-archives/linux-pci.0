Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:54318 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753277AbaE0ShI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 27 May 2014 14:37:08 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Murali Karicheri <m-karicheri2@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jingoo Han <jg1.han@samsung.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mohit Kumar <mohit.kumar@st.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v1 3/5] phy: pci serdes phy driver for keystone
Date: Tue, 27 May 2014 20:36:32 +0200
Message-ID: <4735720.XlAWNkHzF3@wuerfel>
In-Reply-To: <5384C17E.5060806@ti.com>
References: <1400169692-9677-1-git-send-email-m-karicheri2@ti.com> <9828919.7tZBgbvqj4@wuerfel> <5384C17E.5060806@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 27 May 2014 12:46:54 Murali Karicheri wrote:
> I have checked the register set of the following drivers under 
> drivers/phy from the
> master branch (v3.15-rc6) using the registers set available with us 
> internally and
> I can't find a match.
> 
> phy-exynos5250-sata.c  phy-exynos-mipi-video.c  phy-omap-usb2.c 
> phy-sun4i-usb.c
> phy-xgene.c phy-exynos4210-usb2.c  phy-exynos5250-usb2.c phy-mvebu-sata.c
> phy-samsung-usb2.c  phy-ti-pipe3.c phy-bcm-kona-usb2.c phy-exynos4x12-usb2.c
>   phy-exynos-dp-video.c  phy-omap-control.c  phy-twl4030-usb.c
> 
> So there is no duplication.

Ok, thanks a lot for checking!

	Arnd
