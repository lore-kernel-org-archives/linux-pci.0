Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH 02/37] PCI: dwc: designware: Add new *ops* for cpu addr
 fixup
To: Kishon Vijay Abraham I <kishon@ti.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, Joao Pinto
 <Joao.Pinto@synopsys.com>, Arnd Bergmann <arnd@arndb.de>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
 <1484216786-17292-3-git-send-email-kishon@ti.com>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <68f59de0-104f-41aa-886d-52d43ecd8e6b@synopsys.com>
Date: Fri, 13 Jan 2017 16:34:26 +0000
MIME-Version: 1.0
In-Reply-To: <1484216786-17292-3-git-send-email-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-pci@vger.kernel.org, nsekhar@ti.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com,
 linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="windows-1252"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>


Hi Kishon,

=C0s 10:25 AM de 1/12/2017, Kishon Vijay Abraham I escreveu:
> Some platforms (like dra7xx) require only the least 28 bits of the
> corresponding 32 bit CPU address to be programmed in the address
> translation unit. This modified address is stored in io_base/mem_base/
> cfg0_base/cfg1_base in dra7xx_pcie_host_init. While this is okay for
> host mode where the address range is fixed, device mode requires
> different addresses to be programmed based on the host buffer address.
> Add a new ops to get the least 28 bits of the corresponding 32 bit
> CPU address and invoke it before programming the address translation
> unit.
> =

> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/dwc/pcie-designware.c |    3 +++
>  drivers/pci/dwc/pcie-designware.h |    1 +
>  2 files changed, 4 insertions(+)
> =

> diff --git a/drivers/pci/dwc/pcie-designware.c b/drivers/pci/dwc/pcie-des=
ignware.c
> index bed1999..d68bc7b 100644
> --- a/drivers/pci/dwc/pcie-designware.c
> +++ b/drivers/pci/dwc/pcie-designware.c
> @@ -195,6 +195,9 @@ static void dw_pcie_prog_outbound_atu(struct pcie_por=
t *pp, int index,
>  {
>  	u32 retries, val;
>  =

> +	if (pp->ops->cpu_addr_fixup)
> +		cpu_addr =3D pp->ops->cpu_addr_fixup(cpu_addr);
> +
>  	if (pp->iatu_unroll_enabled) {
>  		dw_pcie_writel_unroll(pp, index, PCIE_ATU_UNR_LOWER_BASE,
>  			lower_32_bits(cpu_addr));
> diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-des=
ignware.h
> index a567ea2..32f4602 100644
> --- a/drivers/pci/dwc/pcie-designware.h
> +++ b/drivers/pci/dwc/pcie-designware.h
> @@ -54,6 +54,7 @@ struct pcie_port {
>  };
>  =

>  struct pcie_host_ops {
> +	u64 (*cpu_addr_fixup)(u64 cpu_addr);
>  	u32 (*readl_rc)(struct pcie_port *pp, u32 reg);
>  	void (*writel_rc)(struct pcie_port *pp, u32 reg, u32 val);
>  	int (*rd_own_conf)(struct pcie_port *pp, int where, int size, u32 *val);
> =


I think this is an acceptable fixup, I am ok with it.

Reviewed-By: Joao Pinto <jpinto@synopsys.com>

Joao

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
