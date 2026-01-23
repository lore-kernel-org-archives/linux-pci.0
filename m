Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A2A33F37E;
	Fri, 23 Jan 2026 06:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769151539; cv=none; b=gWlLS0cDthq1NgSnHXLhCJ6XDHrJmM9vlaUWJX3zD4JNS7S7FchzBavlT5Y2XDiiz/KcV9/p7aOlFsagFIewxccnz56ctnAB4R6+zW9r0OZ0Lss9lxVVfV4rMXzRfH39x4SjGzCC9mhr/cFjKQmnOyd4t48/KTeeVCSY26j94+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769151539; c=relaxed/simple;
	bh=Dmw/G5RIZvvD8ZHy/LT6s0YJpihvXwF2H5np16J6wwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQIjMUC9xcTJRvUxysmC5apK9bZ7DL/bElXGgL86Td9UcD+/DZqPr/JvMRXzmqCQRr/qRcA9uRMAgzhJS5lQlJZ5AHX7lz3NXRW1zZnAG3sO897NVitKUiPmYSu9mAuwdE1uWjHmdwWMT5UL6UnQybeawvhodXndXhanAzNIdKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gZOzEAzO; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gZOzEAzO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769151536; x=1800687536;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Dmw/G5RIZvvD8ZHy/LT6s0YJpihvXwF2H5np16J6wwQ=;
  b=gZOzEAzOxekiKo0fOSTwRM/8GuJeWAtTFOXNXmEjquEzuS9teCbxq9UK
   N7b0A4792NZEpY6/hQ24zyAZYV7dTKBZks+WTlkjHwWsGDmVI2K8NP/kl
   jsym8V7s7O+JtCzxmK7WfYzS7C+sPkwEMXS45JROEEoExvmoX5QJoNO6q
   Putffj7bCXA+Fl73rg3uN9wdpln6ltZCFR5MuKLVX5oPObXjftIg5kSG7
   5//IvzmcP09nh0HUHrEnswqQIdxIuY70hVhgkVSIX/ySe/59KNpy+LhCR
   7y4NDw1mwRNnVW9a2eVa3Tw1fyXMeNSjuTvQjQ9Ewjg/sL+dpojU5AYfD
   A==;
X-CSE-ConnectionGUID: +n2tlBE3QVOIWxoP9GypyQ==
X-CSE-MsgGUID: Qipsip7iTs+icugR2o8rFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="95875037"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="95875037"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 22:58:53 -0800
X-CSE-ConnectionGUID: nP7xVJvxRouYz7yoGdPhqw==
X-CSE-MsgGUID: 88sA91CeQ5mE8JNuAtkEVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="206774794"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa009.jf.intel.com with ESMTP; 22 Jan 2026 22:58:51 -0800
Date: Fri, 23 Jan 2026 14:40:55 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: dan.j.williams@intel.com
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	yilun.xu@intel.com, baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com, linux-kernel@vger.kernel.org,
	yi1.lai@intel.com, helgaas@kernel.org
Subject: Re: [PATCH v2] PCI/IDE: Fix duplicate stream symlink names for TSM
 class devices
Message-ID: <aXMX98p1RMLwOEGe@yilunxu-OptiPlex-7050>
References: <20260105093516.2645397-1-yilun.xu@linux.intel.com>
 <6972c872acbb9_1d3310035@dwillia2-mobl4.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6972c872acbb9_1d3310035@dwillia2-mobl4.notmuch>

> That is all a bit too much to do at this late date, so I think for
> v6.19-final just delete this ABI, and try again for v7.0.

I agree.

> 
> -- 8< --
> From 2d236b203ea155d16d3251bd0e3bf4eeab2fcf6b Mon Sep 17 00:00:00 2001
> From: Dan Williams <dan.j.williams@intel.com>
> Date: Thu, 22 Jan 2026 16:35:56 -0800
> Subject: [PATCH] Revert "PCI/TSM: Report active IDE streams"

Tested, no problem.
