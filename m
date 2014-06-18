Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:28740 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964994AbaFRJ1I (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 18 Jun 2014 05:27:08 -0400
From: Jingoo Han <jg1.han@samsung.com>
To: 'Kishon Vijay Abraham I' <kishon@ti.com>,
	"'Karicheri, Muralidharan'" <m-karicheri2@ti.com>,
	'Arnd Bergmann' <arnd@arndb.de>
Cc: devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	arnd@arndb.de, tony@atomide.com,
	'Jason Gunthorpe' <jgunthorpe@obsidianresearch.com>,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	'Mohit Kumar' <mohit.kumar@st.com>,
	'Marek Vasut' <marex@denx.de>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <1401345500-20188-1-git-send-email-kishon@ti.com>
 <1401345500-20188-4-git-send-email-kishon@ti.com> <53876116.90504@ti.com>
 <3E54258959B69E4282D79E01AB1F32B70477D2A4@DFLE11.ent.ti.com>
 <53A15879.7030302@ti.com>
In-reply-to: <53A15879.7030302@ti.com>
Subject: Re: [PATCH v2 03/18] PCI: designware: Configuration space should be
 specified in 'reg'
Date: Wed, 18 Jun 2014 18:27:05 +0900
Message-id: <000001cf8ad7$784e1aa0$68ea4fe0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, June 18, 2014 6:15 PM, Kishon Vijay Abraham I wrote:
> On Friday 30 May 2014 07:45 PM, Karicheri, Muralidharan wrote:
> >> On 5/29/2014 2:38 AM, ABRAHAM, KISHON VIJAY wrote:
> >>> The configuration address space has so far been specified in *ranges*,
> >>> however it should be specified in *reg* making it a platform MEM resource.
> >>> Hence used 'platform_get_resource_*' API to get configuration address
> >>> space in the designware driver.
> >>>
> >>> Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> >>> Cc: Bjorn Helgaas <bhelgaas@google.com>
> >>> Cc: Mohit Kumar <mohit.kumar@st.com>
> >>> Cc: Jingoo Han <jg1.han@samsung.com>
> >>> Cc: Marek Vasut <marex@denx.de>
> >>> Cc: Arnd Bergmann <arnd@arndb.de>
> >>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> >>> ---
> >>>   .../devicetree/bindings/pci/designware-pcie.txt    |    1 +
> >>>   drivers/pci/host/pcie-designware.c                 |   17 +++++++++++++++--
> >>>   2 files changed, 16 insertions(+), 2 deletions(-)

[...]

> >>> +	cfg_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
> >>> +	if (cfg_res) {
> >>> +		pp->config.cfg0_size = resource_size(cfg_res)/2;
> >>> +		pp->config.cfg1_size = resource_size(cfg_res)/2;
> >>> +		pp->cfg0_base = cfg_res->start;
> >>> +		pp->cfg1_base = cfg_res->start + pp->config.cfg0_size;
> >>> +	} else {
> >>> +		dev_err(pp->dev, "missing *config* reg space\n");
> >> This should return error -EINVAL.
> 
> Just read the other thread and Grant Likely suggested the host controller
> driver should be backward compatible [1]. So we can't return -EINVAL here.
> So I'd assume this patch is fine as is? Arnd? Jingoo?

Yes, you're right. The driver should keep backward compatibility for
legacy DT binding. However, after enough time goes by, these legacy
DT handling can be removed.

Best regards,
Jingoo Han

> 
> [1] -> https://lkml.org/lkml/2014/6/3/124
> 
> Thanks
> Kishon

