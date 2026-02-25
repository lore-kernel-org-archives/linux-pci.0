Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20ECB3D7D89;
	Wed, 25 Feb 2026 16:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772037997; cv=none; b=BDx4vKS7bmbEn/YBga6iaf2PRsNotvB1YxHQjmLLr/ot+I2D2yUJ1czHZ5Yr+1eX0G4HxdsMc4ep0vvOw8+EsC+7+ZW/+kw8aRqKFsEBPYDr7eW27LfQuKI8yODqtKGeUr4IstKkA6BbPA/qhKh6IL/aMacdiF7FM0yDQ9URIuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772037997; c=relaxed/simple;
	bh=XQkON2hH42xh3feu1yecYPdnJyLWGJ7ivFADftHZw+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y2vUiVZ8Ia5ULek/pr4PFIv60+19yTVQC24yG8v8aSij3IRYYs1n7zbj1jwyASsVNgEs9+Wqa9A9oRtBVvP4nveV4uYG1ahEg7S1DoAIiTd/Ghi9hUzoQrxUwM214YYSztdNhLBE1vh4fuv6GCEo/4BagqJuvsCNeSubSE2th8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fdMV+FBN; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fdMV+FBN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772037996; x=1803573996;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XQkON2hH42xh3feu1yecYPdnJyLWGJ7ivFADftHZw+w=;
  b=fdMV+FBNEUChHEYajswxP0AMRS0YdBnDF76AXdypoS3kNIDACYt5Y4MO
   9SPK31G2//cGqs/0x7KezwaCsfi0/A0Tz9KHgeBeuqq6tLL3GSOHEbF+L
   12yzLktWeEUNzTmauyNjoo67fV6+onWuFl6gpBdBWOOkxtP+JNeMBU4dG
   HxHh3u1K/hvkcOakY8Ci6BmLibUWfFUXj4jJX5nIYZyd+REWroOoIiYMc
   llePMysiVhKhmAUAXd8cKqjC/ee/RuYw6ViPKVHnbnlSTGKL51fd6PJ69
   OHBdeLa+93nvu1uroeSj6qL3La8wmXBwzZVX/azr1q6TY7Y5bU02cUdOV
   w==;
X-CSE-ConnectionGUID: YCpIBAB4QSO5YydY2RHN3A==
X-CSE-MsgGUID: CpjYtXY7TU2SISLEhVXBXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="73189128"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="73189128"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 08:46:35 -0800
X-CSE-ConnectionGUID: +2kv7+BPQ42sVuL63eEtug==
X-CSE-MsgGUID: hi7i7lsoTQq0dn4Ocmp7+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="215506290"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.111.98]) ([10.125.111.98])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 08:46:34 -0800
Message-ID: <38d9206d-08a3-4b69-a97f-902160bd9e31@intel.com>
Date: Wed, 25 Feb 2026 09:46:33 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] NTB: epf: Document legacy doorbell slot offset in
 ntb_epf_peer_db_set()
To: Koichiro Den <den@valinux.co.jp>, Frank.Li@nxp.com, kishon@kernel.org,
 jdmason@kudzu.us, mani@kernel.org, allenbh@gmail.com,
 kwilczynski@kernel.org, bhelgaas@google.com, jbrunet@baylibre.com,
 lpieralisi@kernel.org
Cc: linux-pci@vger.kernel.org, ntb@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260224133459.1741537-1-den@valinux.co.jp>
 <20260224133459.1741537-7-den@valinux.co.jp>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260224133459.1741537-7-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/24/26 6:34 AM, Koichiro Den wrote:
> ntb_epf_peer_db_set() uses ffs(db_bits) to select a doorbell to ring.
> ffs() returns a 1-based bit index (bit 0 -> 1).
> 
> Entry 0 is reserved for link events, so doorbell bit 0 must map to entry
> 1. However, since the initial commit 812ce2f8d14e ("NTB: Add support for
> EPF PCI Non-Transparent Bridge"), the implementation has been adding an
> extra +1, ending up using entry 2 for bit 0. Fixing the extra increment
> would break interoperability with peers running older kernels.
> 
> Keep the legacy behavior and document the offset and the resulting slot
> layout to avoid confusion when enabling per-db-vector handling.
> 
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/ntb/hw/epf/ntb_hw_epf.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> index d3ecf25a5162..bce7130fec39 100644
> --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> @@ -43,6 +43,18 @@
>  #define NTB_EPF_DB_DATA(n)	(0x34 + (n) * 4)
>  #define NTB_EPF_DB_OFFSET(n)	(0xB4 + (n) * 4)
>  
> +/*
> + * Legacy doorbell slot layout when paired with pci-epf-*ntb:
> + *
> + *   slot 0 : reserved for link events
> + *   slot 1 : unused (historical extra offset)
> + *   slot 2 : DB#0
> + *   slot 3 : DB#1
> + *   ...
> + *
> + * Thus, NTB_EPF_MIN_DB_COUNT=3 means that we at least create vectors for
> + * doorbells DB#0 and DB#1.
> + */
>  #define NTB_EPF_MIN_DB_COUNT	3
>  #define NTB_EPF_MAX_DB_COUNT	31
>  
> @@ -473,6 +485,14 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
>  static int ntb_epf_peer_db_set(struct ntb_dev *ntb, u64 db_bits)
>  {
>  	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
> +	/*
> +	 * ffs() returns a 1-based bit index (bit 0 -> 1).
> +	 *
> +	 * With slot 0 reserved for link events, DB#0 would naturally map to
> +	 * slot 1. Historically an extra +1 offset was added, so DB#0 maps to
> +	 * slot 2 and slot 1 remains unused. Keep this mapping for
> +	 * backward-compatibility.
> +	 */
>  	u32 interrupt_num = ffs(db_bits) + 1;
>  	struct device *dev = ndev->dev;
>  	u32 db_entry_size;

