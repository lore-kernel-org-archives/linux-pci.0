Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 11 Oct 2017 14:41:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Subject: Re: [PATCH 2/2] pci/layerscape: change the default error response
 behavior
Message-ID: <20171011194129.GQ25517@bhelgaas-glaptop.roam.corp.google.com>
References: <20170922072522.36306-1-Zhiqiang.Hou@nxp.com>
 <20170922072522.36306-3-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
In-Reply-To: <20170922072522.36306-3-Zhiqiang.Hou@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: roy.zang@nxp.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 minghuan.lian@nxp.com, linux-arm-kernel@lists.infradead.org,
 bhelgaas@google.com, mingkai.hu@nxp.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 22, 2017 at 03:25:22PM +0800, Zhiqiang Hou wrote:
> From: Minghuan Lian <Minghuan.Lian@nxp.com>
> 
> By default, when the PCIe controller experiences an erroneous
> completion from an external completer for its outbound non-posted
> request, it always sends an OKAY response to the device's internal
> AXI slave system interface. However, such default system error
> response behavior cannot be used for other types of outbound
> non-posted requests. For example, the outbound memory read
> transaction requires an actual ERROR response, like UR completion
> or completion timeout. The patch is to fix it by forwarding
> the error response of the non-posted request.
> 
> Signed-off-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
>  drivers/pci/dwc/pci-layerscape.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/pci/dwc/pci-layerscape.c b/drivers/pci/dwc/pci-layerscape.c
> index 3b01e309a55e..a647090c140e 100644
> --- a/drivers/pci/dwc/pci-layerscape.c
> +++ b/drivers/pci/dwc/pci-layerscape.c
> @@ -33,6 +33,8 @@
>  
>  /* PEX Internal Configuration Registers */
>  #define PCIE_STRFMR1		0x71c /* Symbol Timer & Filter Mask Register1 */
> +#define PCIE_ABSERR		0x8d0 /* Bridge Slave Error Response Register */
> +#define PCIE_ABSERR_SETTING	0x9401 /* Forward error of non-posted request */
>  
>  #define PCIE_IATU_NUM		6
>  
> @@ -54,6 +56,19 @@ struct ls_pcie {
>  
>  #define to_ls_pcie(x)	dev_get_drvdata((x)->dev)
>  
> +static int err_response_flag = 1;
> +
> +static int __init ls_pcie_param(char *p)
> +{
> +	if (p && strncmp(p, "no-err-response", 15) == 0)
> +		err_response_flag = 0;
> +	else
> +		err_response_flag = 1;
> +
> +	return 0;
> +}
> +early_param("ls_pcie", ls_pcie_param);

What's the point of this parameter?  If it's for debugging, it's not
clear that we need it upstream.  If it's for debugging and we *do*
need it upstream, there should be some sort of comment to that effect.

I assume you never expect an end user to need this parameter.

>  static bool ls_pcie_is_bridge(struct ls_pcie *pcie)
>  {
>  	struct dw_pcie *pci = pcie->pci;
> @@ -124,6 +139,14 @@ static int ls_pcie_link_up(struct dw_pcie *pci)
>  	return 1;
>  }
>  
> +/* Forward error response of outbound non-posted requests */
> +static void ls_pcie_fix_error_response(struct ls_pcie *pcie)
> +{
> +	struct dw_pcie *pci = pcie->pci;
> +
> +	iowrite32(PCIE_ABSERR_SETTING, pci->dbi_base + PCIE_ABSERR);
> +}
> +
>  static int ls_pcie_host_init(struct pcie_port *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> @@ -135,6 +158,8 @@ static int ls_pcie_host_init(struct pcie_port *pp)
>  	 * dw_pcie_setup_rc() will reconfigure the outbound windows.
>  	 */
>  	ls_pcie_disable_outbound_atus(pcie);
> +	if (err_response_flag)
> +		ls_pcie_fix_error_response(pcie);
>  
>  	dw_pcie_dbi_ro_wr_en(pci);
>  	ls_pcie_clear_multifunction(pcie);
> -- 
> 2.14.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
