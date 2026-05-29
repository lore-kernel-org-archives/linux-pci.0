Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B2F3A4F35;
	Fri, 29 May 2026 06:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780034797; cv=none; b=Jutwcn8qSvQrXNH9eRB3a+u6q7dseISkQ5ZeKSlL/hNBZGNwu3WOB7KXcZLSUItmxRiTTTT3ZxV11+m9Deinby/O5g0OEZumKZa/k9ttIr2tgxNKFd9tgFvpf3ArIANPHP7d5I9vW+7cD1mQ8qRPv1wllMUtR3A1qJoN3lCwkLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780034797; c=relaxed/simple;
	bh=7FKQBFom695XlbislUzI5qJwnCNNRPQzbQJhpamz8JA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iPc+JUF2Gz4CtVViOHdXtD3B5gFh1c2QAFFEgHbBdnYAwRf2xmO94QUHRCEvw/bvnAqiCOrQPzEA7s3iXV2yQuBj8DRYVVXGv2G2nf+USwI/Si/8PryPBPMn0b9Vztae0t/Q+/UfDOhmsC4NdIOFJU5gsMCq+Vom8e1/88SgEvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nTsAFA0Y; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nTsAFA0Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780034796; x=1811570796;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7FKQBFom695XlbislUzI5qJwnCNNRPQzbQJhpamz8JA=;
  b=nTsAFA0YoIP2mpLiwbLBkPRa6u2/dXIjvR0pOIJmdTylO/GgKQ4eziYs
   6abk0wwdgljlmn9fJYfaPnU8Mzl1d/cDcTOkBuFVydWsGTYHjqZ9eNeLj
   tBka7TQiRlV2sbUiBxtXkZOA/bqdeGyCFIOvoHTBsdkVTog+fNl4kSf9o
   T6UCl7KpSkyvflKGjnSwBTqJzI2Gu96VV/NpfsXZog2CxgMHnzMT7xPs2
   EOZXBgijWdH/JgxGvE6gH+uU+iZMc+0/eBM3zr69bLy53jbH/DYOr8MaZ
   fEa5yMTMUCF1Tdz0tfSnI/7vMsOLSbXNjjSJ9ZhetFjDwqzZOl5I0WaqA
   A==;
X-CSE-ConnectionGUID: vD53QJFDR22HrVsN5tSvPg==
X-CSE-MsgGUID: 5sbUEsiuQdKkXD8yWSZ71g==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="103556797"
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="103556797"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 23:06:36 -0700
X-CSE-ConnectionGUID: zxb2NGzVQH+4L9h83fDUcg==
X-CSE-MsgGUID: uQpplt+BQkqwHt0j4JhNPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="242864626"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 23:06:31 -0700
Message-ID: <691d3688-df39-40f6-88b5-2f62d9a94bc1@linux.intel.com>
Date: Fri, 29 May 2026 14:05:45 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/7] PCI/ATS: Validate STU for VFs in pci_prepare_ats()
To: Pranjal Shrivastava <praan@google.com>, iommu@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, David Woodhouse <dwmw2@infradead.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>,
 David Matlack <dmatlack@google.com>, Samiullah Khawaja
 <skhawaja@google.com>, Daniel Mentz <danielmentz@google.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Mostafa Saleh <smostafa@google.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <20260528202353.3422206-1-praan@google.com>
 <20260528202353.3422206-3-praan@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260528202353.3422206-3-praan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/29/26 04:23, Pranjal Shrivastava wrote:
> While every PCI Function that implements ATS has an independent ATS
> Extended Capability structure with a Read/Write Smallest Translation
> Unit (STU) field, the kernel manages SR-IOV ATS by requiring the IOMMU
> driver to configure the STU on the Physical Function (PF) before any
> any Virtual Functions (VFs) are created.
> 
> Currently, pci_prepare_ats() bails out early for VFs, assuming that the
> PF has already been correctly prepared. However, this creates a potential
> mismatch if a VF is subsequently prepared with a different page shift.
> 
> Update pci_prepare_ats() to validate that the requested page shift (ps)
> matches the STU already configured in the associated PF. This ensures
> early detection of incompatible configurations and maintains the kernel's
> policy of consistent STU sizing across all functions associated with a
> given SMMU.
> 
> Reviewed-by: Jason Gunthorpe<jgg@nvidia.com>
> Reviewed-by: Samiullah Khawaja<skhawaja@google.com>
> Reviewed-by: Nicolin Chen<nicolinc@nvidia.com>
> Signed-off-by: Pranjal Shrivastava<praan@google.com>
> ---
>   drivers/pci/ats.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
