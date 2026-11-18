Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795017618;
	b=A2/3o/cW7q8/T1mt0HxDNW2ZEoZQAYQh61EjRVl4jFc2ntqKf/HgxoXh4OgHOemzy5xu
	 z6hGgZFSRseAovRuI+c1Zw1NrLXWwe5oWBfyPw+IE7mmWyONVdLN/7TEqOQRhuQEdjKkK
	 rto+8h7XNv73cD/PeSpCT7cqlQzg3n2BsQKkTMR9gvXpa2q476lIigyDtO5AGaKGlKKre
	 IA18uZ8tqE6zXObm58fDGoSH09KqaFJUeY7xoxyqN0XGxy8LU2UzH8q3NR1GOGQ5wL4i+
	 8ufL/02RZNBPxrTwzrPLQINb1Nk9TdebTGTdS2yKlbKmX7JYqEe/6orzisTwQ7r3DKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795017618;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=D5QooVbmJyeiQEll/kH3Qhk5QICli5VfsBBRXwpoM1I=;
	b=s6JtYxH/3E+lDfrdd8x+bXknk1X2MTiLcl07KAU0bYEAUbMqoOx+hjMxrdi34rysTgQL
	 dpOEsY5ReOkN10epuXZzOEMa4oMw+7bfULcUs1jEITjknWPSnuCL1pIgUCIX0EQuS27bN
	 Rv2LIZ/Y0q6+EJ81cxttnpA9kCYpH/qyjgQyIj3MRbl3sd+xVOFGrS8cURP6E9oH1d2Wa
	 Onuds9qXuBDyaAxVotc7DQECCQMYHqsS/XhnMrFnJsIaw9zxSUw8aDSPKAO0hPs3QWBhc
	 8slTcfNEH//Pn2M4/4DW3isYVh4ONjiMoNNRl98taI1eZ8FlqMKTmwyCsaxShNI6ASQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cFaewb35;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C72606A31C
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 16:00:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22C72606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cFaewb35
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795017619; x=1826553619;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bDErzl9kuTyesy6CIPye94cbiZqZje+huoOSfq3HhSc=;
  b=cFaewb35NNU5DcvUeNjN93erhmUKeCSin4y5TYoPpWqNKFqSSoL6Ef8G
   pTu71sR6zcRdfLnrUtX6m4KIPWrBs0w21nt0iA7s7I+i+QRr/x8cmbc8N
   ZzJmqROOXqzlhJvD+J87NZ2Dx8PLJMtgCbZkuy06+PR4R7xFiqUbOFQPj
   pXRL2p5VV2EYv7gXpiQlv7z5B72BjLi6rIah5jLabUh4N4QB6eKrTPT92
   Ge4BUviRyjbXmuVaZXk5O73zeoNo63QUUQzkRauRNLQGj7qDCp8e2X5YU
   Rr6RX/pJyWJjzJL5xMa3RSyuTUmDMfYrJT7FM4Gw/UFMPU/cNB3RWTlJs
   g==;
