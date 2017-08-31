Return-Path: <SRS0=KvM2=AB=gmail.com=festevam@kernel.org>
Return-Path: <SRS0=KvM2=AB=gmail.com=festevam@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170831165817.GD18250@bhelgaas-glaptop.roam.corp.google.com>
References: <20170828142307.30061-1-l.stach@pengutronix.de>
 <20170828142307.30061-2-l.stach@pengutronix.de> <20170831165817.GD18250@bhelgaas-glaptop.roam.corp.google.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 31 Aug 2017 14:32:55 -0300
Message-ID: <CAOMZO5DuFiCTMCdw8SNY9QBXFDVFbPa9wagwiJvsZOwYeBTeNw@mail.gmail.com>
Subject: Re: [PATCH 1/3] PCI: designware: only register MSI controller when
 MSI irq line is valid
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lucas Stach <l.stach@pengutronix.de>, Bjorn Helgaas <bhelgaas@google.com>,
	Tim Harvey <tharvey@gateworks.com>, Jingoo Han <jingoohan1@gmail.com>,
	Joao Pinto <Joao.Pinto@synopsys.com>, Shawn Guo <shawnguo@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, patchwork-lst@pengutronix.de,
	Sascha Hauer <kernel@pengutronix.de>, Kishon Vijay Abraham I <kishon@ti.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Niklas Cassel <niklas.cassel@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>,
	Zhou Wang <wangzhou1@hisilicon.com>, Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Xiaowei Song <songxiaowei@hisilicon.com>, Binghui Wang <wangbinghui@hisilicon.com>,
	Stanimir Varbanov <svarbanov@mm-sol.com>, Pratyush Anand <pratyush.anand@gmail.com>,
	Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Richard Zhu <hongxing.zhu@nxp.com>,
	Murali Karicheri <m-karicheri2@ti.com>, Minghuan Lian <minghuan.Lian@freescale.com>,
	Mingkai Hu <mingkai.hu@freescale.com>, Roy Zang <tie-fei.zang@freescale.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Thu, Aug 31, 2017 at 1:58 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:

> Incidental observations not strictly related to this series:
>
>   - It looks like exynos_add_pcie_port() incorrectly assumes
>     platform_get_irq() returns zero on failure (twice).

I will send a series cleaning up the error handling in
platform_get_irq() for the various PCI drivers.
