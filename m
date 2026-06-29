Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD66740D59F
	for <linux-pci@vger.kernel.org>; Mon, 29 Jun 2026 17:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782753517; cv=none; b=A1rSPPD039MUP+juZB2BsLb87yUdg+DtzKf5G2AOCjM9sYcYix2Vfuo9IVqLBiuwgvepayx8SrH0qR6+mqqMCbXBzqo82+Bsk1ZMM+Xc/F8hyM5g/Fb8dDH9eiLUWd20Ke9O3P3HtMpUKyXFpPVF2d8Oj3pYfeVZJgm3fsaxU7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782753517; c=relaxed/simple;
	bh=nDyNKLFBqjMFpuWUcWrQamhSntDzVB9Y+Uo+4cx1HVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tpkVNRfjTdVeHC/lSiIFLezgN1Ot+kNR3LmpRbiPZyCpF7sjYqAKUWzPohViTo64wLvnw9NfpolZ9YXEdTq6LSArWcxf+FbNftkyZwxUGAHWM2C6VrSOxluAPJgWNNSToVj4f6Sz52D7hGiNA4oTxAvdMR73MFf03rNgf8q9jsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y4EM7UuE; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y4EM7UuE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782753515; x=1814289515;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nDyNKLFBqjMFpuWUcWrQamhSntDzVB9Y+Uo+4cx1HVk=;
  b=Y4EM7UuEcAGAIgfOnpHmX5yn0Bfb4GFIETTODQ7lHXzVkP6xrux6hdrL
   jBsjrAcMI3n9SZDC7zKDCMIpZidH7465vriw1We0j+vQp5UTVyWxx0dpW
   YhcqpGKDOQhydOEZ++VyxG+wlwvi5z9Ku4YNKQK9gmEhSHcm39PRdL03h
   4mDHuAfFSyIbcz64HCswGrzjwphLqn96AEDisfsVl92b6QsZyY2TdI9i8
   F/UXnMmHYr8b/jYLEsczBxakfLyUI4L2aZSmqGc2gyrkaWI3csvVzb3sz
   PFcK7+rnPW6gcWN7V7VqsqsJlWtUlzzknT8usB392wQSKbEjsQ4dGsNKT
   g==;
X-CSE-ConnectionGUID: kj/0SM/xTi6Na/m6ZVaiJg==
X-CSE-MsgGUID: KNW+breYRf6V4AU7SUfUQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="106247285"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="106247285"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 10:18:35 -0700
X-CSE-ConnectionGUID: +yOnrEtWQcuPOKr8VJ5xrg==
X-CSE-MsgGUID: JtHLEYcESzOj/KP8byTjcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="245664688"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.207])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 10:18:33 -0700
Date: Mon, 29 Jun 2026 20:18:31 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nirmal Patel <nirmal.patel@linux.intel.com>
Cc: nirmal.patel@intel.com, linux-pci@vger.kernel.org, bhelgaas@google.com,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	lpieralisi@kernel.org
Subject: Re: [PATCH] PCI: vmd: Only assign _OSC features in bare metal OS.
Message-ID: <akKo5w359FZU3uDU@ashevche-desk.local>
References: <20260629170243.269830-1-nirmal.patel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629170243.269830-1-nirmal.patel@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 29, 2026 at 05:02:43PM +0000, Nirmal Patel wrote:

> Copy valid _OSC flags from root bridge only when OS can provide correct
> values. In virtual machine, all of the control features are disabled as
> hypervisor will not passthrough root bridge information to VM.

> Reviewed-by:  Andy Shevchenko <andriy.shevchenko@intel.com>

I confirm that I reviewed this internally and agree on the main approach and
the implementation. I think it's a redundant period in the Subject slipped,
but it maybe tweaked whilst applying I think.

-- 
With Best Regards,
Andy Shevchenko


