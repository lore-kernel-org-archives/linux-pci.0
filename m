Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1682FF679;
	Wed, 28 Jan 2026 17:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769619679; cv=none; b=CGDHlhQinUPIRHT5F5KBPwBv63mqIQ8/mvAJPaZFZqihssKR0sanFrBP0uCW3Fvw2YeA2Rz4nBkp3W9FXT4LsAqCzWleoA2Ihg+AOmMAV8BZdrnEWXg2OYu0jXaOrZMMs1wIPsPeHd/muMKH38Ibpb8LLIWk9DcZ5VH2qvRR/lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769619679; c=relaxed/simple;
	bh=b42Kfhku1yAub1jkIsORkr2G+VtXYCHjFwFhrlH7wTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SHjRBnLzM9Mq08X+rWfF0aUvkMf1C+nTASzpYzHUwiMP2t+M8QykujQzyEp73AsJBxQ521O97apWEfzCL8Sqwd5AkW6aRSwmD16pW4Z/kUVsbD6r+++9YApfUxWwM9D36aMmpwSNmBVnPzyq0QxHdS1QcNfbJOIyvFAsWcd72pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Avu8oC+d; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Avu8oC+d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769619678; x=1801155678;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=b42Kfhku1yAub1jkIsORkr2G+VtXYCHjFwFhrlH7wTU=;
  b=Avu8oC+dyBw1z9a6ElLVexCrLLz0fW2PbvglsLEgRx3m2TFpLoYJ5nQy
   +SRkU7grvZ41oICstSUUQeXOGRp1kKewbZ80XMqTiAdT8SgXwsBCyt8FF
   eiEF2bPb6UQ9yqzjhqzOiaifZymaWOmT1qWAHFaZ2X1HASRj9Nc3/wVJa
   ZcMGsifytP2RKgsUm5iYpUY4Md7zlMOHIV0yWasKM3yjom9a7nPET0eme
   4Dv+4UGhJwh9o/jec9cl/+kbFtGANkfOpae0rkxZtFpXjBHT6TfRDfQSS
   tD7KWxDa7/JPDhcKv7YXbfLubcL8kZflNyO6hjkrNp6DgsNE2KiePNxkO
   A==;
X-CSE-ConnectionGUID: BV9CFXL/SrW+aCqLud6iOg==
X-CSE-MsgGUID: 2RpPiQwISjGoftMM/YUtKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="69853364"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="69853364"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 09:01:17 -0800
X-CSE-ConnectionGUID: 2B7v17WWSw2Kl8eHEq4ODg==
X-CSE-MsgGUID: NPjSMGlKS0+fE2yCr1mUIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="208341510"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.81.126]) ([10.24.81.126])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 09:01:17 -0800
Message-ID: <acf0a082-93b3-49a6-a02c-a0b82b83391a@linux.intel.com>
Date: Wed, 28 Jan 2026 09:01:16 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/5] PCI/AER: Only clear error bits in
 pcie_clear_device_status()
To: Shuai Xue <xueshuai@linux.alibaba.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 bhelgaas@google.com, kbusch@kernel.org
Cc: mahesh@linux.ibm.com, oohall@gmail.com, Jonathan.Cameron@huawei.com,
 terry.bowman@amd.com, tianruidong@linux.alibaba.com, lukas@wunner.de
References: <20260124074557.73961-1-xueshuai@linux.alibaba.com>
 <20260124074557.73961-6-xueshuai@linux.alibaba.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20260124074557.73961-6-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/23/2026 11:45 PM, Shuai Xue wrote:
> Currently, pcie_clear_device_status() clears the entire PCIe Device
> Status register (PCI_EXP_DEVSTA), which includes both error status bits
> and other status bits such as AUX Power Detected (AUXPD) and
> Transactions Pending (TRPND).
> 
> Clearing non-error status bits can interfere with other drivers or
> subsystems that may rely on these bits. To fix it, only clear the error
> bits (0xf) while preserving other status bits.
> 
> Fixes: ec752f5d54d7 ("PCI/AER: Clear device status bits during ERR_FATAL and ERR_NONFATAL")
> Cc: stable@vger.kernel.org
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>


>  drivers/pci/pci.c             | 2 +-
>  include/uapi/linux/pci_regs.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 13dbb405dc31..0b947f90c333 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2246,7 +2246,7 @@ void pcie_clear_device_status(struct pci_dev *dev)
>  	u16 sta;
>  
>  	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &sta);
> -	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
> +	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta & PCI_EXP_DEVSTA_ERR);
>  }
>  #endif
>  
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 3add74ae2594..f4b68203bc4e 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -534,6 +534,7 @@
>  #define  PCI_EXP_DEVSTA_NFED	0x0002	/* Non-Fatal Error Detected */
>  #define  PCI_EXP_DEVSTA_FED	0x0004	/* Fatal Error Detected */
>  #define  PCI_EXP_DEVSTA_URD	0x0008	/* Unsupported Request Detected */
> +#define  PCI_EXP_DEVSTA_ERR	0xf	/* Error bits */

To align with other macros, use 0x000F?

>  #define  PCI_EXP_DEVSTA_AUXPD	0x0010	/* AUX Power Detected */
>  #define  PCI_EXP_DEVSTA_TRPND	0x0020	/* Transactions Pending */
>  #define PCI_CAP_EXP_RC_ENDPOINT_SIZEOF_V1	12	/* v1 endpoints without link end here */

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

