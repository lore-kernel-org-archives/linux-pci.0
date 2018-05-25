Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 25 May 2018 17:30:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] PCI/sysfs: do not allow enabling/disabling a device with
 a driver
Message-ID: <20180525223043.GC63280@bhelgaas-glaptop.roam.corp.google.com>
References: <20180518165624.13993-1-hch@lst.de>
MIME-Version: 1.0
In-Reply-To: <20180518165624.13993-1-hch@lst.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
 ming.lei@redhat.com, keith.busch@linux.intel.com, jthumshirn@suse.de,
 bhelgaas@google.com, arjan@linux.intel.com
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 18, 2018 at 06:56:24PM +0200, Christoph Hellwig wrote:
> Manpulating the enable_cnt behind the back of the driver will wreck
> complete havok with the kernel state, so disallow it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Applied to pci/enumeration for v4.18, thanks!

> ---
>  drivers/pci/pci-sysfs.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 366d93af051d..788a200fb2dc 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -288,13 +288,16 @@ static ssize_t enable_store(struct device *dev, struct device_attribute *attr,
>  	if (!capable(CAP_SYS_ADMIN))
>  		return -EPERM;
>  
> -	if (!val) {
> -		if (pci_is_enabled(pdev))
> -			pci_disable_device(pdev);
> -		else
> -			result = -EIO;
> -	} else
> +	device_lock(dev);
> +	if (dev->driver)
> +		result = -EBUSY;
> +	else if (val)
>  		result = pci_enable_device(pdev);
> +	else if (pci_is_enabled(pdev))
> +		pci_disable_device(pdev);
> +	else
> +		result = -EIO;
> +	device_unlock(dev);
>  
>  	return result < 0 ? result : count;
>  }
> -- 
> 2.17.0
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
