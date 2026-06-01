Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A69633F5AC
	for <linux-pci@vger.kernel.org>; Mon,  1 Jun 2026 06:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780294869; cv=none; b=hHzJDSaoOJDu0lT9dvUr5WiIJdemA7X6yfplZXsBIs+06kk25mLlKFHd/cd8IWhdv5QhyFjedRIsGQjS0SwhUBYDZ6hyGOhzbFkACGle0nw9y8Kv84/yXKCKz16WrfOabIi7RY0GcHPbgFyvQlk7+ZZpx1RH7kgmyGwh5opmmr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780294869; c=relaxed/simple;
	bh=0jGCNAEl0yRsxt/VCx8AwwynyUP+qZakeyTXndkIksY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hV0lTMM5DCVFO6zN7uzQEG2VaC+FIsybOo0VeyFPRqLZHSiuJu4LhjqNsastICExUiD+TxjqbFJb7WNXoYlASMdlfacgqPo//ORxMVbCe2P8Djh4h6qJIKH/KZMBp/kki3Sg4XMxA3w5OLhJe3gjgoRDHQL/ApG9VtilH6gqbvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n0ouJt70; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n0ouJt70"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2bf2d865383so365ad.1
        for <linux-pci@vger.kernel.org>; Sun, 31 May 2026 23:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780294867; x=1780899667; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=soP7J9BuT/6lT7vP2K/RAxhntDj41HAi5S9Movt3ds4=;
        b=n0ouJt706lnd3i/Hyor5qd/+AgGqCs4P1L80IeuH8UV9Ai3N9WKQX/MctCBIW0CAwK
         MyGNBk+0RUelzjEfPs07J7xilf0K+1PmxRA/PrJun/9EgBqQ/PTRN/prsfO6h+ZxCsJ0
         0yCwafjq78aykV7Y+/kt9awT4rz/Y8IHASVFFGG/P8aH+50yQt+7Z5gMkWRPNHWOC4Yj
         la+G+KPUMUxYhOfJR5jK4YSfRYbA5x9aUfeWWwC9xt2+JjZZ3jQElRHJb/uIl1ecG4K8
         wQ29kgLYBdNsvBmeluEdu1+l7VgTmMqbvwzZbNqXNBb9zOpj1DG7iLZbPePY1R/D53bg
         a77Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780294867; x=1780899667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=soP7J9BuT/6lT7vP2K/RAxhntDj41HAi5S9Movt3ds4=;
        b=Zw+6BrnnKPVdL51AefTS887U+2qcUBg8hdKzJnU0Iz1ZNY0qPDviYB/1NVigQ84RaC
         N/n8NvjJL4Z5Fvfp68TTEb96i+I9P+6UQgReqaCnb3owgJEhL4nUboNLbV8M7H1dCaus
         cGS00eZjj2siVqxSe/cehD2ChBBUUY3th7w/IGc9CR53QXnLATma0g8hTXss/iXoiBfi
         9FQ8yYObkASvwUkSriiCdqIf2Y2E/8kwT2Vwc+IsAPGPW5HD9BcenyR/tNCMTRrdTZj3
         3ZSopgPuTV+h7YqIJNHtu3igGxc1P+vPNSnZvxHpGnyLOYM3pwu9gJdPWnvpSSLMVUEY
         MqcA==
X-Forwarded-Encrypted: i=1; AFNElJ9omuqxccvYLH/GniMKeTQePlyfiXSL3/fhSovwsgsBmhgieLRSYhRVRmqDZiMu7SXTNBr4hH5+4Po=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsX5GTNl3Kg4Hv1KSVkZixVexdsGI28Wl0D717BcKl2bVKlxGH
	JZn0wmQ2cbRyY5tq/gmZ8YrsLRruHES0vtbR0o6Ko3TQbpnT7qx6oW1fyOpa8+0nZQ==
X-Gm-Gg: Acq92OHyxWfJofk5wkUCgb1PbIAFmn4W/gNZLiCh9sw8uP1TctwHjgn52Tq6f1yQTEl
	G80LewiQDe4/E7BCkR71dd4anZv+ZFSs52Wj17eBVKnhH5CwX3VbREASKifrMJnbxYVFzopH89z
	KlPQt7mR8s+3Jb2MNGwb9ol3OFV1o9Yl55MgndSxEG8d1WkZDlKI+9i5AU7qO54fn1Gra4YEvuy
	Ep4TD8SeTtG26Kqm3AYFkgXLy+xUzoA3sWO3Zc6nES2W82Rm5qhPnu4PAifqNuSQ54vkhaGjn+1
	z7wxEDfl99JRoRLExDCvWY0GENE6CO+9FG/8VgnQWwuwX3OL377nsGSjNPh9OQpwUgB0eW+PLcJ
	tAE869kvK91Y7rFqSK1iFcWQxIMRb7CES/3obWInVOPIsLW7dNLnqEsZ+4Rs4IGC5ZGs7vzpvnq
	+meMCWP2sEoDXlxLjM2/v//ayGkyJddfsDAkhrps6vMSuETFTztmXXwXDbqg0yjDEF8bWhd74=
