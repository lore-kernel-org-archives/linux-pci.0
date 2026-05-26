Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7D13C8C74;
	Tue, 26 May 2026 22:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779834991; cv=none; b=gGYgV+9bEUq9VS+UyQd6F1ltqpHXd70VL66wZnjBMP3XtevtpdqWRSU0160ntNqyZCOzuK5qIIGTwnp8rfy0AuC5waUpMhgcYEVDnKU39tYsJVwXNgWloVzMm76PDjxjOHNpOcK5Wziq+EbMsKSV124jWsEI2+ZuZoWAiFDxJFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779834991; c=relaxed/simple;
	bh=s6u3VXH0P9rFEUglSuwmK2e5iDT9xZxXARhf65UBspE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gyt+VY6Ex6QJJF2ub8Dju/IpkXN1QELKvMcHsas16vgwC542+GbPX9wk9p9AdacVgcUNgwYVMXgQPABSObLQYnH07I1KfnHzYRfRZui3USEXM0Dr0vY19sjmtn06GTxJLB5TKRrX9htiR63I+dM8UXRGUCzzemYzvLqPiMMqfpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rg9920pE; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rg9920pE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779834990; x=1811370990;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=s6u3VXH0P9rFEUglSuwmK2e5iDT9xZxXARhf65UBspE=;
  b=Rg9920pEP6qvpZ6j6FsJpUs1+8Zz7y5gxSn5pTHaPyTYkdJsgpIlljQb
   QCZZauE29SxDLIQqKjQgzyv/L18dAxyyozu8Nwb9dm0mQmaSOTny7BFGl
   G+egkbqHexgOWXaEh5GhvjtSSLXKbH0nNwkKPH9JVpDORnYJP0LM7YUTX
   /3kqOZSNZrZ62lLCY4JO4Nk56jv8Y/sSNQa0+rkjcBGNfygyoE3In+d2w
   6/sXZ+KbuR3VEGK5KeS5nun7jSvXvyuahEj086pzA9zly7cRhvGWgWA2e
   VMQj2mjeI9US4D0wn1JEvemElMj4Z1hAi0Cy+VegIMiWqSlL2KSZWt4YZ
   A==;
X-CSE-ConnectionGUID: V/Fr/WALT5WUsdQ/bLQTSA==
X-CSE-MsgGUID: AzcJbdOkRziWR5gOn5Ce8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="98236825"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="98236825"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 15:36:29 -0700
X-CSE-ConnectionGUID: f2TB8XaqTa6FwVEP1pmNcw==
X-CSE-MsgGUID: 4CTqT8DGSKG3fDjfFi9QIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="241892702"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.110.201]) ([10.125.110.201])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 15:36:28 -0700
Message-ID: <2faec5ea-c3c5-41a1-a151-9d0992e2da3e@intel.com>
Date: Tue, 26 May 2026 15:36:27 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/12] NTB: epf: Fix doorbell bitmask and IRQ vector
 handling
To: Koichiro Den <den@valinux.co.jp>, Jon Mason <jdmason@kudzu.us>,
 Allen Hubbe <allenbh@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 ntb@lists.linux.dev
References: <20260513024923.451765-1-den@valinux.co.jp>
 <20260513024923.451765-12-den@valinux.co.jp>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260513024923.451765-12-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/12/26 7:49 PM, Koichiro Den wrote:
