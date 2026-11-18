Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795003934;
	b=QRNLXNbUz2irHO60iLk6uirbyOnOo7PCsNNppyGThoylLVbJFbk3MAFr62Qmd/VWSmQl
	 e70tCgzEIrkanBbr2JpmGEezKuo9DbOWE3enQsgG8Ane4RVaFJ6jYoeN1GA8HASIT9YTj
	 YdPgkBeeo50BJMKFBA9OcM+COaLLwekcC2X9nHZX4GIIEeggI8vpBAH0A1/9lumMlqoJF
	 UR7h82RjV9A2pgeXwX5Ge8xL3eewbEaFclbs1QUcVUzxOGvH1pLF/JCVOFNSgnhb8rvbk
	 wJkASYJkOMOwFhu421h5QHzET0WbsBM6pV+PAhb5DlWbRgG2pN95dmwwAZ6DAfy/TDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795003934;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=UTLyf/Un7t8f/JJJ6neh6fVV7b+Ecu5jTGdE9Z/l6tg=;
	b=gwQ7D/Fr4P2+lc0gZP0wpmLNW35z0cstlMqrAteQmb1aH09fUwqPUG0XKT05qo6RiIqk
	 1byf2UpYiMTKS1jRv6AL1Zf9AaY202YEwqxPGI5i+kGD03LzMpcT+nc+TRa0PKgjh6xoE
	 yL+adZ62yB6fljoQ+kbuwPvwRUL30Ode8ImKODwoscCW0mIWPCyzMUS0C0eKo9mYBr7Rn
	 bD3Ok0zWJC3CKmbXQKuhAfi2fsH8h92rzHpixKk7gt27Xw0IQF/jbecn8CBTrjuFK99ek
	 PerTCUDOEV+e+fHiPutaP9m00NCU6h136kTYEd6SMn4QSZ5Ajiru5W0c7VVqQPYWzkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VnLwnZCk;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7BB606A338;
	Wed, 18 Nov 2026 12:12:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E7BB606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VnLwnZCk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795003933; x=1826539933;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=uMdP28J8ruxyc617AkA9mX2kd8b6181ALjrCuZZJlvA=;
  b=VnLwnZCkaAPt+4YtkdqQ8GWEWwxEwFhReGVrezadYKB6nHFteZQFAuUH
   04qMJuvf2u78djWXW08AZoR5H/JPNJvxgxi53tJzNkT0p5lb7wokeoBGH
   P+ZLQAjgO7q3I2mLEz/lzj1lcEGoZD+swPp1DQIq2i50QwUq8fCjSgvvv
   DuVocsIt/CspKMwY25UpZdJ/CO/ekKo8GoidgVSTqWX4f+1/HOKIj7pvF
   3pbMJL7HpUHTeuwG7XiQA7ZX3N2oK5n2zeJG1JqXtxBPwC3UHXc27P512
   Uz3EO7nceEKVQM7mjKwsyV6OvgT6KONWPs6J5bKNgf5ausvvKfz7ALSqD
   Q==;
X-CSE-ConnectionGUID: pnfvTPMhSCS6YmcJAJaTrQ==
X-CSE-MsgGUID: rqt2e007QC+tHBCwu+A8gA==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3834531"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3834531"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 04:12:13 -0800
X-CSE-ConnectionGUID: +QhsQ6GYS+yl7IZW6hab6w==
X-CSE-MsgGUID: M0auMPadQgaD93TxdhD0bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10344295"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.239])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 04:12:10 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 18 Nov 2026 14:12:06 +0200 (EET)
To: Stefan Ghetu <stefan.ghetu@nxp.com>
cc: linux-pci@vger.kernel.org, bhelgaas@google.com, 
    LKML <linux-kernel@vger.kernel.org>, hongxing.zhu@nxp.com, 
    Jason Liu <jason.hui.liu@nxp.com>
Subject: Re: [PATCH] LF-18678 PCI: Add quirk to fix byte-swapped class code
 on ARA240 device
In-Reply-To: <20261118100406.600995-1-stefan.ghetu@nxp.com>
Message-ID: <0558cc87-feca-3584-3af5-b05e7fcf4753@linux.intel.com>
References: <20261118100406.600995-1-stefan.ghetu@nxp.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 18 Nov 2026, Stefan Ghetu wrote:

> From: Richard Zhu <hongxing.zhu@nxp.com>
> 
> The ARA240 PCIe endpoint device (1e58:0002) reports an incorrect,
> byte-swapped class code of 0x000012 instead of 0x120000 (Processing
> Accelerator). This causes the device to appear as an unclassified
> device (class 0x00) rather than a processing accelerator (class 0x12).
> 
> On ARM platforms, the kernel may refuse to assign BARs to unclassified
> devices, preventing the ARA240 from functioning properly. The device
> cannot be initialized and remains unusable.
> 
> Add a PCI quirk to force the correct class code during early device
> enumeration, allowing proper resource assignment and device operation.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Acked-by: Jason Liu <jason.hui.liu@nxp.com>
> Signed-off-by: Stefan Ghetu <stefan.ghetu@nxp.com>
> ---
>  drivers/pci/quirks.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 3d92b99a49238..fc95d87d4af0a 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -559,6 +559,18 @@ static void quirk_citrine(struct pci_dev *dev)
>  }
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_IBM,	PCI_DEVICE_ID_IBM_CITRINE,	quirk_citrine);
>  
> +/*
> + * The ARA240 device reports a byte-swapped class code (0x000012) instead of
> + * the correct value (0x120000 - Processing Accelerator). This causes resource
> + * assignment issues on ARM platforms. Apply a quirk to force the correct
> + * class code.
> + */
> +static void quirk_ara240_class_code(struct pci_dev *dev)
> +{
> +	dev->class = 0x120000;

Why isn't this based on PCI_CLASS_ACCELERATOR_PROCESSING ?

-- 
 i.

