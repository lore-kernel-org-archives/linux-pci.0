Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 10 Feb 2017 14:25:36 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: Re: [PATCH] PCI: Xilinx NWL: Remove mask for messages not supported
 by AXI
Message-ID: <20170210202536.GI29169@bhelgaas-glaptop.roam.corp.google.com>
References: <1485853170-31940-1-git-send-email-bharatku@xilinx.com>
MIME-Version: 1.0
In-Reply-To: <1485853170-31940-1-git-send-email-bharatku@xilinx.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: robh@kernel.org, arnd@arndb.de, marc.zyngier@arm.com,
 linux-pci@vger.kernel.org, michal.simek@xilinx.com,
 linux-kernel@vger.kernel.org, Bharat Kumar Gogada <bharatku@xilinx.com>,
 paul.gortmaker@windriver.com, rgummal@xilinx.com, bhelgaas@google.com,
 colin.king@canonical.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 31, 2017 at 02:29:30PM +0530, Bharat Kumar Gogada wrote:
> - Removing support for vendor defined messages which are not
> suppoerted by AXI
> =

> Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>

Applied to pci/host-xilinx for v4.11, thanks.

Bharat, get_maintainer.pl lists you as a contributor, but not as a
maintainer of this file.  Should we update MAINTAINERS so it does?  =


  $ ./scripts/get_maintainer.pl drivers/pci/host/pcie-xilinx-nwl.c
  Bjorn Helgaas <bhelgaas@google.com> (supporter:PCI SUBSYSTEM,commit_signe=
r:11/11=3D100%,authored:5/11=3D45%,added_lines:71/999=3D7%,removed_lines:58=
/132=3D44%)
  Michal Simek <michal.simek@xilinx.com> (supporter:ARM/ZYNQ ARCHITECTURE)
  "S=F6ren Brinkmann" <soren.brinkmann@xilinx.com> (reviewer:ARM/ZYNQ ARCHI=
TECTURE)
  Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com> (commit_signer:4/11=
=3D36%,authored:4/11=3D36%,added_lines:924/999=3D92%,removed_lines:23/132=
=3D17%)
  Rob Herring <robh@kernel.org> (commit_signer:1/11=3D9%)
  Colin Ian King <colin.king@canonical.com> (commit_signer:1/11=3D9%,author=
ed:1/11=3D9%)
  Paul Gortmaker <paul.gortmaker@windriver.com> (commit_signer:1/11=3D9%,au=
thored:1/11=3D9%,removed_lines:50/132=3D38%)
  linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM)
  linux-arm-kernel@lists.infradead.org (moderated list:ARM/ZYNQ ARCHITECTUR=
E)
  linux-kernel@vger.kernel.org (open list)


> ---
>  drivers/pci/host/pcie-xilinx-nwl.c |   14 +-------------
>  1 files changed, 1 insertions(+), 13 deletions(-)
> =

> diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-x=
ilinx-nwl.c
> index 76dd094..651486a 100644
> --- a/drivers/pci/host/pcie-xilinx-nwl.c
> +++ b/drivers/pci/host/pcie-xilinx-nwl.c
> @@ -62,21 +62,9 @@
>  #define CFG_ENABLE_PM_MSG_FWD		BIT(1)
>  #define CFG_ENABLE_INT_MSG_FWD		BIT(2)
>  #define CFG_ENABLE_ERR_MSG_FWD		BIT(3)
> -#define CFG_ENABLE_SLT_MSG_FWD		BIT(5)
> -#define CFG_ENABLE_VEN_MSG_FWD		BIT(7)
> -#define CFG_ENABLE_OTH_MSG_FWD		BIT(13)
> -#define CFG_ENABLE_VEN_MSG_EN		BIT(14)
> -#define CFG_ENABLE_VEN_MSG_VEN_INV	BIT(15)
> -#define CFG_ENABLE_VEN_MSG_VEN_ID	GENMASK(31, 16)
>  #define CFG_ENABLE_MSG_FILTER_MASK	(CFG_ENABLE_PM_MSG_FWD | \
>  					CFG_ENABLE_INT_MSG_FWD | \
> -					CFG_ENABLE_ERR_MSG_FWD | \
> -					CFG_ENABLE_SLT_MSG_FWD | \
> -					CFG_ENABLE_VEN_MSG_FWD | \
> -					CFG_ENABLE_OTH_MSG_FWD | \
> -					CFG_ENABLE_VEN_MSG_EN | \
> -					CFG_ENABLE_VEN_MSG_VEN_INV | \
> -					CFG_ENABLE_VEN_MSG_VEN_ID)
> +					CFG_ENABLE_ERR_MSG_FWD)
>  =

>  /* Misc interrupt status mask bits */
>  #define MSGF_MISC_SR_RXMSG_AVAIL	BIT(0)
> -- =

> 1.7.1
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
