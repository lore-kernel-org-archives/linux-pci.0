Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 30 May 2018 06:31:03 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH] PCI: Add pci=safemode option
Message-ID: <20180530043103.GA19734@kroah.com>
References: <1527650389-31575-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <1527650389-31575-1-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 linux-pci@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>, Ingo Molnar <mingo@kernel.org>,
 Christoffer Dall <cdall@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
 timur@codeaurora.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Dongdong Liu <liudongdong3@huawei.com>, David Rientjes <rientjes@google.com>,
 Thymo van Beers <thymovanbeers@gmail.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Frederick Lawler <fred@fredlawl.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Marc Zyngier <marc.zyngier@arm.com>, linux-arm-msm@vger.kernel.org,
 Frederic Weisbecker <frederic@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Oza Pawandeep <poza@codeaurora.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 29, 2018 at 11:19:41PM -0400, Sinan Kaya wrote:
> Adding pci=safemode kernel command line parameter to turn off all PCI
> Express service driver as well as all optional PCIe features such as LTR,
> Extended tags, Relaxed Ordering etc.
> 
> Also setting MPS configuration to PCIE_BUS_SAFE so that MPS and MRRS can be
> reconfigured with by the kernel in case BIOS hands off a broken
> configuration.

Why not fix the BIOS?  That's what sane platforms do :)

> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 2 ++
>  drivers/pci/pci.c                               | 7 +++++++
>  drivers/pci/pci.h                               | 2 ++
>  drivers/pci/pcie/portdrv_core.c                 | 2 +-
>  drivers/pci/probe.c                             | 6 ++++++
>  5 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 641ec9c..247adbb 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3153,6 +3153,8 @@
>  		noari		do not use PCIe ARI.
>  		noats		[PCIE, Intel-IOMMU, AMD-IOMMU]
>  				do not use PCIe ATS (and IOMMU device IOTLB).
> +		safemode	turns of all optinal PCI features. Useful
> +				for bringup/troubleshooting.

s/optinal/optional/ ?

And you should explain what exactly in PCI is "optional".  Who defines
this and where is that list and what can go wrong if those options are
not enabled?

In looking at your patch, I can't determine that at all, so there's no
way that someone just looking at this sentence will be able to
understand.

thanks,

greg k-h

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
