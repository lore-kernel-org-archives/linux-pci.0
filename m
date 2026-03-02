Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6D34014BA;
	Mon,  2 Mar 2026 14:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772463280; cv=none; b=DoH51BtAD7ep6HSQ9dHlB2SudktPBKB/FSGecM1YeKph4u4bhZ/uf9xu72oIQPqJuW0vondeijSHbvrjgn4PSSqoIu2vGq9PumCv7L7CLH+Z3I/60zVOAkc47KYRN2tAlz7wG68FixFu/rxLZ7KHy2eA/aOY6cX/qd9uQ66lv20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772463280; c=relaxed/simple;
	bh=PWWbqj84w74ygfO+gwepT4UHsgScdDpJJQmJM9KjRTc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r3+viKtVAG2aI1s5l+588PVcSy+hCHGrIO0cAKEXZAvLvFtePPfQGlMin08gjfBLWsq3Zn24fPSOJgqu3uW+xJBF1dgMnik5uFO0eMJqGOGK9hB6lDg6UuBpRsZeW4k+FOqaSV9cSUaTcDQnIQtYalPz4qQ6RWlYtarPmu7SvrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fPhl51Y1VzHnGdP;
	Mon,  2 Mar 2026 22:53:37 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 2C32140086;
	Mon,  2 Mar 2026 22:54:29 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 2 Mar
 2026 14:54:28 +0000
Date: Mon, 2 Mar 2026 14:54:26 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Nicolin Chen <nicolinc@nvidia.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <bhelgaas@google.com>, <joro@8bytes.org>,
	<praan@google.com>, <baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<miko.lenczewski@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 3/3] iommu/arm-smmu-v3: Allow ATS to be always on
Message-ID: <20260302145426.00001960@huawei.com>
In-Reply-To: <aZ3NS4GhxhElWhh2@nvidia.com>
References: <cover.1771886695.git.nicolinc@nvidia.com>
	<bdeebd35e81cfa5f76d16706a775b23ee1f01fdd.1771886695.git.nicolinc@nvidia.com>
	<20260224120615.00003ad9@huawei.com>
	<aZ261odHq5gwQYXg@nvidia.com>
	<20260224155742.00000282@huawei.com>
	<aZ3NS4GhxhElWhh2@nvidia.com>
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

On Tue, 24 Feb 2026 12:09:47 -0400
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Feb 24, 2026 at 03:57:42PM +0000, Jonathan Cameron wrote:
> > On Tue, 24 Feb 2026 10:51:02 -0400
> > Jason Gunthorpe <jgg@nvidia.com> wrote:
> >   
> > > On Tue, Feb 24, 2026 at 12:06:15PM +0000, Jonathan Cameron wrote:
> > >   
> > > > In my head at least, it would be nice if a driver had to explicitly opt in
> > > > to this behavior. The presence of CXL.cache support for instance doesn't
> > > > actually mean the driver is going to enable it.  However it is probably
> > > > harmless so lets go with this as path of least resistance.    
> > > 
> > > That same remark applies to ATS in general, we have no idea if the
> > > device is going to use it when turned on or not..  
> > 
> > Yup. Understood. That's the bit that smells bad to me.  
> 
> Do you have thoughts on when this is a problem (aside from device
> pre-acceptance security already discussed)? So far I haven't heard
> complaining on this point..

Nothing explicit.  It was a very minor smells wrong moan on basis of
assumptions of what an IOMMU is doing in the way of ATS checking if
we have a malicious device.  So principle of not turning anything on
we don't know we need.

Jonathan

> 
> Jason
> 

