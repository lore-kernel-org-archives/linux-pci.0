Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795017941;
	b=4z7CIBA1K90sCFvgmrTGCCoXkTGVj8xF8z8MK/jXRftp650z6Q7TEdG9i4s1viyb86DD
	 ljXs3bahbh/vQDHBhV9Mu868r/2xJJCCnQEY5ZeZLe9/M+2bcGWOV+2YbFQF7nw1KLsYZ
	 /m8WYbSLru1bMZIiw2D2KFMNDQ0cWfedSDpvHaCsiDDInBIuyVsQEz+TSyFPZ8MusXe+l
	 nGva9oNYsnQ9AapZJY5gpJoFh5MpVH2dDpLATQc8JJmpGsw9VybSrrz6oP1MBYsIjPRuM
	 vTTCOKjFnjlAEee6VDhwSz60QaW7ytvPD95BSaVNl4xbKUdcMZNaM7+qokoKe8PUaow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795017941;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Ae+3JeYiUrhjbpo8o0eXBbuZavQb3IPFMYoUFzPB4Tc=;
	b=o6C4zA+LaEqyA9SoFBEvdROA1R9x+/VPEJ74aO5qMBB1lq3uBro+pwGVzpN+WXrH5LST
	 givC996PlLlBI3SuiEL9wttdKUyb8GcaUGU2glxnDZ5m/xKrHMDdwfMc5/LTFGo3ucf/Y
	 2PtNgk3gAkX+5wEZ60Kwootq0IMpKnAjDYxc6ZqBSsvEFkdrE73ellzWcUdLVMNSjtxa/
	 qriceV/C6k3L2tcU6G+2hmgIIsJ7s0zfpQuoTuxewAZ5A5MkNoRU+zRC63oNXoC1eUYHN
	 if5kWKOOLt9GbzotikPS6Fk1x4WnbRByo+ffR+bblcRurqalUqvglKbgVGLbEqiKnuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LQMAMck3;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2AF606A330
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 16:05:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F2AF606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LQMAMck3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795017940; x=1826553940;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=81nQPe6DhZPapz5KdmrVwUtkk4R09Ot6YOuL6uNj16M=;
  b=LQMAMck3YTiHuiGvgz+bwXFcGFfCj9AM24LythyLN8qXPQKxDCcPDa5Q
   9SCXohtCh+/KHzmy3Zc0xHYmZ0eS8WgEguBhobZy+VMH+F2SxokMW+veR
   sIIMqW7RTTrjK0/Ak60eV9YUMBXeidZzLqFOyaihGljra+W5jMk+muMPC
   1IVPC6f6h2Mua7c163+/b8Din3kQKpPWEEZJlrzgQt4hLCjueoQqUStTb
   9cU82pHI/KF/4sAatG9BIZ6ypmMTxeNj8Z8EVF8YrMbzOgtisFjKT+Xq3
   cRpq4ajkYXY/6p3f9jqLkUt2BB4taNpfpqM7ZBIcCQqNeU6CLO5iRwlWY
   Q==;
X-CSE-ConnectionGUID: oioa6MGsRFOu9RjaLwxlBg==
X-CSE-MsgGUID: 1TrP/zGDR2mSGQUJJwda3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3847336"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3847336"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 08:05:36 -0800
X-CSE-ConnectionGUID: AVZ4HHyQTCWUBgdhxj6XZg==
X-CSE-MsgGUID: JKvDnjUSS8mEjic3oB+mZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="12116519"
Received: from skuppusw-desk1.jf.intel.com (HELO [10.24.80.125]) ([10.24.80.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 08:05:36 -0800
Message-ID: <5eb12731-208b-4be0-84d7-9131810b7842@linux.intel.com>
Date: Wed, 18 Nov 2026 08:05:35 -0800
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] PCI/ERR: Avoid stale error status bits on recovery
 failure
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
 Raag Jadav <raag.jadav@intel.com>, linux-pci@vger.kernel.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
 Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Aravind Iddamsetty <aravind.iddamsetty@intel.com>,
 Srinivasa Adatrao <srinivasa.adatrao@intel.com>,
 Terry Bowman <terry.bowman@amd.com>, Keith Busch <kbusch@kernel.org>,
 Maciej Grochowski <Maciej.Grochowski@sony.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Darshit Shah <darnshah@amazon.de>,
 Jason Perlow <jperlow@gmail.com>, Riana Tauro <riana.tauro@intel.com>,
 Yury Murashka <yurypm@arista.com>, Matthew W Carlis <mattc@purestorage.com>
References: <cover.1794997749.git.lukas@wunner.de>
 <2d0191cb7b92da82302f9d37b859e28ee6c9c85e.1794997749.git.lukas@wunner.de>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <2d0191cb7b92da82302f9d37b859e28ee6c9c85e.1794997749.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/18/26 02:40, Lukas Wunner wrote:
> From: Yury Murashka <yurypm@arista.com>
> 
> pcie_do_recovery() only clears the error status bits of an error-reporting
> device if recovery succeeds, but not if it fails.  (E.g. because reset
> failed, drivers are missing pci_error_handlers or those handlers failed.)
> 
> One undesirable consequence is that the AER driver may subsequently
> identify a wrong device when searching for error-reporting devices in
> is_error_source(), due to stale bits on an unaffected device.
> 
> Avoid by clearing error status bits on recovery failure.
> 
> If recovery succeeds, Fatal Errors are generally cleared by a call to
> pci_restore_state() from drivers' ->slot_reset() callbacks.  If recovery
> fails, those callbacks may not have been invoked or they may not be
> implemented.  Hence clear Fatal Errors as well on recovery failure.
> 
> Link: https://lore.kernel.org/r/CAPzpGcRCTCZtaX1EVaJNZ103THZKsoszZduY7=gwfYdcrMo-SQ@mail.gmail.com/
> Signed-off-by: Yury Murashka <yurypm@arista.com>
> [lukas: drop cmdline param, rewrite commit msg, clear fatal errors]
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>


> Changes v1 -> v2:
>   * Clear Fatal Errors as well on recovery failure (Sathya, sashiko).
>  
>  drivers/pci/pcie/err.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 24a8a8263c2e..a450146fb285 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -289,6 +289,13 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  	return status;
>  
>  failed:
> +	if (host->native_aer) {
> +		pcie_capability_write_word(dev, PCI_EXP_DEVSTA,
> +					   PCI_EXP_DEVSTA_UNC_MASK);
> +		pci_aer_clear_nonfatal_status(dev);
> +		pci_aer_clear_fatal_status(dev);
> +	}
> +
>  	pci_walk_bridge(bridge, pci_pm_runtime_put, NULL);
>  
>  	pci_walk_bridge(bridge, report_perm_failure_detected, NULL);

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

