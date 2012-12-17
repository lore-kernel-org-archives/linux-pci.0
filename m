Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:30122 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751003Ab2LQXiY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 17 Dec 2012 18:38:24 -0500
Date: Mon, 17 Dec 2012 15:38:16 -0800
From: Greg Rose <gregory.v.rose@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Don Dutile <ddutile@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"yuvalmin@broadcom.com" <yuvalmin@broadcom.com>,
	"bhutchings@solarflare.com" <bhutchings@solarflare.com>,
	"yinghai@kernel.org" <yinghai@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	<gregory.v.rose@intel.com>
Subject: Re: [PATCH v2] PCI SRIOV device enable and disable via sysfs
Message-ID: <20121217153816.000061ce@unknown>
In-Reply-To: <20121217232439.GA9746@google.com>
References: <1352146841-64458-1-git-send-email-ddutile@redhat.com>
	<CAErSpo7OS=iuVFDnBEDz8Bx4GmVisw=UGvuv27OgU6JOeZHhrw@mail.gmail.com>
	<20121214101911.00002f59@unknown>
	<50CF7993.9040606@redhat.com>
	<20121217232439.GA9746@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 17 Dec 2012 16:24:39 -0700
Bjorn Helgaas <bhelgaas@google.com> wrote:

> On Mon, Dec 17, 2012 at 02:59:15PM -0500, Don Dutile wrote:
> > On 12/14/2012 01:19 PM, Greg Rose wrote:
> > >pci: Fix return code
> > >
> > >From: Greg Rose<gregory.v.rose@intel.com>
> > >
> > >The return code from the sriov configure function was only
> > >returned if it was less than zero indicating an error.  This
> > >caused the code to fall through to the default return of an error
> > >code even though the sriov configure function has returned the
> > >number of VFs it created - a positive number indicating success.
> > >
> > >
> > >Signed-off-by: Greg Rose<gregory.v.rose@intel.com>
> > 
> > Actually, it returned the number of VFs enabled if it exactly
> > equalled the number to be enabled.  Otherwise, the basic testing
> > would have failed. If the number of vf's enabled was positive but
> > not the same as the number requested-to-be-enabled, then it
> > incorrectly returned.
> > 
> > But, the patch corrects the base problem, so
> > Acked-by: Donald Dutile <ddutile@redhat.com>
> 
> Alternate proposal below.  The patch is ugly; it might be easier to
> compare the before (http://pastebin.com/zneG8AuD) and after
> (http://pastebin.com/BEXEE8kc) versions.
> 
> commit fae71e5dc9064dcb3077b8da6e0ed9d800c1f527
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Thu Dec 13 20:22:44 2012 -0700
> 
>     PCI: Cleanup sriov_numvfs_show() and handle common case without
> error 
>     If we request "num_vfs" and the driver's sriov_configure() method
> enables exactly that number ("num_vfs_enabled"), we complain "Invalid
> value for number of VFs to enable" and return an error.  We should
> silently return success instead.
>     
>     Also, use kstrtou16() since numVFs is defined to be a 16-bit
> field and rework to simplify control flow.
>     
>     Reported-by: Greg Rose <gregory.v.rose@intel.com>
>     Link: http://lkml.kernel.org/r/20121214101911.00002f59@unknown
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 05b78b1..5e8af12 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -422,77 +422,60 @@ static ssize_t sriov_numvfs_show(struct device
> *dev, }
>  
>  /*
> - * num_vfs > 0; number of vfs to enable
> - * num_vfs = 0; disable all vfs
> + * num_vfs > 0; number of VFs to enable
> + * num_vfs = 0; disable all VFs
>   *
>   * Note: SRIOV spec doesn't allow partial VF
> - *       disable, so its all or none.
> + *       disable, so it's all or none.
>   */
>  static ssize_t sriov_numvfs_store(struct device *dev,
>  				  struct device_attribute *attr,
>  				  const char *buf, size_t count)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
> -	int num_vfs_enabled = 0;
> -	int num_vfs;
> -	int ret = 0;
> -	u16 total;
> +	int ret;
> +	u16 num_vfs;
>  
> -	if (kstrtoint(buf, 0, &num_vfs) < 0)
> -		return -EINVAL;
> +	ret = kstrtou16(buf, 0, &num_vfs);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (num_vfs > pci_sriov_get_totalvfs(pdev))
> +		return -ERANGE;
> +
> +	if (num_vfs == pdev->sriov->num_VFs)
> +		return count;		/* no change */
>  
>  	/* is PF driver loaded w/callback */
>  	if (!pdev->driver || !pdev->driver->sriov_configure) {
> -		dev_info(&pdev->dev,
> -			 "Driver doesn't support SRIOV configuration
> via sysfs\n");
> +		dev_info(&pdev->dev, "Driver doesn't support SRIOV
> configuration via sysfs\n"); return -ENOSYS;
>  	}
>  
> -	/* if enabling vf's ... */
> -	total = pci_sriov_get_totalvfs(pdev);
> -	/* Requested VFs to enable < totalvfs and none enabled
> already */
> -	if ((num_vfs > 0) && (num_vfs <= total)) {
> -		if (pdev->sriov->num_VFs == 0) {
> -			num_vfs_enabled =
> -				pdev->driver->sriov_configure(pdev,
> num_vfs);
> -			if ((num_vfs_enabled >= 0) &&
> -			    (num_vfs_enabled != num_vfs)) {
> -				dev_warn(&pdev->dev,
> -					 "Only %d VFs enabled\n",
> -					 num_vfs_enabled);
> -				return count;
> -			} else if (num_vfs_enabled < 0)
> -				/* error code from driver callback */
> -				return num_vfs_enabled;
> -		} else if (num_vfs == pdev->sriov->num_VFs) {
> -			dev_warn(&pdev->dev,
> -				 "%d VFs already enabled; no enable
> action taken\n",
> -				 num_vfs);
> -			return count;
> -		} else {
> -			dev_warn(&pdev->dev,
> -				 "%d VFs already enabled. Disable
> before enabling %d VFs\n",
> -				 pdev->sriov->num_VFs, num_vfs);
> -			return -EINVAL;
> -		}
> +	if (num_vfs == 0) {
> +		/* disable VFs */
> +		ret = pdev->driver->sriov_configure(pdev, 0);
> +		if (ret < 0)
> +			return ret;
> +		return count;
>  	}
>  
> -	/* disable vfs */
> -	if (num_vfs == 0) {
> -		if (pdev->sriov->num_VFs != 0) {
> -			ret = pdev->driver->sriov_configure(pdev, 0);
> -			return ret ? ret : count;
> -		} else {
> -			dev_warn(&pdev->dev,
> -				 "All VFs disabled; no disable
> action taken\n");
> -			return count;
> -		}
> +	/* enable VFs */
> +	if (pdev->sriov->num_VFs) {
> +		dev_warn(&pdev->dev, "%d VFs already enabled.
> Disable before enabling %d VFs\n",
> +			 pdev->sriov->num_VFs, num_vfs);
> +		return -EINVAL;
>  	}

Maybe return -EPERM instead?

>  
> -	dev_err(&pdev->dev,
> -		"Invalid value for number of VFs to enable: %d\n",
> num_vfs);
> +	ret = pdev->driver->sriov_configure(pdev, num_vfs);
> +	if (ret < 0)
> +		return ret;
>  
> -	return -EINVAL;
> +	if (ret != num_vfs)
> +		dev_warn(&pdev->dev, "%d VFs requested; only %d
> enabled\n",
> +			 num_vfs, ret);
> +
> +	return count;
>  }
>  
>  static struct device_attribute sriov_totalvfs_attr =
> __ATTR_RO(sriov_totalvfs);

Looks good to me.

Thanks,

- Greg


