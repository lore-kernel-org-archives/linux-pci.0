Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7995E1A6804
	for <linux-pci@vger.kernel.org>; Tue,  3 Mar 2026 03:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772507716; cv=none; b=gm1mtpA+y2bX1nUylX3RXmAd6A/yj6VsBQbcKFERouuB4xwWAU6aO08OOryEV/ujgVFjVRwooT8H+CPyLUsMktxfPjNDqZ+mdVykU/EpJ8WVImx4AK1IhfclTzY5k6pDTXPB9/nlnOcndC9lqnewnlGP2AD3WsCW0GTfhA+CU4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772507716; c=relaxed/simple;
	bh=xsz3XbahbxkD1Tne3qCV3REAPK8gj5He5vgtDqEZX58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2NFFQfa/dscoGVBU2QwrmirTgP0tier+kABC+0HxTKwXJl7oaeTwAKIcCUgZ+VhUL6J/S2xs3RJ6UdyP20nMq1eG/W18+nUhEoCocKtlPWxl+YJPWO/yZ4E89Lr2DXEZ4J9HlBXDJCJBwoU7dlpLqIgd1p3x+vRDMH+H6Ideio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fwYbzICV; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fwYbzICV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772507715; x=1804043715;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xsz3XbahbxkD1Tne3qCV3REAPK8gj5He5vgtDqEZX58=;
  b=fwYbzICVdTtA31jaUiH+EZoXjkP0QUsyVT8qK16sqfldHaaJydY0g4A/
   yolU5pPxgnYGhewPdt2ggmTDGoAob7IK6NGMqP1Km1SHM3q5QCzviov1I
   XLCZA8cRtieOGm4aLNN/bLds1cvHMxdGHuwPNB5hcq2VkmQ7meHV4BCy8
   5W9PQBcFpp5kAPsQT9OQJmFgROQ1hhkpdvMrXaOCOpn5Ozb9hMrPN7kIL
   dU2JfwTYo0KN93EeedPnaf2FhJdFwDerb5f2U6KhGyPZXWuK+Sk4NvcSG
   qiQuRAKgzTaF83gjzLmfDhQjgoGdA2qYShOJNBQ10sZ7rEgP8cUEcrhi8
   Q==;
X-CSE-ConnectionGUID: mDqUIgXcTIGCQtq4q9xpRw==
X-CSE-MsgGUID: 7x/h7OhaQgKrNlo3Cpbm3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="77398528"
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="77398528"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 19:15:14 -0800
X-CSE-ConnectionGUID: +4ipEaLzRSy9T0JOCTZuNg==
X-CSE-MsgGUID: shjD0TQqSjK4KJB1ww6AcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="220886311"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by fmviesa004.fm.intel.com with ESMTP; 02 Mar 2026 19:15:12 -0800
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vxGE2-000000001MD-0EEX;
	Tue, 03 Mar 2026 03:15:10 +0000
Date: Tue, 3 Mar 2026 04:14:32 +0100
From: kernel test robot <lkp@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, gregkh@linuxfoundation.org, aik@amd.com,
	aneesh.kumar@kernel.org, yilun.xu@linux.intel.com,
	bhelgaas@google.com, alistair23@gmail.com, lukas@wunner.de,
	jgg@nvidia.com, Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH v2 08/19] PCI/TSM: Add "evidence" support
Message-ID: <202603030451.0ZpbO6ex-lkp@intel.com>
References: <20260303000207.1836586-9-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303000207.1836586-9-dan.j.williams@intel.com>

Hi Dan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on c2012263047689e495e81c96d7d5b0586299578d]

url:    https://github.com/intel-lab-lkp/linux/commits/Dan-Williams/PCI-TSM-Report-active-IDE-streams-per-host-bridge/20260303-080409
base:   c2012263047689e495e81c96d7d5b0586299578d
patch link:    https://lore.kernel.org/r/20260303000207.1836586-9-dan.j.williams%40intel.com
patch subject: [PATCH v2 08/19] PCI/TSM: Add "evidence" support
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
docutils: docutils (Docutils 0.21.2, Python 3.13.5, on linux)
reproduce: (https://download.01.org/0day-ci/archive/20260303/202603030451.0ZpbO6ex-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603030451.0ZpbO6ex-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Warning: tools/docs/documentation-file-ref-check references a file that doesn't exist: m,^Documentation/scheduler/sched-pelt
   Warning: tools/docs/documentation-file-ref-check references a file that doesn't exist: m,(Documentation/translations/[
   Using alabaster theme
   WARNING: ./include/crypto/skcipher.h:166 struct member 'SKCIPHER_ALG_COMMON' not described in 'skcipher_alg'
   Documentation/driver-api/pci/tsm:147: ./include/linux/pci-tsm.h:112: ERROR: Unexpected indentation. [docutils]
>> Documentation/driver-api/pci/tsm:147: ./include/linux/pci-tsm.h:113: WARNING: Block quote ends without a blank line; unexpected unindent. [docutils]
>> Documentation/driver-api/pci/tsm:147: ./include/linux/pci-tsm.h:116: WARNING: Definition list ends without a blank line; unexpected unindent. [docutils]
   ERROR: Cannot find file ./drivers/pci/tsm.c
   ERROR: Cannot find file ./drivers/pci/tsm.c
   WARNING: No kernel-doc for file ./drivers/pci/tsm.c
   WARNING: ./include/linux/virtio.h:183 struct member 'map' not described in 'virtio_device'
   WARNING: ./include/linux/virtio.h:183 struct member 'VIRTIO_DECLARE_FEATURES(features' not described in 'virtio_device'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
