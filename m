Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60999 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750785AbbCDUtE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 4 Mar 2015 15:49:04 -0500
From: Bandan Das <bsd@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] vfio-pci: Allow PCI IDs to be specified as module options
References: <20150304194711.26766.75450.stgit@gimli.home>
	<20150304200243.26766.556.stgit@gimli.home>
Date: Wed, 04 Mar 2015 15:49:02 -0500
In-Reply-To: <20150304200243.26766.556.stgit@gimli.home> (Alex Williamson's
	message of "Wed, 04 Mar 2015 13:02:43 -0700")
Message-ID: <jpgy4ncv681.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Alex,

Alex Williamson <alex.williamson@redhat.com> writes:
...
> +		if (fields < 2) {
> +			pr_warn("vfio-pci: invalid id string \"%s\"\n", id);
> +			continue;
> +		}
> +
> +		pr_info("vfio-pci: add %04X:%04X sub=%04X:%04X cls=%08X/%08X\n",
> +			vendor, device, subvendor, subdevice,
> +			class, class_mask);
> +
> +		rc = pci_add_dynid(&vfio_pci_driver, vendor, device,
> +				   subvendor, subdevice, class, class_mask, 0);
> +		if (rc)
> +			pr_warn("vfio-pci: failed to add dynamic id (%d)\n",
> +				rc);
Just a minor observation - maybe we should print out the
vendor/device/subvendor/subdevice as part of the failure message too. The info
message could potentially get lost in a system with high syslog traffic.

Bandan

> +	}
> +}
> +
>  static int __init vfio_pci_init(void)
>  {
>  	int ret;
> @@ -1053,6 +1097,8 @@ static int __init vfio_pci_init(void)
>  	if (ret)
>  		goto out_driver;
>  
> +	vfio_pci_fill_ids();
> +
>  	return 0;
>  
>  out_driver:
>
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
