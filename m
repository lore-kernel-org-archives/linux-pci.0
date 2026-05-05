Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD5630E0E5
	for <linux-pci@vger.kernel.org>; Tue,  5 May 2026 09:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777974479; cv=none; b=NbiCgWElOYXXtiTwYeIU3E+UZ1LeL/iRtptV5jdoRvpB8L6Muuyb4RHqIVW/qM0lCP5iMbNnNaS3zS2+EZapgIwX1zqur7zPGTKQf7GpOhP/l4ANXXtP7ZK8ZekxMjjiifnvJFYOS4y4rFbErrqAAK5IJe50cwOET8fYsucgA7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777974479; c=relaxed/simple;
	bh=zAnAnmOn7Nsr3W4o6fahogMIT0J2Ri6mKdxCByamStA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqm4QkWPSMEEXVWIU8vyW+0ooSyJSvAWXfhyKNBuXeSpQizHcriBvY0Vs/q29/IsOTtcODZVl2RbYUi4Rpdcz7gA6/28DX8gvZdw49TkQNi8hzCgtm4Hs9j8JmG0oDCCKW0rCOv0OICeURgjb0WbqQD9aF3cVvcLsev4FroebXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rMh1e67B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rMh1e67B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75CD2C2BCB9;
	Tue,  5 May 2026 09:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777974479;
	bh=zAnAnmOn7Nsr3W4o6fahogMIT0J2Ri6mKdxCByamStA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rMh1e67Bdu8bd+Suww+0own7A1oO5fbjid4dHlcyzStXAeaeuSXBd+sLd5dwO4H+3
	 h6rbihD+KZu7JK+IEgdGuh6tBpwk4BRueNHeFC1Wfb/g7cCfrIDDd4ioNlBx+UI/c4
	 ZHxUzK43KIcRdDsJeSPvvXajxu1s70VvPkEV9noHKzExVRAZbw3TvPW3Jc6yOfmB8O
	 t6+zQrMbHhCqO7ERo488w4/m+ZOxy2LAJjyQ1mIu6Y1NvnRK+VhITYliDDRh/Hh3MU
	 MdNgP2/sQI3IYJtnbWUnroI1UREyumKDmMiGGsEFQxaBd/4/rGIYHGKyrYBg8I3ZUJ
	 6VKEHIJF3INCg==
Date: Tue, 5 May 2026 11:47:55 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>, Shuan He <heshuan@bytedance.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/proc: Fix race between pci_proc_init() and
 pci_bus_add_device()
Message-ID: <afm8y+KHlgtSWBqH@lpieralisi>
References: <20260501010127.GA990551@rocinante>
 <20260501193721.GA511830@bhelgaas>
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

You can add a Link tag:

https://lore.kernel.org/linux-pci/20250702155112.40124-2-heshuan@bytedance.com/

FWIW I tested it on top of:

https://lore.kernel.org/lkml/20260505-gic-v5-acpi-iwb-probe-deferral-v1-0-b37b85998362@kernel.org/

so:

Tested-by: Lorenzo Pieralisi <lpieralisi@kernel.org>

> Also the analysis of Sashiko feedback?

I have not looked into this yet though I/We should.

Thanks for the fix !
Lorenzo

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
