Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E7D33F399;
	Tue, 27 Jan 2026 10:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769510211; cv=none; b=UxPQN842W1z0UjyTM/fmxNizd4bCuTPnYz1+BGsfuB0bjydS/qBeBRTLj/KrAEaw1lbJ1DQmlG0rZXiUX0yywnWN9yu/c4wDFcnEmxdaIp4gpmv4Qd2gAo7NO2/LtfNym0Y+w1p8Q27hHPvqfUpN1bNvDds7EUQMlN1BYbAKz+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769510211; c=relaxed/simple;
	bh=O6KDmyjHji6Ru/02ierm4133b0yaAcNLA3z6fnIILA4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rawn+FSDkdxM25ZZcyuTtZ7pWbJbsnDJov/FIuX09ZsofOSJP5EVsGf2207wXQxDtdGvQFRViS91PeWaDdN44urJQpx5ys2LiSRtvgkxtjie0/Pjh6/q+H+Bv/tOSBcXPyWgUJVwT0adQz0DbajJbV2nbvJVb8XOGRxzogy1rCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f0hdX38ZCzHnGck;
	Tue, 27 Jan 2026 18:36:00 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id CA3CE4056A;
	Tue, 27 Jan 2026 18:36:45 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 27 Jan
 2026 10:36:45 +0000
Date: Tue, 27 Jan 2026 10:36:43 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <bhelgaas@google.com>, <kbusch@kernel.org>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <mahesh@linux.ibm.com>,
	<oohall@gmail.com>, <terry.bowman@amd.com>, <tianruidong@linux.alibaba.com>,
	<lukas@wunner.de>
Subject: Re: [PATCH v7 3/5] PCI/AER: Report fatal errors of RCiEP and EP if
 link recoverd
Message-ID: <20260127103643.00007991@huawei.com>
In-Reply-To: <20260124074557.73961-4-xueshuai@linux.alibaba.com>
References: <20260124074557.73961-1-xueshuai@linux.alibaba.com>
	<20260124074557.73961-4-xueshuai@linux.alibaba.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Sat, 24 Jan 2026 15:45:55 +0800
Shuai Xue <xueshuai@linux.alibaba.com> wrote:

> The AER driver has historically avoided reading the configuration space of
> an endpoint or RCiEP that reported a fatal error, considering the link to
> that device unreliable. Consequently, when a fatal error occurs, the AER
> and DPC drivers do not report specific error types, resulting in logs like:
> 
>   pcieport 0015:00:00.0: EDR: EDR event received
>   pcieport 0015:00:00.0: EDR: Reported EDR dev: 0015:00:00.0
>   pcieport 0015:00:00.0: DPC: containment event, status:0x200d, ERR_FATAL received from 0015:01:00.0
>   pcieport 0015:00:00.0: AER: broadcast error_detected message
>   pcieport 0015:00:00.0: AER: broadcast mmio_enabled message
>   pcieport 0015:00:00.0: AER: broadcast resume message
>   pcieport 0015:00:00.0: pciehp: Slot(21): Link Down/Up ignored
>   pcieport 0015:00:00.0: AER: device recovery successful
>   pcieport 0015:00:00.0: EDR: DPC port successfully recovered
>   pcieport 0015:00:00.0: EDR: Status for 0015:00:00.0: 0x80
> 
> AER status registers are sticky and Write-1-to-clear. If the link recovered
> after hot reset, we can still safely access AER status and TLP header of the
> error device. In such case, report fatal errors which helps to figure out the
> error root case.
> 
> After this patch, the logs like:
> 
>   pcieport 0015:00:00.0: EDR: EDR event received
>   pcieport 0015:00:00.0: EDR: Reported EDR dev: 0015:00:00.0
>   pcieport 0015:00:00.0: DPC: containment event, status:0x200d, ERR_FATAL received from 0015:01:00.0
>   pcieport 0015:00:00.0: AER: broadcast error_detected message
> + vfio-pci 0015:01:00.0: AER: Errors reported prior to reset
> + vfio-pci 0015:01:00.0: PCIe Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
> + vfio-pci 0015:01:00.0:   device [144d:a80a] error status/mask=00001000/00400000
> + vfio-pci 0015:01:00.0:    [12] TLP                    (First)
> + vfio-pci 0015:01:00.0: AER:   TLP Header: 0x4a004010 0x00000040 0x01000000 0xffffffff
>   pcieport 0015:00:00.0: AER: broadcast mmio_enabled message
>   pcieport 0015:00:00.0: AER: broadcast resume message
>   pcieport 0015:00:00.0: pciehp: Slot(21): Link Down/Up ignored
>   pcieport 0015:00:00.0: AER: device recovery successful
>   pcieport 0015:00:00.0: EDR: DPC port successfully recovered
>   pcieport 0015:00:00.0: EDR: Status for 0015:00:00.0: 0x80
> 
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Hi Shuai,

With the structure zeroed below (just to make this easier to review, not because
there is a bug as far as I can see)
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index e0bcaa896803..4c0a2bbe9197 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c

> @@ -1447,17 +1450,38 @@ int aer_get_device_error_info(struct aer_err_info *info, int i)
>  	return 1;
>  }
>  
> +void aer_report_frozen_error(struct pci_dev *dev)
> +{
> +	struct aer_err_info info;
> +	int type = pci_pcie_type(dev);
> +
> +	if (type != PCI_EXP_TYPE_ENDPOINT && type != PCI_EXP_TYPE_RC_END)
> +		return;
> +

struct aer_err_info has a bunch of fields. I'd just make sure it's zeroed
to avoid us having to check that they are all filled in. = {};
or do it with the initial values being assigned.

	info = (struct aer_err_info) {
		.err_dev_num = 0,
		.severity = AER_FATAL,
		.level = KERN_ERR,
	};
	add_error_device(&info, dev);


> +	info.error_dev_num = 0;
> +	info.severity = AER_FATAL;
> +	info.level = KERN_ERR;
> +	add_error_device(&info, dev);
> +
> +	if (aer_get_device_error_info(&info, 0, true)) {
> +		pci_err(dev, "Errors reported prior to reset\n");
> +		aer_print_error(&info, 0);
> +	}
> +
> +	pci_dev_put(dev); /* pairs with pci_dev_get() in add_error_device() */
> +}

