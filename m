Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:64384 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753590Ab3LNTCK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 14 Dec 2013 14:02:10 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH 09/12] pcie: SPEAr13xx: Add designware pcie support
Date: Sat, 14 Dec 2013 20:01:55 +0100
Cc: "'Mohit KUMAR DCG'" <Mohit.KUMAR@st.com>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	"'Pratyush ANAND'" <pratyush.anand@st.com>,
	"'Viresh Kumar'" <viresh.linux@gmail.com>,
	"'spear-devel'" <spear-devel@list.st.com>
References: <cover.1386752447.git.mohit.kumar@st.com> <2CC2A0A4A178534D93D5159BF3BCB66189F95F66A2@EAPEX1MAIL1.st.com> <002c01cef7bf$c5a7b640$50f722c0$%han@samsung.com>
In-Reply-To: <002c01cef7bf$c5a7b640$50f722c0$%han@samsung.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201312142001.56359.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 13 December 2013, Jingoo Han wrote:
> Arnd, do you mean the following?
> 
> 1. Implement Spear PCIe PHY driver using General PHY framework.
>   ./drivers/phy/phy-spear13xx-pcie.c
> 
> 2. Call General PHY APIs
>   ./drivers/pci/host/pcie-spear13xx.c
>   #include <linux/phy/phy.h>
> 
>   pp->phy = devm_phy_get(pp->dev, ...);
> 
>   phy_power_on(pp->phy);
> 
>   phy_power_off(pp->phy);

Yes, exactly.

Of course if the phy driver is licensed from some other company such as
designware as well, or if it can handle more than just pcie, the
implementation of the phy driver and the binding should reflect that.

	Arnd
