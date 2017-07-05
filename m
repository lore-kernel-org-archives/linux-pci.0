Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751692AbdGETrA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Jul 2017 15:47:00 -0400
Date: Wed, 5 Jul 2017 14:46:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-ntb@googlegroups.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <Allen.Hubbe@emc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Stephen Bates <sbates@raithlin.com>,
        Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH 15/16] switchtec_ntb: add memory window support
Message-ID: <20170705194642.GC25063@bhelgaas-glaptop.roam.corp.google.com>
References: <20170629032648.3073-1-logang@deltatee.com>
 <20170629032648.3073-16-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170629032648.3073-16-logang@deltatee.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 28, 2017 at 09:26:47PM -0600, Logan Gunthorpe wrote:
> The switchtec hardware has two types of memory windows: LUTs and Direct.
> The first area in each BAR is for LUT windows and the remaining area is
> for the direct region. The total number of LUT entries is set by a
> configuration setting in hardware and they all must be the same
> size. (This is fixed by switchtec_ntb to be 64K.)
> 
> switchtec_ntb enables the LUTs only for the first bar and enables the

s/bar/BAR/

> highest power of two possible. Seeing the LUTs are at the beginning of
> the BAR, the direct memory window's alignment is affected. Therefore,
> the maximum direct memory window size can not be greater than the number
> of LUTs times 64K. The direct window in other bars will not have this

s/bars/BARs/

> restriction as the LUTs will not be enabled there. LUTs will only be
> exposed through the NTB api if the use_lut_mw parameter is set.

s/api/API/

> Seeing the switchtec hardware, by default, configures BARs to be 4G a
> module parameter is given to limit the size of the advertised memory
> windows. Higher layers tend to allocate the maximum BAR size and this
> has a tendancy of failing when they try to allocate 4GB of continuous
> memory.

s/tendancy/tendency/

s/of failing/to fail/

s/continuous/contiguous/

> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Stephen Bates <sbates@raithlin.com>
> Reviewed-by: Kurt Schwemmer <kurt.schwemmer@microsemi.com>
> ---
>  drivers/ntb/hw/mscc/switchtec_ntb.c | 205 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 202 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ntb/hw/mscc/switchtec_ntb.c b/drivers/ntb/hw/mscc/switchtec_ntb.c
> index a42e80742b52..5f9118940a24 100644
> --- a/drivers/ntb/hw/mscc/switchtec_ntb.c
> +++ b/drivers/ntb/hw/mscc/switchtec_ntb.c
> @@ -25,6 +25,11 @@ MODULE_VERSION("0.1");
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Microsemi Corporation");
>  
> +static ulong max_mw_size = SZ_2M;
> +module_param(max_mw_size, ulong, 0644);
> +MODULE_PARM_DESC(max_mw_size,
> +	"Limit the size of the memory windows reported to the upper layer");

Maybe the description should be "Max window size reported ..."?

"Limit the size ..." sounds like it could be a boolean.
