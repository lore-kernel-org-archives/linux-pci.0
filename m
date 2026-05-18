Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299D7265621
	for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 16:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779122086; cv=none; b=VBGrqc+MKNsATqM6KJceTBOoYkEgtng1p55pp2sCNs4HqwDY8kz1PZzRgDpCL5+yo9jHnvgTdaMgesMmw+YvQN1Tz9qry9wuniaKn96iL0uT8354+EUSfVD4ce/tCFJbpUTEXxN3gwT04iNp+DhdWSWLVTqy5JokLyPmR5mtls8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779122086; c=relaxed/simple;
	bh=sBQFoLE033+2KzzyiFT/dlWK00kjE6B1jfHaTnnTCLg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hdPxNsFOmTiINh2pAvijpCVI+M1EGjNTnIX8YyVTq7C3L6VMzuhDqYZ8buG6bvzQYeAiSuygI4/IerKbt0B71pFIYD6amqBYWYUuUZPEA2S0FF0fxcOVN3nVXx/QKehNAwwqieIrnp/n8n8yHydymwKI/loL6DjXnPFWUYOulGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ctVY4dY+; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ctVY4dY+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779122085; x=1810658085;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=sBQFoLE033+2KzzyiFT/dlWK00kjE6B1jfHaTnnTCLg=;
  b=ctVY4dY+IPBG1ecISmRz0gUy6MnsrMz8AA5L04DPjrWnCLJJnFlay0oM
   SUKdWFkY1o3JcWHxl3SP/+TBY3wv3qPyjH7Ue5aBHXRF4dtIbcvJQ1S/T
   vTJaiSNkH2AOjNpvCMN1oYiJ8/SFsz/MfJW4biGfre11QNnOx1l+g2NrC
   KumW0fGr6e6ypIjFkFOiEPygDX1F8pDAte2p8TscZflV9bdP6eT2TSTUm
   DFNOmP+iXHvVCa2CsnEzXtKz5Rr4Fnito6NsW0wI174MZdJxpfAUN2yjp
   hdKk5SClB7HGybPXux4U5ukihc8MlMMeG+xA1NEG83yloiYMFaXfVXP83
   A==;
X-CSE-ConnectionGUID: 0TOijhHvQhKUGcFPb6v5JQ==
X-CSE-MsgGUID: aDuIslShQSyHx00KpaTtfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="97550545"
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; 
   d="scan'208";a="97550545"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 09:34:45 -0700
X-CSE-ConnectionGUID: cTO3XNYETFu+YnhsHiXHfQ==
X-CSE-MsgGUID: SmlCRPVKTTeierLDRkJAGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; 
   d="scan'208";a="235224202"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.101])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 09:34:42 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 18 May 2026 19:34:39 +0300 (EEST)
To: "Li,Rongqing(ACG CCN)" <lirongqing@baidu.com>
cc: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>, 
    "ryder.lee@mediatek.com" <ryder.lee@mediatek.com>, 
    "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: =?GB2312?Q?Re=3A_=B4=F0=B8=B4=3A_=5B=CD=E2=B2=BF=D3=CA=BC=FE=5D_Re?=
 =?GB2312?Q?=3A_=5BPATCH=5D_PCI=3A_mediatek=3A_Fix_operator_pr?=
 =?GB2312?Q?ecedence_in_PCIE=5FFTS=5FNUM=5FL0_macro?=
In-Reply-To: <953a48ccc3a94a29887a8059edc21a2a@baidu.com>
Message-ID: <3994196b-b86d-9b88-b1da-6522d245d1c8@linux.intel.com>
References: <20260515005552.2343-1-lirongqing@baidu.com> <20260515013659.DC03BC2BCC7@smtp.kernel.org> <953a48ccc3a94a29887a8059edc21a2a@baidu.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 18 May 2026, Li,Rongqing(ACG CCN) wrote:

> 
> > 
> > Thank you for your contribution! Sashiko AI review found 2 potential issue(s)
> > to consider:
> > - [High] Fixing the macro changes the configured FTS number from 0 to 80,
> > conflicting with the comment requiring 250 and potentially breaking L0s link
> > recovery.
> 
> This requires confirmation from MediaTek
> 
> 
> > - [Low] Missing explicit inclusion of `<linux/bitfield.h>` for `FIELD_PREP()`.
> 
> This isn't an issue. The current file includes ../pci.h, and ../pci.h 
> includes linux/bitfield.h 

While likely true on surface, nothing in pci.h is fundamendally such that 
it would require bitfield.h.

The include is there because of some static inline functions but lets say 
somebody want's to refactor those functions into some .c file if the 
function logic gets too complicated (infact, both are quite complicated 
as is!) and remove the bitfield.h include. At that point, indirect include 
chains are making the post refactoring cleanup harder.

That's why it's better to include what you use in each file.

-- 
 i.

