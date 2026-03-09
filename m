Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C043BE16B;
	Mon,  9 Mar 2026 14:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773065125; cv=none; b=eaLuLtN25bPv75MMCifSGQyEMVXfP9NOR805/3pFD1m4nvhY5mSWvQgznluVkZnu2DYz67K2aZWamBJfcSIlBhjvbwKf5fT8W87mMyi7KD5U5J96p0sSz8Z71oGa+0bXKGNKT4eZilQaSb/Bn+LlDOpp1Z3gyILbaFVB4dISeDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773065125; c=relaxed/simple;
	bh=W4WuCTbQ/gq4MgSONrRszjJinS6ji2YH/f/Iub4+lB0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r7in+zjSGyBMwEISnwrxXnH0KEmmeVwGApaRbzo4m82Kaef3MiN5GITIS7ktTH6bQC/zjTqH1QatTEzKZ1NQ3JhdDwXSF7lEghGmFfdRkDsUv3LOd9HPbQ0kx52uvFdhMSAWiuQ0UROyQ/s+KQJ0ZVECl3BNvZOk40KaJRASfHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fTzL45MmFzHnGjW;
	Mon,  9 Mar 2026 22:05:16 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 954B04056B;
	Mon,  9 Mar 2026 22:05:20 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 9 Mar
 2026 14:05:19 +0000
Date: Mon, 9 Mar 2026 14:05:18 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>, <alucerop@amd.com>,
	<ira.weiny@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v16 07/10] cxl: Update error handlers to support CXL
 Port devices
Message-ID: <20260309140518.000009e2@huawei.com>
In-Reply-To: <20260302203648.2886956-8-terry.bowman@amd.com>
References: <20260302203648.2886956-1-terry.bowman@amd.com>
	<20260302203648.2886956-8-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Mon, 2 Mar 2026 14:36:45 -0600
Terry Bowman <terry.bowman@amd.com> wrote:

> CXL Protocol trace logging is called for Endpoints in cxl_handle_ras() and
> cxl_handle_cor_ras(). Trace logging support for CXL Port devices is missing.
> 
> CXL Endpoint trace logging utilizes a separate trace routine than CXL Port
> device handling. Using is_cxl_memdev(), determine if the device is a CXL EP
> or one of the CXL Port devices.
> 
> Update cxl_handle_ras() and cxl_handle_cor_ras() to call the CXL Port trace
> logging function. Change cxl_handle_ras() return values to be pci_ers_result_t
> type.

Why this last bit?

> 
> Check for invalid ras_base and add log messages if NULL.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

A few comments inline.

Thanks,

Jonathan

> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 48d3ef7cbb92..254144d19764 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -291,15 +291,22 @@ void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>  	void __iomem *addr;
>  	u32 status;
>  
> -	if (!ras_base)
> +	if (!ras_base) {
> +		pr_err_ratelimited("%s: CXL RAS registers aren't mapped\n",
> +				   dev_name(dev));

This print isn't mentioned in the commit message. Probably needs some comment
on why all paths that get here are error paths.

>  		return;
> +	}
>  
>  	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
>  	status = readl(addr);
> -	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
> -		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> +	if (!(status & CXL_RAS_CORRECTABLE_STATUS_MASK))
> +		return;
> +
> +	writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> +	if (is_cxl_memdev(dev))
>  		trace_cxl_aer_correctable_error(dev, status, serial);
> -	}
> +	else
> +		trace_cxl_port_aer_correctable_error(dev, status);
>  }
>  
>  /* CXL spec rev3.0 8.2.4.16.1 */
> @@ -321,22 +328,26 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
>  
>  /*
>   * Log the state of the RAS status registers and prepare them to log the
> - * next error status. Return 1 if reset needed.
> + * next error status. Return PCI_ERS_RESULT_PANIC if reset needed.

This seems odd as normally PANIC implies more than reset.  I guess system reset,
kind of...

>   */
> -bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
> +pci_ers_result_t
> +cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>  {
>  	u32 hl[CXL_HEADERLOG_SIZE_U32];
>  	void __iomem *addr;
>  	u32 status;
>  	u32 fe;
>  
> -	if (!ras_base)
> -		return false;
> +	if (!ras_base) {
> +		pr_err_ratelimited("%s: CXL RAS registers aren't mapped\n",
> +				   dev_name(dev));
> +		return PCI_ERS_RESULT_NONE;
> +	}
>  
>  	addr = ras_base + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
>  	status = readl(addr);
>  	if (!(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK))
> -		return false;
> +		return PCI_ERS_RESULT_NONE;
>  
>  	/* If multiple errors, log header points to first error from ctrl reg */
>  	if (hweight32(status) > 1) {
> @@ -350,10 +361,13 @@ bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>  	}
>  
>  	header_log_copy(ras_base, hl);
> -	trace_cxl_aer_uncorrectable_error(dev, status, fe, hl, serial);
> +	if (is_cxl_memdev(dev))
> +		trace_cxl_aer_uncorrectable_error(dev, status, fe, hl, serial);
> +	else
> +		trace_cxl_port_aer_uncorrectable_error(dev, status, fe, hl);
>  	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
>  
> -	return true;
> +	return PCI_ERS_RESULT_PANIC;
>  }
>  
>  void cxl_cor_error_detected(struct pci_dev *pdev)

