Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B7F48DB3A
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 08:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792397211; cv=none; b=bESuqovGd5kxPvea10964a6CpfnUPIrKaI2klfN1f311t8a/kdOrojOwqRgg5yPzVHxmSd7P9IZG7Hk/KS+Ifw7nWK/7t1I8bjvWU/HH8d6vqH7DRGRyHvfgkS7NuIVXsp0FJZy5dEgwIB+DmdoLOTAFoW9PfpdvdiMtnjEX9mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792397211; c=relaxed/simple;
	bh=FY0qcanD1yswML7l/dRsnVFaY2lJmQx9u8YM3zGuotM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cHaa472ESxKTWUPFVEJk37y0b0LIa8Nf/sWclzeL9ChDFgkTt944VV6h7Grne8NbM3pJkNeWoMqBTAGoEM/Qfg3BdlSw04qAuOP9FrURlKeHsjJu7Dm4iXRa3omdn/v2ZfvFHaGEj9YstoZtj8xI4yhMczt9cNSYUoQcFL7ZMqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vqrzGmVq; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vqrzGmVq"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-169be2dfbacso6614c88.0
        for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 01:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792397196; x=1793001996; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zKlllSkaDqzD1U/0lTr5RBP4KobTu9kcdCFVa+N+5rc=;
        b=vqrzGmVqKkpJlwhHK3iH7XvKbIizHvzh1rSWaNP8KAWStvMEiCEz4k98JRmKQ8bBVK
         qBRkkQvrqe24r8xp9WuDUy0ZnJCJOOCSOIlouqY8PDQPr15jvntvnNdBYyjfayefUjjT
         1OXdfYLh3xE6NSk5MwlneHuVjw9SEZSXdmhnozdM1v10K9piwFArV5ALL26JFC57GJmW
         ONz/1c+oRcVdAFaSrdp9z3Wd0iL26Gy7s2/PZ9LtYEsK470LnbiTvtg6mJ+bd24mf9Hu
         RXsE7dy3Wdy0pEzhuNI3Ch5ck/4McS95HD5ve+w0qOucXikb+Kcap1DcxMcDJnk3I2yy
         v8dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792397196; x=1793001996;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zKlllSkaDqzD1U/0lTr5RBP4KobTu9kcdCFVa+N+5rc=;
        b=FXc1LTIP//PIl+bqSs7SKKunvbibjrrOnMT3tmOebUgnB0NzXjQOaArv5dYUEU61kA
         W+ZEhKXtZ/vz4ctSqy91Wt4B/cTZJ655n4XBmMTKMB7XCUqTOUg3a0Jpqdi5Co3v5l5C
         xQ4HNxUfayQTP7hkyqpcYuVVqzcVmwqzjEwVxNi4WscxKRq+ohIj6M1MSiGBhGLdo9Jc
         BOC1YKuylEG7qcmUC++m7Njfi7ghCNinQ1CUn22qnMt6fB6cAq+3+Uw+0YTAljEEgcc1
         8HLLeHQgsFqLfegLWTJgx9UdP1KSONHdsShTYIeM1z4IbaT2D2IoVx2Cywc+ZlFuc4SD
         bV4A==
X-Forwarded-Encrypted: i=1; AKwUvBy0ruFSZ+mGI51Ys0Pb5Johd9q9YN6LrVuVslrAyXKHo2428WufpP8ZZDaNnr9fM/EtaCtbEZkA/yA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKRr0iUxcI0Y40+r42fAtiOsrRrcrvcXbuzqGRw8EaMAarUAgdb
	QAdiicXguUp+b0u/b7S9XDI5nsoPJRLKkO+Dy5qehQ6zKMJ8lNQD7IH22VJSfcHkLB1KKcygKx0
	4ZtTAMwRU
X-Gm-Gg: AYBFou1Mq3C41r9Iagt+UVIvuw9MLPqmXuk+1fAOn4euc9DyHO7cuAEUzLZAykYSTg4
	uBMM1jmR7s+wvDfGBrfTHge/mn0/yTVipu1oxmJ+7zEaFbcpsgFeF38temoQkQvmXfTPNLmcSQ9
	czzYnXjpajpaeEZXhcoI305xTXeaw8CZztCKxcNZWpLY2+El/YOaiIRs+Bk+Qw7Gfvd/4z9xy+9
	Mlc2q43odFqVeCAkVe+P7GnJUa7nQW9r5yY+KB5KGrZ2e5dIfvS9TvzOZsz41hnKizgeODiRsEg
	Rx5vywKozh8iJ32Z9Twx0VrOuFxLj1QoYnNzC7MOAYpmJvtEHk8/Yp9X6L1hgBMK3nO+kRlflOJ
	QfnrJH9PeEsfU2rJj52wkREDfrOt85740aZhkb6KS1xdLUPsIsnekOEEr/9v0Rp0ZdwnM5drxaq
	6NmkjdxhNPpVOPM9+wC8iH7lM4/ZJR2Gq2XD9nMqdUHu7cQrfpMabHASINkavCupM1tvEhAkMNb
	VCehyLqmI0jYu63HZ7lkPq034Zy+tusNz5glf2eG+JQK7g=