X-CSE-ConnectionGUID: ROQVQXuSRxuDTMxkDBfF3g==
X-CSE-MsgGUID: SOXese+iQY2mg4UDSyqcpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3727126"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3727126"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 08:00:18 -0800
X-CSE-ConnectionGUID: wqyLjkTzROerMGSk0YUqvQ==
X-CSE-MsgGUID: n2FzSOcXQwqiFJvXuof08Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10539829"
Received: from skuppusw-desk1.jf.intel.com (HELO [10.24.80.125]) ([10.24.80.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 08:00:16 -0800
Message-ID: <62178920-f5e9-4d0b-8fc6-0bf0e2a53fd8@linux.intel.com>
Date: Wed, 18 Nov 2026 08:00:16 -0800
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
Subject: Re: [PATCH v2 1/7] PCI/DPC: Avoid access to non-existent AER
 capability
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
 <34c9ee153876bac953135b4518035194b7c07c6c.1794997749.git.lukas@wunner.de>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <34c9ee153876bac953135b4518035194b7c07c6c.1794997749.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/18/26 02:40, Lukas Wunner wrote:
> Downstream Port Containment does not mandate presence of an Advanced Error
> Reporting capability, so a Downstream Port may support DPC, but not AER
> (PCIe r7.1 sec 6.2.11.2).
> 
> In February 2019, commit 9f08a5d896ce ("PCI/DPC: Fix print AER status in
> DPC event handling") amended the DPC driver to access the AER capability
> without checking for its presence.
> 
> This did not cause actual problems because in March 2018, commit
> 4e5fad429bd1 ("PCI/DPC: Do not enable DPC if AER control is not allowed by
> the BIOS") had seemingly inadvertently prevented instantiation of a DPC
> port service on AER-incapable ports.
> 
> However in October 2019, commit 35a0b2378c19 ("PCI/DPC: Add
> "pcie_ports=dpc-native" to allow DPC without AER control") made it
> possible to override this:  The DPC driver may access a non-existent AER
> capability if "pcie_ports=dpc-native" is passed on the command line.
> 
> Fix it by making the DPC driver cope with AER-unsupporting Downstream
> Ports.
> 
> There are two places where the AER capability is accessed:
> 
> - dpc_get_aer_uncorrect_severity() uses it to discern whether a Fatal or
>   Non-Fatal Error triggered DPC.  Access the Device Status Register
>   instead, in accordance with PCIe r7.1 sec 6.2.5.
> 
> - dpc_is_surprise_removal() uses it to detect whether a Surprise Down
>   Error triggered DPC.  Return false on AER-unsupporting devices.  The
>   function works around an AMD-specific quirk and it seems reasonable to
>   assume that all affected products are AER-supporting.  In any case the
>   detection is not possible without AER capability.
> 
> Insert a temporary check for an AER capability after the call to
> aer_get_device_error_info() because the function currently returns false
> for AER-unsupporting devices.  The check will become obsolete and will be
> removed with the imminent baseline capability error reporting.
> 
> Fixes: 35a0b2378c19 ("PCI/DPC: Add "pcie_ports=dpc-native" to allow DPC without AER control")
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v5.5+
> ---

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>


> Changes v1 -> v2:
>   * On AER-capable devices, infer severity from AER Extended Capability
>     instead of Device Status register because the latter also logs masked
>     errors (Sathya).
>   * Fix storytelling in commit message because 4e5fad429bd1 changed
>     behavior, not 708b20003624 (Sathya).
>  
>  drivers/pci/pcie/dpc.c | 45 ++++++++++++++++++++++++++++++------------
>  1 file changed, 32 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 2b779bd1d861..d02cbbbe3143 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -238,19 +238,35 @@ static int dpc_get_aer_uncorrect_severity(struct pci_dev *dev,
>  {
>  	int pos = dev->aer_cap;
>  	u32 status, mask, sev;
> +	u16 devsta;
>  
> -	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, &status);
> -	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, &mask);
> -	status &= ~mask;
> -	if (!status)
> -		return 0;
> -
> -	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, &sev);
> -	status &= sev;
> -	if (status)
> -		info->severity = AER_FATAL;
> -	else
> -		info->severity = AER_NONFATAL;
> +	/*
> +	 * Infer severity from AER Extended Capability if present, else from
> +	 * Device Status register.  The latter cannot be used on AER-capable
> +	 * ports because it also logs masked errors (PCIe r7.1 sec 7.5.3.5).
> +	 */
> +	if (pos) {
> +		pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, &status);
> +		pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, &mask);
> +		status &= ~mask;
> +		if (!status)
> +			return 0;
> +
> +		pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, &sev);
> +		status &= sev;
> +		if (status)
> +			info->severity = AER_FATAL;
> +		else
> +			info->severity = AER_NONFATAL;
> +	} else {
> +		pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &devsta);
> +		if (devsta & PCI_EXP_DEVSTA_FED)
> +			info->severity = AER_FATAL;
> +		else if (devsta & PCI_EXP_DEVSTA_NFED)
> +			info->severity = AER_NONFATAL;
> +		else
> +			return 0;
> +	}
>  
>  	info->level = KERN_ERR;
>  
> @@ -275,7 +291,7 @@ void dpc_process_error(struct pci_dev *pdev)
>  		pci_warn(pdev, "containment event, status:%#06x: unmasked uncorrectable error detected\n",
>  			 status);
>  		if (dpc_get_aer_uncorrect_severity(pdev, &info) &&
> -		    aer_get_device_error_info(&info, 0)) {
> +		    (aer_get_device_error_info(&info, 0) || !pdev->aer_cap)) {
>  			aer_print_error(&info, 0);
>  			pci_aer_clear_nonfatal_status(pdev);
>  			pci_aer_clear_fatal_status(pdev);
> @@ -353,6 +369,9 @@ static bool dpc_is_surprise_removal(struct pci_dev *pdev)
>  	if (!pdev->is_hotplug_bridge)
>  		return false;
>  
> +	if (!pdev->aer_cap)
> +		return false;
> +
>  	if (pci_read_config_word(pdev, pdev->aer_cap + PCI_ERR_UNCOR_STATUS,
>  				 &status))
>  		return false;

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

