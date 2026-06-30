Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC852EBDE9;
	Tue, 30 Jun 2026 03:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782790526; cv=none; b=glIUN0MKwg1Y+BczBnmpOniTwIa1f7S9oh5qPXVEfp5AR7t8jejE2tv9INNKTWo53Nxj6Zp2cLY3o/MG59ga5HXAd3xgQ0DEH6IxmKz4nXinHG7leKVGLm/A+GQutu+8QhVe60VzKhnYAUNfEChexRwOObh4Oih0s4WtGcFOFus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782790526; c=relaxed/simple;
	bh=eOJg98i1zKVxIoQIaHFgp07n99lPyqWnKiqVvNQl9lc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uVs62aMZQ2bamEV/UnGjix20GdcyQtD6BxMW5HZwumSjL2kda83Xp/aZs7EhI0h2xONc+P8Sp2KOZqrmJIXNVaHOTINEeFRNvdZXgGVW9BYbEf2zQb871eatdbPchHmqQpUmqCGOWNGKcg6E1yZWOT4VSdIVI6MS/o/Mp4IAfcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tjLzsrP2; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tjLzsrP2"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782790520; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Q8KcV4BaVP/1tJoj4i1pLu0UFkei8OvR94s+3mBOBDg=;
	b=tjLzsrP2BcvNUBn2FhYncK8ZBXQIVA+ltZFaPOSVUbhj94GBWdkpjvadkqA0S4ipH7IYlR3ENW0QIOdwVYlrQHkEy3kxjhAU9GCwfHwr5e3CLo0vawHD2RWyHve9VRhXchAoj8AfU8EGUqx0W1Azb8sg9Ff6uy4b+FKcSv7ceWM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0X5zUW4B_1782790519;
Received: from 30.246.161.179(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X5zUW4B_1782790519 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 30 Jun 2026 11:35:20 +0800
Message-ID: <2b760949-8004-45e9-a032-e95d4cc27136@linux.alibaba.com>
Date: Tue, 30 Jun 2026 11:35:18 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] perf/dwc_pcie: Add support for Picoheart vendor
 devices
To: Yicong Yang <yang.yicong@picoheart.com>, renyu.zj@linux.alibaba.com,
 will@kernel.org, mark.rutland@arm.com, jic23@kernel.org,
 bhelgaas@google.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jingoohan1@gmail.com, mani@kernel.org, juwenlong@picoheart.com,
 geshijian@picoheart.com, douyufan@picoheart.com
References: <20260629092717.74946-1-yang.yicong@picoheart.com>
 <20260629092717.74946-2-yang.yicong@picoheart.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260629092717.74946-2-yang.yicong@picoheart.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/29/26 5:27 PM, Yicong Yang wrote:
> Add PCI_VENDOR_ID_PICOHEART in pci_ids.h. Update the DWC PCIe
> vendor table with Picoheart PCIe vendorid to enable the PCIe
> PMU support.
> 
> Signed-off-by: Yicong Yang <yang.yicong@picoheart.com>
> ---
>   include/linux/pci_ids.h  | 2 ++
>   include/linux/pcie-dwc.h | 2 ++
>   2 files changed, 4 insertions(+)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 1c9d40e09107..2c17239aacea 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2640,6 +2640,8 @@
>   #define PCI_VENDOR_ID_SUNIX		0x1fd4
>   #define PCI_DEVICE_ID_SUNIX_1999	0x1999
>   
> +#define PCI_VENDOR_ID_PICOHEART		0x20fa
> +
>   #define PCI_VENDOR_ID_HINT             0x3388
>   #define PCI_DEVICE_ID_HINT_VXPROII_IDE 0x8013
>   
> diff --git a/include/linux/pcie-dwc.h b/include/linux/pcie-dwc.h
> index 8ff778e7aec0..b0ccb2ad74db 100644
> --- a/include/linux/pcie-dwc.h
> +++ b/include/linux/pcie-dwc.h
> @@ -32,6 +32,8 @@ static const struct dwc_pcie_vsec_id dwc_pcie_rasdes_vsec_ids[] = {
>   	  .vsec_id = 0x02, .vsec_rev = 0x4 },
>   	{ .vendor_id = PCI_VENDOR_ID_SAMSUNG,
>   	  .vsec_id = 0x02, .vsec_rev = 0x4 },
> +	{ .vendor_id = PCI_VENDOR_ID_PICOHEART,
> +	  .vsec_id = 0x02, .vsec_rev = 0x4 },
>   	{}
>   };
>   

Hi Yicong,

The pci_ids.h part looks good to me. Minor, the new entry in
pcie-dwc.h breaks the alphabetical ordering of the table

Could you please move the PICOHEART entry between AMPERE and QCOM to
keep the list sorted alphabetically?

With that fixed,

Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Thanks.
Shuai
