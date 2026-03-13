Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DF736CDEA
	for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2026 10:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773397096; cv=none; b=q7BDsUJtUNlI5EIRDfelFvmo3AMvtipul+fWqX2vg84NkhsWqMV59nBRoYUc9q6q7GCdZwCFa9Wn0guOM7r7cQ+jrHZu2tORwN1uifIDpyj9aEGh7V1CbnDLQ5IE52BkZxx621ljmH4eOEQ5ts7/nggBhBVbgA/TNXnCu3kjT2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773397096; c=relaxed/simple;
	bh=V4EwiYsitgnGyEK/Z5yCs78CovFdn7wpayzG7cxu8iU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sqs2sjDBhEwA4I349ErgWwxMLfgHxN7n0o3yNwJKZpx+plvad7qdA6R8ZCZDg50IjSplZQAoKz3A+kFoB+Ue3BAZSn/SOUFHIGTaMPS9B3M1ZiLVRxpLA4I7ekRC681fIXexitxu4VBVN+BgGr7lye4HhK9xOMKGo6wR2wViWkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=URnzJxWP; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="URnzJxWP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773397095; x=1804933095;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V4EwiYsitgnGyEK/Z5yCs78CovFdn7wpayzG7cxu8iU=;
  b=URnzJxWPZHnDJr4R00sd17Fotc4Ng5xcQrRAJOrfdEJ7IfIwPJQ6FR7a
   P+/xwTeA/YxW5U+7gQPB9c8IWsPksH/d09i36Ii+Gq2YdGnDZZbRaJ1bo
   YhSd+aLtkKtHXB+x6YDvzdSIr+M8mZVwRA1+WUmOoING+3j8pZybgf9XE
   ShxEm99W+vBm2VUIM3yIbDS0YysYBHcpwyORr/t10gCB3wr+cwYdfz0zn
   y9QWpyPwfulfr6L5clpaByyXlNbXXf5ogR1CWz+UFiPfupGQ1x64ItC5k
   yn4kxkCVVm1XBv59B360hqlSqt/uCkxTKD08zOUaro+g7hTiPwQZF4n6c
   w==;
X-CSE-ConnectionGUID: lEWVmiJtQE2sDe7NloniUg==
X-CSE-MsgGUID: eEaqTS1JQQKGJsvcmKuWiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="91883656"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="91883656"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 03:18:15 -0700
X-CSE-ConnectionGUID: OyWwaDViSYeL5vkcpgTThg==
X-CSE-MsgGUID: iHXT8SjaQ/KiZq0ciHNBmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="251637508"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa002.jf.intel.com with ESMTP; 13 Mar 2026 03:18:12 -0700
Date: Fri, 13 Mar 2026 17:57:55 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: dan.j.williams@intel.com
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org, aik@amd.com, aneesh.kumar@kernel.org,
	bhelgaas@google.com, alistair23@gmail.com, lukas@wunner.de,
	jgg@nvidia.com, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 09/19] PCI/TSM: Support creating encrypted MMIO
 descriptors via TDISP Report
Message-ID: <abPfo26i77FzsAAr@yilunxu-OptiPlex-7050>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
 <20260303000207.1836586-10-dan.j.williams@intel.com>
 <69a86891458b8_6423c1009f@dwillia2-mobl4.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69a86891458b8_6423c1009f@dwillia2-mobl4.notmuch>

> > +	if (dev_WARN_ONCE(&tsm_dev->dev, !IS_ALIGNED((unsigned long) report_obj->data, 8),
> > +			  "misaligned report data\n"))
> > +		return NULL;
> 
> Is this going to cause any implementation to need to copy the buffer
> received from the low-level TSM? If so I would just mark 'struct

TDX Connect needs the copy, the GHCI header is 20 byte size, not
naturally aligned...

> pci_tsm_devif_report' and 'struct pci_tsm_mmio_entry' as __packed and
> drop this check.

..But since this series will persist the report blob long term in
tsm.evidence.obj[PCI_TSM_EVIDENCE_TYPE_REPORT], we anyway need to copy
the blob out from temporary shared GHCI communication buffer. So it is
actually good to me.
