Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA16738BF91;
	Mon,  9 Mar 2026 14:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773064859; cv=none; b=Z17q/TwP0havIjB8DMajRVRxJ1qtA0l0lG9d4Yr2rYos/cgsy0UrHc+v1/eyJG8ONYYwcf+eMiUOhe1wsDgnKXi+OuofJNmdK+Hw8B4Gj4DLoZE8ebDuX9G1gp949uXi/KUt6Qc4Eint3pP2Q2e4Ts0Kko/7fZfzOy/LS7bcLTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773064859; c=relaxed/simple;
	bh=VHzWzSPx3+7Sz6wYhbihU0d9teB4EtAfLpDdUsqzZl8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JpWSOIKaN7y0VGMFPcDZGrRNzG+5YhMsoLVAgje4BoMopyLJ9Qkk7NIhL9PzUXys7JzRSle/LzGJvejP1vhkM7/BIOCtqZEhYCsZEL6CJYok+Qc7ERwWcIIqb+KU6pdaUvqkxEbHJNr7yB8/anWY+3n2iKVVQzGgV4aFNIrAcpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fTzDB0jWLzJ46Dy;
	Mon,  9 Mar 2026 22:00:10 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 1DECC40086;
	Mon,  9 Mar 2026 22:00:53 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 9 Mar
 2026 14:00:52 +0000
Date: Mon, 9 Mar 2026 14:00:50 +0000
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
Subject: Re: [PATCH v16 06/10] PCI/CXL: Add RCH support to CXL handlers
Message-ID: <20260309140050.0000451d@huawei.com>
In-Reply-To: <20260302203648.2886956-7-terry.bowman@amd.com>
References: <20260302203648.2886956-1-terry.bowman@amd.com>
	<20260302203648.2886956-7-terry.bowman@amd.com>
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

On Mon, 2 Mar 2026 14:36:44 -0600
Terry Bowman <terry.bowman@amd.com> wrote:

> Restricted CXL Host (RCH) error handling is not currently supported by the
> CXL Port error handling flow. Integrate the existing RCH error handling
> into the new Port error handling.
> 
> Update cxl_rch_handle_error_iter() to forward the RCH protocol error using
> the AER-CXL kfifo.
> 
> Update cxl_handle_proto_error() to begin the RCH error handling with a call
> to cxl_handle_rdport_errors(). This function handles both correctable and
> uncorrectable RCH protocol errors.
> 
> Change the cxl_handle_rdport_errors() function parameter from a CXL device
> state to a PCI device.
> 
> Report the serial number of the RCD Endpoint in the RCH logging. This
> is used to associate the RCH with the RCD in the logs.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
One question inline.

+ a comment on a bit of neighboring code.

J
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 1d4be2d78469..48d3ef7cbb92 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c

>  static void cxl_handle_proto_error(struct pci_dev *pdev, int severity)
>  {
> +	/*
> +	 * CXL RCD's AER error interrupt is used for reporting RCD and RCH
> +	 * Downstream Port protocol errors. RCH protocol errors are handled
> +	 * using a unique procedure separate from from CXL Port devices.
> +	 * See CXL spec r4.0, 12.2 CXL Error Handling
> +	 */
> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END)
> +		cxl_handle_rdport_errors(pdev);

Maybe I'm missing something but why do we want to carry on running the rest
of this function after this?  Superficially seems like we will be doing
at least some stuff that didn't happen before.

> +
>  	if (severity == AER_CORRECTABLE) {
>  		struct device *dev = &pdev->dev;

> diff --git a/drivers/pci/pcie/aer_cxl_rch.c b/drivers/pci/pcie/aer_cxl_rch.c
> index e471eefec9c4..83142eac0cab 100644
> --- a/drivers/pci/pcie/aer_cxl_rch.c
> +++ b/drivers/pci/pcie/aer_cxl_rch.c
> @@ -37,26 +37,11 @@ static bool cxl_error_is_native(struct pci_dev *dev)
>  static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>  {
>  	struct aer_err_info *info = (struct aer_err_info *)data;

Not related to this patch but that cast isn't needed.

> -	const struct pci_error_handlers *err_handler;
>  
