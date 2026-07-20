Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CACD25B0B7;
	Mon, 20 Jul 2026 20:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784578156; cv=none; b=JnNUIfECObB2zQjXawb5G4ybYfyQYM6Kk007HUNDq3k54f3+rWBwRPZ273OhH8OHmHmwm27bpDKJdKaNMTL1jNemqU+cPC647VO3l74JIclj+xrAouKl8RNcvesvfuTFRjQD1YIktVUFeVBG7hpezeyQcSw9kPGLorTHv/LsjKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784578156; c=relaxed/simple;
	bh=sFOpv2kA+FwJCaEso+qENIiQ1hBBWw24vR/Se27HPGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iS3YmaX9o7HD+Ctt8qGOY/3fzK+Ik42QCzggcs62oO1B74AKE6v93tsokD/JwGhxbOChvt3xl6kvGDP9YEZqnFjz8m/Xhk8s4vWLHck2tiFmr6+8Uh0+EDjnI6j/41QRb7Gb5Bk1SL29/IlZcU8t7+CRTYJlseShSIr4kP6J7N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z5n7Yifc; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z5n7Yifc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784578154; x=1816114154;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sFOpv2kA+FwJCaEso+qENIiQ1hBBWw24vR/Se27HPGs=;
  b=Z5n7Yifc9MRSJfCaf4KJFBbPnSpcSJVx9Sm4jON3xqXHfXLddvpIHyzl
   zaPLy4s3Sa95PzpFzfBn1I0Lle/VQKsvVyA4Hnv7yXWo1MZGG1cgbCh0M
   wxbIt2VSLev3LHuD9eTDNHDJ9R5NTr3v/2uBbSEVubvDvOhf61bkP5vAd
   3gc6z1gHJgiRz31BRVrODHPWXF1C7lsCHanM6SRRSw+/pcm2NCW78EwtT
   oIcfB+xAUqUAXBonjMsW8Ebalb9YubnTTxvbOco6HA/ly9btrn1xE+q7Z
   aBmO850bYORJxJ3GM0jo5oRXqRz1lHfb7e7llQsItkmi2ukZdu7R5GinV
   w==;
X-CSE-ConnectionGUID: WlBnzJB5SF6IcrzSWwILgg==
X-CSE-MsgGUID: xVhOcZtiSdqafzyXiHFYFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="84298313"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="84298313"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 13:09:13 -0700
X-CSE-ConnectionGUID: H4x5cj83RbqFt5QQqpUxGA==
X-CSE-MsgGUID: pA3maaPWTcelrKWA5o3qPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="256365696"
Received: from cooperst-gp83.amr.corp.intel.com (HELO [10.125.109.176]) ([10.125.109.176])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 13:09:10 -0700
Message-ID: <9c371c59-c871-4988-83d7-2aa780d8e6c4@intel.com>
Date: Mon, 20 Jul 2026 13:09:09 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 01/13] cxl/ras: Fix cxl_rch_get_aer_severity() wrong
 severity register
To: Terry Bowman <terry.bowman@amd.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, Len Brown <lenb@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Robert Richter <rrichter@amd.com>
Cc: linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Alejandro Lucero <alucerop@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Ankit Agrawal <ankita@nvidia.com>, Ard Biesheuvel <ardb@kernel.org>,
 Ben Cheatham <Benjamin.Cheatham@amd.com>, Borislav Petkov <bp@alien8.de>,
 Breno Leitao <leitao@debian.org>, Davidlohr Bueso <dave@stgolabs.net>,
 "Fabio M . De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Gregory Price <gourry@gourry.net>, Hanjun Guo <guohanjun@huawei.com>,
 Jonathan Corbet <corbet@lwn.net>, Kees Cook <kees@kernel.org>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Li Ming <ming.li@zohomail.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Oliver O'Halloran <oohall@gmail.com>, Shiju Jose <shiju.jose@huawei.com>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Shuai Xue <xueshuai@linux.alibaba.com>,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 Tony Luck <tony.luck@intel.com>, Vishal Verma <vishal.l.verma@intel.com>
References: <20260717222706.3540281-1-terry.bowman@amd.com>
 <20260717222706.3540281-2-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260717222706.3540281-2-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/17/26 3:26 PM, Terry Bowman wrote:
> cxl_rch_get_aer_severity() classifies RCH Downstream Port uncorrectable
> errors as fatal or non-fatal by ANDing uncorrectable status with
> PCI_ERR_ROOT_FATAL_RCV. This is wrong because PCI_ERR_ROOT_FATAL_RCV is a
> Root Error Status register bit (bit 6), not a severity bit. ANDing it
> against uncorrectable status tests a reserved bit and produces incorrect
> severity classification.
> 
> Fix by ANDing the unmasked uncor_status against uncor_severity. Per
> PCIe Base Spec r6.0 Section 7.8.4.4, each bit in the Uncorrectable
> Error Severity register indicates whether the corresponding error is
> fatal (1) or non-fatal (0).
> 
> Fixes: 6ac07883dbb5 ("cxl/pci: Add RCH downstream port error logging")
> Cc: stable@vger.kernel.org
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

This can be picked up ahead looks like?

> 
> ---
> 
> Changes in v17 -> v18:
> - New patch.
> ---
>  drivers/cxl/core/ras_rch.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
> index 0a8b3b9b63884..44b335d560708 100644
> --- a/drivers/cxl/core/ras_rch.c
> +++ b/drivers/cxl/core/ras_rch.c
> @@ -80,7 +80,8 @@ static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
>  				     int *severity)
>  {
>  	if (aer_regs->uncor_status & ~aer_regs->uncor_mask) {
> -		if (aer_regs->uncor_status & PCI_ERR_ROOT_FATAL_RCV)
> +		if ((aer_regs->uncor_status & ~aer_regs->uncor_mask) &
> +		    aer_regs->uncor_severity)
>  			*severity = AER_FATAL;
>  		else
>  			*severity = AER_NONFATAL;

