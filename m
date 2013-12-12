Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:49231 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602Ab3LLVa1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 12 Dec 2013 16:30:27 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Mohit KUMAR DCG <Mohit.KUMAR@st.com>
Subject: Re: [PATCH 05/12] clk: SPEAr13xx: Fix pcie clock name
Date: Thu, 12 Dec 2013 22:30:21 +0100
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Pratyush ANAND <pratyush.anand@st.com>,
	"spear-devel" <spear-devel@list.st.com>,
	Viresh Kumar <viresh.linux@gmail.com>
References: <cover.1386752447.git.mohit.kumar@st.com> <201312112342.43840.arnd@arndb.de> <2CC2A0A4A178534D93D5159BF3BCB66189F95F642A@EAPEX1MAIL1.st.com>
In-Reply-To: <2CC2A0A4A178534D93D5159BF3BCB66189F95F642A@EAPEX1MAIL1.st.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201312122230.21828.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 12 December 2013, Mohit KUMAR DCG wrote:
> > 
> > I think in the future, the spear clocks really need to get moved into DT
> > representations, as we do for other platforms, which will get rid of a lot of
> > code in drivers/clk, including all the clkdev registration.
>
> -  Let it be this way for now. May be we will improve it in next cycle

Fair enough. This will be a major change that doesn't have to delay the PCIe
driver, just make sure you can address the other comments I made for now.

The clock situation will have to be worked out though before the bindings
can be considered stable, because you will have to add mandatory 'clocks'
properties to a lot of them.

	Arnd
