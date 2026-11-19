Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795107050;
	b=Vzbug7j0iuekUAF859oQrnaGGERgBAnyIrPys74vFtoVUQJgsZiMUDr6mzKxMP1Eceoz
	 FBrEQ24uJ8bt/rJd3aRkORxlW8Sd9It3tTTEuRHvsyBVUJF1RxRL87nuPntAheaWXVHGN
	 +9LIh3staYCJMXu8Ajw/JNcxMzsj3gv9dIQuUwMQ/DroiuSzSEEf0Gv0bWTZeFdfvj6eG
	 Yg8yDJqfcyak4F4WtgLYdhry3VgwOMmVc/z94iDFcFs7Y3Oliq4ylvldSGsdM0W9mka+U
	 tFWwzvCNJ64umOh80/7xc0ogt4o7i/kO5mgOx6P0I0T/1vmKCqv9ceTPWws41YUmxHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795107050;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=EcqBrWCUUrYZP/IHf4d+yvGiA1J1fd7GT5UeV1WbZIQ=;
	b=5paCS4J0BJlJ+iCuDBsu+Wq80+IyEL2yVFcKvUGhoFXAeF2mo8xanfvSRSUsE4/LnYIX
	 e6O+4qQeIr7BKOK3MN33yN1HE+kLjeQHxYetTNXKpf37fNcOEob4ZomBxqbNbWhCc5Gwm
	 meGwij7ZMn2T3WuM7uc0p/+3eI8e3dwk9EXTyzYPigHbdzAjSuOElYFNnM7bj/sb/f87h
	 9tcT7hpL16vdyVvGmwtkYnJKjSYTe3kgXKDVbPx/JDZ8X5w97w18mmFDtu0No/1DAOSi/
	 Uacs1QciKWKEKDdpbdNu1g10YeEgNbnaPrqzc4xK58HsdfpiZYXh7jK6UYd9/ONkYIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XUoRKMYI;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A0F606A325;
	Thu, 19 Nov 2026 16:50:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3A0F606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XUoRKMYI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795107049; x=1826643049;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Qwhi2oNFohJLaevwkDwP2jMX0JhsiJJ9IwcLPxRLG/w=;
  b=XUoRKMYIBzxQQ1YjOwZgWXtQp2F+kppKZ3ECFqiT7W0iqBGMiKgqj4vU
   On7X00vvN2wunPp+xKxBIPW5p4qa/PUAG9c1MMfnyUBaK0qlL+jPKHutn
   axP8IbHF1lzwZqFw0g18zZ6/o7RgFzq3jBrDfE92PmiWcE49cF9jJcqap
   X/pQlDRg/NH34bH3TPaqF+y5V6dqi/2XM4+ALY6dRVIbLDrNDfDtUVOeB
   h1+8YKOEkVSYjUrvyRpU/FZGXNvDdavyrFLgIh/v0loy5GfnTt4gm90zm
   61kiqJeeHMN8P4efpkcwbX9pr31s1bKJwQFYEMAhFTwuOj9tX30lLMplw
   g==;
X-CSE-ConnectionGUID: 0kWRSpa/R0GrTgMlSXN6zQ==
X-CSE-MsgGUID: mwHPTEkYSkyc/AyzAwPDbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3955326"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="3955326"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 08:50:49 -0800
X-CSE-ConnectionGUID: HjcHMjJRST+Ah5eSi1wmtQ==
X-CSE-MsgGUID: sk1hx9wjQ4SWQ1+5/B9VyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="10364330"
Received: from smithj1-mobl2.amr.corp.intel.com (HELO [10.125.109.70]) ([10.125.109.70])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 08:50:48 -0800
Message-ID: <99a13c8a-538e-490e-bbf3-4dec31afb340@intel.com>
Date: Thu, 19 Nov 2026 09:50:46 -0700
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
Subject: Re: [PATCH] PCI: Skip the CXL state update for a VF
To: Joshua Machauer <machaujo@amazon.de>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, nh-open-source@amazon.com
References: <20261119164219.51540-1-machaujo@amazon.de>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20261119164219.51540-1-machaujo@amazon.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/19/26 9:42 AM, Joshua Machauer wrote:
> set_pcie_cxl() runs for every device that is added. It first updates
> the CXL state of the upstream bridge, which walks that bridge's
> extended capabilities and recurses up to the root port. It then walks
> the device's own extended capabilities for the Flex Bus Port DVSEC.
> 
> For a VF neither walk can change anything. A CXL device exposes its
> Flex Bus Port DVSEC through Function 0 (CXL 4.0, section 8.1.8), so
> the search in a VF finds nothing and the VF's is_cxl stays false.
> pci_upstream_bridge() resolves a VF through its PF, so the bridge is
> the one that was already updated when the PF was added.
> 
> Enabling SR-IOV adds the VFs one after another, and each add repeats
> both walks against the same bridges.
> 
> On an NVIDIA Vera system, enabling 256 VFs on a PF whose upstream
> bridge has 18 extended capabilities takes 296 ms instead of 402 ms.
> Enabling 32 VFs on a Rubin GPU takes 218 ms instead of 235 ms. The
> times are for the write to sriov_numvfs, with the PF bound to
> pci-pf-stub and VF driver autoprobe disabled, so no VF driver probes.
> 
> Return early for a VF. Every device keeps the is_cxl value it gets
> today.
> 
> Signed-off-by: Joshua Machauer <machaujo@amazon.de>

commit log a bit wordy, otherwise LGTM

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/pci/probe.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 9a178e0e5f7f..34acebd1c706 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1717,6 +1717,14 @@ static void set_pcie_cxl(struct pci_dev *dev)
>  	if (!pci_is_pcie(dev))
>  		return;
>  
> +	/*
> +	 * A CXL device exposes its Flex Bus Port DVSEC through Function 0,
> +	 * so a VF has none. Its upstream bridge is the PF's, which was
> +	 * updated when the PF was added.
> +	 */
> +	if (dev->is_virtfn)
> +		return;
> +
>  	/*
>  	 * Update parent's CXL state because alternate protocol training
>  	 * may have changed

