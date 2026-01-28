Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93617314D0D;
	Wed, 28 Jan 2026 16:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769619542; cv=none; b=sPj5VDWZGBTG7b2q6dB/0bUNS3JRMQHLB3DLcJ6I2yjBoPyuViExy+qU9ysp30fKdsupp7iXEYyybuotw5IhqcX889qfxuiTDyTkitsOJRuOGu0eBg59kme1FfCFbUz5BZwJ5cQVazlkFJSJwP/GCqJusgKeWBByoyTImDhM8so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769619542; c=relaxed/simple;
	bh=bnHXPMPNgHRvQiG4GLdo6odlzdOHxKJIHAHU+qCgXrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YfCCCw4k0y3W5aaYEWK+0fe6W8HVS0zmNbHhV89Uk8L8P4GWEsLbzm+F5Fo4wxwQwe89QzcMDi3t8h+9ketf72t0ocWpNSHe/WjNdIq7VIFSSweimNvIUpuzwmcNQWvUc4I8cuzEHlEN2H7DbJx79ft+XDOMgIaGV1u5tJyGLek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ncEs/GNY; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ncEs/GNY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769619541; x=1801155541;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bnHXPMPNgHRvQiG4GLdo6odlzdOHxKJIHAHU+qCgXrA=;
  b=ncEs/GNYfawWCLJuynJ7BNNWL3O5l/sbxh5rf1LiJU9ciSA2birt7L4g
   +WO0QgQPNf5Y8fhSv4zxP0v8s+ruMjKZLK3YIt8BbyyyFGjAKllxdFs17
   B/hWj2Io3sD+KXWNbWNNO7OsyFDFuRNjMQleTFyxJ0ssSasD5mMMxTwwy
   ViWVVoV42qHySiEa9nDwzg/IXMc8xR/UXq1GAo7wMkWzY6r8eVsbz1aEm
   O82w1eQm7LKGmJzOOG57avORQ92Fq4USwkQRX1cX0iDDOewDf7ZVIza52
   hl/hWR3Gh0bgtPEwLh3CAy7yO/pAKiEtfw74+ozctxLPAQaEuABgKIrXH
   Q==;
X-CSE-ConnectionGUID: XSGUep0hRm2/IS6GVv7I0Q==
X-CSE-MsgGUID: Qcl4VCoVQHuZ4JBAqMZCGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="88257690"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="88257690"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 08:59:01 -0800
X-CSE-ConnectionGUID: S6k9xmHPR7qDkRvMokBb7Q==
X-CSE-MsgGUID: MijA/aemRcKq3WeA4g3K1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="208225520"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.81.126]) ([10.24.81.126])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 08:59:00 -0800
Message-ID: <f98c4da6-502a-4d9c-8df7-8db3b3ea5d15@linux.intel.com>
Date: Wed, 28 Jan 2026 08:58:59 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/5] PCI/AER: Clear both AER fatal and non-fatal status
To: Shuai Xue <xueshuai@linux.alibaba.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 bhelgaas@google.com, kbusch@kernel.org
Cc: mahesh@linux.ibm.com, oohall@gmail.com, Jonathan.Cameron@huawei.com,
 terry.bowman@amd.com, tianruidong@linux.alibaba.com, lukas@wunner.de
References: <20260124074557.73961-1-xueshuai@linux.alibaba.com>
 <20260124074557.73961-5-xueshuai@linux.alibaba.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20260124074557.73961-5-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/23/2026 11:45 PM, Shuai Xue wrote:
> The DPC driver clears AER fatal status for the port that reported the
> error, but not for the downstream device that deteced the error.  The
> current recovery code only clears non-fatal AER status, leaving fatal
> status bits set in the error device.
> 
> Use pci_aer_raw_clear_status() to clear both fatal and non-fatal error
> status in the error device, ensuring all AER status bits are properly
> cleared after recovery.
> 
> Fixes: aa344bc8b727 ("PCI/ERR: Clear AER status only when we control AER")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>


>  drivers/pci/pcie/err.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 0780ea09478b..5e463efc3d05 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -285,7 +285,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  	 */
>  	if (host->native_aer || pcie_ports_native) {
>  		pcie_clear_device_status(dev);
> -		pci_aer_clear_nonfatal_status(dev);
> +		pci_aer_raw_clear_status(dev);
>  	}
>  
>  	pci_walk_bridge(bridge, pci_pm_runtime_put, NULL);

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

