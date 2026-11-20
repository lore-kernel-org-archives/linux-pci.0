Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795138648;
	b=xKnXwGyAs/PKQLh8Ho71XlAGqwDJQmeBb3j8H2y/Tpja6lVkjPbwQz7ZTN2lZsfgbheC
	 FTW7o5aYBOlTm/mMKfSuCQNYbckF7s4147X+AgKMaz71MY+H+TVw8RVASCLkCQAHBOIkE
	 GBY8IHpLnijILbHMQ6BOeVKcpyOhjhc7T1TVXBLhOU9z6sTqcSFdZzFWsygO9BcnMOhFf
	 iI1GhD9JNhLXaXTNz+TUaNNnwrunVJEMw4T3Bbs+4oefxfpFxts1seAv9lwxbBJVLscdd
	 I3BSw2Q3ATzz2SLWlO8J7U+5tx94sMcMZV5i41tpzpUHSCqdrpss68jIblsiCG7wHew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795138648;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=aRheB04iyX7dVXieUD6PMSF3gXPAOjSc37jCJuLzCOA=;
	b=ORdwvkKbq2DeWCdE7ahPOhFfdlcd46RP4mfMDnn2siDehVmsuZuTqxGFk0bnMAvh5WzV
	 yM/id0AAngKkBNgZNT2qdBuSiqc+CQxW0ejojEffCzhwVe1W0DsHat27z6SqkX2Qx8pWA
	 RDRiA0HcRGJjiTIPoNIOHk7yPtCSkAquh8xUsNBRHpBDm+BOw6mfbzyx14E2Ql9FF6/tB
	 b4gYiZVYXpxi+rgeYVZ2XpT3OryGonaRLkMxQ7SbYqKVB7aifsh0/6ixqn0tZbGMguty3
	 6KOAua0pcNiwb3DSCf4ctEPnEvfyPXoWonRzu06fgnlicJQSXHspQADTRmPD0DGYJsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=F17RyKvR;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1147606A326;
	Fri, 20 Nov 2026 01:37:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1147606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=F17RyKvR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795138647; x=1826674647;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PqF9kZKHLawccCDUzoTo95Nflk56OouMnex8knpthCg=;
  b=F17RyKvRdJJx6cVj0bmnguuXem6fkAbSnMYGEprxP5saW6kLBPkOvK60
   cSGDOxRWLUHOO2o734Aq9rCDcy57/aqc1FbNIXKQjZOqU/pMXaZKmwuCy
   yhKcykitMpShRccmGB4ziEHpV0X/6IziA5DRrob6FhGF/cpeQy+1mHZIF
   v7WpWJJjXg1bGhlMQ/oAmShP4pxku9TwYyHG3xQ1Hd0HeEv7eqaa0QgTe
   TocXQzjnSg6KUoSpSNVHdQN2tXZ4sV4WSlO9iyZL1vj1DIkx4pAee8tUg
   D/1JVk2dJ66jugO6+mDhwNJW6ACmAuDch5bfdo7BbTQOmXycUPXce81fs
   Q==;
X-CSE-ConnectionGUID: vLEIaxkGT56/sHZWBUgU8Q==
X-CSE-MsgGUID: BA/udjwGSF+LcKxjb+a6iA==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3908711"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="3908711"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 17:37:26 -0800
X-CSE-ConnectionGUID: QD2IAhdmTcWXu4GVw/OoQw==
X-CSE-MsgGUID: S+cVzm7cTCGeTTtfiaIvcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="10867899"
Received: from unknown (HELO [10.238.1.144]) ([10.238.1.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 17:37:20 -0800
Message-ID: <e97e2e79-02e8-42c5-861b-a78636bcba0d@linux.intel.com>
Date: Fri, 20 Nov 2026 09:37:17 +0800
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
 linux-tegra@vger.kernel.org, patches@lists.linux.dev,
 Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v9 07/13] PCI/TSM: Remove the legacy guest request
 interface
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
 linux-coco@lists.linux.dev
References: <20261116081935.85372-1-aneesh.kumar@kernel.org>
 <20261116081935.85372-8-aneesh.kumar@kernel.org>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20261116081935.85372-8-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/16/2026 4:19 PM, Aneesh Kumar K.V (Arm) wrote:
> Guest TSM requests can now be dispatched through the IOMMUFD
> IOMMU_VDEVICE_OP ioctl. Remove the PCI-device-based guest request entry
> point, its scope enum and the corresponding PCI/TSM driver callback.
> 
> 
> Cc: Bjorn Helgaas<bhelgaas@google.com>
> Cc:linux-pci@vger.kernel.org
> Cc: Alexey Kardashevskiy<aik@amd.com>
> Cc: Lukas Wunner<lukas@wunner.de>
> Reviewed-by: Jason Gunthorpe<jgg@nvidia.com>
> Signed-off-by: Aneesh Kumar K.V (Arm)<aneesh.kumar@kernel.org>
> ---
>   drivers/pci/tsm/core.c  | 60 ----------------------------------------
>   include/linux/pci-tsm.h | 61 +----------------------------------------
>   2 files changed, 1 insertion(+), 120 deletions(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
