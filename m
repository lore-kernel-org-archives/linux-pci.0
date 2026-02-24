Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C2F3A7826;
	Tue, 24 Feb 2026 15:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771948669; cv=none; b=YBBJX60BiXCAfnPUebU3VDVKzeys2apVG/6zCWsHepaOoK9Tsu8DlplMlGsQyPtYoRnEJVygIKs1eSKoaH8q+N9Fk3JunlwBdM8YzUyuPJQ1EGkEwXLD+jZCgfl25kkxdaA608dFyFm6vBSkow1rXExyPsTSOno/rp/DwFUxA6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771948669; c=relaxed/simple;
	bh=3HmCSU8v0qUIZEPgi6VtfWbbw6DAODzcruLTpi09h4E=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AdAW8Ybl1j+XjkWlKMKdwaVmF/3P+IGhkj9IH4Sat3ocYs7sT/wOQm44PLLMpAJNlsyHqkFzUL0V52zBxumHrqbPprsrmZZcL0kZJxtKOhoTPH7GVvKAgE24oWX6h44EwOZrWE+k6RhgBHSw/GhrtZk83DdEFVHg1IaUE1Dwny4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fL2RQ5VB5zJ46Zj;
	Tue, 24 Feb 2026 23:57:22 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 8DCEA40539;
	Tue, 24 Feb 2026 23:57:44 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 24 Feb
 2026 15:57:43 +0000
Date: Tue, 24 Feb 2026 15:57:42 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Nicolin Chen <nicolinc@nvidia.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <bhelgaas@google.com>, <joro@8bytes.org>,
	<praan@google.com>, <baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<miko.lenczewski@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 3/3] iommu/arm-smmu-v3: Allow ATS to be always on
Message-ID: <20260224155742.00000282@huawei.com>
In-Reply-To: <aZ261odHq5gwQYXg@nvidia.com>
References: <cover.1771886695.git.nicolinc@nvidia.com>
	<bdeebd35e81cfa5f76d16706a775b23ee1f01fdd.1771886695.git.nicolinc@nvidia.com>
	<20260224120615.00003ad9@huawei.com>
	<aZ261odHq5gwQYXg@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Tue, 24 Feb 2026 10:51:02 -0400
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Feb 24, 2026 at 12:06:15PM +0000, Jonathan Cameron wrote:
> 
> > In my head at least, it would be nice if a driver had to explicitly opt in
> > to this behavior. The presence of CXL.cache support for instance doesn't
> > actually mean the driver is going to enable it.  However it is probably
> > harmless so lets go with this as path of least resistance.  
> 
> That same remark applies to ATS in general, we have no idea if the
> device is going to use it when turned on or not..

Yup. Understood. That's the bit that smells bad to me.

> 
> Generally Linux has taken the approach of almost always enabling ATS
> if the device offers the PCIe capability.
> 
> The purpose of this series is to close of the few "almost" cases so it
> is always on.
Absolutely understood.  I just took the opportunity to moan!

J
> 
> Jason
> 

