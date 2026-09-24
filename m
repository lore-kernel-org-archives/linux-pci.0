Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BA7411A04;
	Thu, 24 Sep 2026 03:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790221819; cv=none; b=lLh7gzw7iX+deQiMmcSQKClFIBj5lQf5u6m9Y7w9iKwLP4grhk956sn4q3VMIEUc645RTUBSL7xQXergw1xP1bx95PMcayx0W0J3z9apY6ih2z7FYWD2JXQAle/hIxJKfKeXXz9f24uOpdcNi8LeV6MExHep/H2ONWpQpQNzjnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790221819; c=relaxed/simple;
	bh=EYDtgQh4UcsNtSysALP+BZSrwdnGwsWWo/9NQvy0WCI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J9xr9i5jX4gYOdXDEVhFf3SPf7Q4oFF1LaPqNX6avA58PyDpR9jWANpdGrGJ5WnNP9DIiB7LLJjSTd5f6rdyguVrLcgPYRfl9SiI5mAGoJjLfr6MIzAfcfC/qOacep+4V9cthLWxyDiqqLXYfyfMh9Y+pBf5Rev3f5glkWJ1aXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LAoLIIDU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAoLIIDU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209201F00898;
	Thu, 24 Sep 2026 03:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790221817;
	bh=vL0tcDYJr3n2Q4j6if2QNfUOhtsuGg0RL0rCca8Bhnk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LAoLIIDUnEmOBMkyDlO5bl4xr79XHe+LIjFG3J45nGFqVXb0VXQZeqVDMcM7XnvDv
	 6+QchEdBrf0LA4iqvpnsOFjdzrLf69/UngP40z89FLxkH9cr1i97Jj5Kd1JpitopCy
	 2OkyBLtfhP++3A0fK5OkyC4PLZ9S3REsklGRzWk0L73Shr5ygVR0CDVTGEZh79bNyk
	 BoQNYixweWY4Aq4ntBTwhOizQsNGTHt4QE9M0vSt/zvkXrpJludha7iKr/3gO2KEgC
	 DpTZSbW3wml9kQePNy/H7+Sd2PunY2lRVJrRSJtgodxzPhC4R5WmyYzataIJc2O00Q
	 xvI+aViWdo4Gg==
Date: Thu, 24 Sep 2026 04:50:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Srirangan Madhavan <smadhavan@nvidia.com>
Cc: Alison Schofield <alison.schofield@intel.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Alex Williamson
 <alex.williamson@redhat.com>, vsethi@nvidia.com, alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>, Vishal Aslot
 <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>, Jiandi An
 <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
Subject: Re: [PATCH v13 13/15] cxl: Restore CXL state after PCI reset
Message-ID: <20260924045010.3c1b299f@jic23-hlaptop>
In-Reply-To: <20260922083924.2451158-14-smadhavan@nvidia.com>
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
	<20260922083924.2451158-14-smadhavan@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 08:39:22 +0000
Srirangan Madhavan <smadhavan@nvidia.com> wrote:

> Restore the PCI configuration needed for HDM access, followed by cached
> HDM decoder and CXL Device DVSEC state. Recommit a cleared locked decoder
> before restoring its lock, but leave surviving locked state unchanged.
> 
> Stop at the first restoration failure and preserve a disabled PCI command
> snapshot. Keep IOMMU exclusion active through restoration and post-reset
> cache invalidation.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Hi Srirangan,

I'm out of time for today so main request it to take a look at that
final function. It is running quite a complex statemachine with a bunch
of ownership transfers. That's the sort of single function that takes
too much energy to review. Please have a revisit and see if there
is a simpler stepwise way to do that.

