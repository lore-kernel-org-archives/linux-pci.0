Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog120.obsmtp.com ([207.126.144.149]:40006 "EHLO
	eu1sys200aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751344AbaBEEks convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 4 Feb 2014 23:40:48 -0500
From: Mohit KUMAR DCG <Mohit.KUMAR@st.com>
To: Jingoo Han <jg1.han@samsung.com>
Cc: "Arnd Bergmann (arnd@arndb.de)" <arnd@arndb.de>,
	Pratyush ANAND <pratyush.anand@st.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Date: Wed, 5 Feb 2014 12:40:33 +0800
Subject: RE: designware: RC BARs setup related fix
Message-ID: <2CC2A0A4A178534D93D5159BF3BCB66189FD2CA14F@EAPEX1MAIL1.st.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

+Cc linux-pci@vger.kernel.org

> -----Original Message-----
> From: Mohit KUMAR DCG
> Sent: Wednesday, February 05, 2014 10:06 AM
> To: 'Jingoo Han'
> Cc: Arnd Bergmann (arnd@arndb.de); Pratyush ANAND
> Subject: designware: RC BARs setup related fix
> 
> Hello Jingoo,
> 
> The Synopsys  PCIe core provides one pair of 32-bit BARs (BAR 0 and BAR 1).
> The BARs can  be configured as follows:
> - One 64-bit BAR: BARs 0 and 1 are combined to form a single 64-bit BAR.
> - Two 32-bit BARs: BARs 0 and 1 are two independent 32-bit BARs
> 
> For the 64-bit, non-prefetchable memory BAR configuration should be:
> 	/* setup RC BARs */
> 	dw_pcie_writel_rc(pp, 0x00000004, PCI_BASE_ADDRESS_0);
> 	dw_pcie_writel_rc(pp, 0x00000000, PCI_BASE_ADDRESS_1);
> 
> For 32-bit, non-prefetchable memory BAR configuration should be:
> 	/* setup RC BARs */
> 	dw_pcie_writel_rc(pp, 0x00000000, PCI_BASE_ADDRESS_0);
> 	dw_pcie_writel_rc(pp, 0x00000000, PCI_BASE_ADDRESS_1);
> 
> While reviewing the code I find that dw driver programmed BARs as:
> 	/* setup RC BARs */
> 	dw_pcie_writel_rc(pp, 0x00000004, PCI_BASE_ADDRESS_0);
> 	dw_pcie_writel_rc(pp, 0x00000004, PCI_BASE_ADDRESS_1);
> 
> I think it needs to be fixed. If you agree I will fix it as in option 1 or you  have
> some  other point?
> 
> Thanks
> Mohit
> 