X-Received: by 2002:a17:902:ecc4:b0:2bf:139c:dcf3 with SMTP id d9443c01a7336-2c07cb51c58mr2879505ad.19.1780294866691;
        Sun, 31 May 2026 23:21:06 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8424defc024sm2572466b3a.47.2026.05.31.23.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 23:21:06 -0700 (PDT)
Date: Mon, 1 Jun 2026 06:20:58 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Ankit Soni <Ankit.Soni@amd.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>,
	David Matlack <dmatlack@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mostafa Saleh <smostafa@google.com>
Subject: Re: [PATCH v6 6/6] iommu/amd: Fail probe on ATS configuration failure
Message-ID: <ah0kyi5asHpnrpgC@google.com>
References: <20260529111208.387412-1-praan@google.com>
 <20260529111208.387412-7-praan@google.com>
 <unqzyef2n26wdf6tmc6vvwvpsgv244uvz7cxji4scymqmoofyb@trkzr7ix5bog>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <unqzyef2n26wdf6tmc6vvwvpsgv244uvz7cxji4scymqmoofyb@trkzr7ix5bog>

On Mon, Jun 01, 2026 at 06:00:15AM +0000, Ankit Soni wrote:
> > @@ -2502,10 +2508,22 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
> >  	else
> >  		dev_data->max_irqs = MAX_IRQS_PER_TABLE_512;
> >  
> > -	if (dev_is_pci(dev))
> > -		pci_prepare_ats(to_pci_dev(dev), PAGE_SHIFT);
> > +	if (dev_is_pci(dev)) {
> > +		struct pci_dev *pdev = to_pci_dev(dev);
> > +
> > +		if (pci_ats_supported(pdev)) {
> > +			ret = pci_prepare_ats(pdev, PAGE_SHIFT);
> > +			if (ret) {
> > +				iommu_dev = ERR_PTR(ret);
> > +				goto out_err;
> > +			}
> > +		}
> > +	}
> >  
> >  out_err:
> > +	if (IS_ERR(iommu_dev))
> > +		iommu_ignore_device(iommu, dev);
> > +
> >  	return iommu_dev;
> >  }
> >  
> 
> Hi,
> This regresses IRQ remapping in the PD_MODE_NONE branch. By design
> rlookup_table[devid] must stay valid for IR - init.c:2257 documents
> this: "Do not return an error to enable IRQ remapping ...". Pre-patch
> the PD_MODE_NONE branch returned ERR_PTR(-ENODEV) without nulling
> rlookup, precisely so irq_remapping_alloc() / __rlookup_amd_iommu()
> keep working; this unconditional cleanup violates that.
> The new pci_prepare_ats() failure path has the same shape:
> amd_iommu_set_pci_msi_domain() ran earlier and parented dev->msi_domain
> on iommu->ir_domain, but on this new out_err that's not unwound. So
> nulling rlookup_table[devid] makes irq_remapping_alloc() return -EINVAL
> on the first MSI alloc for the device. Sashiko also flagged this in [1];
> 
> Also if iommu_init_device() branch fails, iommu_ignore_device() will be
> called twice.
> 

Hi Ankit,

Ack. Sashiko made me realize that this regresses IRQ mapping for AMD,
and I agree that the call to iommu_ignore_device() is a bit too 
aggressive as it  wipes the rlookup_table entry required for IRQ 
remapping, particularly in PD_MODE_NONE.

I was thinkig to address this in the next version as follows:

1. Split the probe error paths:
   - Proper init failures (like iommu_init_device) will continue to call
     iommu_ignore_device(). I will fix the double invocation here.

   - Config failures (like ATS mismatch or PD_MODE_NONE) will return an
     an error but skip caling  iommu_ignore_device(), preserving the
     rlookup_table entry for IRQ remapping.

2. Resolve the Use-After-Free (UAF):
   To prevent the UAF on the "DMA-only" failure path, I will ensure that
   the hardware Device Table Entry (DTE) is set to a safe state (like
   blocked or bypass) and the dev_data->dev pointer is cleared, as the
   IOMMU core does not invoke release_device() after a probe failure.

3. Fix iommu_ignore_device() infrastructure:
   I will address the pre-existing bugs identified by Sashiko:
   - Fix clearing order (calling setup_aliases before clearing the
     rlookup_table).
   - Replace the non-atomic memset() on the hardware dev_table with an
     atomic DTE update.

That said, I'm investigating the safest way to revert the MSI domain
assignment on probe failure to avoid the dangling domain issue pointed
out by Sashiko. Maybe we can add an amd_iommu_restore_msi_domain() helper
to revert the assignment made in amd_iommu_set_pci_msi_domain() on probe
failure?

Please, let me know if that sounds okay?

Also, I'm wondering if I should send this as a separate series specific 
to AMD which is unrelated to this one? Or maybe handle AMD IOMMU in a
separate series altogether. Let me know if you (and Vasanth / Suravee) 
would prefer that?

Thanks,
Pranjal
