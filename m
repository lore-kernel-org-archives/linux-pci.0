Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94136488201
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 08:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792396963; cv=none; b=Uj9HI2MmT9StVMdr5/9ejNFayXPe6F4ZsGgrCkm3kc1Wd2O7tZsr/M3zm3Ust5+XIoTxNck2HjIVz7OpFBpvn0uyqAJdclk7kzJaoqH7QPbroUGgGcUHWKfe5ZyaArxUE6TwxEvpmJAeKDGpdK6xPRJ/3vmD4I+ipWG3RCDNHqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792396963; c=relaxed/simple;
	bh=6YV1jIyhie2HywPvxhBM7kASTJm/y5FD1q8Bn0YGL7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PkY6ZhflCj+ujZqV0Mk2EBZW7WaEGEaX/BmenS8fraA9ucOp8SsAhEP+3cTrXUKg5i9rteZ9/he1nDsLdJVT6afOqL1e+i+P96bgu49DVQXjwzqIiVooW6tx7WnK34UOWShlNuhA9zQYyopoRSkTyvYHygHcyTQwEe3/RkaoSYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XpNp07ga; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XpNp07ga"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e9f6a16afcso16785ad.1
        for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 01:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792396961; x=1793001761; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U96zIc88mN0rNQvIVq2ht+DBQv4Z66PcnccoKG6Xats=;
        b=XpNp07gahmCWUfZ9yOaqaRmu7AkZabrk7ea35PtFYf/9pL6wUNmURwtjFMJKYfYv5g
         oaPZDyybn1w8DgoCeCm2utWw6x0speiWOPwAKir4Veq61No1n9hakDgNwxh3wICsltvn
         mQ5eOM+vudTZTL+ioRTucydISf34GrotTbJ3cbWGy4TFY4/95TMktT6BLtMZvOLvXeVu
         6sQCPYwLmcmv/1AvirmLTACju0SysfrtePtkqD6hI5Q6H89JYDhvUaU9Yu4waKmEOWIK
         wfhHlJWZo1dEVI80pZVLecw0TGx+avIWXdvGOUvThxfC5ash/uFnzzHI5gDfzMQKF3Ay
         AEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792396961; x=1793001761;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U96zIc88mN0rNQvIVq2ht+DBQv4Z66PcnccoKG6Xats=;
        b=kDa3xxe20ZhmZA2AwK83Db1NFHhgyo1C0+KADEhotrgPbuOdXPeavGq9CWow0ENiR6
         T+4+ReL9BquqdSW06NKWzI1KG9CGUlClNXNOXQt+5Xt9M7jC5TowzRoMgNpNjsrCUK5R
         xA1pU9reXvrYP9tsulxRH+mbxnFprH6eict0doHhSbTPdWA5ee8Tm/mVa87/KvigKuGs
         fcd3zJbI/5tL4vrfi9E9B1VIhFDdefrSeFd4Vy6qKOPh9yiXKVPJz/ONX499BrfhYfpR
         ns0FmTjioncqwaIaafGcYYw2k9hGxrxoM0lcvzopvRX+9iBKu8ieiYi9mYZLYBKrQYZO
         zPDQ==
X-Forwarded-Encrypted: i=1; AKwUvBwuK/t+7jAz425noX1xsKY6FeV8bkABuMHO2SM1epdaOmQNYtCQ+q4NzMALko1YTC0j4FuLwaRUK7I=@vger.kernel.org
X-Gm-Message-State: AFq9FYKB9WXHf+fCF6KypvDlOpbSs+kcDCscNEAE9JL0otHBZ8ezdh3q
	gPMIJmy5rfs6NyKZBNRnCb2l7DcvJvHXIqeaFqXYXZilkpnaJ8Vb3PtSrt/ZjKoHww==
X-Gm-Gg: AYBFou0Mv9cQ2Q4m5vdhWvjNl8XX71wi4+T4mg7uYTvTccPKfr/fMJ5AP8kDXO4TRrN
	ZJw0H+XAUAP78oTIfI4GqGO3IJnkrgVEq/emCAeUepSc48iBBd9exyjPGI8Fqcf3x7Nz5Ah6Ozu
	nBr5EncPFqewfiWtMaGs9VeE/Z5dHDYIjyu87A57kCaqupZTKjKeHfd1G2VeGXkiN9z34kGrbHl
	9A1Q3TGj+1HMF48tKEktqmSbSDTfAHN+b6QQXy96bXw0EO45OSYOGU8Rp2XwgaB1IrPr77Xrnnu
	wZ4RPAjGpkNJPT0I6Q5wjdZWsCTG0AzueIubqCv/bsuyMLKv425kAE9HQ3C+R955cvIgshBgZ44
	dlc+b6RY/7Vl4nWh6sMiNQhyWWyOJoyOPQXYGAD9SCtlBt8S96OiTcgPQwJIDjKaC2miRQp0YT6
	INsistO3FdorXINBo4YEmrpuUoF2yWVF9tO/YGrCwYaiporw+9TeadXrKcKlKaaQm2WSlzWQID5
	kpij6VAbhpsWXSCSZGuCxY1UMkv+IaFrzWtnQ==
