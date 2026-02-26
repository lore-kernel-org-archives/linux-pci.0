Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3ED33A6E8
	for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 11:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772104353; cv=none; b=tkjk2BXVehTI+5qPOsl8FIpwahx3OHp9Sc+lEpFqlMT/xLwGfxPMLbJxYj1IVtzy8nEmvLllbkN2mjv9gsBvVI7X4iQ7RJwTf7jwdVk+ygnUY7rQ3CmEyHVslvCGO6qnbj4K+FPBp9XMCDdqjcK55dGWXGi5MrFRS5BHQqSFzoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772104353; c=relaxed/simple;
	bh=WFfTXvkY3j+SoJDH54wiCqus/kuOOnnLM0PuPglxNMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FgQ4/MlQ+gEuZ4j7a7+IZxHdnSZzsR7rhMZbxFzSec+Pmp1aHn1jn0uYCZn9MqTq3X8M8KF4bxKANdEEYNnpA/Q1w4Gqj11wPX1gEC6Wp518xcN2kXdu8hvR1k8Mr/W5welgCkFAKjTEU4IB70YQt7Xn1eVLVabzQ04zshDCMno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DEPCYBHT; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DEPCYBHT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772104351; x=1803640351;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WFfTXvkY3j+SoJDH54wiCqus/kuOOnnLM0PuPglxNMQ=;
  b=DEPCYBHTNdqvLrlOznwRN4B+yoRyEJdkixjinYLlPX/2S3GCF78qkY6o
   cRNpIcqBVFQ2tTJ0D2DxJ7tae1Q4G/+gXVYKexTvE6YvMR376EssK3z+q
   8/rpawIa+9gCpR0N75RvLUdIE85LatzTFp9MbX6SS8chfgISwr+ljlwvj
   q0IVfpq7oXIM2pHUjWik1+sisf33a1+dzNj69pizpA8Fk8UIk2L6676mO
   3Vwh41mHEj5BGwY9HondPkoJq/FxBUvXQKsuNitlUCzYc1ydhXFpbneLu
   q846bFUsKdJb+AcWQAQde1tH4FHIxd4k16W8K8zI9ejtVB0QcQCWzV5zM
   A==;
X-CSE-ConnectionGUID: Rfr5s1YOSNG/6DMnI0/WiA==
X-CSE-MsgGUID: gq7a85b+Q1maCgwZuOq51A==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="83490452"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; 
   d="scan'208";a="83490452"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 03:12:30 -0800
X-CSE-ConnectionGUID: 2CKX5bs0QT2/SF3IDQgZ6Q==
X-CSE-MsgGUID: 5F9yTyDCT3imhCDA6WsdmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; 
   d="scan'208";a="244130173"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa001.fm.intel.com with ESMTP; 26 Feb 2026 03:12:25 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id A041B99; Thu, 26 Feb 2026 12:12:24 +0100 (CET)
Date: Thu, 26 Feb 2026 12:12:24 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Vitaly Lifshits <vitaly.lifshits@intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Dima Ruinskiy <dima.ruinskiy@intel.com>
Subject: Re: [PATCH 2/5] igc: Let the PCI core deal with the PM resume flow
Message-ID: <20260226111224.GL2275908@black.igk.intel.com>
References: <20260224111044.3487873-3-mika.westerberg@linux.intel.com>
 <20260224165837.GA3736201@bhelgaas>
 <20260225122619.GA2275908@black.igk.intel.com>
 <87jyw09y2r.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87jyw09y2r.fsf@intel.com>

On Wed, Feb 25, 2026 at 03:56:44PM -0800, Vinicius Costa Gomes wrote:
> Mika Westerberg <mika.westerberg@linux.intel.com> writes:
> 
> > On Tue, Feb 24, 2026 at 10:58:37AM -0600, Bjorn Helgaas wrote:
> >> On Tue, Feb 24, 2026 at 12:10:41PM +0100, Mika Westerberg wrote:
> >> > Currently igc driver calls pci_set_power_state() and pci_restore_state()
> >> > and the like to bring the device back from low power states. However,
> >> > PCI core handles all this on behalf of the driver. Furthermore with PTM
> >> > enabled the PCI core re-enables it on resume but the driver calls
> >> > pci_restore_state() which ends up disabling it again.
> >> > 
> >> > For this reason let the PCI core handle the common PM resume flow.
> >> > 
> >> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> >> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> >> 
> >> I love it, thanks a lot for doing this!
> >> 
> >> Do we still need the pci_enable_device_mem() and pci_set_master()
> >> in __igc_resume()?
> >>
> >> I suppose some of that is related to the pci_disable_device() in the
> >> suspend path (__igc_shutdown()), but there are only a few dozen
> >> drivers that do this, so I'm not sure it's essential.
> >
> > I think they are just as you describe due the fact there are explicit
> > pci_disable_device() calls. Probably we can get rid of them as well but
> > that requires careful testing that nothing accidentally breaks.
> >
> 
> This series is solving real problems (thank you btw), I think the
> pci_disable_device() one would be better as a separate series.

Okay works for me :)
