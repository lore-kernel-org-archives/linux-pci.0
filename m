Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4E63446CB;
	Fri, 23 Jan 2026 03:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769140579; cv=none; b=sB7U6VG/QZfM6zqpjzRoNoEN44Oc1IOuqF8wGBeVqrru6BSki7pTmzLVjrD6VLyxJCkv3Y94xLAacCdxu1kogXUIp5aZJa+9WKNqqMPM1D6RqiwZ8SWVoZzbuKMGYbhDUtqzUbNXHs+w7nbF+STAEu3pVLusCcoxVkXmhLrSo10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769140579; c=relaxed/simple;
	bh=cWnGLaGXBLgDYyxWoqBvV8qX2dwkHdhEwVAZOn/L4cQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMbf4Q2jy5MVZg/M3AYHjflOMbRSgapakKNNESekNs9QrlP4kEVdTedXs5+JUqrogarIAN/dCIS9NVstWFL0IeO4RdTMULTKu/s9DWJGSRI05nB5356Wsu7nfmAzn2BydxtSdwF7E3/+cW9S1ob7C5jvnkKzwd26URIay9DVbRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LVywQc+S; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LVywQc+S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769140573; x=1800676573;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cWnGLaGXBLgDYyxWoqBvV8qX2dwkHdhEwVAZOn/L4cQ=;
  b=LVywQc+Sw2VJqy6HItzS8ptJf7dHCZZJI4bahYKR5hRBmGMXDynL7VqI
   eGoJFP7/WoDWUAHJHwFhL9D67xp1jTHwnLx5TQ53Rfo1nuT1171NazXSQ
   9U7AM+ovjthBHB1TTqaaGYSpOTmPeKfZpN/CUvfVBZwUBCMDJTDs8u5LJ
   AaBLzH5zNIueSH8HtQlythpq+qdCxPbQC4KcjliHc56uZ8nwjQbwmcrw2
   lDb3a5gfZCWetp93lW5rwVRpRV9eoSggT0Z0tTKvpFUPMNzdlNUj0He3p
   ERn8M3gx05DhY+pFr8EbDzHi4Io/WSIwU4PahzB68rcFQRvFWNQFocLhI
   w==;
X-CSE-ConnectionGUID: SMrfSoX+Reiet9QXdKiRnw==
X-CSE-MsgGUID: ITClwHslTJCQBHydjOXo3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="70557103"
X-IronPort-AV: E=Sophos;i="6.21,247,1763452800"; 
   d="scan'208";a="70557103"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 19:56:06 -0800
X-CSE-ConnectionGUID: 05q4ytmWR0uWWtwC5oO4Bw==
X-CSE-MsgGUID: t86tD3WgRyGdZ14Uih465w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,247,1763452800"; 
   d="scan'208";a="211049367"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa003.jf.intel.com with ESMTP; 22 Jan 2026 19:56:03 -0800
Date: Fri, 23 Jan 2026 11:38:08 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: dan.j.williams@intel.com
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	yilun.xu@intel.com, baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com, linux-kernel@vger.kernel.org,
	yi1.lai@intel.com, helgaas@kernel.org
Subject: Re: [PATCH v2] PCI/IDE: Fix duplicate stream symlink names for TSM
 class devices
Message-ID: <aXLtILY85oMU5qlb@yilunxu-OptiPlex-7050>
References: <20260105093516.2645397-1-yilun.xu@linux.intel.com>
 <6972c872acbb9_1d3310035@dwillia2-mobl4.notmuch>
 <6972c9b522ef_1d3310053@dwillia2-mobl4.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6972c9b522ef_1d3310053@dwillia2-mobl4.notmuch>

On Thu, Jan 22, 2026 at 05:07:01PM -0800, dan.j.williams@intel.com wrote:
> dan.j.williams@ wrote:
> [..]
> > However, after seeing Jonathan's feedback and noticing that he missed
> > that 'H' 'R' and 'E' are documented in the host bridge ABI I think it
> > would be better to simplify this to just a link back to the host bridge.
> > 
> >     /sys/class/tsm/tsmN/pciDDDD:BB => /sys/devices/pciDDDD:BB
> > 
> > That achieves the same result and is easier to document as "When a TSM
> > has a established any IDE stream it links to the host bridge. When the
> > last stream is removed the link is removed." It achieves the goal of
> > letting an admin do "ls /sys/class/tsm/tsmN/*/stream*" to get a survey
> > of all consumed stream resources in the system.
> 
> In fact it does not even need to be dynamic. At tsm_register() time when
> @pci_ops is provided, link all host bridges. Unlink them at unregister

I'm sort of supporting dynamic. My DUT has 40 host bridges registered,
most of them has nothing to do with TSM/IDE, so I'm afraid if it is
overkill to list them all, and bury the real TSM capable bridge in the
noise.

And if TSM always list all bridges then why we need these symlinks, we
can just:

  ls -d /sys/devices/pci*\:*/stream*


I assume the annoying part of dynamic is we need to refcount, which IMHO
unnecessarily complex and you are trying to avoid, is it?

> time. The only driving need for it to be dynamic is if there is ever a
> platform that supports multiple TSMs each supporting a different set of
> host bridges. Can cross that bridge later.