X-Received: by 2002:a17:903:388d:b0:2df:96ca:d7c7 with SMTP id d9443c01a7336-2e9b324cc9dmr6595855ad.10.1792396960066;
        Mon, 19 Oct 2026 01:02:40 -0700 (PDT)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e8353b1sm35762345ad.39.2026.10.19.01.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 01:02:39 -0700 (PDT)
Date: Mon, 19 Oct 2026 08:02:31 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev,
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org,
	Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev
Subject: Re: [PATCH v11 11/16] iommu/arm-smmu-v3: Add CMDQ_PROD_STOP_FLAG to
 gate CMDQ submissions
Message-ID: <atXOl-9C_HNvDT1E@google.com>
References: <20260929034510.2023173-1-praan@google.com>
 <20260929034510.2023173-12-praan@google.com>
 <ar1yNtr7Kp2OTcDd@nvidia.com>
 <ar3yWUmi8E0k37Ml@google.com>
 <ar6gY9grmdMZcN/M@nvidia.com>
 <20261002164748.GD3481470@ziepe.ca>
 <asAeCz_rmpe5hbsh@google.com>
 <asUvUf4PZJ7JCLXp@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asUvUf4PZJ7JCLXp@nvidia.com>

On Tue, Oct 06, 2026 at 10:26:41AM -0700, Nicolin Chen wrote:
> On Fri, Oct 02, 2026 at 09:11:39PM +0000, Pranjal Shrivastava wrote:
> > On Fri, Oct 02, 2026 at 01:47:48PM -0300, Jason Gunthorpe wrote:
> > > On Thu, Oct 01, 2026 at 11:03:15AM -0700, Nicolin Chen wrote:
> > > 
> > > > > So we can't issue ATC_INVs during suspend (the EP is already down), nor
> > > > > during resume (the SMMU resumes *before* the EP is made active). The EP
> > > > > can't use its ATC while suspended, and if it loses power/resets on the
> > > > > way back to D0 (from D3cold, or D3hot with No_Soft_Reset=0), it comes 
> > > > > back with an empty ATC.. same assumption the PCI reset path makes today
> > > > > (pci_dev_reset_iommu_prepare()).
> > > > 
> > > > In that case, would the STOP flag be too late? It's only set in
> > > > the middle of the SMMU suspend. So, an ATC command (via doamin
> > > > invalidation) might be issued prior to the Point of Commitment,
> > > > which will be timed out due to the unresponding EP?
> > > 
> > > How can you ever fix that?
> > 
> > The unfortunate reality is that this gap exists in the kernel even
> > today.. upstream SMMUv3 has no RPM, so it's always on, while the EPs can
> > runtime suspend independently. So an ATC_INV can already be issued to
> > an EP that has suspended. I'd argue RPM improves this slightly, since
> > once the STOP flag is set everything is elided, so the window closes at
> > SMMU suspend instead of never.
> 
> That doesn't sound very convincing though...
>

All I'm saying is that today, EPs can get suspended without the SMMU
ever knowing, making the SMMU aware of it helps with that.. although I
agree we need a policy here.

> > > How does power management really work, is it expected that the end
> > > device is already quieted by its driver?
> > > 
> > 
> > Yes, power management would topo-sort all dependencies and invoke
> > suspend callbacks accordingly, i.e. in our case the suspend callbacks of
> > all SMMU clients would be called before the SMMU's suspend callback.
> 
> If that's guaranteed, we should probably -EBUSY the suspend if one
> STE isn't aborted.
> 

That'd only work for (ATS-enabled) PCI devices.. for platform devices,
the STE stays as is across RPM by design (no ATC, and the TLB/CFG state
is covered by the invalidate-all on resume).

> > > Could the first step in power management install a blocked STE? Then
> > > we don't have to worry about ATC desync and that automatically stops
> > > generating new ATC invalidations if we go and detact the domains too
> > > 
> > 
> > Partially.. at SMMU suspend we set GBPA to abort and clear SMMUEN, so
> > nothing gets through while the SMMU is off. But that's global and only
> > happens after all EPs are down, it doesn't stop ATC_INVs in the window
> > Nicolin pointed out.
> > 
> > One way to ensure the ATC state is relying on the PCIe spec to lose ATC
> > content during D0 entry from D3cold, or D3hot with No_Soft_Reset=0). 
> > 
> > Another way to enforce this, is to *somehow* ask the endpoint drivers
> > disable ATS during *their* suspend, i.e. in the EP's driver's suspend
> > they could call pci_disable_ats or a better suited helper from pci core
> > and the in the pm_resume / rpm_resume they could call it's equivalent 
> > pci_enable_ats, counterpart ensuring a clean ATS state. Or maybe the
> 
> pci_enable/disable_ats is used by IOMMU drivers only.
> 

Can't the PCI core call it too? I agree the endpoint drivers may not be
aware of ATS, but there should be some way for us to flush + disable the
ATC after the EP driver's suspend & before the EP sleeps (and so before
the SMMU's suspend is called)?

> > pci_dev_reset_iommu_prepare/done() pair (with slight refactoring) in EP's
> > suspend/resume?
> 
> That sounds right to me, though a different API for suspend/resume
> will be required. And call them in pci_pm_runtime_suspend/resume()
> maybe.
> 

Ack.

Praan
