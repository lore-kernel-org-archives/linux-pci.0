Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD641F192E
	for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2026 10:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773397667; cv=none; b=geaMgsinZBkK44qHVwBiiNHJpfW7LSJS/f31naucYQfHYDFDBPOJiH5R9v+V+chyNByH3NUmnyXMvFZUlUt4MD6dHxi33N/ujp2pQtHL07rftD2VE0NYCeoKshQJNSHIbW4JZIcCpVRGAQvWBlbCMp6+0GZffVYO5BQpOyyVhNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773397667; c=relaxed/simple;
	bh=LRvz29aOmDthviDx9NvYAHEaIikV3tNGXz0Q25oWcNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgZFodx4PT/VfdPOpkeMUv2A6pKB2wXdQt4OSS0c1+1X3FsKJRnb/xg5EgX1C2fWQ7E/29ZXWdSpQpEUI3q9xEUskjxqbCFO+HEvDmJPmxUJnBOi6fS6Fqs3wxmLiny08JH9nXufKc2Tx5LkBzbjs1yLM5ueiIxq+5K9qwW1v9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X4b1IqKA; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X4b1IqKA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773397666; x=1804933666;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LRvz29aOmDthviDx9NvYAHEaIikV3tNGXz0Q25oWcNY=;
  b=X4b1IqKAQN0mpOMzOadhgM2VqF12NhcwAHKlNVwXVJamNOd/wuNqQnel
   J3k8JFP9g2OlbDjOpKSJ/qpS4sXVoewTWbfO6X5iWCtc5Zw70JwJLzZs1
   6m7BhimE226iST5Iypbd68jtN8XaOlVEF/RQETLsSZ05rwzK63XuLC7JD
   dDsGzmUvllQpVyfGiuyMFpaeC0Mgu43nHAApAExU2/X3AIu7awdrlQL58
   E7l5Dq7zBhLvyxhx0KyVwzNb+tiXGcvmH0fsx0z+40aIXyNpKcRM1rdXZ
   1UFi1O+JwfGenOSJ4XmYcYNN8Ho5DTRS/78TfDy3KcccoPYq/Cz2Lhuve
   A==;
X-CSE-ConnectionGUID: dIF5lbCNQsmQ0qnR2/6ZYg==
X-CSE-MsgGUID: Ot1qOcTWQLi7fBT6fFU8Nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="91884298"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="91884298"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 03:27:46 -0700
X-CSE-ConnectionGUID: ql9T5RDOTrm0HsrOIaLBzA==
X-CSE-MsgGUID: SyULQGfjR7OCZUjrsWglMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="251640572"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa002.jf.intel.com with ESMTP; 13 Mar 2026 03:27:43 -0700
Date: Fri, 13 Mar 2026 18:07:25 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org, aik@amd.com, aneesh.kumar@kernel.org,
	bhelgaas@google.com, alistair23@gmail.com, lukas@wunner.de,
	jgg@nvidia.com, Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH v2 08/19] PCI/TSM: Add "evidence" support
Message-ID: <abPh3d4+opAkot3p@yilunxu-OptiPlex-7050>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
 <20260303000207.1836586-9-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303000207.1836586-9-dan.j.williams@intel.com>

> +void pci_tsm_init_evidence(struct pci_tsm_evidence *evidence, int slot,
> +			   enum hash_algo digest_algo)
> +{
> +	evidence->slot = slot;
> +	evidence->generation = 1;
> +	evidence->digest_algo = digest_algo;
> +	init_rwsem(&evidence->lock);

IIUC, this function is for link tsm driver, is it? But in the following
patch, devsec tsm would consume pci_tsm_mmio_alloc() which uses
evidence->lock. So my solution is to initialize the lock on tsm
construction.

--------8<--------
diff --git a/drivers/pci/tsm/core.c b/drivers/pci/tsm/core.c
index 9f062218c312..c55deeafe32b 100644
--- a/drivers/pci/tsm/core.c
+++ b/drivers/pci/tsm/core.c
@@ -1175,7 +1175,6 @@ void pci_tsm_init_evidence(struct pci_tsm_evidence *evidence, int slot,
        evidence->slot = slot;
        evidence->generation = 1;
        evidence->digest_algo = digest_algo;
-       init_rwsem(&evidence->lock);
 }
 EXPORT_SYMBOL_GPL(pci_tsm_init_evidence);

@@ -1198,6 +1197,7 @@ int pci_tsm_link_constructor(struct pci_dev *pdev, struct pci_tsm *tsm,
        }
        tsm->pdev = pdev;
        tsm->tsm_dev = tsm_dev;
+       init_rwsem(&tsm->evidence.lock);

        return 0;
 }
@@ -1221,6 +1221,7 @@ int pci_tsm_devsec_constructor(struct pci_dev *pdev, struct pci_tsm_devsec *tsm,
        pci_tsm->tdi = NULL;
        pci_tsm->pdev = pdev;
        pci_tsm->tsm_dev = tsm_dev;
+       init_rwsem(&pci_tsm->evidence.lock);

        return 0;
 }
