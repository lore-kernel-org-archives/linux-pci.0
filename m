Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793722134;
	b=3cd22yt+GDHgbDLm0u98X99CRLq/oCOYiMt7urUIGBPzKZTRL7dFdgjwOZdahhfQRI+h
	 WpryjOqTc+lAf4g+MSCnQt1VTtc8VaVqHhWcmdzWEU6qy4sPfFAUEoj7R/xtnj59xwnYE
	 1LS8/wolMueqL0GrbZz9Kn9FfPUGXn0ibmXvALp7eQdNTYSLQGsnEyzHWieL8rOAQiijj
	 NgD0mmfCZchsBkM0+cXasDVh+j1XPsDAfTmD19k6y7sZPBpOe0haAPxSlNatKNOH7EakS
	 WJxmq/JfjdnmWZ4y4KGZAZzCaZh4jhYf9bvaUhPeVxuvf5DrhH64qpDjCDwghVefjVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793722134;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Rc07ArdQvFh+ft5vlXAchmesZ95OF36366xbM/Kgcjo=;
	b=k2VJtcNpODOPZWOV6O9U99p0Ur9xpFKfeVXIILLMLHRsnGSMKxf36T10sVFkSkRV4CtD
	 ad7BIH2dEKo9+FNiR6uZmIkzQIPhEQuTldxeqWfypntURJkMdBRBuJKSymxIwZOp14dYe
	 wIOQ1uunCewvopXhEL6sUbtyF9ElilBb6S22+lKFCuN4M0i2tyU5VvwXTrWatMDthZnrF
	 NS5itv+SAiOcNrOgTXhrLMcKO21JpApXU3U37PbSyBbSBF504Wog419ULqmH/ZHEwxnjR
	 Rp8h/Qw0Aldq+QSzZ3633kCvrwClQgMatgSTRnvDAIObxsi48g+Y76+tZbjz/E2uBUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UDiiScKX;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D380606A324
	for <linux-pci@vger.kernel.org>; Tue,  3 Nov 2026 16:08:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D380606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UDiiScKX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793722134; x=1825258134;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8pQlpQpDC9jLiJmdWIqN0LUbmYhioNBj7jR8j2FrOyc=;
  b=UDiiScKXo0CoXbR/OKsjsvjFvxe4akxeEI/jH1wqshmO8Sq5L5ItsDnl
   E0lAF/0VdWB0jI0gj48WovhXk1anTFEv4wsSOrw2WRzzqFlqdFr3G9wtt
   WSXj2CTIN5+eduMA2dM+bnyxaD2jt9WF1ZYP4KJSGWgAMWfcpkR3ScLRH
   KpWuBzhtNGDQs5n4osz4Fp6lmPxjwHSwgQyxJgsOdmrDI005KpRxT3VXC
   hswZsikt1Tcz7bKNG9L+V6jTZwng2uBsoCokLhkfCSuhMiDVe1gwwilFN
   EUIM8OmJhK8H/bbTUKok/EI+c/GEk0COxPc80QvQh9yvBpF6hKsZaUIz6
   A==;
X-CSE-ConnectionGUID: 6OMmwCCGQIyXQE3DbKu58A==
X-CSE-MsgGUID: GdOW/SQzQ2agQew9NXoo2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2446208"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2446208"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 08:08:53 -0800
X-CSE-ConnectionGUID: uGjADqWgSpOzMTcRDilLrw==
X-CSE-MsgGUID: M51pzQjCSG+Mh6jTN8qQOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6572925"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.80.90]) ([10.24.80.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 08:08:52 -0800
Message-ID: <7ce177a6-e03e-419c-8af0-027b8b21ab1a@linux.intel.com>
Date: Tue, 3 Nov 2026 08:08:52 -0800
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
Subject: Re: [PATCH 1/2] PCI/AER: Avoid NULL pointer deref on search for Error
 Source
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
 linux-pci@vger.kernel.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
 Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Alex Deucher <alexander.deucher@amd.com>, Keith Busch <kbusch@kernel.org>,
 Maciej Grochowski <Maciej.Grochowski@sony.com>
References: <cover.1793697480.git.lukas@wunner.de>
 <6de42407246d270c75126baa338761e6f21ab067.1793697480.git.lukas@wunner.de>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <6de42407246d270c75126baa338761e6f21ab067.1793697480.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/3/2026 1:45 AM, Lukas Wunner wrote:
> A Root Port's subordinate bus may be NULL if the PCI core runs out of bus
> numbers on enumeration.  Yet when the AER driver searches for the source
> of an Error Message, it dereferences the subordinate pointer without
> checking for NULL.  Fix it.
> 
> Fixes: 28eb27cf0839 ("PCI AER: support invalid error source IDs")
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v2.6.31+
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>  drivers/pci/pcie/aer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index db4f607f889c..d492c7ce01e1 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1251,7 +1251,7 @@ static bool find_source_device(struct pci_dev *parent,
>  
>  	if (pci_pcie_type(parent) == PCI_EXP_TYPE_RC_EC)
>  		pcie_walk_rcec(parent, find_device_iter, e_info);
> -	else
> +	else if (parent->subordinate)
>  		pci_walk_bus(parent->subordinate, find_device_iter, e_info);
>  
>  	if (!e_info->error_dev_num)

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

