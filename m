Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FE1332916
	for <linux-pci@vger.kernel.org>; Fri, 24 Apr 2026 08:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777019940; cv=none; b=gB64Hwfy6oToaYpCpXPfvnrlTeD8pYiOEn8CN9N8FMkiVosrQqH2Ji7syZqdEWDFxZkvepWX5B2wAtXoJEgXprhA2KA1s2rSEGmed0SXRTv2Ab5GQmYiAa/r3/QNpXyxwOYRbLRCPfRSK2ShTEHVGCcSuH8jjwR/GIp+5SZrXdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777019940; c=relaxed/simple;
	bh=CjuCkvBq1PB8b+gCgvVo/yQ7x7TLVoccW07r7OtiyA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SD8CTg9Fjs5dyv9LSuh5rpmR4843xGZoMa+FIf1XJeQvcWkvqYckyh8O+yMTV6IRUgt9whJvTYaGMKUqNIKHYcBMeJn+sl90+8yq3tBgTb+GHG5KGggM8UgEbdP9DpGGVpj7oTvMqzl5U0lLTph3oW9bh/g+FDZsewpyhMM++oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cn1/Syts; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cn1/Syts"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777019940; x=1808555940;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=CjuCkvBq1PB8b+gCgvVo/yQ7x7TLVoccW07r7OtiyA0=;
  b=Cn1/Syts8F1sOJ30Ns1ehoEvgIl0FztgFVzkySWX66UHHm5yC/fionTl
   V2o4Ymv8THMkldQdeOFzwW8Sf9kd9F7oq5BFtV1OxnH8mKpSSOaK7bL5s
   IdKTKOEo+36yk6ADXDRFd2qfEW+UEbr1YrCAAXrJ1dlZStBxVehGDrRy5
   4whNw5UaxT+N5NJFNkSmenh0tpiMk7DrodtwJWNXwInHhlcm9z44s0vVb
   toKsaASII37DxjbnEeWlZmNETE/v5mnmztH154Guz9u8lvGhA2DO8aj7h
   drjoOcUio7lqAWXl2iTPEZJDVEI/BJHGPb7RmDODY+6o6k1VKGqGDFn+T
   w==;
X-CSE-ConnectionGUID: Bvrk7ivNTiSLkIST3LjWRg==
X-CSE-MsgGUID: iJmIAqkqTf+ecVKENCAWDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="78112195"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="78112195"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 01:38:59 -0700
X-CSE-ConnectionGUID: xrXG/JEYQyOfYAGawkKo+g==
X-CSE-MsgGUID: o8lKoOCnSTCY4jiwR+HuEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="237951143"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.71])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 01:38:57 -0700
Date: Fri, 24 Apr 2026 11:38:54 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org, Xunlei Pang <xlpang@linux.alibaba.com>,
	oliver.yang@linux.alibaba.com
Subject: Re: [PATCH v11 0/2] PCI: Fix crash when access broken ROM
Message-ID: <aessHrL4jkCbSjNA@ashevche-desk.local>
References: <20260209175432.GA196137@bhelgaas>
 <e607705c-b4eb-4582-b941-28e9a318dbe2@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e607705c-b4eb-4582-b941-28e9a318dbe2@linux.alibaba.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Apr 24, 2026 at 02:32:06PM +0800, Guixin Liu wrote:
> 在 2026/2/10 01:54, Bjorn Helgaas 写道:
> > On Mon, Feb 09, 2026 at 02:43:39PM +0800, Guixin Liu wrote:

...

> > > In this version, I fixed the case issues in the first patch title.
> > Will do, thanks.  Since the v7.0 merge window is open, this is on my
> > list to look at as soon as v7.0-rc1 is tagged, probably on Feb 22.
> Hi Bjorn, looks like these two patches still haven't been merged, Would it
> be possible to get them merged for the 7.0 release?

v7.0 has already been released. Now it's a v7.1-rc1 candidate at best.

-- 
With Best Regards,
Andy Shevchenko


