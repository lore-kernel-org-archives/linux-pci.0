Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC563C73EA
	for <linux-pci@vger.kernel.org>; Tue,  7 Apr 2026 16:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775579052; cv=none; b=CvlLtB1ifWGZvoPfEFsuf3M00oxiKAaxTVHT0UkwXeck5z30JNej6Yu/heLxGnnfdIaLfjib2aKfQDaet8x+SrnJTxhKaCUGUvmBiP1Tjbg8nQ4IkBz/eCulqRv/B1M9TiYYT25O/AChqXOTOTP0e1WdoZEKjxntVecZaQ5A+Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775579052; c=relaxed/simple;
	bh=9FeJFyp0FaZnv7lMyE8/o9uC1lGRabz7wKdgpqoqhx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uuxyl31tu4wxU1Bo+lCBs8D48HVapK066csK3mHlit31RC05J/qGj22MAh9DUF81AqXmlOnA87u7Or29lLEfI0qiXw18nu+IrYGegIm3bU+4sru2HyFAs7WbKoDL0elNBbXyf9/kpB2+R9p8CzN9jz4A/cZbO0ofqoFAPj/bP9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EpAauxTx; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EpAauxTx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775579050; x=1807115050;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9FeJFyp0FaZnv7lMyE8/o9uC1lGRabz7wKdgpqoqhx8=;
  b=EpAauxTxe+h8nRrpKDnnMzWzXIaUk005wYVQSDqpeUNHK5O/YL9tdRQw
   G5pmQMiNl/XeVbUfGrYCLHcPCjAFiZMBlN1y3b8Q8q0/+7qTdgsac4syP
   ubAOUvnsgAdvMwR/6uUYdtnKUNp5Q0FyOnk/ReRpeijgKDWzOiB8DkY/M
   oKDqLMb8+UgHjPWSwV20e/BYOBYhm2Nbp9NDLTTLAItKSWSOet7DZ0f3p
   sFnRd2BnswsPIJ7NFR2tiT3YxrKBozAQBbkdYk5OK8bDaCjUz8iMqCst8
   yi8y42g3leIfNmOzhIUDu/FdSf4jixVT0YenvULtFtypwXfy107ePWtVL
   A==;
X-CSE-ConnectionGUID: MI18FM4JTP2gBokwrrKXjQ==
X-CSE-MsgGUID: WjIZp1opTim1nuHA9bMtsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="79137092"
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="79137092"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 09:24:09 -0700
X-CSE-ConnectionGUID: +2Jwot1rQC6eUXiRWlp2yA==
X-CSE-MsgGUID: hkMlB8cmTy6L/5Cqw9Xajw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="223431250"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa006.fm.intel.com with ESMTP; 07 Apr 2026 09:24:07 -0700
Date: Wed, 8 Apr 2026 00:02:37 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org, aik@amd.com, aneesh.kumar@kernel.org,
	bhelgaas@google.com, alistair23@gmail.com, lukas@wunner.de,
	jgg@nvidia.com
Subject: Re: [PATCH v2 01/19] PCI/TSM: Report active IDE streams per host
 bridge
Message-ID: <adUqnUwBBtrqXcX7@yilunxu-OptiPlex-7050>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
 <20260303000207.1836586-2-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303000207.1836586-2-dan.j.williams@intel.com>

On Mon, Mar 02, 2026 at 04:01:49PM -0800, Dan Williams wrote:
> The first attempt at an ABI for this failed to account for naming
> collisions across host bridges:
> 
> Commit a4438f06b1db ("PCI/TSM: Report active IDE streams")
> 
> Revive this ABI with a per host bridge link that appears at first stream
> creation for a given host bridge and disappears after the last stream is
> removed.
> 
> For systems with many host bridge objects it allows:
> 
>     ls /sys/class/tsm/tsmN/pci*/stream*
> 
> ...to find all the host bridges with active streams without first iterating
> over all host bridges. Yilun notes that is handy to have this short cut [1]
> and from an administrator perspective it helps with inventory for
> constrained stream resources.
> 
> Link: http://lore.kernel.org/aXLtILY85oMU5qlb@yilunxu-OptiPlex-7050 [1]
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>
