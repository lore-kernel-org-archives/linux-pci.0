Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:59708 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107AbaLRX0H (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 18 Dec 2014 18:26:07 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Murali Karicheri <m-karicheri2@ti.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Krzysztof Halasa <khalasa@piap.pl>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Mohit Kumar <mohit.kumar@st.com>
Subject: Re: [PATCH v3 0/2] arm: pcibios: remove pci_sys_data domain
Date: Fri, 19 Dec 2014 00:25:17 +0100
Message-ID: <14802556.IUBqXXJ43p@wuerfel>
In-Reply-To: <54935F7A.7000206@ti.com>
References: <1416569367-29409-1-git-send-email-lorenzo.pieralisi@arm.com> <54935F7A.7000206@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 18 December 2014 18:12:58 Murali Karicheri wrote:
> 
> I am assuming this is transparent to the user drivers of designware core 
> such as pci-keystone as CONFIG_PCI_DOMAINS_GENERIC is enabled by default 
> by ARM. Is this true ?

One difference is that you can now specify the domain number in DT,
but if you don't do that, it should behave exactly as befor.

	Arnd
