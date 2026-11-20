Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795143536;
	b=cWFZZ4tuFGcbK8pFnJfj9mfB7kg053VfZoyRC/qOrABBGjzYpWBfAC7/sD/Un1s2nJji
	 54MBiTWcYVNniIl6u88uDFnpiRDxRlBs2drA+ZS9JM2Bsu9r4ZXrRMBJ8IkqUpr8Vyaom
	 ck1mmk3noaWkpp5+0/+w3WuCodwBI8qjNge5M2Z7jDOHYyK3ypFTBR6kRJq6uW4K2c6Hj
	 eQUqEI1eTGyIO3RT70WD0nj+c8WzSybuxpeXycwH4gaUCiUK4WudjxloIcrWyogsyjPRk
	 1Tvb3Zg89cEvuMZmuRjMqdtbQE18f6GbKLQE64YFZrKp5gFLyXZaCZUZUw23sGiHBgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795143536;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=jwjWgtW4kRseoA0zVDGCPLIdUcXknOULKOmu6gYkLdw=;
	b=mpA7oQFN7mt2fQlg3xgxUFqll5veFA0qsWdVJGZIqP6Mhb0ces/hFg9wJwBMP1vrxPNh
	 HSb2AyMDEJ4plrZ/qFJWSzrLRRx66F4hbDVqpE1LDNgA9hmfUT4SXXCzueC1XHUXrwjnz
	 CpsW9SVWIL01kfxhiqCMi+T0IfvcH8qo6fIXO8QrLyL/GaXpqmmOi9hnglZ0xq3rUplpx
	 M9LeD2eCSqtiriH82Zj6HE03cAFmmjgZYdizgRbYWCaLt0vU8FD0XwMHOI8IovFWjI2g/
	 7HX/N5UGbr+HCWm/HeMTP6clXWQ7huKJushdNjkb6jAaMqMY4xLq0wbYUPG/zDnIytg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PPI2Tz45;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8627B606A326;
	Fri, 20 Nov 2026 02:58:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8627B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PPI2Tz45
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795143537; x=1826679537;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hj2txJligqlKIDnOrXcY2GWTzSNfobaEGxDoiQKT+JY=;
  b=PPI2Tz45fCY26IlHxGlcVdrBe9LJcBwKiK+Lr1+Cp6OhwabuGGDATSYZ
   2P/MBq0Y3ywqlWF6sshTrccU6JFoyOK5fB7GqFFudc4Zc5rdODNZlAVk1
   G4YFa5L51tDd7O3r3FoW+YGiIEqoKHX2M/7rr7wfRiPj3n+0uzJ99/uXk
   gQ/yd4+V3EWaNhxI/S+pCOEJdbuENmLlWnGNzsYzGK90K3bT4ism7LI/r
   kRNGYKBgt63o6OcJ4iC3DQqDZL5/lYP916vHkB9nu+0WM/YLSr81W/nbd
   3GA3n2j8o9ENSTiuypXsZv0Ot34UWZe8AKJFgqBcIA8SJ0nWup/3nr1d9
   Q==;
X-CSE-ConnectionGUID: nrH7I9XvTSqg6Se3hh8oAA==
X-CSE-MsgGUID: pHY5ORR6S7OVd0XHKsuKFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3931082"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="3931082"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 18:58:56 -0800
X-CSE-ConnectionGUID: pk12LqTwRhqc5Oao+l9uWg==
X-CSE-MsgGUID: fKSf6pqqQ4++4flk103ZCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="10591451"
Received: from unknown (HELO [10.238.1.144]) ([10.238.1.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 18:58:46 -0800
Message-ID: <0996eead-a63e-4a17-96d3-45ccd48cd4b1@linux.intel.com>
Date: Fri, 20 Nov 2026 10:58:44 +0800
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
Subject: Re: [PATCH v9 08/13] PCI/TSM: Keep connections active while device
 contexts exist
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
 linux-coco@lists.linux.dev
References: <20261116081935.85372-1-aneesh.kumar@kernel.org>
 <20261116081935.85372-9-aneesh.kumar@kernel.org>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20261116081935.85372-9-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/16/2026 4:19 PM, Aneesh Kumar K.V (Arm) wrote:
> Add PCI TEE Security Manager (TSM) contexts that prevent PF0 disconnect
> while in use. Verify that the device is connected to the requested TSM.
> Each successful get returns a separate context and requires a matching
> put. Reject disconnect with -EBUSY until all contexts are released.
> 
> Remove the legacy bind and unbind interface. Device security state is
> managed by the backend, so also remove the associated "bound" sysfs
> attribute and its ABI documentation.

This patch does two things: add pci tsm contexts to keep the pf0 active
while in use, and remove the old device bind/unbind interface. Could
these changes be split into separate patches? That would make the
changes easier to review.

> 
> Cc: Bjorn Helgaas<bhelgaas@google.com>
> Cc:linux-pci@vger.kernel.org
> Cc: Alexey Kardashevskiy<aik@amd.com>
> Cc: Jason Gunthorpe<jgg@ziepe.ca>
> Cc: Lukas Wunner<lukas@wunner.de>
> Signed-off-by: Aneesh Kumar K.V (Arm)<aneesh.kumar@kernel.org>
> ---
>   Documentation/ABI/testing/sysfs-bus-pci |  15 +-
>   drivers/pci/tsm/core.c                  | 227 ++++++++++--------------
>   include/linux/pci-tsm.h                 |  71 +++++---
>   3 files changed, 136 insertions(+), 177 deletions(-)

Thanks,
baolu
