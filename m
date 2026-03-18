Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F143D170F;
	Wed, 18 Mar 2026 11:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773834319; cv=none; b=iGj59UHVng8cL8fkQREsFwy5dJTcyP3xHrCCNnf8p9bQcVuK9Ldk1RbAc/LQXcwimHGtR4gyOKRMv90lE2I/qia/z/Ts6sm+2hzxqBfvFMwjFdSNPxo919TabFUY28K594buFkkrGeujvMe3D3oVW70zmVxRzJU2rMTeCEWh1mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773834319; c=relaxed/simple;
	bh=7HTUqEgNoxYYlJYCimlmPf/6F++wW/C+VtXyvOM1RSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CX8A/6htzbhbpi9y9naO95f6rRGZCZvNk2i0cHy2nYoBb4vOJQ3eJ3mwmmw20/tZff3oPoA26IQdjix+HNBkuLxu4gBNnHZx615Kpi6klrVMj0us92rTprHxQK9MWe9car3l44yF5s4IFL4m15aBc7DIS6BIFtkhcFSJXDhqMEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=aGw88IfI; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="aGw88IfI"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773834311; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=E2NdF1QMWjUu0qtpBR8177AKP0EmQ3nxJJ4E1dUpmQs=;
	b=aGw88IfIe8VPw9tuZd1F+YdyJo7CLzhsjof6kyfCQVPqT1UsUrVswXiM9wHhKr9DnyRivJR3ZQQ0xknNr9Ngcu4UNBXu5HyXZB3SlHe+HzokLz1BWWyK0+sWdYrt/BZl9g2e+c98J2uJW8VInJrUsU3Y4gbblPemO9yvR2ZKQJs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0X.EJ6bT_1773834309;
Received: from 30.246.163.250(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X.EJ6bT_1773834309 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 18 Mar 2026 19:45:10 +0800
Message-ID: <b4085354-93e4-4484-8744-d8c7e7718c57@linux.alibaba.com>
Date: Wed, 18 Mar 2026 19:45:19 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] iommu: Add iommu_report_device_broken() to
 quarantine a broken device
To: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
 robin.murphy@arm.com, joro@8bytes.org, bhelgaas@google.com, jgg@nvidia.com
Cc: rafael@kernel.org, lenb@kernel.org, praan@google.com,
 baolu.lu@linux.intel.com, kevin.tian@intel.com,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-pci@vger.kernel.org, vsethi@nvidia.com
References: <cover.1773774441.git.nicolinc@nvidia.com>
 <c5390aeaeccfa86a1c79f26d2c0ff5df380940a4.1773774441.git.nicolinc@nvidia.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <c5390aeaeccfa86a1c79f26d2c0ff5df380940a4.1773774441.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/18/26 3:15 AM, Nicolin Chen wrote:
> When an IOMMU hardware detects an error due to a faulty device (e.g. an ATS
> invalidation timeout), IOMMU drivers may quarantine the device by disabling
> specific hardware features or dropping translation capabilities.
> 
> However, the core-level states of the faulty device are out of sync, as the
> device can be still attached to a translation domain or even potentially be
> moved to a new domain that might overwrite the driver-level quarantine.
> 
> Given that such an error can be likely an ISR, introduce a broken_work per
> iommu_group, and add a helper function to allow driver to report the broken
> device, so as to completely quarantine it in the core.
> 
> Use the existing pci_dev_reset_iommu_prepare() function to shift the device
> to its resetting_domain/blocking_domain. A later pci_dev_reset_iommu_done()
> call will clear it and move it out of the quarantine.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   include/linux/iommu.h |  2 ++
>   drivers/iommu/iommu.c | 59 +++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 61 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 9ba12b2164724..9b5f94e566ff9 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -891,6 +891,8 @@ static inline struct iommu_device *__iommu_get_iommu_dev(struct device *dev)
>   #define iommu_get_iommu_dev(dev, type, member) \
>   	container_of(__iommu_get_iommu_dev(dev), type, member)
>   
> +void iommu_report_device_broken(struct device *dev);
> +

This declaration is inside the #ifdef CONFIG_IOMMU_API section, but
there's no corresponding stub in the #else block. While current
callers (arm-smmu-v3) always have CONFIG_IOMMU_API, for API
completeness, please add a stub.
Thanks.
Shuai
