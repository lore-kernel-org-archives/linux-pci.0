Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:47533 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750999Ab3IZEcU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Sep 2013 00:32:20 -0400
From: Jingoo Han <jg1.han@samsung.com>
To: 'Bjorn Helgaas' <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	'Kukjin Kim' <kgene.kim@samsung.com>,
	'Pratyush Anand' <pratyush.anand@st.com>,
	'Mohit KUMAR' <Mohit.KUMAR@st.com>,
	'Siva Reddy Kallam' <siva.kallam@samsung.com>,
	'SRIKANTH TUMKUR SHIVANAND' <ts.srikanth@samsung.com>,
	'Arnd Bergmann' <arnd@arndb.de>,
	'Sean Cross' <xobs@kosagi.com>,
	'Kishon Vijay Abraham I' <kishon@ti.com>,
	'Thierry Reding' <thierry.reding@gmail.com>,
	'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	'Jingoo Han' <jg1.han@samsung.com>
References: <001a01ceaace$013ec980$03bc5c80$%han@samsung.com>
In-reply-to: <001a01ceaace$013ec980$03bc5c80$%han@samsung.com>
Subject: Re: [PATCH V3] PCI: exynos: add support for MSI
Date: Thu, 26 Sep 2013 13:32:18 +0900
Message-id: <001b01ceba71$62ca02c0$285e0840$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, September 06, 2013 3:55 PM, Jingoo Han wrote:
> 
> This patch adds support for Message Signaled Interrupt in the
> Exynos PCIe diver using Synopsys designware PCIe core IP.
> 
> Signed-off-by: Siva Reddy Kallam <siva.kallam@samsung.com>
> Signed-off-by: Srikanth T Shivanand <ts.srikanth@samsung.com>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> Cc: Pratyush Anand <pratyush.anand@st.com>
> Cc: Mohit KUMAR <Mohit.KUMAR@st.com>

Hi Bjorn Helgaas,

There is no comment for last 3 weeks.
Would you merge this patch to your tree?
Thank you.

Best regards,
Jingoo Han

> ---
> Changes since v2:
> - fixed MAX_MSI_CTRLS because MAX_MSI_IRQS is 32 only
> - used __get_free_pages() to allocate msi_data
> - used one msi_data and msi_irq_in_use per one RC
> - used irq_domain to represent the MSI controller
> - removed msi-base irq number from device tree because this is not
>   a hardware property.
> 
> Changes since v1:
> - removed unnecessary exynos_pcie_clear_irq_level()
> - updated the bindings documentation
> - used new msi_chip infrastructure
> - removed ARCH_SUPPORTS_MSI
> - replaced #ifdef guards with IS_ENABLED(CONFIG_PCI_MSI)
> 
>  drivers/pci/host/pci-exynos.c      |   44 +++++++
>  drivers/pci/host/pcie-designware.c |  240 ++++++++++++++++++++++++++++++++++++
>  drivers/pci/host/pcie-designware.h |   14 +++
>  3 files changed, 298 insertions(+)

