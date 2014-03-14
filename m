Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:12751 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754565AbaCNGB6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 14 Mar 2014 02:01:58 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N2E002GUWR7TI90@mailout1.samsung.com> for
 linux-pci@vger.kernel.org; Fri, 14 Mar 2014 15:01:55 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Mohit Kumar' <mohit.kumar@st.com>
Cc: arnd@arndb.de, 'Pratyush Anand' <pratyush.anand@st.com>,
	'Viresh Kumar' <viresh.linux@gmail.com>,
	spear-devel@list.st.com, linux-pci@vger.kernel.org,
	'Jingoo Han' <jg1.han@samsung.com>
References: <cover.1393568715.git.mohit.kumar@st.com>
 <cbfef3a20e6c713a0d7d6b970dc4c75928798442.1393568715.git.mohit.kumar@st.com>
In-reply-to: <cbfef3a20e6c713a0d7d6b970dc4c75928798442.1393568715.git.mohit.kumar@st.com>
Subject: Re: [PATCH V7 08/10] pcie: SPEAr13xx: Add designware wrapper support
Date: Fri, 14 Mar 2014 15:01:55 +0900
Message-id: <000001cf3f4a$e71b75a0$b55260e0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, February 28, 2014 8:55 PM, Mohit Kumar wrote:
> 
> From: Pratyush Anand <pratyush.anand@st.com>
> 
> SPEAr1310 and SPEAr1340 SOC uses designware PCIe controller. Add
> SPEAr13xx PCIe driver based on designware controller driver.
> 
> SPEAr1310 has 3 PCIe ports and SPEAr1340 has 1, which are multiplexed
> with ahci/sata pins. By default evaluation board of both controller
> works for ahci mode.
> To use these patches on SPEAr1340/1310 evaluation board, do the
> necessary modifications on board and enable (okay) pcie and miphy
> from respective evb dtsi file.
> 
> Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
> Signed-off-by: Mohit Kumar <mohit.kumar@st.com>
> Cc: Jingoo Han <jg1.han@samsung.com>

For 'drivers/pci/host/pcie-spear13xx.c',

Reviewed-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Viresh Kumar <viresh.linux@gmail.com>
> Cc: spear-devel@list.st.com
> Cc: linux-pci@vger.kernel.org
> ---
>  arch/arm/boot/dts/spear1310.dtsi  |    6 +
>  arch/arm/boot/dts/spear1340.dtsi  |    2 +
>  arch/arm/boot/dts/spear13xx.dtsi  |    4 +-
>  arch/arm/mach-spear/Kconfig       |    1 +
>  drivers/pci/host/Kconfig          |    8 +
>  drivers/pci/host/Makefile         |    1 +
>  drivers/pci/host/pcie-spear13xx.c |  414 +++++++++++++++++++++++++++++++++++++
>  7 files changed, 434 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/pci/host/pcie-spear13xx.c


