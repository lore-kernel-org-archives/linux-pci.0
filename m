Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322D038F24E;
	Wed, 21 Jan 2026 11:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768995093; cv=none; b=L+bX52E0ncgyXfoxuKqWXEUE0ebqht+42zHNafeQgAJBLV7JKM3HyO4gYUyjLfIwNZ9uDVxUx3ubI/RJ2UoCq2FZpprlz8zq7JV5gSKJ3K7tf2vqCst7qZ0GKKPZkBXeZc2m8+T82cbLyruAPQzbGG42zEybL4xLTGERZseruG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768995093; c=relaxed/simple;
	bh=6K0cGwSm5Nfdo19Vlx2NJijGIQfXQVq9P8ZNa8mF3aQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ed2b5hQEz/RQuRy2IQc3GFEdaNpR3BZVGZVtWX8rvDFfrj7SzIj90jXubBRsQUfdKldyRbIK+dZB3xaUFfOfsTEiQuvmNx4DpX3VJBUXOSdxrxe2K6tjXEfzo9fHYPWZqy5RPzPC0e7+CXoUFpmRWDEL/COytmWeRejyCUbpTaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dx27d6pD9zHnHFs;
	Wed, 21 Jan 2026 19:30:53 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 8F5C640086;
	Wed, 21 Jan 2026 19:31:27 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 21 Jan
 2026 11:31:25 +0000
Date: Wed, 21 Jan 2026 11:31:23 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <smadhavan@nvidia.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <ming.li@zohomail.com>,
	<rrichter@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<huaisheng.ye@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <vaslot@nvidia.com>, <vsethi@nvidia.com>,
	<sdonthineni@nvidia.com>, <vidyas@nvidia.com>, <mochs@nvidia.com>,
	<jsequeira@nvidia.com>
Subject: Re: [PATCH v4 08/10] cxl: add DVSEC config save/restore
Message-ID: <20260121113123.00004ca1@huawei.com>
In-Reply-To: <20260120222610.2227109-9-smadhavan@nvidia.com>
References: <20260120222610.2227109-1-smadhavan@nvidia.com>
	<20260120222610.2227109-9-smadhavan@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Tue, 20 Jan 2026 22:26:08 +0000
smadhavan@nvidia.com wrote:

> From: Srirangan Madhavan <smadhavan@nvidia.com>
> 
> Save and restore CXL DVSEC control registers across reset with
> CONFIG_LOCK handling so RWL fields are preserved when locked. This
> maintains device policy and capability state across cxl_reset while
> avoiding writes to locked fields.

Add some more info here on what is protected by the lock and
preserved across reset.  This is odd enough I think that detail is needed.
There are other RWL fields outside those registers you are restoring here.
e.g. the range registers, various things in extended meta data,

> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/pci.c | 107 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/cxl/pci.h |  15 +++++++
>  2 files changed, 122 insertions(+)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index f9cc452ccb8a..7d6a0ef70b2d 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1154,6 +1154,113 @@ static int cxl_region_flush_host_cpu_caches(struct device *dev, void *data)
>  	return 0;
>  }
> 
> +/*
> + * CXL DVSEC register save/restore
> + */
> +static int cxl_save_dvsec_state(struct pci_dev *pdev,
> +				struct cxl_type2_saved_state *state, int dvsec)
> +{
> +	int rc;
> +
> +	rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_CTRL_OFFSET,
> +				  &state->dvsec_ctrl);
> +	if (rc)
> +		return rc;
> +
> +	rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_CTRL2_OFFSET,
> +				  &state->dvsec_ctrl2);
> +	return rc;
Similar to below. Just combine 2 lines into 1.
> +}
> +
> +static int cxl_restore_dvsec_state(struct pci_dev *pdev,
> +				   const struct cxl_type2_saved_state *state,
> +				   int dvsec, bool config_locked)
> +{
> +	int rc;
> +	u16 val_to_restore;
> +
> +	if (config_locked) {
> +		u16 current_val;
> +
> +		rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_CTRL_OFFSET,
> +					  &current_val);
> +		if (rc)
> +			return rc;
> +
> +		val_to_restore = (current_val & CXL_DVSEC_CTRL_RWL_MASK) |
> +				 (state->dvsec_ctrl & ~CXL_DVSEC_CTRL_RWL_MASK);
> +	} else {
> +		val_to_restore = state->dvsec_ctrl;
> +	}
> +
> +	rc = pci_write_config_word(pdev, dvsec + CXL_DVSEC_CTRL_OFFSET,
> +				   val_to_restore);
> +	if (rc)
> +		return rc;
> +
> +	rc = pci_write_config_word(pdev, dvsec + CXL_DVSEC_CTRL2_OFFSET,
> +				   state->dvsec_ctrl2);
> +	return rc;

If this isn't expected to get more complex (I haven't checked) then
return pci_write_config()

> +}
> +
> +/**
> + * cxl_config_save_state - Save CXL configuration state
> + * @pdev: PCI device
> + * @state: Structure to store saved state
> + *
> + * Saves CXL DVSEC state before reset.
> + */
> +int cxl_config_save_state(struct pci_dev *pdev,
> +			  struct cxl_type2_saved_state *state)
> +{
> +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> +	int dvsec;
> +
> +	if (!cxlds || !state)
> +		return -EINVAL;
> +
> +	memset(state, 0, sizeof(*state));
We need to make sure all registers are read, so why is zeroing helpful? 

> +
> +	dvsec = cxlds->cxl_dvsec;
> +	if (!dvsec)
> +		return -ENODEV;
> +
> +	return cxl_save_dvsec_state(pdev, state, dvsec);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_config_save_state, "CXL");

