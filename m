Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9232E3947AC
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 05:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785302153; cv=none; b=kzKaJE6DzZ3Q51mWte03IsB23Scskw1zejVJPsyW5H7tQ/e29out2iXL5itaqU7k+RFesF1gflrmq08tkWYzJuLdLcYAHWZzxoAOF/XHSzZCh9EVVPxdrpD6JHEaklmYCuDC8rCaGj3auvibnFzpqVJRC0KGwALINeGL0uepHuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785302153; c=relaxed/simple;
	bh=arvW8DEjXjLKtC6BO9hMfUJE3a2BUgzm9bXYSPBa1uM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0X/uLjye9ku56Ih9Uvv6sFONyV2t+zU/jWDHDTxg+A7TqMsYdS/PQFuHihNFXhdKdQ0eeK/3nHU7QU2Bqkj5mzwVVkiOvYLAYJFT6Gwhuusm6/+U0FgrjX2qjtGa3wnQn0nBPgIJhtyhE5o7ajt8hW6f0MVjVpsp/1DC1sjWQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XAC73K+Y; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XAC73K+Y"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cede6375caso60945ad.0
        for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 22:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785302152; x=1785906952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oi3z5OGmFTcAu6ua8IwxSpW3BCYGUVzFL1IOvsxUp2E=;
        b=XAC73K+YPBVhImCmFchTHVQa5BsmFaZj80CXTx3uqwOlPjQTvTGrrh2qay+nNmbiz5
         p8F3y9elDJ53jnlKYICZdiUAzKcL1rpcFUMUnX9pLrOcV/CTPaZ4Jb9uwYyOHGV7q0AR
         daHVrqBtjMNQ4Lolwj+qwa1fZ6UV9R73xcjKLQqrPMF0si6iowjvVUnXegSGFAH4m3w0
         OLJSTcebRCdQ0EKVaI7XwdqiM0JQRFndtXHNt/TLlZ6O6MEZrhrg8zCKMLgkfxRC7mno
         pZYMdWCpTMpHFFhll3VctbiJ7jUhKP9MFgFLBpE193fEfJjusHAFPPGyMVQ2gs40sLfq
         q4gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785302152; x=1785906952;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oi3z5OGmFTcAu6ua8IwxSpW3BCYGUVzFL1IOvsxUp2E=;
        b=NrIDqCGK1UuHXz6D24SNujZqYZDZ7WM6APjdEOdry6RAK4eZjs/UjE3LlQfC8F+Jih
         9Xk4tt6Zz3+fQV3ZN2f1UURhJuEC9Cr/VX0QoQtGGRNLQcOypSOgT9ucbOfviEmuZzcx
         LvkVgKwlkq05H4cJLF8qZpOs5xjMXpWtJKCjFHiKdeKtYwySGA/Hm4iugTi2AR+WLuJm
         0a0WD6K6+xx6NTnPTaF3Zr/iqvvM1pIMlURj5BtLWJ1ODMIjBdgYyIs9aUYqKXa40i+a
         kR067qFzg3qehrFYxPDYDwKksjnhIunI9B4LQD9qprUiox/mZFLq6OyV/wjyujxvuA2E
         4cxQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr7Nso9joyLoZBonWZCfuqycx6CyQl6YteIm0pRtLVnLxXZeBi8d+e0vuyKHn2TbRbgqJW9JAKJi6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpD89aU50A58HXkjiACrVF0LFNTSx5y4POtRDv/w1mC30f41xH
	Hmxc6bpcTu/VJ/QYDZHidRiqO2PzLIUaJs73gABMrz72Q34KWfrJ+X749a9VP4HTTJdJp5DQNT4
	Qh2lq1g==
