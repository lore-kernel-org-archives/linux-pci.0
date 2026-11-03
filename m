Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793722522;
	b=llp+bS56XA6MkfwQ3UItGjbbSJtF5VASMSKXZLQSV4V/PdWinBsvYhBpfoehv6dgySL+
	 v4MNKbhztsrdXDDMtH2uhfy13c0MXKEKbpWTk+PxFz3qaU3NTWaePt3xPC2gwnWfRO3Jw
	 2n2f7LrFyTcVqcuVmcNm5oP80spqWCKn8X0uRfPYDrGIKXj1y2ivRw6bCErrPhCcNtomv
	 1VKaYTqXEzxRvHxzzB08abG7pcoHVlF0lIqOnc5SqDkUlX4ElRf8FO7z0YmN1xcJz6dWW
	 HyF/cL37iCtFfA4YPUOJtoxGOWu36sVmpvq2X6pu88ZxJjiphSTUesgXfjSAzS9xrBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793722522;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=DEgAB1NzBQkrZ+rOiK6BEb5rYv2OCkqEnUDIxFNDzdI=;
	b=Rh8N5I2K9V9Bz7kOf2s5LBGjpFjxXAZTowwb87oPsnrQMJy0Rxg9pmFF3qqWP0k518x0
	 5Ojwn5JhkHUrPQvj+l5lVbMKOZFyShJgUFtinurKTPuCIw/uyPKzjom9KJIULhIycDzxn
	 M1w+zXdJt9PpFyGzwmu0KMARoYNfQTo+eDQMdXTpVRhoXCmhUkxeVRA9Itt9DT8ROOrLf
	 duZYJtwFaroT1q2uF/kLic36ya1wSosMyhU2fvwkhwYybXfvri9PNZO+WMCLpaTIsPfH7
	 wEas63x/smAOk8Stvg2OejE77ZdKvuNqNKpvBTjxv8GkBXPrcoJG6Nr8Eex97U7bZDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ArgVASSd;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9E9606A33F
	for <linux-pci@vger.kernel.org>; Tue,  3 Nov 2026 16:15:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE9E9606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ArgVASSd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793722522; x=1825258522;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=o4O4Ks4uYsLqgXXzPfeRNGEZQxA0LUp+7bdtqiyqVHo=;
  b=ArgVASSdiRDmK3msUtfNCPmkuiUJvv5bneoMdE3fAuyDifV5H711YfmK
   ur/ct0e5KeLIp2luSfgSWCc/FPsrx8T5Pn+Q59zrz3zq6lOA+SR3hC/Er
   u+0GheUrkTpGoye6MDIy6M6gmCwjB2T7JYRpsq5e3dKB5QKtEP57RfjA3
   4rWeBkNuhKsNrDzYUMVHxhc+Si35gIRuLQIkKee7geKQV8XCI6v328xv7
   ccP/WRt2NBCLpSXci4XsFEVNuhAHGnppC1gBWbAKHibuRmeRkG0GkdjKH
   778X+QeyUEG1E3zoSnHCA1DVHpbVLpV8ZekExH90OpUPL0GDT8xQHBa4p
   Q==;
X-CSE-ConnectionGUID: 14Eg+6LzTyyZ+q8WtIh4bQ==
X-CSE-MsgGUID: xCgud3eNRJS3Inafk1mQOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2446992"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2446992"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 08:15:09 -0800
X-CSE-ConnectionGUID: gLojHqxCRcW1rnClKrSqDg==
X-CSE-MsgGUID: 51yT1/HlQT6IbRMLFX8ziw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6574537"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.80.90]) ([10.24.80.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 08:15:08 -0800
Message-ID: <5fe32a78-4048-4624-8c1a-b50e3ecbb093@linux.intel.com>
Date: Tue, 3 Nov 2026 08:15:07 -0800
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
Subject: Re: [PATCH 2/2] PCI/AER: Check validity of Error Source ID register
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
 linux-pci@vger.kernel.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
 Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Alex Deucher <alexander.deucher@amd.com>, Keith Busch <kbusch@kernel.org>,
 Maciej Grochowski <Maciej.Grochowski@sony.com>
