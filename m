Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sun, 2 Jul 2017 16:42:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: srinivas.kandagatla@linaro.org
Cc: Stanimir Varbanov <svarbanov@mm-sol.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: qcom: limit TPL size to 2K to fix hw issue
Message-ID: <20170702214254.GG18324@bhelgaas-glaptop.roam.corp.google.com>
References: <20170629153455.11995-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170629153455.11995-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 29, 2017 at 05:34:55PM +0200, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> This patch limits TPL size to 2K from default 4K size as a workaround
> for a HW bug in v0 version of pcie IP. When using default TPL size of 4K
> the internal buffer gets corrupted due to this HW bug.
> 
> This bug was originally noticed during ssh session between APQ8064
> based board and PC. Network packets got corrupted randomly and
> terminated the ssh session due to this bug.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Applied to pci/host-qcom for v4.13, thanks!

> ---
>  drivers/pci/dwc/pcie-qcom.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/pci/dwc/pcie-qcom.c b/drivers/pci/dwc/pcie-qcom.c
> index 5bf23d432fdb..28ba5192a21d 100644
> --- a/drivers/pci/dwc/pcie-qcom.c
> +++ b/drivers/pci/dwc/pcie-qcom.c
> @@ -51,6 +51,12 @@
>  #define PCIE20_ELBI_SYS_CTRL			0x04
>  #define PCIE20_ELBI_SYS_CTRL_LT_ENABLE		BIT(0)
>  
> +#define PCIE20_AXI_MSTR_RESP_COMP_CTRL0		0x818
> +#define CFG_REMOTE_RD_REQ_BRIDGE_SIZE_2K	0x4
> +#define CFG_REMOTE_RD_REQ_BRIDGE_SIZE_4K	0x5
> +#define PCIE20_AXI_MSTR_RESP_COMP_CTRL1		0x81c
> +#define CFG_BRIDGE_SB_INIT			BIT(0)
> +
>  #define PCIE20_CAP				0x70
>  
>  #define PERST_DELAY_US				1000
> @@ -357,6 +363,13 @@ static int qcom_pcie_init_v0(struct qcom_pcie *pcie)
>  	/* wait for clock acquisition */
>  	usleep_range(1000, 1500);
>  
> +
> +	/* Set the Max TLP size to 2K, instead of using default of 4K */
> +	writel(CFG_REMOTE_RD_REQ_BRIDGE_SIZE_2K,
> +	       pci->dbi_base + PCIE20_AXI_MSTR_RESP_COMP_CTRL0);
> +	writel(CFG_BRIDGE_SB_INIT,
> +	       pci->dbi_base + PCIE20_AXI_MSTR_RESP_COMP_CTRL1);
> +
>  	return 0;
>  
>  err_deassert_ahb:
> -- 
> 2.11.0
> 
