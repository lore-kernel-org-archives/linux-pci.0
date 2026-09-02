Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7FF4A6CF7;
	Wed,  2 Sep 2026 15:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788363462; cv=none; b=SlSRI0vJduamo6oonFETt6mKrxMIiWthH3IR5Jdrp2oYuaspd79oj0e4KM29Bvnki0+RvKt1T9xo3IJJl3qwXvMrG7v2k1vxcvtioMdWkEQpDuHx5NAtfTNlvmJxoSTaCrmGtLKUP7nvcXTG9AmBZyl92wtWjkFZhmBcVokwss0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788363462; c=relaxed/simple;
	bh=+HmhVsA9O4QqWJ4nFtIsTdMAlBYBl/2H21MqPcG/NZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A3iBPK8e0TajW2zTCEorfWoHmv2UGLu/TlIa13BFLsEpBEQ67sW+XKfgWWTjJoE/UYEqa25eIdbSW40KUJqw26YPSN17JqXEFadFRty72RqtQgzjcyT6OhJhEstNAx+NgD2WItPfCFMgFF9iVbCQfYhtU3xf9IzrA4126Mb/T2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lPXC/Zk1; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lPXC/Zk1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788363453; x=1819899453;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+HmhVsA9O4QqWJ4nFtIsTdMAlBYBl/2H21MqPcG/NZM=;
  b=lPXC/Zk1sOHxmRcAEKr6IgjDZ5z1ZHNxNWNkIiG8vkvTVbgsxoBoCfRC
   81jJ8GXNbslBMF3X/8omhSXfb1Q/yw4M/QZRCRHphjy7x1Vqib++Xdi74
   SKWqWQc99AkXw0BgXprpEqULV56GbT80NR8ZziXveMAegw2LdXRpdQLY1
   wk5DDYAXudaYhPM2FQq1m4YqVO6mcHLFvgXs4UiQfw3OY6IDkB6M2YfQq
   insDyS+xj0feAO6dBH//UW7AP7ZtQ0hpsLAx+/zHbPEuypfL31enOIHJJ
   Kem6yLdEY3dbYDro6lMz4ReksUzGaQW3LT0uBQ/XMhCg6hIthUBdUEZiJ
   A==;
X-CSE-ConnectionGUID: X3Iz5hrkQXuhbTFRkGM04w==
X-CSE-MsgGUID: e6O2CKCqT2m13Z4MSJ6YRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="99425806"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="99425806"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 08:37:28 -0700
X-CSE-ConnectionGUID: PF+FBMmrTb2+dJxcLQSHMQ==
X-CSE-MsgGUID: FzkFJL0XRte1K2ZpFfyHRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="274718906"
Received: from sxiong-mobl3.amr.corp.intel.com (HELO [10.125.110.132]) ([10.125.110.132])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 08:37:27 -0700
Message-ID: <2b60d222-d5a2-4d9e-bd85-8b1ba0f0367a@intel.com>
Date: Wed, 2 Sep 2026 08:37:25 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/12] PCI/CXL: Add CXL reset support for Type 2
 devices
To: Srirangan Madhavan <smadhavan@nvidia.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Ira Weiny <ira.weiny@intel.com>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20260804192958.1823952-1-smadhavan@nvidia.com>
 <8eedb254-c942-4ee8-ab96-eb7c1ae577ad@intel.com>
 <093e50be-5a43-40c1-817f-bbcaadb3af76@nvidia.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <093e50be-5a43-40c1-817f-bbcaadb3af76@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/1/26 10:11 PM, Srirangan Madhavan wrote:
> On 8/25/26 2:13 PM, Dave Jiang wrote:
>>> Userspace can select "cxl_reset" in reset_method and then trigger reset
>>> through the existing reset attribute.
>> Srirangan,
>> Do we need to consider concurrent mailbox commands while reset is ongoing? Although rather than blocking them, maybe we just need to harden the mailbox path in CXL core so that when ~0s are read we return error and give up? and maybe a reset_prepare() to quiesce things. Just some random thoughts.
>>
>> DJ
> 
> I agree that the PCI device lock does not serialize against the mailbox mutex, so a mailbox command could still be in progress during reset.
> 
> Since cxl_reset also needs to work without cxl_pci bound, reset_prepare() and reset_done() seem like a good place to add this.
> 
> I would prefer to do this as a follow-up along with hardening for ~0s read, if that is okay. I can send out a follow up RFC to discuss the specifics.
> 

That is fine with me. 
