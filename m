Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795153186;
	b=2inuGccm+61WAlCDWZJ01KOwtjksPkYHeQ6Iibme85zkcQITjDOGQ13vYTGc+dSjrv3Y
	 iVFtxCE/S2v6Roi9AxE0ilSs8YAkR7xlMRcFm4mpsijos4fFLtj6SJ3O7ny/M7Ew7e6NR
	 yEdytRLpv+8vND354f3Ys2CVrzjL/LIRdaHG/HX1wjUg+Hkpg30GlOgdca3dAqg+7Osmo
	 3SKD828VBZ4tuyQXrIDGrqUtTt5kkGYJVhTa05exmxXi7XZkARdxmj1b3gu2PY8GQQSxW
	 Dm2ITb607CuPFA6HRdIxorOW74D0lBWHxSG5jOd1uvmOsNNW1i3L3RpclhaOre1QC9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795153186;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=ElvNMLPb9nWTefCnh+Wvm1TWF1EkTveOzrAIj5NeSzA=;
	b=bR5lYuxVucIT+zSppDcadBeyfG2wZzhtJS6ppg6mnUKauRuL0cSxNAKBANDuUF9tOCTE
	 8l2qI7DxD25HbfkuspJgUFNJGE4RDFlyATsvKIkyGOx8L00EmWttJ4ltAO2euTY/OIlFP
	 4erjZ/VDvYea4ix3k/I4p7D4ON7HMnOGuKaVZveEipHLK7SR6a3o8LPLUm6f/qnbfWHmR
	 tRkWFatx+0l7TXzPN8DFjnX+9QwokoMsjJjnn1LCh5Nlc8iYV3lqPKVJhjQNpARc2FihE
	 cYfSqtiN6RWJbdY5JuSXj59hwYaSMl1sDcB8CmIDV6LorSEfrKzie+WFgxVgaDbdVEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=l3wTozIw;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA32606A325;
	Fri, 20 Nov 2026 05:39:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAA32606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=l3wTozIw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795153186; x=1826689186;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JOXloh/WTQ18M0f0+orJ8jQWk9eyZPfHxhSzgmLwgig=;
  b=l3wTozIwOlQzZcAXQL7AANbVSETjXCnF+BlPDw7BG/vVoi+UTII+0z2C
   9s2swZ8PNkbi2D28lgJuT7myndMdAFiS/LjdTafX3c2fSFAH/cyWb/KWi
   KHTL6mO/VhZY9ASGCCVaHniMXUV8Df3zFhM8HJmKN7KaKe55OZDuay46U
   FMWIs/l2sGChWtMbWIQ4MEow5FTsi0aXVDZ6FHF2wArUeG3VSrWs8WtTk
   iix+4eG00KcUsNpv7x2NS9QOD9AOcym5m8HCljZzep9p3HDxBVX4of6up
   SZvpIhGWcA+26+4oLLSMwyaKPGvQuq6RKfcrNXJO8iiiwz0winuOQHc0J
   Q==;
X-CSE-ConnectionGUID: DE6hYKnITSKP6NJL3OZ2gg==
X-CSE-MsgGUID: PlkqC3YBQKiGkJyFx2C+0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3926486"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="3926486"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 21:39:45 -0800
X-CSE-ConnectionGUID: NCD7hbrERneuQrgdNmaJMQ==
X-CSE-MsgGUID: qCE/ag8EST2VFpCAsOOiuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="12327914"
Received: from unknown (HELO [10.238.1.144]) ([10.238.1.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 21:39:36 -0800
Message-ID: <2d8af908-4dd5-43a9-b618-d1ee4189f6ba@linux.intel.com>
Date: Fri, 20 Nov 2026 13:39:34 +0800
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Alex Williamson <alex@shazbot.org>,
 Alexey Kardashevskiy <aik@amd.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Joerg Roedel <joro@8bytes.org>, Jonathan Cameron <jic23@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
 Krishna Reddy <vdumpa@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
 Nicolin Chen <nicolinc@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
 Samuel Ortiz <sameo@rivosinc.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Steven Price <steven.price@arm.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Thierry Reding <thierry.reding@kernel.org>,
 Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
 Xu Yilun <yilun.xu@linux.intel.com>, Ashish Kalra <ashish.kalra@amd.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, iommu@lists.linux.dev,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-tegra@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v9 10/13] iommufd/viommu: Allow PCI TSM backends to
 provide vIOMMU operations
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
 linux-coco@lists.linux.dev
References: <20261116081935.85372-1-aneesh.kumar@kernel.org>
 <20261116081935.85372-11-aneesh.kumar@kernel.org>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20261116081935.85372-11-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/16/2026 4:19 PM, Aneesh Kumar K.V (Arm) wrote:
> In confidential-computing configurations, a vIOMMU may be implemented by
> a TSM driver rather than by the physical IOMMU driver. Such an
> implementation also needs the TSM identity when creating and validating
> vdevices.
> 
> Allow VIOMMU_ALLOC to first query the TSM associated with the target PCI
> device for vIOMMU operations. Fall back to the physical IOMMU driver
> when the TSM does not provide operations for the requested vIOMMU type.
> 
> Resolve the PCI TSM association under pci_tsm_rwsem, take a TSM device
> reference, and pin the module providing the operations. Store the TSM
> device in the vIOMMU. Release the device reference and module pin on
> allocation failure, fallback to the physical IOMMU driver, or vIOMMU
> destruction. Drop the device reference before releasing the module pin,
> since the final put may call into the backend module.
> 
> The device reference preserves the TSM allocation. Backends providing
> vIOMMU operations must not unregister their TSM while the module is pinned,
> since the reference does not prevent backend resource teardown.
> 
> Cc: Jason Gunthorpe<jgg@ziepe.ca>
> Cc: Kevin Tian<kevin.tian@intel.com>
> Cc: Joerg Roedel<joro@8bytes.org>
> Cc: Will Deacon<will@kernel.org>
> Cc: Robin Murphy<robin.murphy@arm.com>
> Cc: Bjorn Helgaas<bhelgaas@google.com>
> Cc: Alexey Kardashevskiy<aik@amd.com>
> Cc: Lukas Wunner<lukas@wunner.de>
> Cc: Xu Yilun<yilun.xu@linux.intel.com>
> Cc:iommu@lists.linux.dev
> Cc:linux-pci@vger.kernel.org
> Signed-off-by: Aneesh Kumar K.V (Arm)<aneesh.kumar@kernel.org>
> ---
>   drivers/iommu/iommufd/viommu.c | 35 +++++++++++++++++++++++++++-----
>   drivers/pci/tsm/core.c         | 22 ++++++++++++++++++++
>   drivers/virt/coco/tsm-core.c   | 37 ++++++++++++++++++++++++++++++++++
>   include/linux/iommufd.h        |  2 ++
>   include/linux/pci-tsm.h        | 24 ++++++++++++++++++++++
>   include/linux/tsm.h            | 25 +++++++++++++++++++++++
>   6 files changed, 140 insertions(+), 5 deletions(-)

This change spans both PCI/TSM and IOMMUFD. Could it be split into
separate patches for each subsystem—for example, one adding the TSM
lookup interface and another updating IOMMUFD to use it?

Thanks,
baolu
