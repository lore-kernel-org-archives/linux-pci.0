Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:54192 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996Ab3LKWnQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Dec 2013 17:43:16 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 05/12] clk: SPEAr13xx: Fix pcie clock name
Date: Wed, 11 Dec 2013 23:42:43 +0100
Cc: Mohit Kumar <mohit.kumar@st.com>, linux-pci@vger.kernel.org,
	Pratyush Anand <pratyush.anand@st.com>,
	spear-devel@list.st.com, Viresh Kumar <viresh.linux@gmail.com>
References: <cover.1386752447.git.mohit.kumar@st.com> <aeeefe3537089f0d0a2f8f5662d50dfca2aadf29.1386752447.git.mohit.kumar@st.com>
In-Reply-To: <aeeefe3537089f0d0a2f8f5662d50dfca2aadf29.1386752447.git.mohit.kumar@st.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201312112342.43840.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 11 December 2013, Mohit Kumar wrote:
> From: Pratyush Anand <pratyush.anand@st.com>
> 
> Follow dt clock naming convention for PCIe clocks.
> 

I think in the future, the spear clocks really need to get
moved into DT representations, as we do for other platforms,
which will get rid of a lot of code in drivers/clk, including
all the clkdev registration.

	Arnd
