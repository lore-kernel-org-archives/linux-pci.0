Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52140 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751382AbaLSPXj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 19 Dec 2014 10:23:39 -0500
Message-ID: <549442C4.1030302@ti.com>
Date: Fri, 19 Dec 2014 10:22:44 -0500
From: Murali Karicheri <m-karicheri2@ti.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	<linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Krzysztof Halasa <khalasa@piap.pl>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Mohit Kumar <mohit.kumar@st.com>
Subject: Re: [PATCH v3 0/2] arm: pcibios: remove pci_sys_data domain
References: <1416569367-29409-1-git-send-email-lorenzo.pieralisi@arm.com> <54935F7A.7000206@ti.com> <14802556.IUBqXXJ43p@wuerfel>
In-Reply-To: <14802556.IUBqXXJ43p@wuerfel>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/18/2014 06:25 PM, Arnd Bergmann wrote:
> On Thursday 18 December 2014 18:12:58 Murali Karicheri wrote:
>>
>> I am assuming this is transparent to the user drivers of designware core
>> such as pci-keystone as CONFIG_PCI_DOMAINS_GENERIC is enabled by default
>> by ARM. Is this true ?
>
> One difference is that you can now specify the domain number in DT,
> but if you don't do that, it should behave exactly as befor.
>
> 	Arnd
Arnd,

Great! Thanks.

-- 
Murali Karicheri
Linux Kernel, Texas Instruments
