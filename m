Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1676346D2BB;
	Tue, 21 Jul 2026 16:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784651469; cv=none; b=MHSwa2Cf+GPoJmYOnUZPhL+05f8+e/LvzyJT89/wmoNYBDu411aHZJDlerSv7cYqL2Dx7TrtmDyvLRjCGj4ubGGFW6h+mP0NXL4uV9VVB+VVWWSr3q5/Hzab9ypOraXaGnK1eMTlnRkhPEDZf40waaWBLbwQc388XS50/vXZEbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784651469; c=relaxed/simple;
	bh=0BEMgH7BeCBC9GIU91wYk5G+v7xPd6dq9KbwdX5MNZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g0ayAlaAFfIOgw2rTnFAc75Gd91iBvVqR0Xneok5UJtvrFcrWYBpeeA86xWcdkOFlU0qgDQoejAcZra6cvS3UbZjl98HKNzWxf/F1SJoSzxhT3yXHpaEu3meFFA+h93fEKjI6ddKpBfFa6xVcbXjF3S4vMbtP+iZpGJ0eqpmfxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MuaB1Z+w; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MuaB1Z+w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784651467; x=1816187467;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0BEMgH7BeCBC9GIU91wYk5G+v7xPd6dq9KbwdX5MNZg=;
  b=MuaB1Z+w2OjoLEaFWvJoJLN3VwzKk8KoRm4fJ3Goy3nnOBNCHX/aXPM5
   OaMnkbCeCH/e2/fjWVoGLQJcAo2Ie6HlJZX/3Litr5v+aB8vBLL7rlmg0
   7z5RgEM4fAqyOsBV2bv+GO0G324cr+3F4+lmg0mbXPeEirwabCxjmQkbR
   +3muNqdxNKGVHRYMi5W6lNpbp+QxT8VP5I5gfOXyHrzzpX92rYqnFTWcb
   X3b35qRvFG/OF07MlCIiC3fJHuXmZxoCfrjv+AE/G6USR0H5fhoUVfiRL
   Jw10WEpB1vztzvQNYoxJduPgmcAquRCi4y5i8n6gTsk7SHVOc+hYFnFRT
   g==;
X-CSE-ConnectionGUID: 8QgWhw/OQ7KOYiOEn+GCOg==
X-CSE-MsgGUID: qZJRvitiTHqiztQMQVQ1Jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="96623997"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="96623997"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 09:31:06 -0700
X-CSE-ConnectionGUID: fk71XVOTR4izltGA2iR/mg==
X-CSE-MsgGUID: bl/xLh03R6ylMqDnGyNRMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="261372468"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO [10.125.109.244]) ([10.125.109.244])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 09:31:06 -0700
Message-ID: <c9e140e9-f962-453b-9e84-0b2e7148d93f@intel.com>
Date: Tue, 21 Jul 2026 09:31:04 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/11] dmaengine: ioat: disable relaxed ordering before
 registering the device
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
 Vinod Koul <vkoul@kernel.org>
Cc: Frank Li <Frank.li@nxp.com>, Kelvin Cao <kelvin.cao@microchip.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 George Ge <george.ge@microchip.com>, Jaeyoung Chung <jjy600901@snu.ac.kr>,
 Sashiko <sashiko-bot@kernel.org>
References: <20260721155739.62120-1-logang@deltatee.com>
 <20260721155739.62120-10-logang@deltatee.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260721155739.62120-10-logang@deltatee.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/21/26 8:57 AM, Logan Gunthorpe wrote:
> ioat3_dma_probe() disabled PCIe relaxed ordering after calling
> dma_async_device_register(), so if an error occurs and the code jumps
> to err_disable_interrupts, the function returns with the device still
> registered in the core's dma_device_list while the caller frees the
> ioatdma_device struct, leaving a dangling registration that anything
> walking the device list can dereference after it's been freed.
> 
> Move the capability read/write ahead of dma_async_device_register()
> instead. Nothing after registration depends on relaxed ordering
> already being disabled, and nothing before it depends on the device
> being registered, so this is a plain reordering. It also means every
> remaining step after registration can't fail, so there's no need to
> ever have to unregister the device once registered.
> 
> Fixes: 511deae0261c ("dmaengine: ioatdma: disable relaxed ordering for ioatdma")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/dmaengine/20260707165906.249F41F000E9@smtp.kernel.org
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Acked-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/dma/ioat/init.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c
> index 737496391109..a57024c4b066 100644
> --- a/drivers/dma/ioat/init.c
> +++ b/drivers/dma/ioat/init.c
> @@ -1170,15 +1170,6 @@ static int ioat3_dma_probe(struct ioatdma_device *ioat_dma, int dca)
>  		       ioat_chan->reg_base + IOAT_DCACTRL_OFFSET);
>  	}
>  
> -	err = dma_async_device_register(&ioat_dma->dma_dev);
> -	if (err)
> -		goto err_disable_interrupts;
> -
> -	ioat_kobject_add(ioat_dma, &ioat_ktype);
> -
> -	if (dca)
> -		ioat_dma->dca = ioat_dca_init(pdev, ioat_dma->reg_base);
> -
>  	/* disable relaxed ordering */
>  	err = pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &val16);
>  	if (err) {
> @@ -1194,6 +1185,15 @@ static int ioat3_dma_probe(struct ioatdma_device *ioat_dma, int dca)
>  		goto err_disable_interrupts;
>  	}
>  
> +	err = dma_async_device_register(&ioat_dma->dma_dev);
> +	if (err)
> +		goto err_disable_interrupts;
> +
> +	ioat_kobject_add(ioat_dma, &ioat_ktype);
> +
> +	if (dca)
> +		ioat_dma->dca = ioat_dca_init(pdev, ioat_dma->reg_base);
> +
>  	if (ioat_dma->cap & IOAT_CAP_DPS)
>  		writeb(ioat_pending_level + 1,
>  		       ioat_dma->reg_base + IOAT_PREFETCH_LIMIT_OFFSET);

