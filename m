Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F5E231C91;
	Tue,  8 Sep 2026 01:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788829578; cv=none; b=ejAHn/KUX3gqipvpJfP2APrV0RohEQvM7KM9v1bkQngIc0BYS/2LaFGpvYtuDpCcus1TbvI5TzDmyxlo+65dqTqK9WG86roM/0S1td/LGHRir+eQo4IGPttTY7WuPwXivClmbgi6wp0tqtuNL+2OYDcYIC/Ig02NNfZjR/SD36c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788829578; c=relaxed/simple;
	bh=3374W45U46gENlsUaZk+xLbAFqzB0I4aUYGj7Ep0yhc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rXzV1uekOP5BBd1LMgTEd20scIcPdCM0uiKr/wfBSEiNV2KwInwQAddP11l01KxS12bjtn9CAJw4CJXDg53Rpd1W3e7T65DEdFurW/r1yXOeeEH5DL13+AqvuPigP0RBSKv8zx7Sd8KKbSyjUn4s9cUwzZ4OC4PUg1sJwE/xrjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLQdput5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLQdput5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038CB1F00A3A;
	Tue,  8 Sep 2026 01:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788829576;
	bh=qrddGjrwXSdjWaE2ZDuMoNWHcwnqvB7kfF5xfpSoywQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nLQdput5ISlAcbbFxE/NiWZ3PpggaA0Dep5RLS9SFV21xzPhRpw+kWbKO749lxRrR
	 iYuMNZF86tTXGiNghgb4mZoRqBn5ZgvpED0HJ3WDWz4X+qOSo3Av1oNTGXEnqrrSHq
	 qURkPJ+VvVK0CernPOgSVuSOKwaGkFDEP9k/7YR8bJwrXxoyB0xUdWbrPteCzwWwe5
	 qJuoofxyZh1p914fplfKMiAQEuaRdQZ2w7kvl+aB2Yry3jioWI00KHza36bInMqwvk
	 isSLoAls7mBt79J4UBzfO7+CKFvBRtRI/U0fNcz742q7LjsxL5AWFIR+x9WqKF+tKF
	 G8dxsA9WMsDQA==
Date: Tue, 8 Sep 2026 02:06:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Terry Bowman <terry.bowman@amd.com>, "Lukas Wunner" <lukas@wunner.de>
Cc: Dave Jiang <dave.jiang@intel.com>, Alison Schofield
 <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, "Bjorn Helgaas" <bhelgaas@google.com>,
 Dan Williams <djbw@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, <linux-cxl@vger.kernel.org>, Tony Luck
 <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, "Hanjun Guo"
 <guohanjun@huawei.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, "Shuai
 Xue" <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, Ira Weiny
 <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, Shuah Khan
 <skhan@linuxfoundation.org>, Ben Cheatham <Benjamin.Cheatham@amd.com>,
 Richard Cheng <icheng@nvidia.com>, Robert Richter <rrichter@amd.com>,
 <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v20 3/9] cxl/ras: Handle RCH correctable and
 uncorrectable errors in one pass
Message-ID: <20260908020608.56e8c443@jic23-huawei>
In-Reply-To: <20260902133933.2992457-4-terry.bowman@amd.com>
References: <20260902133933.2992457-1-terry.bowman@amd.com>
	<20260902133933.2992457-4-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Sep 2026 08:39:27 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> cxl_rch_get_aer_info() reads and clears both the correctable and
> uncorrectable AER status registers in a single pass. The previous
> severity decode returned after the first matching class, so when a
> correctable and an uncorrectable error were logged simultaneously the
> correctable event was cleared in hardware but never traced or handled.
> 
> Handle both classes independently: dispatch cxl_handle_cor_ras() when
> correctable status is set and cxl_do_recovery() when uncorrectable
> status is set. Remove the now-unused cxl_rch_get_aer_severity() helper
> and decode the uncorrectable severity inline.
> 
> Log the uncorrectable status unconditionally. __pci_print_aer() only
> logs it via ANFE recursion when aer_compute_anfe_status() is non-zero.
> A conditional skip could drop a fatal or non-ANFE record once the
> hardware status is cleared.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/linux-cxl/20260803222923.517B11F00A3A@smtp.kernel.org/
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Request for Lukas to look at interactions with pci_print_aer() changes that
went in this cycle.  To me it feels like this 'fixing' things up in the
wrong place (maybe!)

