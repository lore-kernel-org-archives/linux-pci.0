Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794479525;
	b=WbYOfzL3WMbNlgjYJp7qWtYGvStmSuj+CSqfc/K/eDdHfV6hU9yNz8O3yruz4DmVGjNj
	 Rqjz1SByt2mEKKDo49osr8LYhhP3TgcVc4OHVRyP4zsnk3yRcwjHb1FJX2hULpX/fCRDA
	 QvrkqrnRxMvMSqFbuaM57wn+qyRfJBSI/qyNCb6u4NrenXmjLZ2QOBDhJjVNY8P+2G2CQ
	 2goHxUv6bY+DYbISx3LF2z8m7rieDvv4W6GPBaXHWMvzcDszi6JVIcdIbwfDPUUGnhOOq
	 VTZQDPAey+Rl4+SLlPQi/dumHPLQEcipoQ4HrBRkiBf95rWnapUAk9jQGUCW8aFsaPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794479525;
	h=Received:DKIM-Signature:X-Mailer:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type;
	bh=DaFOdktrS9fp8GjCaaexp9MaiiYjCXQTieg0RYTagzo=;
	b=xtf9fL+dXb8tiQaISrdxJhpcJ9SrJrehGscmU2Xl4FO7FDL+crlRjknB3dU5ZRK0hBbV
	 TUd+lEzwS6ONOrmYxPeiffrPSsQW+GiweFE0RzY/RZZ+KEzXeZyz+gMD3bknadlTPj4+1
	 sv9Rmgppl7n1BJ37ZdtkdudVzVrDzZMnBHN3FbCznk5fiORCK5PXPxaabBZIqFL3Ybdl8
	 5n6bHyaWDg0lhC8VpVp0AmsgF9t0EdPsLGYIMpEI627elu1aUqqJrXu0+kiXgZE3wZLxk
	 KPC30mv5P4+OF9JoJ+UUZ478xiaeBPnMus7ZUaFmFisn+D147Ru4N+mCr4iDbUkeZ8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SVCKZF+a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51DA606A32A;
	Thu, 12 Nov 2026 10:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SVCKZF+a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9843A1F00A05;
	Thu, 12 Nov 2026 10:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794479525;
	bh=DaFOdktrS9fp8GjCaaexp9MaiiYjCXQTieg0RYTagzo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=SVCKZF+auGmqT7JSUb746d9UAYnxXK8NWFfq/0oYpoErPWvB81l2FLR7ZNtt1TzRs
	 SOfI8u76neTSvF2w5qbIOVuKL+j0Qdh6z4NfLSuKTzJC1HYiLRrvVCW+ItdeGsyYhB
	 0xlkYqobVHgprk7YC6bfI9EaNr8ah+XrX4cNJm0+dsmvib7BsjEv9Z3jN2rLkg2sGR
	 MI32t1e5nR4llWY0pS55Dcb/MdeZz4OkIAu7g3AqoCR6aOMCNrkFy4bHY133gLUfKu
	 NvKAmHPiobyEkFiawUS89SUAGf2RECSFN4yWnkCah3YSfAeSzsWc22rZpjE4HCsa5S
	 l3Qlv9hfTFjNQ==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: "Tian, Kevin" <kevin.tian@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Cc: Alex Williamson <alex@shazbot.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Krishna Reddy <vdumpa@nvidia.com>,
	Lukas Wunner <lukas@wunner.de>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Steven Price <steven.price@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: RE: [PATCH v8 11/15] iommufd/viommu: Select vIOMMU operations
 before allocation
In-Reply-To: <SA2PR11MB4844544BB238847916EA3A038C762@SA2PR11MB4844.namprd11.prod.outlook.com>
References: <20261104161632.3547423-1-aneesh.kumar@kernel.org>
 <20261104161632.3547423-12-aneesh.kumar@kernel.org>
 <SA2PR11MB4844544BB238847916EA3A038C762@SA2PR11MB4844.namprd11.prod.outlook.com>
Date: Thu, 12 Nov 2026 16:01:54 +0530
Message-ID: <yq5ay0aypch1.fsf@kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

"Tian, Kevin" <kevin.tian@intel.com> writes:

>> From: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>> Sent: Thursday, November 5, 2026 12:16 AM
>> 
>> Physical IOMMU drivers currently provide the vIOMMU size and
>> initialization callbacks through iommu_ops. The initialization callback
>> then selects and installs the corresponding iommufd_viommu_ops.
>> 
>> Add iommu_ops::get_viommu_ops() to select the operations from the
>> physical device and requested vIOMMU type before allocation. Move the
>> size and initialization callbacks into iommufd_viommu_ops. The core can
>> then validate the selected operations, allocate the driver structure,
>> initialize it, and install the operations.
>> 
>> Convert AMD, Arm SMMUv3, Tegra CMDQV, and the selftest backend to the
>> new interface.
>> 
>> Selecting the operations early allows subsequent changes to use
>> implementation-specific vIOMMU properties, including when validating the
>> parent HWPT.
>
> what does "implementation-specific" mean? Isn't every existing vIOMMU
> type already implementation specific?
>

How about I update this to.

The current code requires a valid parent HWPT before calling
viommu_init(), which selects the vIOMMU operations. A later patch adds
an operations flag indicating that a vIOMMU type does not require a parent
HWPT. Selecting the operations earlier allows the core to check that flag
before deciding whether to look up and validate a parent HWPT.

>
>> 
>>  /*
>>   * This function is assigned to struct
>> iommufd_viommu_ops.alloc_domain_nested()
>> - * during the call to struct iommu_ops.viommu_init().
>> + * when the vIOMMU operations are selected.
>>   */
>>  struct iommu_domain *
>>  amd_iommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32
>> flags,
>
> the comment sounds changing the semantics.
>
> ideally it's still assigned at viommu_init(), just from iommufd_viommu_ops
> instead of iommu_ops now.

How about
 /*
  * This function is assigned to struct iommufd_viommu_ops.alloc_domain_nested()
- * during the call to struct iommu_ops.viommu_init().
+ * during the call to struct iommufd_viommu_ops.viommu_init().
  */

-aneesh
