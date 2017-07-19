Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Jisheng Zhang'" <jszhang@marvell.com>, <Joao.Pinto@synopsys.com>,
 <bhelgaas@google.com>
References: <20170718064821.3668-1-jszhang@marvell.com>
In-Reply-To: <20170718064821.3668-1-jszhang@marvell.com>
Subject: Re: [PATCH v2] PCI: dwc: designware: test PCIE_ATU_ENABLE bit to
 check enabled or not
Date: Tue, 18 Jul 2017 23:25:24 -0400
Message-ID: <000001d3003e$a9ad0fe0$fd072fa0$@gmail.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, July 18, 2017 2:48 AM, Jisheng Zhang wrote:
> 
> The ATU CTRL2 register is 32 bit, besides the enable bit, other bits
> may also be set. To check whether the ATU is enabled or not, we should
> test the enable bit.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> Acked-by: Joao Pinto <jpinto@synopsys.com>

Acked-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han


> ---
> Since v1:
>  - Add Joao's Ack
>  - Fix typo in commit msg, thank Jingoo
> 
>  drivers/pci/dwc/pcie-designware.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/dwc/pcie-designware.c b/drivers/pci/dwc/pcie-
> designware.c
> index 0e03af279259..6bf0b409050a 100644
> --- a/drivers/pci/dwc/pcie-designware.c
> +++ b/drivers/pci/dwc/pcie-designware.c
> @@ -177,7 +177,7 @@ void dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
> int index, int type,
>  	 */
>  	for (retries = 0; retries < LINK_WAIT_MAX_IATU_RETRIES; retries++)
> {
>  		val = dw_pcie_readl_dbi(pci, PCIE_ATU_CR2);
> -		if (val == PCIE_ATU_ENABLE)
> +		if (val & PCIE_ATU_ENABLE)
>  			return;
> 
>  		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
> --
> 2.13.2



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
