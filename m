Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 11 Jan 2017 12:18:53 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dennis Chen <dennis.chen@arm.com>
Subject: Re: [PATCH] PCI:MSI Return -ENOSPC when requested vectors is not
 enough
Message-ID: <20170111181853.GA14532@bhelgaas-glaptop.roam.corp.google.com>
References: <1480558504-18691-1-git-send-email-dennis.chen@arm.com>
MIME-Version: 1.0
In-Reply-To: <1480558504-18691-1-git-send-email-dennis.chen@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Steve Capper <steve.capper@arm.com>, Marc Zyngier <marc.zyngier@arm.com>,
 linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-ide@vger.kernel.org, Tom Long Nguyen <tom.l.nguyen@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Tejun Heo <tj@kernel.org>, nd@arm.com,
 Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 01, 2016 at 10:15:04AM +0800, Dennis Chen wrote:
> The __pci_enable_msi_range() should return -ENOSPC instead of -EINVAL
> when the device doesn't have enough vectors as required, just as the 
> MSI-X vector allocator does in __pci_enable_msix_range(). Otherwise, 
> some drivers depending on that return value will probably fallback to
> the legacy interrupt directly, for example, in commit 17a51f12cfbd2814
> ("ahci: only try to use multi-MSI mode if there is more than 1 port"), the
> ahci driver will fallback to single MSI mode only when the return value
> is -ENOSPC in case of required vectors is not enough, else the driver will
> use legacy interrupt which has been observed on a x86 box with 6-port SATA
> controller.

Unless Christoph objects, I'll apply this, but I don't understand the
situation with 17a51f12cfbd.  That commit doesn't check for EINVAL or
ENOSPC so I don't know what the connection with this patch is.

I know Christoph said he changed something in ahci to treat all errors
the same, but I don't know where that is, either.

If there's a revision of Linus' tree that is broken, please give the
details so I can at least describe which versions are broken, when it
got fixed by Christoph, and figure out whether we need stable
backports or anything.

Bjorn

> With this patch, when a MSI-capable device doesn't have enough MSI
> vectors as requested, it will fallback to single MSI mode while not
> legacy interrupt.
> 
> Signed-off-by: Dennis Chen <dennis.chen@arm.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Tom Long Nguyen <tom.l.nguyen@intel.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Steve Capper <steve.capper@arm.com>
> Cc: linux-ide@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>  drivers/pci/msi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index ad70507..da37113 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -1084,7 +1084,7 @@ static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
>  	if (nvec < 0)
>  		return nvec;
>  	if (nvec < minvec)
> -		return -EINVAL;
> +		return -ENOSPC;
>  
>  	if (nvec > maxvec)
>  		nvec = maxvec;
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
