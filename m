Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <e42a6bb8ff0ddd6eaa31fe381875425a3730a73f.1532090446.git.leonard.crestez@nxp.com>
References: <cover.1532090446.git.leonard.crestez@nxp.com>
 <e42a6bb8ff0ddd6eaa31fe381875425a3730a73f.1532090446.git.leonard.crestez@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 20 Jul 2018 10:38:18 -0300
Message-ID: <CAOMZO5BQjxeGOUE3jwbA_sRuYWQkHTJo3AeywXXpm-9kVdsYfw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] PCI: imx: Initial imx7d pm support
To: Leonard Crestez <leonard.crestez@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, Joao Pinto <Joao.Pinto@synopsys.com>,
 Richard Zhu <hongxing.zhu@nxp.com>, linux-pm@vger.kernel.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Jingoo Han <jingoohan1@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 NXP Linux Team <linux-imx@nxp.com>, Sascha Hauer <kernel@pengutronix.de>,
 linux-pci@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Leonard,

On Fri, Jul 20, 2018 at 9:47 AM, Leonard Crestez
<leonard.crestez@nxp.com> wrote:

> +static int imx6_pcie_resume_noirq(struct device *dev)
> +{
> +       int ret = 0;

There is no need for initializing 'ret' here.

> +       struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
> +       struct pcie_port *pp = &imx6_pcie->pci->pp;
> +
> +       if (imx6_pcie->variant != IMX7D)
> +               return 0;
> +
> +       imx6_pcie_assert_core_reset(imx6_pcie);
> +       imx6_pcie_init_phy(imx6_pcie);
> +       imx6_pcie_deassert_core_reset(imx6_pcie);
> +       dw_pcie_setup_rc(pp);
> +
> +       ret = imx6_pcie_establish_link(imx6_pcie);
> +       if (ret < 0)
> +               pr_err("pcie link is down after resume.\n");

Shouldn't the error be propagated?

Also, dev_err() is preferred instead of pr_err().

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
