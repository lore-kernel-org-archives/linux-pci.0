Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EECC3F1AD5
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 14:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779372794; cv=none; b=jDt7Kb2t/I7fRRNJD3UbnFJyS9eXcuuIBhhQTqTXoji6K9O1Pdvum4XuIX2Qofp4uN4FCK6HW4p3bjXkeDXsuCgCQA00uMhEtiWNmQ5B37qIPOfyHH+K7unR+sDx8XJ3gvB+cmbGSW9eoZ8cUBlGuPiRf73Ogoj3gQCMZb0HoN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779372794; c=relaxed/simple;
	bh=bmfPERpB7MWSF0cAZjt909bSkVQeW7RLJVftGqD541k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=W0ZM5agLvFRRhtdxnQ3f5z1b4aneeu6buKFa44o/6/VBfPBl/rxAmetMNEwrSoZAS5mBL0sWVH0RdP8U/eYftvbJ7KWJ+onbonWswf+bpWwxrOSw/T94mfJaX5+eVoKZ3B1iSqNv7Xa/Dl6KrVhAUU2MJVgg2HbdhFytK0BGIfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bnW0P3OR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bnW0P3OR"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 8FDDC1F00A3B;
	Thu, 21 May 2026 14:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779372792;
	bh=YPwCQUu2Ga1RaKdOcrj3e6UUg4ulzf3ZGzZl11DHA3M=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=bnW0P3ORHMY1w+0MtEq+q24jzm1Jcu3OJf4BkM9zBUIk9GgFEGV2hIOILEnSUfcQH
	 Bq+GelOjKhDgonfhqNg9c5fx35CArVV3Bsm6P9Xa+znofk+XFarHvINAo8CZK4ypC5
	 QeHyi7YPTRy7bD7/8aahfJ9FBpe9T+ocSj/zS6SlH0CcR7FL6hoGOViUlN7trn8D/k
	 ZWvkyhh+bQcFANp/Xq5RQJ9p0PkOAMxkcwq36Pgqeo91TW69tssn5EyD35jQFt+w54
	 s+BIedXEnpfnNaYwAbVLx8iFH2uZ6/OfYpYzWwafHgnEuyAKqXdgjhvGCwC3Xw34nD
	 4wNA1q1naKABQ==
Date: Thu, 21 May 2026 09:13:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>, Shuan He <heshuan@bytedance.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/proc: Fix race between pci_proc_init() and
 pci_bus_add_device()
Message-ID: <20260521141311.GA160665@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260501193721.GA511830@bhelgaas>

On Fri, May 01, 2026 at 02:37:21PM -0500, Bjorn Helgaas wrote:
> On Fri, May 01, 2026 at 10:22:56AM +0900, Krzysztof Wilczyński wrote:
> > Hello,
> > 
> > > Thus, wrap the for_each_pci_dev() loop with pci_lock_rescan_remove() to
> > > serialise against concurrent PCI bus operations.  Add an early return in
> > > pci_proc_attach_device() when dev->procent is already set, making the
> > > function idempotent and symmetric with pci_proc_detach_device() which
> > > clears this field.
> > 
> > A note on testing:
> > 
> >   0-day bot (recent test runs; newer builds will arrive later):
> >     - https://lore.kernel.org/linux-pci/202603162306.2oKy0qcP-lkp@intel.com
> > 
> >   Sashiko's feedback:
> >     - https://sashiko.dev/#/patchset/20260430003542.455198-1-kwilczynski%40kernel.org
> > 
> > Lorenzo Pieralisi did some testing reported outside the mailing list (we
> > talked on IRC) on the platform he had some boot issues.  With this patch
> > applied, the problems seen before were resolved.
> 
> Thanks!  Can we include a link to the problem report and maybe a
> couple lines of the symptoms?
> 
> Also the analysis of Sashiko feedback?
> 
> Sashiko worried about pci_lock_rescan_remove() deadlock between
> pci_proc_init() and PCI controller drivers with async probing.
> pci_proc_init() is a device initcall.  Some drivers are also device
> initcalls (imx_pcie_init(), ks_pcie_init(), rcar_pcie_init()), and it
> looks like they can use async probing.
> 
> Does this rely on the pci_proc_init() device_initcall happening before
> any of the driver device_initcalls?  That would be non-obvious and
> fragile.
> 
> The second sashiko issue (concurrent calls of
> pci_proc_attach_device()) also seems worth a look.  The
> pci_enable_sriov() path isn't serialized by pci_lock_rescan_remove():
> 
>   pci_enable_sriov
>     sriov_enable
>       sriov_add_vfs
>         pci_iov_add_virtfn
>           pci_bus_add_device
>             pci_proc_attach_device
>               bus->procdir = proc_mkdir()
> 
> If two threads race for devices on the same bus, it looks like the
> loser can set bus->procdir back to NULL when proc_mkdir() fails with
> "duplicate entry".
> 
> This is a per-device path, but we're creating a per-bus directory.  I
> wonder if that proc_mkdir() could/should be done in a bus creation
> path?

Where are we at with this patch?  I haven't had a chance to look any
deeper at these questions.
