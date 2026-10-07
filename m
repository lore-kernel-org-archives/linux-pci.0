Received: from sender6-pp-o94.zoho.com (sender6-pp-o94.zoho.com [165.173.180.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B253B4746BA;
	Wed,  7 Oct 2026 12:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791376224; cv=pass; b=ciWf/1jIrUfd8XilYWkGl/+j6T3IgSUQz+Z8QzCKegBu6qB8Vl1T3XuVZpS/vE8Hkv1UowBusRJrdMrVPLrGRcqSYtSWiGxz06mv7gsMBQBHmRWOtlWqOzxAFJRwG5dymHxKPYcdGvE4/vtF3/4elHBsqWb7+K2saiZcOBVhDJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791376224; c=relaxed/simple;
	bh=2YmTwrPprp+eP4w2noKc5/nxe09isVqPOLh+GN4kr+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=If44DCeTDoqEhC9dJaf7Ezlpf3RfR+banivqUocoZ5OQr+SJjSnS9UIyiMEeuJpaDdYjJldlNzd30oDtPgBynhFCelgCIRNBVgfeDxjAVp1LxCqB0jvPFQa7gtBY17oVJlItCI5UdcIlHLgYlzkKtFVRKY7RcHzv69J0ext7df0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=RNBDwlx7; arc=pass smtp.client-ip=165.173.180.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="RNBDwlx7"
ARC-Seal: i=1; a=rsa-sha256; t=1791376203; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=awF1gKmo9vqF0dE+zVeVfut7cEGQBFOMCs/uTn+gqS6d0iM9nWhouKDs4yKRTS5C+8tEBhDHVSEVLRnHYeY48iFA8PDk/mcdm5fJPhrYzY+0D3jMa90osB2tKH+IhNSlrsyuvWz/uYlNYUGysn3TL9hIIvePEpermOYPefWkdGU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1791376203; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WuaR6SwNLswFyflkkWn+8kga4fm9ihedFdgFP+68sjw=; 
	b=IJ7dbRWLg3apXLfsLr2hiON5PWKSJficPArTPa9X7VGb9VyQne+k7VMZQOkadMHfMIlXvEIomYL4LTo+0sW/gSWMnj58SEaGUoli57kpNRiiEFLVFdruTAe/s0ghiqEBzroOw7J/mgH5ln9aU59CusuG/ROgRSa4Rd5pycXv5Ho=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791376203;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=WuaR6SwNLswFyflkkWn+8kga4fm9ihedFdgFP+68sjw=;
	b=RNBDwlx7xgxxRwExerTXiykVmdddeR6DV/WTSDegC6DE262/8qtdUUSpmOxcLx7E
	9ErJlbALtmBn8VU2MCqWGGDC47sfTJe3ZylnnvUPkLw+pt9mX1LYJh46Jws1ICs0cBj
	gWk488EHgnK9JEQvpgsK0/nkqV+zjWXBufv27V78=
Received: by smtp.zohomail.com with SMTPS id 1791376202063656.6378742924468;
	Wed, 7 Oct 2026 05:30:02 -0700 (PDT)
Message-ID: <cd9b6a2d-8240-4e4c-8729-f4eb86f8df5c@zohomail.com>
Date: Wed, 7 Oct 2026 20:29:54 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 03/16] cxl: Move decoder declarations to shared header
To: Srirangan Madhavan <smadhavan@nvidia.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <jic23@kernel.org>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
References: <20261001092227.3004747-1-smadhavan@nvidia.com>
 <20261001092227.3004747-4-smadhavan@nvidia.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20261001092227.3004747-4-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu080112273f74bd0c6011bebc539a44d60000c9c65a8adc82e506d68e3e299ae00fb8826674117c6d90b350:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/10/1 17:22, Srirangan Madhavan 写道:
> Move the common decoder declarations to include/cxl/cxl.h for use by
> shared decoder settings. Preserve their layout and documentation.
>
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>

> ---
>   drivers/cxl/cxl.h | 37 -------------------------------------
>   include/cxl/cxl.h | 41 ++++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 40 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 9e0500d56866..44ff3334648c 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -264,45 +264,8 @@ int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
>   #define CXL_DECODER_F_NORMALIZED_ADDRESSING BIT(6)
>   #define CXL_DECODER_F_RESET_MASK (CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK)
>   
> -enum cxl_decoder_type {
> -	CXL_DECODER_DEVMEM = 2,
> -	CXL_DECODER_HOSTONLYMEM = 3,
> -};
> -
> -#define CXL_DECODER_MAX_INTERLEAVE 16
> -
>   #define CXL_QOS_CLASS_INVALID -1
>   
> -/**
> - * struct cxl_decoder - Common CXL HDM Decoder Attributes
> - * @dev: this decoder's device
> - * @id: kernel device name id
> - * @hpa_range: Host physical address range mapped by this decoder
> - * @interleave_ways: number of cxl_dports in this decode
> - * @interleave_granularity: data stride per dport
> - * @target_type: accelerator vs expander (type2 vs type3) selector
> - * @region: currently assigned region for this decoder
> - * @flags: memory type capabilities and locking
> - * @target_map: cached copy of hardware port-id list, available at init
> - *              before all @dport objects have been instantiated. While
> - *              dport id is 8bit, CFMWS interleave targets are 32bits.
> - * @commit: device/decoder-type specific callback to commit settings to hw
> - * @reset: device/decoder-type specific callback to reset hw settings
> -*/
> -struct cxl_decoder {
> -	struct device dev;
> -	int id;
> -	struct range hpa_range;
> -	int interleave_ways;
> -	int interleave_granularity;
> -	enum cxl_decoder_type target_type;
> -	struct cxl_region *region;
> -	unsigned long flags;
> -	u32 target_map[CXL_DECODER_MAX_INTERLEAVE];
> -	int (*commit)(struct cxl_decoder *cxld);
> -	void (*reset)(struct cxl_decoder *cxld);
> -};
> -
>   /*
>    * Track whether this decoder is free for userspace provisioning, reserved for
>    * region autodiscovery, whether it is started connecting (awaiting other
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 802b143de83d..69941f7fdb76 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -5,8 +5,10 @@
>   #ifndef __CXL_CXL_H__
>   #define __CXL_CXL_H__
>   
> +#include <linux/device.h>
>   #include <linux/node.h>
>   #include <linux/ioport.h>
> +#include <linux/range.h>
>   #include <cxl/mailbox.h>
>   
>   /**
> @@ -23,7 +25,44 @@ enum cxl_devtype {
>   	CXL_DEVTYPE_CLASSMEM,
>   };
>   
> -struct device;
> +struct cxl_region;
> +
> +enum cxl_decoder_type {
> +	CXL_DECODER_DEVMEM = 2,
> +	CXL_DECODER_HOSTONLYMEM = 3,
> +};
> +
> +#define CXL_DECODER_MAX_INTERLEAVE 16
> +
> +/**
> + * struct cxl_decoder - Common CXL HDM Decoder Attributes
> + * @dev: this decoder's device
> + * @id: kernel device name id
> + * @hpa_range: Host physical address range mapped by this decoder
> + * @interleave_ways: number of cxl_dports in this decode
> + * @interleave_granularity: data stride per dport
> + * @target_type: accelerator vs expander (type2 vs type3) selector
> + * @region: currently assigned region for this decoder
> + * @flags: memory type capabilities and locking
> + * @target_map: cached copy of hardware port-id list, available at init
> + *              before all @dport objects have been instantiated. While
> + *              dport id is 8bit, CFMWS interleave targets are 32bits.
> + * @commit: device/decoder-type specific callback to commit settings to hw
> + * @reset: device/decoder-type specific callback to reset hw settings
> +*/
> +struct cxl_decoder {
> +	struct device dev;
> +	int id;
> +	struct range hpa_range;
> +	int interleave_ways;
> +	int interleave_granularity;
> +	enum cxl_decoder_type target_type;
> +	struct cxl_region *region;
> +	unsigned long flags;
> +	u32 target_map[CXL_DECODER_MAX_INTERLEAVE];
> +	int (*commit)(struct cxl_decoder *cxld);
> +	void (*reset)(struct cxl_decoder *cxld);
> +};
>   
>   /*
>    * Using struct_group() allows for per register-block-type helper routines,