X-Received: by 2002:a05:7023:d0c:b0:184:6afb:b26c with SMTP id a92af1059eb24-185b79b5548mr344812c88.18.1792397184354;
        Mon, 19 Oct 2026 01:06:24 -0700 (PDT)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36082e81a06sm28999611eec.26.2026.10.19.01.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 01:06:23 -0700 (PDT)
Date: Mon, 19 Oct 2026 08:06:13 +0000
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
Message-ID: <atXPdbcX0XADEdh7@google.com>
References: <20260929034510.2023173-1-praan@google.com>
 <20260929034510.2023173-12-praan@google.com>
 <ar1yNtr7Kp2OTcDd@nvidia.com>
 <ar3yWUmi8E0k37Ml@google.com>
 <ar6gY9grmdMZcN/M@nvidia.com>
 <20261002164748.GD3481470@ziepe.ca>
 <asAeCz_rmpe5hbsh@google.com>
 <asUvUf4PZJ7JCLXp@nvidia.com>
 <20261017174912.GK14213@ziepe.ca>
 <atO7jTV+XNReShT+@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atO7jTV+XNReShT+@nvidia.com>

On Sat, Oct 17, 2026 at 11:16:45AM -0700, Nicolin Chen wrote:
> On Sat, Oct 17, 2026 at 02:49:12PM -0300, Jason Gunthorpe wrote:
> > On Tue, Oct 06, 2026 at 10:26:41AM -0700, Nicolin Chen wrote:
> > > > pci_dev_reset_iommu_prepare/done() pair (with slight refactoring) in EP's
> > > > suspend/resume?
> > > 
> > > That sounds right to me, though a different API for suspend/resume
> > > will be required. And call them in pci_pm_runtime_suspend/resume()
> > > maybe.
> > > 
> > > Jason, how do you think about this?
> > 
> > Maybe lets just start by refusing power management when ATS is on? For
> > PCIe devices too?
> > 
> > It isn't just ARM that has this issue, every iommu is busted if you
> > suspend the PCI device while an ATS domain is still active..
> 
> So, should we put that refuse guard in pci_pm_runtime_suspend()?
> 
> I am thinking about splitting the iommu and pci patches out of my
> smmmuv3_atc_timeout series. They could be get merged alone.
> 
> Then, we add a new API for pci_pm_runtime_suspend/resume() with a
> new BLOCKED_SUSPEND reason in the list:

The guard doesn't sound too bad, but what if we refactor the reset APIs
instead and use them from the PCI core to disable ATS + flush the ATC
right before the EP suspends, as discussed earlier? That'd fix it for
every IOMMU without taking PM away from anyone.

FWIW, AFAICT VT-d and AMD-Vi already enable ATS for ATS-capable devices
attached to the default DMA domain, so a blanket refusal might end up
disabling RPM for some internal devices (e.g. dGPUs / NVMe) that rely on
it today.

On the PCI side, I could roughly:

  - Base on Nicolin's split out iommu/pci patches (blocked reason list)
  - Add a suspend flavour of pci_dev_reset_iommu_prepare/done() with a
    BLOCKED_SUSPEND reason, i.e. RID/PASIDs parked on the blocking
    domain, group->domain retained (so dma_map/unmap keep working),
    ATS-capable devices only
  - Call prepare() in pci_pm_runtime_suspend() after the driver's
    callback but before D3, and done() in pci_pm_runtime_resume() after
    D0 + pci_restore_state() but before the driver's callback. Same for
    the system sleep (noirq) paths
  - Keep the guard only as a fallback, i.e. -EBUSY the suspend if
    prepare() fails

That flushes the ATC while the EP can still respond and stops any new
ATC_INVs to it. On the SMMU side, we'd then never see a suspended ATS
master with ATS still enabled, so a WARN_ON_ONCE() at suspend would do.

WDYT?

Thanks,
Praan
