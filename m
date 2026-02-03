Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E46B39E6ED;
	Tue,  3 Feb 2026 15:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770134059; cv=none; b=BDvG11oIX5ueTHrEkhyTlvKWqu1byyoOI8o5rqaSd3LQnw69tr17rRjwcculCTl619r9qHWPXSqR+jmEuX7sX0cIQcLZJxf/wLRSVWDUJvyx+mh4J5eCek9jELP8eXN5VMiUZI3DNFidTaap+LUxwQgye9Kf9llpEwZ0wVIKUoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770134059; c=relaxed/simple;
	bh=4UNO/bbs71rsousKzNfIbj9ul10q3GXfzXc6h00EvVg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nbA6dY3qmjnUdgKBB72FTKcRu0xmKb8JfW1mDviv7TvwIZ60+NdcLwUy8fBnCwWKZjxXvLVdFTGOtdzA2/KAjubYS0lioLY33ZJZbKQ5yUIN3L/35zLlw/f5Nz3yJ0EHeb+J8SZQM/FL/mGhyIffj/tNQVMQ7VgWDLaA5H/EBGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f57LZ06jbzJ469G;
	Tue,  3 Feb 2026 23:53:26 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 970C440569;
	Tue,  3 Feb 2026 23:54:13 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 3 Feb
 2026 15:54:12 +0000
Date: Tue, 3 Feb 2026 15:54:11 +0000
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
Subject: Re: [PATCH v15 6/9] cxl: Update error handlers to support CXL Port
 protocol errors
Message-ID: <20260203155411.00004c0d@huawei.com>
In-Reply-To: <20260203025244.3093805-7-terry.bowman@amd.com>
References: <20260203025244.3093805-1-terry.bowman@amd.com>
	<20260203025244.3093805-7-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Mon, 2 Feb 2026 20:52:41 -0600
Terry Bowman <terry.bowman@amd.com> wrote:

> CXL Protocol errors are logged for Endpoints in cxl_handle_ras() and
> cxl_handle_cor_ras(). The same is missing for CXL Port devices. The CXL
> Port logging function is already present but needs a call added from
> the handlers.
> 
> Update cxl_handle_ras() and cxl_handle_cor_ras() to call the CXL Port
> trace logging function.
> 
> Also, add log messages in the case 'ras_base' is NULL. And, add calls to
> the existing CXL Port tracing in the same functions.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
The error type was already wrongly documented for cxl_handle_ras().
This makes that comment inaccurate in a different way, particularly as you return a bool
value for a pci_ers_result_t.
> 
> ---
> 
> Changes in v14 -> v15:
> - New commit
> ---
>  drivers/cxl/core/core.h | 10 ++++++----
>  drivers/cxl/core/ras.c  | 30 ++++++++++++++++++++++--------
>  2 files changed, 28 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 92aea110817d..3b232e991b12 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h

> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 0216dafa6118..970ff3df442c 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c

>  /* CXL spec rev3.0 8.2.4.16.1 */
> @@ -317,15 +324,19 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
>   * Log the state of the RAS status registers and prepare them to log the
>   * next error status. Return 1 if reset needed.

It didn't return 1 previously and doesn't do in a different way now.
So comment needs an update.

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
> +	if (!ras_base) {
> +		pr_err_ratelimited("%s: CXL RAS registers aren't mapped\n",
> +				   dev_name(dev));
>  		return false;

returning false as pci_err_result_t?

> +	}
>  
>  	addr = ras_base + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
>  	status = readl(addr);
> @@ -344,10 +355,13 @@ bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
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
>  static void cxl_port_cor_error_detected(struct device *dev)