References: <cover.1793697480.git.lukas@wunner.de>
 <27a3876874161204e7a37ab63e7b27ee9783261f.1793697480.git.lukas@wunner.de>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <27a3876874161204e7a37ab63e7b27ee9783261f.1793697480.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/3/2026 1:45 AM, Lukas Wunner wrote:
> Certain Intel and AMD Root Ports are known to populate the Error Source ID
> register with an invalid value.  The AER driver seeks to recognize such
> buggy silicon by assuming invalidity if the bus number is zero.  It then
> searches for the error-signaling device in the hierarchy below the Root
> Port.  This was introduced by commit 28eb27cf0839 ("PCI AER: support
> invalid error source IDs").
> 
> Alex has provided dmesg output which shows an invalid Error Source ID with
> a non-zero bus number.  The AER driver's heuristic fails to recognize its
> invalidity:
> 
>   pcieport 0000:00:07.1: AER: Correctable Error message received from 0000:01:00.0 (no details found)
> 
> The Root Port at 0000:00:07.1 has subordinate bus 04, so an error source
> on bus 01 is obviously invalid.  The range of subordinate buses is cached
> and checking against it is cheap.
> 
> Do that instead of relying on a heuristic.  Emit a message when an invalid
> Error Source ID is detected to alert silicon validation engineers.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=222095
> Tested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  drivers/pci/pci.h       |  7 ++++++-
>  drivers/pci/pcie/aer.c  | 33 +++++++++++++++++++++++++--------
>  drivers/pci/pcie/rcec.c | 14 ++++++++++++++
>  3 files changed, 45 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 77efa4c5c960..aa392bb6a482 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -871,6 +871,9 @@ static inline bool pci_dev_binding_disallowed(struct pci_dev *dev)
>   * @id: Value from register PCI_ERR_ROOT_ERR_SRC
>   * @severity: AER severity, 0-UNCOR Non-fatal, 1-UNCOR fatal, 2-COR
>   * @root_ratelimit_print: Flag to log or not log the root's error. 0=NotLog/1=Log
> + * @id_valid: Whether @id is a valid value.  Some Root Ports report an invalid
> + *	Error Source ID, necessitating a search for the error-signaling device
> + *	in the hierarchy below the Root Port.
>   * @multi_error_valid: If multiple errors are reported
>   * @first_error: First reported error
>   * @__pad2: Padding for alignment
> @@ -893,7 +896,8 @@ struct aer_err_info {
>  
>  	unsigned int severity:2;
>  	unsigned int root_ratelimit_print:1;
> -	unsigned int __pad1:4;
> +	unsigned int __pad1:3;
> +	unsigned int id_valid:1;
>  	unsigned int multi_error_valid:1;
>  
>  	unsigned int first_error:5;
> @@ -955,6 +959,7 @@ void pcie_link_rcec(struct pci_dev *rcec);
>  void pcie_walk_rcec(struct pci_dev *rcec,
>  		    int (*cb)(struct pci_dev *, void *),
>  		    void *userdata);
> +bool pci_rcec_associated(struct pci_dev *rcec, u16 id);
>  #else
>  static inline void pci_rcec_init(struct pci_dev *dev) { }
>  static inline void pci_rcec_exit(struct pci_dev *dev) { }
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index d492c7ce01e1..9957c36bf215 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -951,12 +951,13 @@ static void aer_print_source(struct pci_dev *dev, struct aer_err_info *info,
>  {
>  	u16 source = info->id;
>  
> -	pci_info(dev, "%s%s Error message%s from %04x:%02x:%02x.%d%s\n",
> +	pci_info(dev, "%s%s Error message%s from %04x:%02x:%02x.%d%s%s\n",
>  		 info->multi_error_valid ? "Multiple " : "",
>  		 aer_error_severity_string[info->severity],
>  		 info->multi_error_valid ? "s received, first one" : " received",
>  		 pci_domain_nr(dev->bus), PCI_BUS_NUM(source),
>  		 PCI_SLOT(source), PCI_FUNC(source),
> +		 info->id_valid ? "" : " (invalid source)",
>  		 found ? "" : " (no details found)");
>  }
>  
> @@ -1146,6 +1147,24 @@ static int add_error_device(struct aer_err_info *e_info, struct pci_dev *dev)
>  	return 0;
>  }
>  
> +static bool source_id_valid(struct pci_dev *root, u16 id)
> +{
> +	/* The Root Port or RCEC can itself be a valid Error Source */
> +	if (pci_dev_id(root) == id)
> +		return true;
> +
> +	/* For RCECs, @id shall be in range of its associated buses/devices */
> +	if (pci_pcie_type(root) == PCI_EXP_TYPE_RC_EC)
> +		return pci_rcec_associated(root, id);
> +
> +	/* For Root Ports, @id shall be in range of its subordinate buses */
> +	if (!root->subordinate)
> +		return false;
> +
> +	return root->subordinate->busn_res.start <= PCI_BUS_NUM(id) &&
> +	       root->subordinate->busn_res.end   >= PCI_BUS_NUM(id);
> +}
> +
>  /**
>   * is_error_source - check whether the device is source of reported error
>   * @dev: pointer to pci_dev to be checked
> @@ -1157,11 +1176,8 @@ static bool is_error_source(struct pci_dev *dev, struct aer_err_info *e_info)
>  	u32 status, mask;
>  	u16 reg16;
>  
> -	/*
> -	 * When bus ID is equal to 0, it might be a bad ID
> -	 * reported by Root Port.
> -	 */
> -	if ((PCI_BUS_NUM(e_info->id) != 0) &&
> +	/* Some Root Ports report an invalid Error Source ID */
> +	if (e_info->id_valid &&
>  	    !(dev->bus->bus_flags & PCI_BUS_FLAGS_NO_AERSID)) {
>  		/* Device ID match? */
>  		if (e_info->id == pci_dev_id(dev))
> @@ -1174,8 +1190,7 @@ static bool is_error_source(struct pci_dev *dev, struct aer_err_info *e_info)
>  
>  	/*
>  	 * When either
> -	 *      1) bus ID is equal to 0. Some ports might lose the bus
> -	 *              ID of error source id;
> +	 *      1) Error Source ID register is invalid;
>  	 *      2) bus flag PCI_BUS_FLAGS_NO_AERSID is set
>  	 *      3) There are multiple errors and prior ID comparing fails;
>  	 * We check AER status registers to find possible reporter.
> @@ -1566,6 +1581,8 @@ static void aer_isr_one_error_type(struct pci_dev *root,
>  {
>  	bool found;
>  
> +	info->id_valid = source_id_valid(root, info->id);
> +
>  	found = find_source_device(root, info);

nit: Updated the kernel-doc help of find_source_device() to include id_valid.

>  
>  	/*
> diff --git a/drivers/pci/pcie/rcec.c b/drivers/pci/pcie/rcec.c
> index 2bf6d9d549ba..609d656300fa 100644
> --- a/drivers/pci/pcie/rcec.c
> +++ b/drivers/pci/pcie/rcec.c
> @@ -21,6 +21,20 @@ struct walk_rcec_data {
>  	void *user_data;
>  };
>  
> +bool pci_rcec_associated(struct pci_dev *rcec, u16 id)
> +{
> +	if (!rcec->rcec_ea)
> +		return false;
> +
> +	if (rcec->bus->number == PCI_BUS_NUM(id)) {
> +		unsigned long bitmap = rcec->rcec_ea->bitmap;
> +		return test_bit(PCI_SLOT(id), &bitmap);
> +	}
> +
> +	return rcec->rcec_ea->nextbusn <= PCI_BUS_NUM(id) &&
> +	       rcec->rcec_ea->lastbusn >= PCI_BUS_NUM(id);
> +}
> +
>  static bool rcec_assoc_rciep(struct pci_dev *rcec, struct pci_dev *rciep)
>  {
>  	unsigned long bitmap = rcec->rcec_ea->bitmap;

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>


-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

