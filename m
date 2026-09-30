Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EAC2C21FD
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 18:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790791647; cv=none; b=qUb5thJaShqK9rmQtcbusVld4Yro6E8EwWyKLQHglMt4nPL2qz102f00Rxsr6G7jf0shqQRzH9mTK5mp6MjqEEzuTdureaK8Z3zP7lswEQpLy6E5fE1xJGD2hlsDkI8rv9emAgZ53XGlV2HhqGM+XxY3kMNM8Ia7+0YUyPJIiMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790791647; c=relaxed/simple;
	bh=mUCVKGIVm+I3brrnTqZGl3Ov5zBQT9g+vBg2/SQyWUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S62Sh9rkIb1uMRaXgYTeW0FlcklinOYgit1PUOIvt9PwbhjXLnaGtEbsYRjPl1lYJVV0V0tF+ay4IK/93xn+LBnzJTCHO7HVagdJUiB1EkaWmB2fsZyjFzq+qWX/kewlLHS8YbVOxSs5FXbAqSGBI6IO/9fJlyVJKVWoRuoj4XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TBJ6zRqu; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TBJ6zRqu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790791646; x=1822327646;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mUCVKGIVm+I3brrnTqZGl3Ov5zBQT9g+vBg2/SQyWUk=;
  b=TBJ6zRqu87f4spsgDqTe4Z3cL3jWTy9uda6tI+KjFloij0z/D4eLfAMu
   F5EuE8FEDe/CSpFA/Sg7H1g3US/4I7/VnLyPJKoReOYDfMB/op4PWEiG5
   jpnqw3UVuNcZ3jwUbm7BVCporEunBsXWmnWgiVxna75vK10P+6aXmilUp
   CroCwHbzJlLMjfcg0qHaVqY2jlBzxMbFDscLbOD/XceCr97R7hX1B0V3N
   95yxmRvJAnxwjzMNWpnq8J3KW8MOtBHENYJ2nRBLicG7pzDDd1SUmgQm8
   um62j/fhy3tSfS2FGPRd3x8BO7XhQyRnn8sNlbIVcUMBJ3omfixW3EvYG
   A==;
X-CSE-ConnectionGUID: xzmt6ECLQ4C936PPS2AjIA==
X-CSE-MsgGUID: Wovyw/YWTryOJzhc2d1+uQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="117065774"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="117065774"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 11:07:25 -0700
X-CSE-ConnectionGUID: uKOoW0x3TZOi7P10sS1i5w==
X-CSE-MsgGUID: YGz6XKE6Sx2Znr+iqdtuBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="272204341"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO [10.125.111.186]) ([10.125.111.186])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 11:07:22 -0700
Message-ID: <db704e6a-f43c-426a-99c8-c5b8298510a6@intel.com>
Date: Wed, 30 Sep 2026 11:07:21 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coco/tsm: Update maintainership
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexey Kardashevskiy <aik@amd.com>,
 "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>, ankita@nvidia.com,
 Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Cedric Xing <cedric.xing@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Eric Biggers <ebiggers@kernel.org>,
 Jani Nikula <jani.nikula@intel.com>, Jonathan Cameron <jic23@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>, Kai Huang <kai.huang@intel.com>,
 Kees Cook <kees@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Lukas Wunner <lukas@wunner.de>, Luis Chamberlain <mcgrof@kernel.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
 Fang Peter <peter.fang@intel.com>, Petr Pavlu <petr.pavlu@suse.com>,
 rick.p.edgecombe@intel.com, Samuel Ortiz <sameo@rivosinc.com>,
 Sami Tolvanen <samitolvanen@google.com>,
 Saravana Kannan <saravanak@google.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Steven Price <steven.price@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Will Deacon <will@kernel.org>,
 yilun.xu@intel.com, Kevin Tian <kevin.tian@intel.com>,
 Xu Yilun <yilun.xu@linux.intel.com>
References: <0-v1-52697321555d+14e66-tsm_maintainer_jgg@nvidia.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <0-v1-52697321555d+14e66-tsm_maintainer_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/29/26 4:26 PM, Jason Gunthorpe wrote:
> With Dan's passing Aneesh and Jason have volunteered to take this on, with
> the support of their employers.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  CREDITS     | 9 +++++++++
>  MAINTAINERS | 3 ++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> I've now spoken to all the main companies contributing here and asked for
> volunteers. This is what I could confirm at this point. I'll be at LPC also
> for any further discussion. Regards
> 
> diff --git a/CREDITS b/CREDITS
> index a0bd941ca5dd26..7749f1e477ab43 100644
> --- a/CREDITS
> +++ b/CREDITS
> @@ -4414,6 +4414,15 @@ W: ftp://ftp.uk.linux.org/pub/linux/people/willy/
>  D: Linux/PARISC hacker.  Filesystem hacker.  Random other hacking.  Custom
>  D: PPC port hacking.
>  
> +N: Dan Williams
> +D: Technical Advisory Board member
> +D: Asynchronous Transfers/Transforms (IOAT) API, Compute Express Link (CXL),
> +D: Device Direct Access (DAX), Filesystem Direct Access (DAX),
> +D: Intel I/OAT DMA driver, libnvdimm BTT: block translation table,
> +D: libnvdimm PMEM: persistent memory driver,
> +D: libnvdimm: non-volatile memory device subsystem,
> +D: Trusted Execution Environment Security Manager (TSM)

Thanks Jason! Just adding a few more things:

  +D: Intel C600 SAS driver (ISCI)
  +D: Intel XScale IOP SOC
  +D: MDRAID IMSM external metadata format

Acked-by: Dave Jiang <dave.jiang@intel.com>

> +
>  N: G\"unter Windau
>  E: gunter@mbfys.kun.nl
>  D: Some bug fixes in the polling printer driver (lp.c)
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 72294ddfa5b757..729ab465af96a8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -27788,7 +27788,8 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/trigger-source/*
>  
>  TRUSTED EXECUTION ENVIRONMENT SECURITY MANAGER (TSM)
> -M:	Dan Williams <djbw@kernel.org>
> +M:	Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> +M:	Jason Gunthorpe <jgg@nvidia.com>
>  L:	linux-coco@lists.linux.dev
>  S:	Maintained
>  F:	Documentation/ABI/testing/configfs-tsm-report
> 
> base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e