X-Gm-Gg: AR+sD133PMqtmS1nNddXWFrJ/J8kTI+WhfaEQNi1hWONrt3PnDEVC1/TYnZl34fiFeS
	CAtNczj2Yl+0Sbw05hDjWSHyznFDfhsXYcDv8VpK3RDeV57pTUriuGggBVMWflQ9dAgFqTolZGu
	3kQBgndK3ZAjrjwow+yylcfQDCDHLH5n2skOfi/iAl+zvc75Kk7TLJ/MWtDJ7E72XKO+UajS5mr
	F0xb+dc6dzF52SsE/Amsu9nuRzxEtsFviVMHPmNJW+zKRoBBqlUNkNXjX8Vr4VGQ4/aKdFwl9DG
	eXN/xecqcses5vD+4j0svnPL+/OtoqGjc7Y013diFZ9X6i29n+ZnNungACkn5lft3xcBsxZqAR/
	oGny/hxUfvOGIXM/ZP400+DmgNZK6zOORRgbpmzC42GMJ1q9E20RiPneeVxw7WdWXqb4CTrYnBs
	DWV6+L/j+ONW4klfeXbtjxdmHmrRqI75yzxiEm/A+KOggQGf92sZHjH9ZV93EBP6anA1fPwxuHo
	AM5jXVE1R78tzepJd7Nyro=
X-Received: by 2002:a17:902:e014:b0:2cf:4353:f117 with SMTP id d9443c01a7336-2d026c5c8c4mr1262155ad.0.1785302151338;
        Tue, 28 Jul 2026 22:15:51 -0700 (PDT)
Received: from google.com (21.168.124.34.bc.googleusercontent.com. [34.124.168.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea0051591sm789220b3a.19.2026.07.28.22.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 22:15:50 -0700 (PDT)
Date: Wed, 29 Jul 2026 05:15:43 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org,
	bhelgaas@google.com, kevin.tian@intel.com, kees@kernel.org,
	smostafa@google.com, baolu.lu@linux.intel.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	skaestle@nvidia.com, mmarrid@nvidia.com, skolothumtho@nvidia.com,
	bbiber@nvidia.com
Subject: Re: [PATCH v2 03/11] iommu/arm-smmu-v3: Add
 arm_smmu_drain_queue_for_iopf() helper
Message-ID: <ammMf5z-Gl-Wygk6@google.com>
References: <cover.1779944354.git.nicolinc@nvidia.com>
 <a62db13ab63916e9a62cddeec41a74a98cdf6a8f.1779944354.git.nicolinc@nvidia.com>
 <amkcQRVylEe_t-yP@google.com>
 <amkqZbPJs9qly4pH@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amkqZbPJs9qly4pH@nvidia.com>

On Tue, Jul 28, 2026 at 03:17:09PM -0700, Nicolin Chen wrote:
> On Tue, Jul 28, 2026 at 09:16:49PM +0000, Pranjal Shrivastava wrote:
> > The following is a unified drain_queue helper, that also attempts to
> > address Sashiko's concerns. This applies on top of my runtime PM v9
> > series [1], please see if it works for you:
> > 
> > Subject: [PATCH] iommu/arm-smmu-v3: Add a unified arm_smmu_drain_queue()  helper
> > 
> > Introduce a unified arm_smmu_drain_queue() helper to replace queue
> > specific polling loops. The helper handles both snapshot-based cohort
> > draining (for IOPF) and full queue draining (required for Runtime PM).
> > 
> > The Runtime PM explicitly gates the CMDQ (via CMDQ_PROD_STOP_FLAG) prior
> > to draining, this allows a single, snapshot-based target to natively
> > handle all drain scenarios.
> 
> [..] 
> >  	queue_poll_init(smmu, &qp);
> > +	qp.wfe = is_cmdq;
> 
> The callers of this drain() will be RPM and PRI, either of which
> needs busy-waiting. So, I have added a different drain() helper.
> I run Sashiko locally; it also gives a clean result.
> 

Ahh my bad. I meant to set qp.wfe = false, is_cmdq is a rebase remnant...

> Commit:
> https://github.com/nicolinc/iommufd/commit/d10325ff40fd45c476bc98d484d8dd2cdc7fdf95
> 

Thanks for sharing this, looks good from the CMDQ side (since we call
this when new CMDQ submissions are gated).

For PRIQ/EVTQ, my only worry was the HW producing more events,
say Device A is detached (we call drain from attach_release) but Device B
(still attached) starts an agressive DMA with multiple PRI requests/evts.

Maybe we should go back to snapshot based polling for that?
Anyway, we can discuss this when the series is posted.

> This will be in my pri-v3 series:
> https://github.com/nicolinc/iommufd/commits/smmuv3_pri-v3
> 
> We have too many SMMUv3 under review now. So, I will post it once
> some of them are merged.
> 
> Nicolin

Thanks,
Praan
