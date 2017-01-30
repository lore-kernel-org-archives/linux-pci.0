Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH] PCI: ACPI: Fix ThunderX PEM initialization
To: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>, <tn@semihalf.com>,
 <David.Daney@cavium.com>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <stemerkhanov@CAVIUMNETWORKS.onmicrosoft.com>
References: <1485793552-12614-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
From: David Daney <ddaney@caviumnetworks.com>
Message-ID: <e92355e7-634f-dc91-4716-da73a23b406c@caviumnetworks.com>
Date: Mon, 30 Jan 2017 09:39:30 -0800
MIME-Version: 1.0
In-Reply-To: <1485793552-12614-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 01/30/2017 08:25 AM, Vadim Lomovtsev wrote:
> This patch is to address PEM initialization issue
> which causes network issues.
>
> It is necessary to search for _HID:PNP0A08 while requesting
> PEM resources via ACPI instead of "THRX0002".

Since this is fixing new code, there should be no chance to break 
previously working systems.

Bjorn: If possible, this should be merged for v4.10

>
> Signed-off-by: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>

Acked-by: David Daney <david.daney@cavium.com>


> ---
>  drivers/pci/host/pci-thunder-pem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/host/pci-thunder-pem.c b/drivers/pci/host/pci-thunder-pem.c
> index af722eb..aec30b8 100644
> --- a/drivers/pci/host/pci-thunder-pem.c
> +++ b/drivers/pci/host/pci-thunder-pem.c
> @@ -331,7 +331,7 @@ static int thunder_pem_acpi_init(struct pci_config_window *cfg)
>  	if (!res_pem)
>  		return -ENOMEM;
>
> -	ret = acpi_get_rc_resources(dev, "THRX0002", root->segment, res_pem);
> +	ret = acpi_get_rc_resources(dev, "PNP0A08", root->segment, res_pem);
>  	if (ret) {
>  		dev_err(dev, "can't get rc base address\n");
>  		return ret;
>


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
