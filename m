Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAB03B5842
	for <linux-pci@vger.kernel.org>; Mon,  9 Mar 2026 16:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773074533; cv=none; b=AxGwQSB39qDtOeNkRsHwurpr5XBPP/VOJb7YVFWdCyeZswDC07amk55F4g5pGwWEo/RTaIRZxupSCuv2WIYccAbZJL5HDR902T38U7rtzA+sp16x7PiLdOQxVfDYecMaDZI2gQkBzGcwIv0DGty1uch87fqzzQfKE8mJTPeY8ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773074533; c=relaxed/simple;
	bh=oJXexXiXWMbqytYDDRKnVOmd8MImhm52sVrSz9CvGXw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M8xYHjZvnJuTYkoBd9b4HA3ZkgB6zpzbjmtSeC3yYzm80RpGWTzbjMtPYXH3QIEVwDwAXvMrheKlyeEzQscfPbswssGkoodQwSqphY8wIg8TTsRmHtlAL1rhF55MXkaNoT8sz4N9c7bGlyE8oFJNXNDVDjgZUze6miX20Ddp5ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fV2q14mzpzHnH44;
	Tue, 10 Mar 2026 00:42:05 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id B356C40569;
	Tue, 10 Mar 2026 00:42:09 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 9 Mar
 2026 16:42:08 +0000
Date: Mon, 9 Mar 2026 16:42:07 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <aik@amd.com>, <aneesh.kumar@kernel.org>,
	<yilun.xu@linux.intel.com>, <bhelgaas@google.com>, <alistair23@gmail.com>,
	<lukas@wunner.de>, <jgg@nvidia.com>, Christoph Hellwig <hch@lst.de>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin
 Murphy <robin.murphy@arm.com>, Roman Kisel <romank@linux.microsoft.com>,
	Samuel Ortiz <sameo@rivosinc.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v2 03/19] device core: Introduce confidential device
 acceptance
Message-ID: <20260309164207.00006b3b@huawei.com>
In-Reply-To: <20260303000207.1836586-4-dan.j.williams@intel.com>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
	<20260303000207.1836586-4-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Mon,  2 Mar 2026 16:01:51 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> An "accepted" device is one that is allowed to access private memory within
> a Trusted Computing Boundary (TCB). The concept of "acceptance" is distinct
> from other device properties like usb_device::authorized, or
> tb_switch::authorized. The entry to the accepted state is a violent
> operation in which the device will reject MMIO requests that are not
> encrypted, and the device enters a new IOMMU protection domain to allow it
> to access addresses that were previously off-limits.
> 
> Subsystems like the DMA mapping layer, that need to modify their behavior
> based on the accept state, may only have access to the base 'struct
> device'. It is also likely that the concept of TCB acceptance grows beyond
> PCI devices over time. For these reasons, introduce the concept of
> acceptance in 'struct device_private' which is device common, but only
> suitable for buses and built-in infrastructure to consume.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Roman Kisel <romank@linux.microsoft.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Samuel Ortiz <sameo@rivosinc.com>
> Cc: Alexey Kardashevskiy <aik@amd.com>
> Cc: Xu Yilun <yilun.xu@linux.intel.com>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Seems reasonable to me.
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