> 
> ---
> 
> Changes in v19 -> v20:
> - Add snapshot of aer_regs before the correctable pci_print_aer(). (Sashiko)
> - Log the UCE status unconditionally instead of skipping on PCI_ERR_COR_ADV_NFAT
> 
> Changes in v18 -> v19:
> - New patch to process correctable and uncorrectable RCH errors in the
>   same call so a co-logged correctable event is not lost.
> ---
>  drivers/cxl/core/ras_rch.c | 64 +++++++++++++++++++-------------------
>  1 file changed, 32 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
> index ddaa3d7781678..285eed5b828b9 100644
> --- a/drivers/cxl/core/ras_rch.c
> +++ b/drivers/cxl/core/ras_rch.c
> @@ -89,42 +89,15 @@ static bool cxl_rch_get_aer_info(void __iomem *aer_base,
>  	return true;
>  }
>  
> -/* Get AER severity. Return false if there is no error. */
> -static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
> -				     int *severity)
> -{
> -	u32 uncor_status = aer_regs->uncor_status & ~aer_regs->uncor_mask;
> -
> -	if (uncor_status) {
> -		*severity = (uncor_status & aer_regs->uncor_severity) ?
> -			     AER_FATAL : AER_NONFATAL;
> -		return true;
> -	}
> -
> -	if (aer_regs->cor_status & ~aer_regs->cor_mask) {
> -		*severity = AER_CORRECTABLE;
> -		return true;
> -	}
> -
> -	return false;
> -}
> -
>  void cxl_handle_rdport_errors(struct pci_dev *pdev)
>  {
>  	struct aer_capability_regs aer_regs;
>  	struct cxl_dport *dport;
> -	int severity;
>  
>  	struct cxl_port *port __free(put_cxl_port) = cxl_pci_find_port(pdev, NULL);
>  	if (!port)
>  		return;
>  
> -	/*
> -	 * The RCH Downstream Port is the Root Port's dport
> -	 * (dport free and RAS iomap) is hosted on the CXL Host Bridge
> -	 * (port->uport_dev), not &port->dev. Hold that device's lock so the
> -	 * dport cannot be freed and its registers unmapped while in use here.
> -	 */
>  	guard(device)(port->uport_dev);
>  	dport = cxl_find_dport_by_dev(port, pdev->dev.parent);
>  	if (!dport)
> @@ -133,12 +106,39 @@ void cxl_handle_rdport_errors(struct pci_dev *pdev)
>  	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
>  		return;
>  
> -	if (!cxl_rch_get_aer_severity(&aer_regs, &severity))
> -		return;
> +	/*
> +	 * Snapshot aer_regs before handling the correctable error:
> +	 * pci_print_aer() takes it by pointer and rewrites uncor_status/
> +	 * uncor_mask in place on the Advisory Non-Fatal Error path. Use the
> +	 * copy for the uncorrectable dispatch and logging below so neither is
> +	 * corrupted by the correctable pci_print_aer() call.
> +	 */

I want input from Lukas on this.  Seems like we are papering over the cracks.
Maybe pci_print_aer() should be using a copy rather than forcing us to do it
out here.

> +	struct aer_capability_regs uncor_regs = aer_regs;
> +	u32 uncor_status = uncor_regs.uncor_status & ~uncor_regs.uncor_mask;
>  
> -	pci_print_aer(pdev, severity, &aer_regs);
> -	if (severity == AER_CORRECTABLE)
> +	/*
> +	 * Handle correctable and uncorrectable errors independently; both
> +	 * may be set in the same pass and cxl_rch_get_aer_info() has already
> +	 * cleared both status registers.
> +	 */
> +	if (aer_regs.cor_status & ~aer_regs.cor_mask) {
> +		pci_print_aer(pdev, AER_CORRECTABLE, &aer_regs);
>  		cxl_handle_cor_ras(dport->dport_dev, to_ras_base(port, dport));
> -	else
> +	}
> +
> +	if (uncor_status) {
> +		int severity = (uncor_status & uncor_regs.uncor_severity) ?
> +			       AER_FATAL : AER_NONFATAL;
> +
> +		/*
> +		 * Log unconditionally. The correctable pci_print_aer() only
> +		 * logs this via ANFE recursion when aer_compute_anfe_status()
> +		 * is non-zero. Testing PCI_ERR_COR_ADV_NFAT alone cannot tell
> +		 * whether it fired, and the HW status is already cleared. A
> +		 * duplicate line beats a lost error.
> +		 */
> +		pci_print_aer(pdev, severity, &uncor_regs);
> +
>  		cxl_do_recovery(pdev, dport->port, dport);
> +	}
>  }

