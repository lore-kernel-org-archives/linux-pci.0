Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Po Liu'" <po.liu@nxp.com>,
	<linux-pci@vger.kernel.org>
References: <1471932072-6980-1-git-send-email-po.liu@nxp.com>
 <1472455618-17892-1-git-send-email-po.liu@nxp.com>
In-Reply-To: <1472455618-17892-1-git-send-email-po.liu@nxp.com>
Subject: Re: [PATCH v2] arm64:pci: fix the IOV device access config space
 valid condition
Date: Tue, 30 Aug 2016 11:43:25 -0400
Message-ID: <000a01d202d5$3f86e3a0$be94aae0$@gmail.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: soren.brinkmann@xilinx.com, 'Roy Zang' <roy.zang@nxp.com>,
 'Arnd Bergmann' <arnd@arndb.de>, pratyush.anand@gmail.com,
 'Stuart Yoder' <stuart.yoder@nxp.com>, 'Yang-Leo Li' <leoyang.li@nxp.com>,
 linux-arm-kernel@lists.infradead.org, 'Bjorn Helgaas' <bhelgaas@google.com>,
 lftan@altera.com, michal.simek@xilinx.com, 'Mingkai Hu' <mingkai.hu@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Monday, August 29, 2016 3:27 AM, Po Liu wrote:
> 
> When echo a number to /sys/bus/pci/devices/xxx/sriov_numvfs to enable the
> VF devices. A crash log occurred. This found to be access the IOV devices
> config space failure issue.
> 
> The read/write config space from host would judge the pcie device plugin
> or not by(Designware platform as example):
> 
> if (bus->primary == pp->root_bus_nr && dev > 0)
>     return 0;
> 
> Although all PCIe devices for dev(coming from the device and function
> number) is zero. But the dev is not zero for VF devices. So remove the
> condition.
> 
> These PCI hosts were changed: designware, altera, xilinx.
> 
> Signed-off-by: Po Liu <po.liu@nxp.com>

For 'pcie-designware.c',

Acked-by: Jingoo Han <jingoohan1@gmail.com>

I really don't like to modify host driver stuffs.
But, if there is no alternatives, this patch looks good.

Best regards,
Jingoo Han

> ---
> changes for v2:
> 	- add pci hosts: altera, xilinx;
> 
>  drivers/pci/host/pcie-altera.c     | 7 -------
>  drivers/pci/host/pcie-designware.c | 7 -------
>  drivers/pci/host/pcie-xilinx.c     | 7 -------
>  3 files changed, 21 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-
> altera.c index 2b78376..edbe0a7 100644
> --- a/drivers/pci/host/pcie-altera.c
> +++ b/drivers/pci/host/pcie-altera.c
> @@ -171,13 +171,6 @@ static bool altera_pcie_valid_config(struct
> altera_pcie *pcie,
>  	if (bus->number == pcie->root_bus_nr && dev > 0)
>  		return false;
> 
> -	/*
> -	 * Do not read more than one device on the bus directly attached
> -	 * to root port, root port can only attach to one downstream port.
> -	 */
> -	if (bus->primary == pcie->root_bus_nr && dev > 0)
> -		return false;
> -
>  	 return true;
>  }
> 
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-
> designware.c
> index 12afce1..dd20eb2 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -670,13 +670,6 @@ static int dw_pcie_valid_config(struct pcie_port *pp,
>  	if (bus->number == pp->root_bus_nr && dev > 0)
>  		return 0;
> 
> -	/*
> -	 * do not read more than one device on the bus directly attached
> -	 * to RC's (Virtual Bridge's) DS side.
> -	 */
> -	if (bus->primary == pp->root_bus_nr && dev > 0)
> -		return 0;
> -
>  	return 1;
>  }
> 
> diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-
> xilinx.c index a30e016..75c89db 100644
> --- a/drivers/pci/host/pcie-xilinx.c
> +++ b/drivers/pci/host/pcie-xilinx.c
> @@ -168,13 +168,6 @@ static bool xilinx_pcie_valid_device(struct pci_bus
> *bus, unsigned int devfn)
>  	if (bus->number == port->root_busno && devfn > 0)
>  		return false;
> 
> -	/*
> -	 * Do not read more than one device on the bus directly attached
> -	 * to RC.
> -	 */
> -	if (bus->primary == port->root_busno && devfn > 0)
> -		return false;
> -
>  	return true;
>  }
> 
> --
> 2.1.0.27.g96db324



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
