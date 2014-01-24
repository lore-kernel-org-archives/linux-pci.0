Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:65165 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbaAXINa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jan 2014 03:13:30 -0500
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MZW00LCPC6ECN70@mailout4.samsung.com> for
 linux-pci@vger.kernel.org; Fri, 24 Jan 2014 17:13:26 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Mohit Kumar' <mohit.kumar@st.com>
Cc: 'Pratyush Anand' <pratyush.anand@st.com>,
	'Viresh Kumar' <viresh.linux@gmail.com>,
	spear-devel@list.st.com, linux-pci@vger.kernel.org,
	'Thierry Reding' <thierry.reding@gmail.com>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <cover.1390471111.git.mohit.kumar@st.com>
 <59f1ee2335f1f49913d5ed77213880f868987e96.1390471111.git.mohit.kumar@st.com>
In-reply-to: <59f1ee2335f1f49913d5ed77213880f868987e96.1390471111.git.mohit.kumar@st.com>
Subject: Re: [PATCH V2 7/8] pcie: SPEAr13xx: Add designware pcie support
Date: Fri, 24 Jan 2014 17:13:26 +0900
Message-id: <000201cf18dc$282cf360$7886da20$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



> -----Original Message-----
> From: Mohit Kumar [mailto:mohit.kumar@st.com]
> Sent: Thursday, January 23, 2014 7:33 PM
> Cc: Pratyush Anand; Mohit Kumar; Jingoo Han; Viresh Kumar; spear-devel@list.st.com; linux-
> pci@vger.kernel.org
> Subject: [PATCH V2 7/8] pcie: SPEAr13xx: Add designware pcie support
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
> necessary modifications on board and enable (okay) pcie from respective
> evb dtsi file.
> 
> Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
> Signed-off-by: Mohit Kumar <mohit.kumar@st.com>
> Cc: Mohit Kumar <mohit.kumar@st.com>
> Cc: Jingoo Han <jg1.han@samsung.com>
> Cc: Viresh Kumar <viresh.linux@gmail.com>
> Cc: spear-devel@list.st.com
> Cc: linux-pci@vger.kernel.org
> ---
>  arch/arm/boot/dts/spear13xx.dtsi     |   53 +++++-
>  arch/arm/configs/spear13xx_defconfig |    2 +
>  arch/arm/mach-spear/Kconfig          |    1 +
>  drivers/mfd/spear13xx-cfg.c          |  205 ++++++++++++++++++
>  drivers/pci/host/Kconfig             |    5 +
>  drivers/pci/host/Makefile            |    1 +
>  drivers/pci/host/pcie-spear13xx.c    |  394 ++++++++++++++++++++++++++++++++++

(+cc Thierry Reding)

How about changing the file name to 'pci-spear13xx.c'?
Now, all PCI host drivers are using the prefix 'pci-', not 'pcie-'.

According to the Thierry Reding's comment,
"I think we should keep these sorted alphabetically. Also Tegra and
Marvell are PCIe controllers but they still use the pci- prefix instead
of pcie-. Perhaps it'd be good to keep consistency here? I initially
chose pci- because from a software point of view it doesn't matter all
that much whether it's PCI or PCIe and because the drivers are part of
the PCI subsystem. However if Exynos now uses the pcie- prefix it makes
it look like Tegra and Marvell are plain old PCI."
(https://groups.google.com/forum/#!msg/linux.kernel/qtimJoNSc3w/_1aayHaG54YJ)

If there is a special reason, please let us know.

Other things look good. :-)
Thank you.

Best regards,
Jingoo Han

>  7 files changed, 659 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/pci/host/pcie-spear13xx.c


