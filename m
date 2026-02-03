Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B1434F475;
	Tue,  3 Feb 2026 16:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770135531; cv=none; b=RFx4Ax8JNWmDsq/4d614NmgCe3JzcS6olhHlmBb2FtnuDoHp141Qui2K7wGjjZiUod4HKHLV22XgHrgA5JEecbWNh9iMXXNn8UcgfAW1Tp7WT4659/DudHp0qE0VFRdK7xeE/vG9/A/bLODCB/ypdOlIY1YASvdVCEOPyYeYuJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770135531; c=relaxed/simple;
	bh=eS1WcSWVcHX1tpDW7sUjdRJysXhg4Mej4pUZU98+FHo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q36W2SXoCnXGLsM6JfcJX2UI0sDqjdTzUQ0eY2kcbtNjssM3OEqEGY8wQz7im9oUqPpaEfFUvla2uSjPKr2tIXdPrvcNcKOF4+G8gcSHZ2M/nYC6CK6E/yhb2wuErSGi462ruNw9IG/DO5wvRMcS67IC4mYrpKb0l66EspVwaW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f57tr37RLzJ46bg;
	Wed,  4 Feb 2026 00:17:56 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 1138C40570;
	Wed,  4 Feb 2026 00:18:44 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 3 Feb
 2026 16:18:43 +0000
Date: Tue, 3 Feb 2026 16:18:41 +0000
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
Subject: Re: [PATCH v15 7/9] cxl: Update Endpoint AER uncorrectable handler
Message-ID: <20260203161841.000006a1@huawei.com>
In-Reply-To: <20260203025244.3093805-8-terry.bowman@amd.com>
References: <20260203025244.3093805-1-terry.bowman@amd.com>
	<20260203025244.3093805-8-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Mon, 2 Feb 2026 20:52:42 -0600
Terry Bowman <terry.bowman@amd.com> wrote:

> CXL drivers now implement protocol RAS support. PCI protocol errors,
> however, continue to be reported via the AER capability and must still be
> handled by a PCI error recovery callback.
> 
> Replace the existing cxl_error_detected() callback in cxl/pci.c with a
> new cxl_pci_error_detected() implementation that handles only uncorrectable
> PCI protocol errors reported through AER.
> 
> Introduce helper named cxl_handler_aer() amd implement to handle and
> log the CXL device's AER error.
> 
> This cleanly separates CXL protocol error handling from PCI AER handling
> and ensures that each subsystem processes only the errors it is
> responsible.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 
> ---
> 
> Changes in v14->v15:
> - Title update (Terry)
> - Change cxl_pci_error-detected() to handle & log AER (Terry)`
> - Update commit message (Terry)
> - Moved cxl_handle_ras()/cxl_handle_cor_ras() to earlier patch (Terry)
> 
> Changes in v13->v14:
> - Update commit headline (Bjorn)
> - Rename pci_error_detected()/pci_cor_error_detected() ->
>   cxl_pci_error_detected/cxl_pci_cor_error_detected() (Jonathan)
> - Remove now-invalid comment in cxl_error_detected() (Jonathan)
> - Split into separate patches for UCE and CE (Terry)
> 
> Changes in v12->v13:
> - Update commit messaqge (Terry)
> - Updated all the implementation and commit message. (Terry)
> - Refactored cxl_cor_error_detected()/cxl_error_detected() to remove
>   pdev (Dave Jiang)
> 
> Changes in v11->v12:
> - None
> 
> Changes in v10->v11:
> - cxl_error_detected() - Change handlers' scoped_guard() to guard() (Jonathan)
> - cxl_error_detected() - Remove extra line (Shiju)
> - Changes moved to core/ras.c (Terry)
> - cxl_error_detected(), remove 'ue' and return with function call. (Jonathan)
> - Remove extra space in documentation for PCI_ERS_RESULT_PANIC definition
> - Move #include "pci.h from cxl.h to core.h (Terry)
> - Remove unnecessary includes of cxl.h and core.h in mem.c (Terry)
> ---
>  drivers/cxl/core/ras.c | 68 +++++++++++++++---------------------------
>  drivers/cxl/cxlpci.h   |  9 +++---
>  drivers/cxl/pci.c      |  6 ++--
>  3 files changed, 31 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 970ff3df442c..061e6aaec176 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -441,55 +441,35 @@ void cxl_cor_error_detected(struct pci_dev *pdev)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
>  
> -pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
> -				    pci_channel_state_t state)
> +static bool cxl_handle_aer(struct pci_dev *pdev)
>  {
> -	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> -	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> -	struct device *dev = &cxlmd->dev;
> -	bool ue;
> -
> -	scoped_guard(device, dev) {
> -		if (!dev->driver) {
> -			dev_warn(&pdev->dev,
> -				 "%s: memdev disabled, abort error handling\n",
> -				 dev_name(dev));
> -			return PCI_ERS_RESULT_DISCONNECT;
> -		}
> +	struct aer_capability_regs aer;

I don't see a strong reason to use this structure given you just want two
of the registers and read into them one by one.

> +	u32 aer_cap = pdev->aer_cap;
>  
> -		if (cxlds->rcd)
> -			cxl_handle_rdport_errors(cxlds);
> -		/*
> -		 * A frozen channel indicates an impending reset which is fatal to
> -		 * CXL.mem operation, and will likely crash the system. On the off
> -		 * chance the situation is recoverable dump the status of the RAS
> -		 * capability registers and bounce the active state of the memdev.
> -		 */
> -		ue = cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial,
> -				    cxlmd->endpoint->regs.ras);
> +	if (!aer_cap) {
> +		pr_warn_ratelimited("%s: AER capability isn't present\n",
> +				    pci_name(pdev));

These could use dev_warn_rate_limited()
or even add a wrapper similar to pci_info_rate_limited()

> +		return false;
>  	}
>  
> -	switch (state) {
> -	case pci_channel_io_normal:
> -		if (ue) {
> -			device_release_driver(dev);
> -			return PCI_ERS_RESULT_NEED_RESET;
> -		}
> -		return PCI_ERS_RESULT_CAN_RECOVER;
> -	case pci_channel_io_frozen:
> -		dev_warn(&pdev->dev,
> -			 "%s: frozen state error detected, disable CXL.mem\n",
> -			 dev_name(dev));
> -		device_release_driver(dev);
> -		return PCI_ERS_RESULT_NEED_RESET;
> -	case pci_channel_io_perm_failure:
> -		dev_warn(&pdev->dev,
> -			 "failure state error detected, request disconnect\n");
> -		return PCI_ERS_RESULT_DISCONNECT;
> -	}
> -	return PCI_ERS_RESULT_NEED_RESET;
> +	pci_read_config_dword(pdev, aer_cap + PCI_ERR_UNCOR_STATUS, &aer.uncor_status);
> +	pci_read_config_dword(pdev, aer_cap + PCI_ERR_UNCOR_MASK, &aer.uncor_mask);
> +
> +	/* The AER driver logged the error */
> +	pci_aer_clear_nonfatal_status(pdev);
> +	pci_aer_clear_fatal_status(pdev);
> +
> +	return (aer.uncor_status & aer.uncor_mask);
> +}

