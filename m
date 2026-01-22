Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B73637AA78;
	Thu, 22 Jan 2026 18:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769106558; cv=none; b=ueyuETdRyI7x60ODmqLzeLJbdxez0Zf8amV1OGdJrCKwigZ6A499RQ/Qsmhf/T0M+eybofa5aVeMPmSrDwmdwHKAhWdXw+S1UDxz+qbKNp9KwT4Cpfc1lQfl0Epu3S5WEgTupJlq2ymBjLJoAV0cKp2J6mwHjyUSoxbTNhAlveU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769106558; c=relaxed/simple;
	bh=gYE9xDBiA1qtzsTNaoCe8Sk8eUO3OuRD0gOfEUTJgjw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DiOS4/lg8Pr7z2bYXCwZ0+H4SfDrnL6G8MRRXC2RnKrE0dQ6B59VErbLWH2zq9xdc6Ho9h7/sxjTIjn8ATIkHLsXAl4Kqn6UfNtrxLUBMLVeID8YjLBmyOsuk+h3cDiZKoI9IofphTTrbVPdkQ/a6YUCFuySs5p/NL9hXTJYef0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDzqga/B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDzqga/B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D14B0C116C6;
	Thu, 22 Jan 2026 18:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769106558;
	bh=gYE9xDBiA1qtzsTNaoCe8Sk8eUO3OuRD0gOfEUTJgjw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=iDzqga/B8bplfBR65n0ajH4sEO6LXws40/60b/EAnO1Kc0kr1dmllpZqyLXTygGjw
	 A5wpPKqn7Qkc99ifEcpCNfNfFbaOM7f2cVVplcY9Z0ruY7+rbWxEURgjj/YGoHhNwe
	 z+eXQZ8E2Ub/XLIbSS1Q+79E8ROZggzR2DMjZT0C6OlQbUcmhJmDlvkE537F8RiM+H
	 Tq+uLsUTcffUxlJ/OGNhtdMTRfpP3Or7CCn+dNXCtcAX2tkzFuSZV4DWPbipZyX7LD
	 F4FWejrfQtL1CgwsVRVKJXUMZLFk/SABlxA4xhfj7cMnutAnQIU63MkX0x6EEmh8Zm
	 GPQ75XCt2MwjQ==
Date: Thu, 22 Jan 2026 12:29:16 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Terry Bowman <terry.bowman@amd.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, shiju.jose@huawei.com, ming.li@zohomail.com,
	Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
	dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
	lukas@wunner.de, Benjamin.Cheatham@amd.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, vishal.l.verma@intel.com,
	alucerop@amd.com, ira.weiny@intel.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v14 15/34] PCI/AER: Update struct aer_err_info with
 kernel-doc formatting
Message-ID: <20260122182916.GA17168@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114182055.46029-16-terry.bowman@amd.com>

On Wed, Jan 14, 2026 at 12:20:36PM -0600, Terry Bowman wrote:
> Update the existing 'struct aer_err_info' definition to use kernel-doc
> formatting. Remove the inline comments to reduce noise and do not introduce
> functional changes. This will improve readability and maintainability.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
> 
> Changes in v13->v14:
> - New commit
> ---
>  drivers/pci/pci.h | 29 +++++++++++++++++++++++------
>  1 file changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 41ec38e82c08..dbc547db208a 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -724,16 +724,33 @@ static inline bool pci_dev_binding_disallowed(struct pci_dev *dev)
>  
>  #define AER_MAX_MULTI_ERR_DEVICES	5	/* Not likely to have more */
>  
> +/**
> + * struct aer_err_info - AER Error Information
> + * @dev: Devices reporting error
> + * @ratelimit_print: Flag to log or not log the devices' error. 0=NotLog/1=Log
> + * @error_dev_num: Number of devices reporting an error
> + * @level: printk level to use in logging
> + * @id: Value from register PCI_ERR_ROOT_ERR_SRC
> + * @severity: AER severity, 0-UNCOR Non-fatal, 1-UNCOR fatal, 2-COR
> + * @root_ratelimit_print: Flag to log or not log the root's error. 0=NotLog/1=Log
> + * @multi_error_valid: If multiple errors are reported
> + * @first_error: First reported error
> + * @is_cxl: Bus type error: 0-PCI Bus error, 1-CXL Bus error
> + * @tlp_header_valid: Indicates if TLP field contains error information
> + * @status: COR/UNCOR error status
> + * @mask: COR/UNCOR mask
> + * @tlp: Transaction packet information
> + */
>  struct aer_err_info {
>  	struct pci_dev *dev[AER_MAX_MULTI_ERR_DEVICES];
>  	int ratelimit_print[AER_MAX_MULTI_ERR_DEVICES];
>  	int error_dev_num;
> -	const char *level;		/* printk level */
> +	const char *level;
>  
>  	unsigned int id:16;
>  
> -	unsigned int severity:2;	/* 0:NONFATAL | 1:FATAL | 2:COR */
> -	unsigned int root_ratelimit_print:1;	/* 0=skip, 1=print */
> +	unsigned int severity:2;
> +	unsigned int root_ratelimit_print:1;
>  	unsigned int __pad1:4;
>  	unsigned int multi_error_valid:1;
>  
> @@ -742,9 +759,9 @@ struct aer_err_info {
>  	unsigned int is_cxl:1;
>  	unsigned int tlp_header_valid:1;
>  
> -	unsigned int status;		/* COR/UNCOR Error Status */
> -	unsigned int mask;		/* COR/UNCOR Error Mask */
> -	struct pcie_tlp_log tlp;	/* TLP Header */
> +	unsigned int status;
> +	unsigned int mask;
> +	struct pcie_tlp_log tlp;
>  };
>  
>  int aer_get_device_error_info(struct aer_err_info *info, int i);
> -- 
> 2.34.1
> 
