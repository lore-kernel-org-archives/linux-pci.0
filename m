Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:64760 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753612Ab3LNTDI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 14 Dec 2013 14:03:08 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Mohit KUMAR DCG <Mohit.KUMAR@st.com>
Subject: Re: [PATCH 02/12] SPEAr13xx: Move SPEAr1340 definitions to header file
Date: Sat, 14 Dec 2013 20:02:38 +0100
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Pratyush ANAND <pratyush.anand@st.com>,
	"spear-devel" <spear-devel@list.st.com>,
	Viresh Kumar <viresh.linux@gmail.com>
References: <cover.1386752447.git.mohit.kumar@st.com> <201312112348.06755.arnd@arndb.de> <2CC2A0A4A178534D93D5159BF3BCB66189F95F669D@EAPEX1MAIL1.st.com>
In-Reply-To: <2CC2A0A4A178534D93D5159BF3BCB66189F95F669D@EAPEX1MAIL1.st.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201312142002.38423.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 13 December 2013, Mohit KUMAR DCG wrote:
> > The RST bits should probably go into a drivers/reset driver. Not sure what the
> > other registers do, but I'm sure we can find a driver for these too, possibly
> > they should be part of the PHY driver?
> 
> -  Perhaps if we implement phy and reset driver then we may not require to move these definitions and
> it will address most of your comments on SPEar13xx pcie driver. I am understanding and working on this.l 
> 

Ok, very good.

	Arnd