> @@ -726,6 +1064,18 @@ static int cxl_reset_disable_cache(struct pci_dev *pdev, int dvsec, u16 cap)
>  	return cxl_reset_wait_cache_wbi(pdev, dvsec);
>  }
>  
> +static int cxl_reset_restore_cache_policy(struct pci_dev *pdev, int dvsec)
> +{
> +	int rc;
> +
> +	rc = cxl_reset_update_ctrl2_no_replay(pdev, dvsec, 0,
> +					      PCI_DVSEC_CXL_DISABLE_CACHING);
> +	if (rc)
> +		pci_err(pdev, "failed to re-enable CXL caching: %d\n", rc);
> +
> +	return rc;
> +}
> +
>  static int cxl_reset_wait_done(struct pci_dev *pdev, int dvsec, u16 cap)
>  {
>  	unsigned long deadline;
> @@ -767,28 +1117,41 @@ static int cxl_reset_wait_done(struct pci_dev *pdev, int dvsec, u16 cap)
>  	}
>  }
>  
> -static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap,
> -			     struct cxl_hdm_range_context *range_ctx)
> +static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
>  {
> +	struct cxl_hdm_info *snapshot = NULL;
> +	struct cxl_hdm_range_context range_ctx;
> +	u16 command;
>  	int rc, rc2;
>  
> -	rc = cxl_reset_disable_cache(pdev, dvsec, cap);
> +	down_write(&cxl_rwsem.region);
> +	INIT_LIST_HEAD(&range_ctx.ranges);
> +
> +	rc = cxl_hdm_ranges_prepare(&range_ctx, pdev);
> +	if (rc)
> +		goto out_destroy_ranges;
> +
> +	rc = cxl_snapshot_hdm(pdev, &snapshot);
>  	if (rc)
>  		goto out_destroy_ranges;
>  
> +	rc = cxl_reset_disable_cache(pdev, dvsec, cap);
> +	if (rc)
> +		goto out_destroy_enable_cache;
> +
>  	if (!pci_wait_for_pending_transaction(pdev)) {
>  		pci_err(pdev, "timed out waiting for pending transactions\n");
>  		rc = -ETIMEDOUT;
> -		goto out_destroy_ranges;
> +		goto out_destroy_enable_cache;
>  	}
>  
>  	rc = pci_dev_reset_iommu_prepare(pdev);
>  	if (rc) {
>  		pci_err(pdev, "failed to stop IOMMU for CXL reset: %d\n", rc);
> -		goto out_destroy_ranges;
> +		goto out_destroy_enable_cache;
>  	}
>  
> -	/* Clear Memory Clear again even if this command write reports failure. */
> +	/* Clear Memory Clear below even if this command write reports failure. */
>  	rc = cxl_reset_update_ctrl2_no_replay(pdev, dvsec,
>  					      PCI_DVSEC_CXL_INIT_CXL_RST |
>  					      PCI_DVSEC_CXL_RST_MEM_CLR_EN, 0);
> @@ -798,39 +1161,60 @@ static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap,
>  	rc = cxl_reset_wait_done(pdev, dvsec, cap);
>  
>  out_clear_memory:
> -	rc2 = cxl_reset_update_ctrl2_no_replay(
> -		pdev, dvsec, 0, PCI_DVSEC_CXL_RST_MEM_CLR_EN);
> +	rc2 = cxl_reset_update_ctrl2_no_replay(pdev, dvsec, 0,
> +					       PCI_DVSEC_CXL_RST_MEM_CLR_EN);
>  	if (rc2)
>  		pci_err(pdev, "failed to clear CXL Reset Memory Clear: %d\n",
> -			rc2);
> +			 rc2);
>  	rc = rc ?: rc2;
> +	if (rc)
> +		goto out_finish_ranges;
> +
> +	cxl_restore_pci_state_for_hdm_restore(pdev, &command);
> +	rc = cxl_restore_state(pdev, snapshot);
>  
> +out_finish_ranges:
>  	/* Evict lines fetched during reset before ending DMA exclusion. */
> -	rc2 = cxl_hdm_ranges_finish(range_ctx);
> +	rc2 = cxl_hdm_ranges_finish(&range_ctx);
>  	rc = rc ?: rc2;
> +	if (rc)
> +		goto out_fail_closed;
> +
>  	pci_dev_reset_iommu_done(pdev);
> -	goto out_enable_cache;
>  
> -out_destroy_ranges:
> -	cxl_hdm_range_context_destroy(range_ctx);
> +	rc = cxl_reset_restore_cache_policy(pdev, dvsec);
> +	if (rc) {
> +		cxl_reset_save_disabled_state(pdev);
> +		goto out_unlock;
> +	}
>  
> -out_enable_cache:
> -	/*
> -	 * DISABLE_CACHING was the first preparation step. Restore the original
> -	 * cache policy last, after reset exclusion has ended.
> -	 */
> -	rc2 = cxl_reset_update_ctrl2_no_replay(
> -		pdev, dvsec, 0, PCI_DVSEC_CXL_DISABLE_CACHING);
> -	if (rc2)
> -		pci_err(pdev, "failed to re-enable CXL caching: %d\n", rc2);
> +	rc = cxl_reset_save_restored_state(pdev, command);
> +	goto out_unlock;
> +
> +out_fail_closed:
> +	cxl_reset_save_disabled_state(pdev);
> +	pci_dev_reset_iommu_done(pdev);
> +	rc2 = cxl_reset_restore_cache_policy(pdev, dvsec);
>  	rc = rc ?: rc2;
> +	goto out_unlock;
> +
> +out_destroy_enable_cache:
> +	cxl_hdm_range_context_destroy(&range_ctx);
> +	rc2 = cxl_reset_restore_cache_policy(pdev, dvsec);
> +	rc = rc ?: rc2;
> +	goto out_unlock;
> +
> +out_destroy_ranges:
> +	cxl_hdm_range_context_destroy(&range_ctx);
>  
> +out_unlock:
> +	kfree(snapshot);
> +	up_write(&cxl_rwsem.region);

This is going to take some signficant unpicking but as
it stands it is very complex to follow with releases quite
often out of reverse order of setup and complex hand
off from one function to another. Please take another look
even if I don't get back to this with more specific comments.


>  	return rc;
>  }


