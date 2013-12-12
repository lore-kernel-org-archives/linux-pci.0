Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog105.obsmtp.com ([207.126.144.119]:44429 "EHLO
	eu1sys200aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750755Ab3LLFBB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 12 Dec 2013 00:01:01 -0500
From: Mohit KUMAR DCG <Mohit.KUMAR@st.com>
To: Arnd Bergmann <arnd@arndb.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Pratyush ANAND <pratyush.anand@st.com>,
	spear-devel <spear-devel@list.st.com>,
	Viresh Kumar <viresh.linux@gmail.com>
Date: Thu, 12 Dec 2013 13:00:30 +0800
Subject: RE: [PATCH 05/12] clk: SPEAr13xx: Fix pcie clock name
Message-ID: <2CC2A0A4A178534D93D5159BF3BCB66189F95F642A@EAPEX1MAIL1.st.com>
References: <cover.1386752447.git.mohit.kumar@st.com>
 <aeeefe3537089f0d0a2f8f5662d50dfca2aadf29.1386752447.git.mohit.kumar@st.com>
 <201312112342.43840.arnd@arndb.de>
In-Reply-To: <201312112342.43840.arnd@arndb.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Arnd,

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd@arndb.de]
> Sent: Thursday, December 12, 2013 4:13 AM
> To: linux-arm-kernel@lists.infradead.org
> Cc: Mohit KUMAR DCG; linux-pci@vger.kernel.org; Pratyush ANAND; spear-
> devel; Viresh Kumar
> Subject: Re: [PATCH 05/12] clk: SPEAr13xx: Fix pcie clock name
> 
> On Wednesday 11 December 2013, Mohit Kumar wrote:
> > From: Pratyush Anand <pratyush.anand@st.com>
> >
> > Follow dt clock naming convention for PCIe clocks.
> >
> 
> I think in the future, the spear clocks really need to get moved into DT
> representations, as we do for other platforms, which will get rid of a lot of
> code in drivers/clk, including all the clkdev registration.
-  Let it be this way for now. May be we will improve it in next cycle.

Thanks
Mohit	
