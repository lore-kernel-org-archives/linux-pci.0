Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 3 Feb 2017 15:07:40 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 1 0/4] PCI: Use of_device_get_match_data() to simplify
 probe
Message-ID: <20170203210740.GC24162@bhelgaas-glaptop.roam.corp.google.com>
References: <20170131201400.27605.56002.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
In-Reply-To: <20170131201400.27605.56002.stgit@bhelgaas-glaptop.roam.corp.google.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Scott Branden <sbranden@broadcom.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Jon Mason <jonmason@broadcom.com>, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-renesas-soc@vger.kernel.org,
 Minghuan Lian <minghuan.Lian@freescale.com>,
 Zhou Wang <wangzhou1@hisilicon.com>, Simon Horman <horms@verge.net.au>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-arm-kernel@lists.infradead.org, Ray Jui <rjui@broadcom.com>,
 bcm-kernel-feedback-list@broadcom.com, Mingkai Hu <mingkai.hu@freescale.com>,
 Roy Zang <tie-fei.zang@freescale.com>,
 Shailendra Verma <shailendra.v@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 31, 2017 at 02:19:51PM -0600, Bjorn Helgaas wrote:
> This turned into much ado about nothing, but Shailendra's hisi patch
> prompted similar cleanups in other drivers.  It's a minor simplification,
> but I think worth doing consistently across drivers.
> 
> Basically this is Geert's observation that when the driver probe function
> is called only as a result of matching something in <match_table>, a
> subsequent of_match_device(<match_table>, dev) call should never fail.
> 
> Therefore, instead of this:
> 
>   struct of_device_id *match;
> 
>   match = of_match_device(<match_table>, dev);
>   ... = match->data;
> 
> we can do this:
> 
>   ... = of_device_get_match_data(dev);
> 
> ---
> 
> Bjorn Helgaas (3):
>       PCI: iproc: Use of_device_get_match_data() to simplify probe
>       PCI: layerscape: Use of_device_get_match_data() to simplify probe
>       PCI: rcar: Use of_device_get_match_data() to simplify probe
> 
> Shailendra Verma (1):
>       PCI: hisi: Use of_device_get_match_data() to simplify probe
> 
> 
>  drivers/pci/host/pci-layerscape.c      |    7 +------
>  drivers/pci/host/pcie-hisi.c           |    8 +++-----
>  drivers/pci/host/pcie-iproc-platform.c |    7 +------
>  drivers/pci/host/pcie-rcar.c           |    7 +------
>  4 files changed, 6 insertions(+), 23 deletions(-)

I applied these to pci/host-layerscape, pci/host-hisi, pci/host-iproc,
pci/host-rcar for v4.11.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
