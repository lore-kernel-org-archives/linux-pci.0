Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 24 Aug 2016 15:50:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Po Liu <po.liu@nxp.com>
Subject: Re: [PATCH v1] arm64:pci: fix the IOV device enabled crash issue in
 designware
Message-ID: <20160824205059.GG23914@localhost>
References: <1471932072-6980-1-git-send-email-po.liu@nxp.com>
MIME-Version: 1.0
In-Reply-To: <1471932072-6980-1-git-send-email-po.liu@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: =?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>,
 Roy Zang <roy.zang@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-pci@vger.kernel.org, Pratyush Anand <pratyush.anand@gmail.com>,
 Stuart Yoder <stuart.yoder@nxp.com>, Yang-Leo Li <leoyang.li@nxp.com>,
 Mingkai Hu <mingkai.hu@nxp.com>, Jingoo Han <jingoohan1@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Ley Foon Tan <lftan@altera.com>,
 Michal Simek <michal.simek@xilinx.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Jingoo, Pratyush, Michal, S=F6ren, Ley]

On Tue, Aug 23, 2016 at 02:01:12PM +0800, Po Liu wrote:
> When echo a number to /sys/bus/pci/devices/xxx/sriov_numvfs to enable the
> VF devices. A crash log occurred. This found to be access the IOV devices
> config space failure issue.

What was the actual crash?  The mere fact that we made a config read fail
should not cause a crash.  We might erroneously prevent access to VF
devices, but it shouldn't crash.  So maybe there's another bug elsewhere
that we should fix first.

> The read/write config space from host would judge the pcie device plugin
> or not by:
> =

> if (bus->primary =3D=3D pp->root_bus_nr && dev > 0)
>     return 0;

I'm guessing other drivers have the same issue, e.g.,
altera_pcie_valid_config(), xilinx_pcie_valid_device().

Can you look through them and fix them all at once?

> Although all pcie devices for dev(coming from the device and function
> number) is zero. But the dev is not zero for VF. So remove the
> condition.
> =

> Signed-off-by: Po Liu <po.liu@nxp.com>
> ---
>  drivers/pci/host/pcie-designware.c | 7 -------
>  1 file changed, 7 deletions(-)
> =

> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-d=
esignware.c
> index 12afce1..dd20eb2 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -670,13 +670,6 @@ static int dw_pcie_valid_config(struct pcie_port *pp,
>  	if (bus->number =3D=3D pp->root_bus_nr && dev > 0)
>  		return 0;
>  =

> -	/*
> -	 * do not read more than one device on the bus directly attached
> -	 * to RC's (Virtual Bridge's) DS side.
> -	 */
> -	if (bus->primary =3D=3D pp->root_bus_nr && dev > 0)
> -		return 0;
> -
>  	return 1;
>  }
>  =

> -- =

> 2.1.0.27.g96db324
> =

> =

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