> The EPF driver currently stores the incoming doorbell as a vector number
> (irq_no + 1) in db_val and db_clear() clears all bits unconditionally.
> This breaks db_read()/db_clear() semantics when multiple doorbells are
> used.
> 
> Store doorbells as a bitmask (BIT_ULL(vector)) and make
> db_clear(db_bits) clear only the specified bits. Use atomic64 operations
> as db_val is updated from interrupt context.
> 
> Once db_val is stored as a bitmask, the ISR's doorbell vector is used
> not only for ntb_db_event(), but also as the bit index for BIT_ULL().
> The existing ISR derives that vector by subtracting pci_irq_vector(pdev,
> 0) from the Linux IRQ number passed to the handler, but Linux IRQ
> numbers are not guaranteed to be contiguous.
> 
> Pass per-vector context as request_irq() dev_id instead, so the ISR gets
> the device vector directly.
> 
> Validate the doorbell vector before updating db_val or calling
> ntb_db_event(), so an unexpected vector cannot create an invalid shift
> or be reported to NTB clients.
> 
> While at it, read and validate mw_count before requesting interrupt
> vectors. An unsupported memory-window count does not need IRQs, and
> failing before ntb_epf_init_isr() keeps the probe error path simple.
> 
> Fixes: 812ce2f8d14e ("NTB: Add support for EPF PCI Non-Transparent Bridge")
> Suggested-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
> Changes since v3:
>   - Stop deriving the device vector from Linux IRQ numbers; pass
>     per-vector request_irq() context instead.
>   - Validate the doorbell vector before BIT_ULL() and ntb_db_event().
>   - Check mw_count before requesting IRQs.
>   - Drop a Reviewed-by tag due to the large changes.
> 
>  drivers/ntb/hw/epf/ntb_hw_epf.c | 61 +++++++++++++++++++++------------
>  1 file changed, 39 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> index 7b0fc7ef00c6..10618e462229 100644
> --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> @@ -6,6 +6,7 @@
>   * Author: Kishon Vijay Abraham I <kishon@ti.com>
>   */
>  
> +#include <linux/atomic.h>
>  #include <linux/delay.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> @@ -89,6 +90,13 @@ enum epf_irq_slot {
>  
>  #define NTB_EPF_MAX_MW_COUNT	(NTB_BAR_NUM - BAR_MW1)
>  
> +struct ntb_epf_dev;
> +
> +struct ntb_epf_irq_ctx {
> +	struct ntb_epf_dev *ndev;
> +	unsigned int irq_no;
> +};
> +
>  struct ntb_epf_dev {
>  	struct ntb_dev ntb;
>  	struct device *dev;
> @@ -108,9 +116,9 @@ struct ntb_epf_dev {
>  	unsigned int self_spad;
>  	unsigned int peer_spad;
>  
> -	int db_val;
> +	atomic64_t db_val;
>  	u64 db_valid_mask;
> -	int irq_base;
> +	struct ntb_epf_irq_ctx irq_ctx[NTB_EPF_MAX_DB_COUNT + 1];
>  };
>  
>  #define ntb_ndev(__ntb) container_of(__ntb, struct ntb_epf_dev, ntb)
> @@ -334,11 +342,10 @@ static int ntb_epf_link_disable(struct ntb_dev *ntb)
>  
>  static irqreturn_t ntb_epf_vec_isr(int irq, void *dev)
>  {
> -	struct ntb_epf_dev *ndev = dev;
> -	int irq_no;
> -
> -	irq_no = irq - ndev->irq_base;
> -	ndev->db_val = irq_no + 1;
> +	struct ntb_epf_irq_ctx *ctx = dev;
> +	struct ntb_epf_dev *ndev = ctx->ndev;
> +	unsigned int db_vector;
> +	unsigned int irq_no = ctx->irq_no;
>  
>  	if (irq_no == EPF_IRQ_LINK) {
>  		ntb_link_event(&ndev->ntb);
> @@ -346,7 +353,17 @@ static irqreturn_t ntb_epf_vec_isr(int irq, void *dev)
>  		dev_warn_ratelimited(ndev->dev,
>  				     "Unexpected reserved doorbell slot IRQ received\n");
>  	} else {
> -		ntb_db_event(&ndev->ntb, irq_no - EPF_IRQ_DB_START);
> +		db_vector = irq_no - EPF_IRQ_DB_START;
> +		if (ndev->db_count < NTB_EPF_MIN_DB_COUNT ||
> +		    db_vector >= ndev->db_count - 1) {
> +			dev_warn_ratelimited(ndev->dev,
> +					     "Unexpected doorbell vector %u (db_count %u)\n",
> +					     db_vector, ndev->db_count);
> +			return IRQ_HANDLED;
> +		}
> +
> +		atomic64_or(BIT_ULL(db_vector), &ndev->db_val);
> +		ntb_db_event(&ndev->ntb, db_vector);
>  	}
>  
>  	return IRQ_HANDLED;
> @@ -373,18 +390,18 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
>  		argument &= ~MSIX_ENABLE;
>  	}
>  
> -	ndev->irq_base = pci_irq_vector(pdev, 0);
> +	ndev->db_count = irq - 1;
>  	for (i = 0; i < irq; i++) {
> +		ndev->irq_ctx[i].ndev = ndev;
> +		ndev->irq_ctx[i].irq_no = i;
>  		ret = request_irq(pci_irq_vector(pdev, i), ntb_epf_vec_isr,
> -				  0, "ntb_epf", ndev);
> +				  0, "ntb_epf", &ndev->irq_ctx[i]);
>  		if (ret) {
>  			dev_err(dev, "Failed to request irq\n");
>  			goto err_free_irq;
>  		}
>  	}
>  
> -	ndev->db_count = irq - 1;
> -
>  	ret = ntb_epf_send_command(ndev, CMD_CONFIGURE_DOORBELL,
>  				   argument | irq);
>  	if (ret) {
> @@ -396,7 +413,7 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
>  
>  err_free_irq:
>  	while (i--)
> -		free_irq(pci_irq_vector(pdev, i), ndev);
> +		free_irq(pci_irq_vector(pdev, i), &ndev->irq_ctx[i]);
>  	pci_free_irq_vectors(pdev);
>  
>  	return ret;
> @@ -529,7 +546,7 @@ static u64 ntb_epf_db_read(struct ntb_dev *ntb)
>  {
>  	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
>  
> -	return ndev->db_val;
> +	return atomic64_read(&ndev->db_val);
>  }
>  
>  static int ntb_epf_db_clear_mask(struct ntb_dev *ntb, u64 db_bits)
> @@ -541,7 +558,7 @@ static int ntb_epf_db_clear(struct ntb_dev *ntb, u64 db_bits)
>  {
>  	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
>  
> -	ndev->db_val = 0;
> +	atomic64_and(~db_bits, &ndev->db_val);
>  
>  	return 0;
>  }
> @@ -582,6 +599,12 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
>  	struct device *dev = ndev->dev;
>  	int ret;
>  
> +	ndev->mw_count = readl(ndev->ctrl_reg + NTB_EPF_MW_COUNT);
> +	if (ndev->mw_count > NTB_EPF_MAX_MW_COUNT) {
> +		dev_err(dev, "Unsupported MW count: %u\n", ndev->mw_count);
> +		return -EINVAL;
> +	}
> +
>  	/* One Link interrupt and rest doorbell interrupt */
>  	ret = ntb_epf_init_isr(ndev, NTB_EPF_MIN_DB_COUNT + 1,
>  			       NTB_EPF_MAX_DB_COUNT + 1);
> @@ -595,14 +618,8 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
>  	 * doorbell layout, hence -1.
>  	 */
>  	ndev->db_valid_mask = BIT_ULL(ndev->db_count - 1) - 1;
> -	ndev->mw_count = readl(ndev->ctrl_reg + NTB_EPF_MW_COUNT);
>  	ndev->spad_count = readl(ndev->ctrl_reg + NTB_EPF_SPAD_COUNT);
>  
> -	if (ndev->mw_count > NTB_EPF_MAX_MW_COUNT) {
> -		dev_err(dev, "Unsupported MW count: %u\n", ndev->mw_count);
> -		return -EINVAL;
> -	}
> -
>  	return 0;
>  }
>  
> @@ -696,7 +713,7 @@ static void ntb_epf_cleanup_isr(struct ntb_epf_dev *ndev)
>  	ntb_epf_send_command(ndev, CMD_TEARDOWN_DOORBELL, ndev->db_count + 1);
>  
>  	for (i = 0; i < ndev->db_count + 1; i++)
> -		free_irq(pci_irq_vector(pdev, i), ndev);
> +		free_irq(pci_irq_vector(pdev, i), &ndev->irq_ctx[i]);
>  	pci_free_irq_vectors(pdev);
>  }
>  

