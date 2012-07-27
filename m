Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from canardo.mork.no ([148.122.252.1]:57526 "EHLO canardo.mork.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751486Ab2G0JMH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 27 Jul 2012 05:12:07 -0400
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: Huang Ying <ying.huang@intel.com>
Cc: huang ying <huang.ying.caritas@gmail.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Zheng Yan <zheng.z.yan@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>
Subject: Re: bisected regression, v3.5 -> next-20120724: PCI PM causes USB hotplug failure
References: <Pine.LNX.4.44L0.1207241312050.1164-100000@iolanthe.rowland.org>
	<87r4s0opck.fsf@nemi.mork.no> <87pq7ko532.fsf@nemi.mork.no>
	<1343190864.10311.26.camel@yhuang-dev> <87k3xskvqq.fsf@nemi.mork.no>
	<CAC=cRTOi+=49+_4VuMuBR8rTPvjXLMVhNBFbr3SHgNyxfnKQUA@mail.gmail.com>
	<874now7xi8.fsf@nemi.mork.no> <1343292851.3874.12.camel@yhuang-dev>
	<87k3xqyfm3.fsf@nemi.mork.no> <1343367309.3874.21.camel@yhuang-dev>
Date: Fri, 27 Jul 2012 11:11:47 +0200
In-Reply-To: <1343367309.3874.21.camel@yhuang-dev> (Huang Ying's message of
	"Fri, 27 Jul 2012 13:35:09 +0800")
Message-ID: <87sjcd4lgs.fsf@nemi.mork.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Huang Ying <ying.huang@intel.com> writes:

> Do you have time to try the following patch?
>
> Best Regards,
> Huang Ying
>
> ---
>  drivers/pci/pci-driver.c |    6 ++++++
>  1 file changed, 6 insertions(+)
>
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -280,8 +280,12 @@ static long local_pci_probe(void *_ddi)
>  {
>  	struct drv_dev_and_id *ddi = _ddi;
>  	struct device *dev = &ddi->dev->dev;
> +	struct device *parent = dev->parent;
>  	int rc;
>  
> +	/* The parent bridge must be in active state when probing */
> +	if (parent)
> +		pm_runtime_get_sync(parent);
>  	/* Unbound PCI devices are always set to disabled and suspended.
>  	 * During probe, the device is set to enabled and active and the
>  	 * usage count is incremented.  If the driver supports runtime PM,
> @@ -298,6 +302,8 @@ static long local_pci_probe(void *_ddi)
>  		pm_runtime_set_suspended(dev);
>  		pm_runtime_put_noidle(dev);
>  	}
> +	if (parent)
> +		pm_runtime_put(parent);
>  	return rc;
>  }
>  


Yup, that worked in the quick test I just did.

 lspci reading the device config will still not wake the bridge, but I
assume that is intentional?  But loading the device driver now wakes
both the bridge and the device, so that works.


Bjørn
