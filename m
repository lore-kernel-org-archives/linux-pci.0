Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C442857EA;
	Wed, 22 Apr 2026 06:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776840871; cv=none; b=Epfbo5pUQIdiyDQy5ryMcf6SKZeDIxjXtGpyun22W3E52xdKbgRlk+yUVPPLw6/TZJJOxuR1w0hnPyCnb+ytnvaiKtMTC5EpQyNKGlUULrr0nL6fF6u2kAQJqvjqLOChdgDpOYtFOW96tO+bojmscZTWKdor+dPTz5JEsZSBpA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776840871; c=relaxed/simple;
	bh=EvDMWnHQWcDDP8K40VNSkgMF2bbZlcj4t4u2ti+GU8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sxjvudB7vPrb047k5P4yp5+sVpgM29QhsFL4EjUJndb2midhV0cLydlVNwTXTyhDquAQmuqrxClIf2DflI4BAr3RTvVooPqww/LZtMxn8VpfpUH3ZZBuGG73rHZU7eYxsIjmHcwAuBRBYn8y/O7jZUCT97SErH4XNXhCszfMcPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AD2WnQRt; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AD2WnQRt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776840870; x=1808376870;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EvDMWnHQWcDDP8K40VNSkgMF2bbZlcj4t4u2ti+GU8M=;
  b=AD2WnQRt+L55+5sXIHAhTwiytZNcXPVq0hC7V9bU42tioWD1GmkJYMh4
   bGHGEd172CIVxJWoOlvGbfiNS5NRhlmXuyz0PAPMfTZZD3CDEqjwbg8Nn
   LYF/9Py4BTe0A81JgLnCYd1ovrWWrb6ne3kbxYs5Akm7niJW1o1zEDBk3
   iJaG8yppA9r6g/o264XQ1wqqEnFWi8kig/k2BTaWKh6Le7EAgFUXDUYg2
   jsXc5Loql0HC3qE+iWo3vE4NFgFGJL8coaeFesUo5T+HjyjBPsuv4TIvB
   p3p1Xdc8a3FQejM8GFB1zzTeiMGXYDTyPkQRZhLXqhchVqJMzJsjOCk8G
   A==;
X-CSE-ConnectionGUID: HhXdhGnuS6ShYDMC1RxbJg==
X-CSE-MsgGUID: xL3F/ypvSkit4dnA3CTrOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="77663724"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="77663724"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 23:54:30 -0700
X-CSE-ConnectionGUID: SqxfaiLBTyePG01Wxr3uSw==
X-CSE-MsgGUID: wqHnRg0HSP64051zbrOeKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="237309104"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa005.jf.intel.com with ESMTP; 21 Apr 2026 23:54:26 -0700
Date: Wed, 22 Apr 2026 14:32:13 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Williams, Dan J" <dan.j.williams@intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "Gao, Chao" <chao.gao@intel.com>,
	"Jiang, Dave" <dave.jiang@intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"Xu, Yilun" <yilun.xu@intel.com>,
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"kas@kernel.org" <kas@kernel.org>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"Verma, Vishal L" <vishal.l.verma@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 21/31] x86/virt/tdx: Add SEAMCALL wrappers for trusted
 IOMMU setup and clear
Message-ID: <aehrbSkgK7dWl1S/@yilunxu-OptiPlex-7050>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-22-yilun.xu@linux.intel.com>
 <BN9PR11MB52765F4804B8E2223BBB0B1F8C582@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52765F4804B8E2223BBB0B1F8C582@BN9PR11MB5276.namprd11.prod.outlook.com>

On Thu, Apr 09, 2026 at 07:30:32AM +0000, Tian, Kevin wrote:
> > From: Xu Yilun <yilun.xu@linux.intel.com>
> > Sent: Saturday, March 28, 2026 12:01 AM
> > 
> > From: Zhenzhong Duan <zhenzhong.duan@intel.com>
> > 
> > Add SEAMCALLs to setup/clear trusted IOMMU for TDX Connect.
> 
> what is 'trusted IOMMU'? a new hardware, or some sensitive resource in
> the IOMMU which is only visible to TDX module?

Some extended HW resources in IOMMU so I think the later.

> 
> If the latter it's clearer to say "trusted configuration in IOMMU".

Yeah. And I realized there are more configuration except IOMMU, so I
would say:

  Add SEAMCALLs to setup/clear the IOMMU device and related I/O stack to
  work in trusted (TDX) mode.

> 
> > 
> > Enable TEE I/O support for a target device requires to setup trusted IOMMU
> > for the related IOMMU device first, even only for enabling physical secure
> > links like SPDM/IDE.
> 
> this series is just about SPDM/IDE. then the first part about TEE I/O is not
> really relevant.

This is truely obscure. I want to clarify some potential concern about
why we need to setup IOMMU when only to enable PCIe link encryption, my
re-phase:

    With the setup SEAMCALL, TDX Module ensures that related resources in
    the IOMMU device & I/O stack are in expected state and protected from
    further untrusted access, so that subsequent SPDM/IDE enabling is
    secure.

> 
> > 
> > TDH.IOMMU.SETUP takes the register base address (VTBAR) to position an
> > IOMMU device, and outputs an IOMMU_ID as the trusted IOMMU identifier.
> > TDH.IOMMU.CLEAR takes the IOMMU_ID to reverse the setup.
> 
> Intel IOMMU is called VT-d. It has a register block but not a PCI device so
> there is no BAR resource related.
> 
> let's just call it 'reg_base'

Yes.

> 
> intel-iommu driver already has its own 'id' definition for each iommu device.
> It's clearer to add a prefix to this new id, e.g. tdx_iommu_id?

Yes.
