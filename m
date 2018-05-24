Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:43786 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935296AbeEXMlH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 May 2018 08:41:07 -0400
Date: Thu, 24 May 2018 13:41:01 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Dexuan Cui <decui@microsoft.com>
Cc: 'Bjorn Helgaas' <bhelgaas@google.com>,
        "'linux-pci@vger.kernel.org'" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "'olaf@aepfle.de'" <olaf@aepfle.de>,
        "'apw@canonical.com'" <apw@canonical.com>,
        "'jasowang@redhat.com'" <jasowang@redhat.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'driverdev-devel@linuxdriverproject.org'"
        <driverdev-devel@linuxdriverproject.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "'vkuznets@redhat.com'" <vkuznets@redhat.com>,
        "'marcelo.cerri@canonical.com'" <marcelo.cerri@canonical.com>
Subject: Re: [PATCH] PCI: hv: Do not wait forever on a device that has
 disappeared
Message-ID: <20180524124101.GB20732@e107981-ln.cambridge.arm.com>
References: <KL1P15301MB0006DF4209AEE3809ABD303FBF6B0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <KL1P15301MB0006DF4209AEE3809ABD303FBF6B0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 23, 2018 at 09:12:01PM +0000, Dexuan Cui wrote:
> 
> Before the guest finishes the device initialization, the device can be
> removed anytime by the host, and after that the host won't respond to
> the guest's request, so the guest should be prepared to handle this
> case.
> 
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: K. Y. Srinivasan <kys@microsoft.com>
> ---
>  drivers/pci/host/pci-hyperv.c | 46 ++++++++++++++++++++++++++++++++-----------
>  1 file changed, 34 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
> index ad6a64d..248765f 100644
> --- a/drivers/pci/host/pci-hyperv.c
> +++ b/drivers/pci/host/pci-hyperv.c
> @@ -556,6 +556,26 @@ static void put_pcichild(struct hv_pci_dev *hv_pcidev,
>  static void get_hvpcibus(struct hv_pcibus_device *hv_pcibus);
>  static void put_hvpcibus(struct hv_pcibus_device *hv_pcibus);
>  
> +/*
> + * There is no good way to get notified from vmbus_onoffer_rescind(),
> + * so let's use polling here, since this is not a hot path.
> + */
> +static int wait_for_response(struct hv_device *hdev,
> +			     struct completion *comp)
> +{
> +	while (true) {
> +		if (hdev->channel->rescind) {
> +			dev_warn_once(&hdev->device, "The device is gone.\n");
> +			return -ENODEV;
> +		}
> +
> +		if (wait_for_completion_timeout(comp, HZ / 10))
> +			break;
> +	}
> +
> +	return 0;

This is pretty racy, isn't it ? Also, I reckon you should consider the
timeout return value as an error condition unless I am completely
missing the point of what you are doing.

Lorenzo

> +}
> +
>  /**
>   * devfn_to_wslot() - Convert from Linux PCI slot to Windows
>   * @devfn:	The Linux representation of PCI slot
> @@ -1569,7 +1589,8 @@ static struct hv_pci_dev *new_pcichild_device(struct hv_pcibus_device *hbus,
>  	if (ret)
>  		goto error;
>  
> -	wait_for_completion(&comp_pkt.host_event);
> +	if (wait_for_response(hbus->hdev, &comp_pkt.host_event))
> +		goto error;
>  
>  	hpdev->desc = *desc;
>  	refcount_set(&hpdev->refs, 1);
> @@ -2070,15 +2091,16 @@ static int hv_pci_protocol_negotiation(struct hv_device *hdev)
>  				sizeof(struct pci_version_request),
>  				(unsigned long)pkt, VM_PKT_DATA_INBAND,
>  				VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
> +		if (!ret)
> +			ret = wait_for_response(hdev, &comp_pkt.host_event);
> +
>  		if (ret) {
>  			dev_err(&hdev->device,
> -				"PCI Pass-through VSP failed sending version reqquest: %#x",
> +				"PCI Pass-through VSP failed to request version: %d",
>  				ret);
>  			goto exit;
>  		}
>  
> -		wait_for_completion(&comp_pkt.host_event);
> -
>  		if (comp_pkt.completion_status >= 0) {
>  			pci_protocol_version = pci_protocol_versions[i];
>  			dev_info(&hdev->device,
> @@ -2287,11 +2309,12 @@ static int hv_pci_enter_d0(struct hv_device *hdev)
>  	ret = vmbus_sendpacket(hdev->channel, d0_entry, sizeof(*d0_entry),
>  			       (unsigned long)pkt, VM_PKT_DATA_INBAND,
>  			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
> +	if (!ret)
> +		ret = wait_for_response(hdev, &comp_pkt.host_event);
> +
>  	if (ret)
>  		goto exit;
>  
> -	wait_for_completion(&comp_pkt.host_event);
> -
>  	if (comp_pkt.completion_status < 0) {
>  		dev_err(&hdev->device,
>  			"PCI Pass-through VSP failed D0 Entry with status %x\n",
> @@ -2331,11 +2354,10 @@ static int hv_pci_query_relations(struct hv_device *hdev)
>  
>  	ret = vmbus_sendpacket(hdev->channel, &message, sizeof(message),
>  			       0, VM_PKT_DATA_INBAND, 0);
> -	if (ret)
> -		return ret;
> +	if (!ret)
> +		ret = wait_for_response(hdev, &comp);
>  
> -	wait_for_completion(&comp);
> -	return 0;
> +	return ret;
>  }
>  
>  /**
> @@ -2405,11 +2427,11 @@ static int hv_send_resources_allocated(struct hv_device *hdev)
>  				size_res, (unsigned long)pkt,
>  				VM_PKT_DATA_INBAND,
>  				VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
> +		if (!ret)
> +			ret = wait_for_response(hdev, &comp_pkt.host_event);
>  		if (ret)
>  			break;
>  
> -		wait_for_completion(&comp_pkt.host_event);
> -
>  		if (comp_pkt.completion_status < 0) {
>  			ret = -EPROTO;
>  			dev_err(&hdev->device,
> -- 
> 2.7.4
> 
