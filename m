Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 21 Sep 2017 18:30:33 -0500
From: Rob Herring <robh@kernel.org>
To: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Subject: Re: [PATCH 1/5] irqchip/ls-scfg-msi: add LS1012a MSI support
Message-ID: <20170921233033.zy7xt7hdfxvhjg7o@rob-hp-laptop>
References: <20170919092658.22482-1-Zhiqiang.Hou@nxp.com>
 <20170919092658.22482-2-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
In-Reply-To: <20170919092658.22482-2-Zhiqiang.Hou@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, roy.zang@nxp.com,
 marc.zyngier@arm.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Minghuan.Lian@nxp.com, Mingkai.Hu@nxp.com, bhelgaas@google.com,
 shawnguo@kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 19, 2017 at 05:26:54PM +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> The ls1012a implement only 1 msi controller, and it is the same as
> ls1043a.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
>  .../devicetree/bindings/interrupt-controller/fsl,ls-scfg-msi.txt         | 1 +
>  drivers/irqchip/irq-ls-scfg-msi.c                                        | 1 +
>  2 files changed, 2 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
