Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731FD2652B6;
	Tue,  3 Feb 2026 16:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770136038; cv=none; b=AY+Dmf2mST1qKrvuPAQ/E1vu+Cubpsn7iQOJw4XmHBJfNG2UrkgpsIX9HGoUSbJhJOtWfIRIhpD7O44zpqrf52BwpI9DZXJ1q3Rm/1CEVpJAMyAn5bfCTS1+LvYW79bj29ixB1PK1imNI4rw8tAo4t/Z4joqr3UZa7Eh/huAdvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770136038; c=relaxed/simple;
	bh=z7k3+zs9+ReXK199UPguA2ILoq53tPoo21AtK2GfAHA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jaXfFOO1oebdmNEjyZgUDNtV1UL7X01nRBFiNi8cmcIHXN5Q5ln22PCuapyf6WKGnJ4FdkP2d3qsHbPcL7DtjDpaywcjLk6JHKTuKiLLJWwQZFEgXt5IzbJ679ABOtVssErtkh2C5MTORy5La0aDCtvMfd5QxYKjwOyRn6LiKwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f584f2ybJzJ468t;
	Wed,  4 Feb 2026 00:26:26 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 0CB3640565;
	Wed,  4 Feb 2026 00:27:14 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 3 Feb
 2026 16:27:13 +0000
Date: Tue, 3 Feb 2026 16:27:11 +0000
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
Subject: Re: [PATCH v15 8/9] cxl: Remove Endpoint AER correctable handler
Message-ID: <20260203162711.000019a4@huawei.com>
In-Reply-To: <20260203025244.3093805-9-terry.bowman@amd.com>
References: <20260203025244.3093805-1-terry.bowman@amd.com>
	<20260203025244.3093805-9-terry.bowman@amd.com>
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

On Mon, 2 Feb 2026 20:52:43 -0600
Terry Bowman <terry.bowman@amd.com> wrote:

> CXL drivers dont require a correctable PCI AER handler. Correctable AER
> errors reported by CXL devices are logged and cleared in the AER driver.
> This makes the correctable AER handler callback in the CXL driver
> unnecessary.
> 
> Remove cxl_cor_error_detected() and drop the .cor_error_detected callback
> from the CXL PCI error handlers.
> 
> This consolidates correctable error reporting under the CXL RAS infrastructure
> and avoids redundant or conflicting logging with the AER driver.

Please add a before and after log so we know what the redundant info was that has
been dropped.

Jonathan

> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 
> ---
> 
> Changes in v14->v15:
> - Remove cxl_pci_cor_error_detected(). Is not needed. AER is logged
>   in the AER driver. (Dan)
> - Update commit message (Terry)
> 
> Changes in v13->v14:
> - New commit
> - Change cxl_cor_error_detected() parameter to &pdev->dev device from
>   memdev device. (Terry)
> - Updated commit message (Terry)
> ---
>  drivers/cxl/core/ras.c | 23 -----------------------
>  drivers/cxl/cxlpci.h   |  2 --
>  drivers/cxl/pci.c      |  1 -
>  3 files changed, 26 deletions(-)
> 
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 061e6aaec176..e5a0d0283d3f 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -418,29 +418,6 @@ static pci_ers_result_t cxl_port_error_detected(struct device *dev)
>  	}
>  }
>  
> -void cxl_cor_error_detected(struct pci_dev *pdev)
> -{
> -	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> -	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> -	struct device *dev = &cxlds->cxlmd->dev;
> -
> -	scoped_guard(device, dev) {
> -		if (!dev->driver) {
> -			dev_warn(&pdev->dev,
> -				 "%s: memdev disabled, abort error handling\n",
> -				 dev_name(dev));
> -			return;
> -		}
> -
> -		if (cxlds->rcd)
> -			cxl_handle_rdport_errors(cxlds);
> -
> -		cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->serial,
> -				   cxlmd->endpoint->regs.ras);
> -	}
> -}
> -EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
> -
>  static bool cxl_handle_aer(struct pci_dev *pdev)
>  {
>  	struct aer_capability_regs aer;
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 5534422b496c..e3388dffdd75 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -78,13 +78,11 @@ struct cxl_dev_state;
>  void read_cdat_data(struct cxl_port *port);
>  
>  #ifdef CONFIG_CXL_RAS
> -void cxl_cor_error_detected(struct pci_dev *pdev);
>  void devm_cxl_dport_rch_ras_setup(struct cxl_dport *dport);
>  pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
>  					pci_channel_state_t error);
>  void devm_cxl_port_ras_setup(struct cxl_port *port);
>  #else
> -static inline void cxl_cor_error_detected(struct pci_dev *pdev) { }
>  static inline pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
>  						      pci_channel_state_t state)
>  {
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index ff741adc7c7f..c6b2966f5fda 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1055,7 +1055,6 @@ static const struct pci_error_handlers pci_error_handlers = {
>  	.error_detected	= cxl_pci_error_detected,
>  	.slot_reset	= cxl_slot_reset,
>  	.resume		= cxl_error_resume,
> -	.cor_error_detected	= cxl_cor_error_detected,
>  	.reset_done	= cxl_reset_done,
>  };
>  

