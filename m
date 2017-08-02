Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 2 Aug 2017 16:52:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jisheng Zhang <jszhang@marvell.com>
Subject: Re: [PATCH v2] PCI: dwc: designware: test PCIE_ATU_ENABLE bit to
 check enabled or not
Message-ID: <20170802215241.GO20308@bhelgaas-glaptop.roam.corp.google.com>
References: <20170718064821.3668-1-jszhang@marvell.com>
MIME-Version: 1.0
In-Reply-To: <20170718064821.3668-1-jszhang@marvell.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Joao.Pinto@synopsys.com, jingoohan1@gmail.com, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, bhelgaas@google.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 18, 2017 at 02:48:21PM +0800, Jisheng Zhang wrote:
> The ATU CTRL2 register is 32 bit, besides the enable bit, other bits
> may also be set. To check whether the ATU is enabled or not, we should
> test the enable bit.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> Acked-by: Joao Pinto <jpinto@synopsys.com>

Applied with Jingoo's ack to pci/host-designware for v4.14, thanks!

> ---
> Since v1:
>  - Add Joao's Ack
>  - Fix typo in commit msg, thank Jingoo
> 
>  drivers/pci/dwc/pcie-designware.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/dwc/pcie-designware.c b/drivers/pci/dwc/pcie-designware.c
> index 0e03af279259..6bf0b409050a 100644
> --- a/drivers/pci/dwc/pcie-designware.c
> +++ b/drivers/pci/dwc/pcie-designware.c
> @@ -177,7 +177,7 @@ void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
>  	 */
>  	for (retries = 0; retries < LINK_WAIT_MAX_IATU_RETRIES; retries++) {
>  		val = dw_pcie_readl_dbi(pci, PCIE_ATU_CR2);
> -		if (val == PCIE_ATU_ENABLE)
> +		if (val & PCIE_ATU_ENABLE)
>  			return;
>  
>  		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
> -- 
> 2.13.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
