Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC87338BF60;
	Tue, 24 Feb 2026 12:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771934784; cv=none; b=C1hV+AeifO+y3etUjPnX1qsNCObi5jfIqpFiYErlcsOeDxRUkiqh7JoTuzT673f4/XgxuIPXane6roV6JG5qeV70KwEd0eCdBrwklukzrXK/JtypVsDE1YG9/OVUYbUHC/1G9j9mZuC1Mb4urxQtUDD4w/JyyHHmE2cFxcATghU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771934784; c=relaxed/simple;
	bh=QxllERUzHwOPwlHsC7EYkE7GrjX59tt0xvN6u0A1JUE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PIbtgci1GO7Ee0KXrA192zpOlZtMq16UYpAR6ZIfU+80bSMCyjSGqNl7q3a0811ussTeAyLjsOF8L0j9mtj62lCwD5pfr2GWlOAM8QowAO/P4hrPUi8QaIj7jbfV/2CvTz+aAMrcQkU4Qyyv0Ak2cdYHoUBcjHfiYO5sRs+w4dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fKxJN1R30zJ46fX;
	Tue, 24 Feb 2026 20:05:56 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id B598340539;
	Tue, 24 Feb 2026 20:06:17 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 24 Feb
 2026 12:06:16 +0000
Date: Tue, 24 Feb 2026 12:06:15 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: <jgg@nvidia.com>, <will@kernel.org>, <robin.murphy@arm.com>,
	<bhelgaas@google.com>, <joro@8bytes.org>, <praan@google.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<miko.lenczewski@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 3/3] iommu/arm-smmu-v3: Allow ATS to be always on
Message-ID: <20260224120615.00003ad9@huawei.com>
In-Reply-To: <bdeebd35e81cfa5f76d16706a775b23ee1f01fdd.1771886695.git.nicolinc@nvidia.com>
References: <cover.1771886695.git.nicolinc@nvidia.com>
	<bdeebd35e81cfa5f76d16706a775b23ee1f01fdd.1771886695.git.nicolinc@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Mon, 23 Feb 2026 14:52:22 -0800
Nicolin Chen <nicolinc@nvidia.com> wrote:

> When a device's default substream attaches to an identity domain, the SMMU
> driver currently sets the device's STE between two modes:
> 
>   Mode 1: Cfg=Translate, S1DSS=Bypass, EATS=1
>   Mode 2: Cfg=bypass (EATS is ignored by HW)
> 
> When there is an active PASID (non-default substream), mode 1 is used. And
> when there is no PASID support or no active PASID, mode 2 is used.
> 
> The driver will also downgrade an STE from mode 1 to mode 2, when the last
> active substream becomes inactive.
> 
> However, there are PCIe devices that demand ATS to be always on. For these
> devices, their STEs have to use the mode 1 as HW ignores EATS with mode 2.
> 
> Change the driver accordingly:
>   - always use the mode 1
>   - never downgrade to mode 2
>   - allocate and retain a CD table (see note below)
> 
> Note that these devices might not support PASID, i.e. doing non-PASID ATS.
> In such a case, the ssid_bits is set to 0. However, s1cdmax must be set to
> a !0 value in order to keep the S1DSS field effective. Thus, when a master
> requires ats_always_on, set its s1cdmax to minimal 1, meaning the CD table
> will have a dummy entry (SSID=1) that will be never used.
> 
> Now, for these device, arm_smmu_cdtab_allocated() will always return true,
> v.s. false prior to this change. When its default substream is attached to
> an IDENTITY domain, its first CD is NULL in the table, which is a totally
> valid case. Thus, add "!master->ats_always_on" to the condition.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

In my head at least, it would be nice if a driver had to explicitly opt in
to this behavior. The presence of CXL.cache support for instance doesn't
actually mean the driver is going to enable it.  However it is probably
harmless so lets go with this as path of least resistance.

One trivial thing inline (ignore if you like!) Otherwise LGTM
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 4d00d796f0783..69d40918bc22f 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c

> @@ -3274,7 +3294,10 @@ static void arm_smmu_attach_dev_ste(struct iommu_domain *domain,
>  		.old_domain = old_domain,
>  		.ssid = IOMMU_NO_PASID,
>  	};
> +	bool ats_always_on = false;
>  
> +	if (master->ats_always_on && s1dss != STRTAB_STE_1_S1DSS_TERMINATE)
> +		ats_always_on = true;
Maybe flatten this to not do the off then on dance.

	bool ats_always_on = master->ats_always_on && s1dss != STRTAB_STE_1_S1DSS_TERMINATE;


