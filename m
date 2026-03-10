Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633953246E8
	for <linux-pci@vger.kernel.org>; Tue, 10 Mar 2026 15:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773155992; cv=none; b=WykWSq3w3ObhbC8z3wfSLZR6yLq8X3XK02yXPcEkjL6jmWdUIgLSySEB7O7LitdV9NhDfu2h3j/8B9HTPRABqSymgZwb44dq6bygJQ7HneRr5AHS5ZKtaqlELMth5KjhQQ9CabcP+gy9RJdOBYiSphdydVeE6e0yoAM6KXEy8YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773155992; c=relaxed/simple;
	bh=t0mpfZD9ghiA61gvfNsCWxTjADq9UDNAwEA9lpLiHF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxcxdLtxp1avAAwwsCv+VCbpIMt8AnMqcGHZsd5mGyG2N6JCaNF6z1tsm6ue0f6KtXs5V1XJDh8PD8H6kPK2aBGDfY66sUNe6k8XVqq+7t0ijExPcf24Adl3Nl9O4iufbfddQchQ/yceaUpwCbrS4dydYzPsnBssJSR8YspIzCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dx6h0Fcl; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dx6h0Fcl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773155991; x=1804691991;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=t0mpfZD9ghiA61gvfNsCWxTjADq9UDNAwEA9lpLiHF4=;
  b=dx6h0FclaRbo77NeTa2oqlxbzFi8LQx48a8lNWOYFKz0q7z2x5bBsNsX
   +gHOFi7Og06ZyVTZ+DtGQFXKMoT7SmoDFE+hVNsEsDxYMu8vwHXdnxMWT
   NfeIAuc4AfI3QiC14rgunkkz2qrnJtoNZIjnHU6MBh8eP5pFLkp5YFUgc
   T0Est5ols4kmUaai880F2Fan13zMDTEqithNjOMTMxv/dCbeHFVy/OfgI
   bvDT2aP9jSjsqA9Z0dKJSAlClBEkOBO+tuh3J6HXLxc0ySo8e/qiIEN2X
   vJQkj1ZFUImiPbwi0Cc/hA0wE9uWDME+R/rw5m/9+DmDoFleK9HbvzOBN
   w==;
X-CSE-ConnectionGUID: ZYHR+/yeSUKDAHVijbKFXQ==
X-CSE-MsgGUID: 0UUJWOI4SgK3yNUqJbcUzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="78059673"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="78059673"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 08:19:50 -0700
X-CSE-ConnectionGUID: kAPgrrb6Tc6kpxo5u+WHfQ==
X-CSE-MsgGUID: lT61rQ3kRnSZ+wVoGO3qzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="220111991"
Received: from zzombora-mobl1 (HELO localhost) ([10.245.244.33])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 08:19:49 -0700
Date: Tue, 10 Mar 2026 17:19:45 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Simon Richter <Simon.Richter@hogyros.de>
Cc: linux-pci@vger.kernel.org, intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 4/5] pci: check if VGA decoding was really activated
Message-ID: <abA2kQScB-m2ka3K@intel.com>
References: <20260307173538.763188-1-Simon.Richter@hogyros.de>
 <20260307173538.763188-5-Simon.Richter@hogyros.de>
 <abAChDpsUQhpnOcT@intel.com>
 <1a7a9d17-5086-4fdb-83e7-56d5ddaaadbd@hogyros.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1a7a9d17-5086-4fdb-83e7-56d5ddaaadbd@hogyros.de>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland

On Tue, Mar 10, 2026 at 11:08:40PM +0900, Simon Richter wrote:
> Hi,
> 
> On 3/10/26 8:37 PM, Ville Syrjälä wrote:
> 
> > Maybe this should also have a comment or spec quote to explain
> > that it's legal behavior?
> 
> The PCI-to-PCI Bridge Specification version 1.1 has in chapter 4.5 "VGA 
> Support":
> 
>      Bridges are not required to implement the VGA support mechanisms
>      described in the following sections.
> 
> So this has always been optional.
> 
> What is a bit annoying is that I cannot find an explicit sentence 
> allowing the VGAEnable bit to be hardwired to zero in that specification.
> 
> It is explicitly allowed to hardwire the VGASnoopEnable bit to zero if 
> VGA palette snooping is not supported for downstream devices (Table 3-2 
> "Command Register"):
> 
>      Implementation of VGA palette snooping by a bridge is optional. If
>      VGA palette snooping is not supported, this bit must be implemented
>      as read-only with a value of 0
> 
> That is the command register though, not the bridge control register.
> 
> The bridge control register documentation (Table 3-9) does not 
> explicitly say what should be done if VGA support is not available, but 
> the behaviour of the VGAEnable bit is a superset of the VGASnoopEnable 
> bit, and the VGASnoopEnable bit becomes a Don't Care if VGAEnable is 
> set, so "the bit must be hardwired to zero if unsupported" appears to be 
> the only valid interpretation.
> 
> This seems to be the behaviour of all the devices I have available:
> 
>   - IBM PowerNV PCIe root bridge (POWER9)
>   - SiFive VisionFive2 PCIe root bridge (PLDA XpressRich-AXI Ref Design)
> 
> Both read back this bit as zero when written via setpci:
> 
> # setpci -s 0000:00:00.0 BRIDGE_CONTROL
> 0002
> # setpci -s 0000:00:00.0 BRIDGE_CONTROL=0xa
> # setpci -s 0000:00:00.0 BRIDGE_CONTROL
> 0002
> 
> There is also a question in the Altera support forum for their PCIe Root 
> Bridge IP at https://community.altera.com/kb/knowledge-base/-/345837 .

Yeah, looks like the exact explanation was only added in the PCIe
bridge spec. Before that it was somewhat ambiguous.

> 
> > The slightly bigger concern I have is whether we need to unwind
> > the previous steps if this fails? Looks like we don't update
> > vgadev->owns on failure (even though we may have partially
> > enabled things). But since the bridge should never forward any
> > VGA accesses, leaving some extra PCI_COMMAND enable(s) set on
> > the device shouldn't matter in practice.
> 
> I was thinking the same, but because we're going upwards in the 
> hierarchy, the bridges we leave enabled are downstream of the bridge 
> that refused to forward.
> 
> I can add this for completeness though, that should be fairly easy.
> 
> > So I guess this should
> > work even without unwinding. Well, not sure about
> > arch_set_vga_state() since that's 100% magic...
> 
> It's not entirely magic, because after success from arch_set_vga_state() 
> we still go through all the bridges. I believe uv uses it for some kind 
> of paravirtualization.
> 
>     Simon

-- 
Ville Syrjälä
Intel
