Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E9938B7AA;
	Fri, 29 May 2026 06:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780034622; cv=none; b=mgozEkquRjjKspeuZSAn5UWP3qsvs18OdZrlWA/JUFpgIJ9gq3oYpkv9F6Nq8Syr85kdZA/gyjtF9P8wwpLJkI+yZnI8+YCvXIWOntRm0DWSUOA/9xChomQYIKWsFhpsW1BUFjDjdB71eJ3SkBeMARfDfsJzYBw+ivrFVZ815n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780034622; c=relaxed/simple;
	bh=azyEsUy11K9vnAl2wpTXXwsKzMrJnt5yH0Sb1Ijv/V0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FvMN+CQi4kdWV9ohTBOkcdUTXn3H9xcRt0ZRGodHt6hEAQt7ux+qNaYEJRIAehy7HMpwx6dkKlwSVFqIMKV0RxSdgBfaqIrS60pMRnqzcSVUo7Rn9GiLMaUcl50BQ1rd0j62YRwNRTAhzi1fC8n1tAsFF1fTOP6e0VmPW3oPf0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ngggiqfx; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ngggiqfx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780034620; x=1811570620;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=azyEsUy11K9vnAl2wpTXXwsKzMrJnt5yH0Sb1Ijv/V0=;
  b=ngggiqfxfDHW4dPoYvDLLHSrtEDtOXmazq7T1Oo6p++xqBv6c9/iUoyr
   0JiX/xMcz8ZCZLvzTdMi7vH+VzQ7onU/mq6OI77o7MiusUEt+yqMmqNZl
   lPT8fPI/mQGBovRAyCXva7DiL7Dh/CgLDEolArqsm1BCndsqN38EIN/P7
   M1wurw+gkR1HXR9Wjki1yjC/XHYXch3kENF/iQuC0RbcLq+5EXFoBVSMb
   66NrejcrOIZf/FkYkwzvfOm4tu8VeFs008wDo9fLnSqh7taTcd8C4zrUo
   9rltivuVIjC483NkxTCbTPyPsnDKRlhzQoLoXZGu+H06TctLXVECejBFo
   w==;
X-CSE-ConnectionGUID: eVBi5/l8Tg20a83o+J0fiA==
X-CSE-MsgGUID: QGWtgzMMQuCnRj+P6Ro/tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="106333966"
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="106333966"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 23:03:40 -0700
X-CSE-ConnectionGUID: 7VA9ccfSQamvHxf8NSJxbg==
X-CSE-MsgGUID: MasJ3534QweKVPiGb6JzFA==
X-ExtLoop1: 1
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 23:03:35 -0700
Message-ID: <027de4e2-b3a0-4a02-b827-31163388bd6f@linux.intel.com>
Date: Fri, 29 May 2026 14:02:50 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/7] PCI/ATS: Ensure pci_ats_supported() is PF-aware
 for VFs
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
 <20260528202353.3422206-2-praan@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260528202353.3422206-2-praan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/29/26 04:23, Pranjal Shrivastava wrote:
> Update pci_ats_supported() to additionally check the associated PF's
> status when called on a VF. This ensures that PF-level quirks and
> untrusted status are correctly propagated to VFs, providing a robust
> support check that aligns with the kernel's PF-centric ATS configuration
> model and is immune to the timing of VF-specific fixups.
> 
> Reviewed-by: Jason Gunthorpe<jgg@nvidia.com>
> Reviewed-by: Samiullah Khawaja<skhawaja@google.com>
> Reviewed-by: Nicolin Chen<nicolinc@nvidia.com>
> Signed-off-by: Pranjal Shrivastava<praan@google.com>
> ---
>   drivers/pci/ats.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
