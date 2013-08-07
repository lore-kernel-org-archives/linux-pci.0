Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jingoo Han <jg1.han@samsung.com>
To: 'Bjorn Helgaas' <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	'Kukjin Kim' <kgene.kim@samsung.com>,
	'Pratyush Anand' <pratyush.anand@st.com>,
	'Mohit KUMAR' <Mohit.KUMAR@st.com>,
	'Arnd Bergmann' <arnd@arndb.de>,
	'Sean Cross' <xobs@kosagi.com>,
	'Kishon Vijay Abraham I' <kishon@ti.com>,
	'Thierry Reding' <thierry.reding@gmail.com>,
	'SRIKANTH TUMKUR SHIVANAND' <ts.srikanth@samsung.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH V5] pci: exynos: split into two parts such as Synopsys part
 and Exynos part
Date: Wed, 07 Aug 2013 13:13:42 +0900
Message-id: <002501ce9324$8066f5a0$8134e0e0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, July 31, 2013 5:14 PM, Jingoo Han <jg1.han@samsung.com> wrote:
> Exynos PCIe IP consists of Synopsys specific part and Exynos
> specific part. Only core block is a Synopsys designware part;
> other parts are Exynos specific.
> Also, the Synopsys designware part can be shared with other
> platforms; thus, it can be split two parts such as Synopsys
> designware part and Exynos specific part.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> Cc: Pratyush Anand <pratyush.anand@st.com>
> Cc: Mohit KUMAR <Mohit.KUMAR@st.com>

Hi Bjorn Helgaas,

There is no comment for last 2 weeks.
Will you accept this patch?


Best regards,
Jingoo Han

> ---
> Changes since v4:
> - fixed section mismatch warnings
> - fixed sparse warnings
> 
>  .../devicetree/bindings/pci/designware-pcie.txt    |    3 +
>  arch/arm/boot/dts/exynos5440.dtsi                  |    2 +
>  drivers/pci/host/Makefile                          |    3 +-
>  drivers/pci/host/pci-exynos.c                      |  530 ++++++++++
>  drivers/pci/host/pcie-designware.c                 | 1011 ++++++--------------
>  drivers/pci/host/pcie-designware.h                 |   65 ++
>  6 files changed, 874 insertions(+), 740 deletions(-)
>  create mode 100644 drivers/pci/host/pci-exynos.c
>  create mode 100644 drivers/pci/host/pcie-designware.h


