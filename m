Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD011346E46
	for <linux-pci@vger.kernel.org>; Fri,  1 May 2026 19:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777664243; cv=none; b=VHSQEYjMv2kwXzQ8UPmz1pqlQ759iyCxZah3CAJN33UsoimZmmIMm2NHym9Fkupz0aHAVGSHk/MZwuT7R2krZ6gLIr178ZUhsI4a5qWsP9Ml2gp5ZymZ8d4vkQndP9YzukoFECtL6AVYdqc5MkK+TXrpniBrw/qLff8JGrJ1HKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777664243; c=relaxed/simple;
	bh=a1HVvxBli67IFW2LWFabcWygSyAIX9i8lmA4uyxDfZo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=C2s2fyWtcOezqGBBFnWuN26QBbJr7SMj/tvZayEHhgbvxKWCYFcM+c3IgwY85TwCdm7Ngpv3OHHoDjJ7sq5CC3RRrn59Y+es0fwMonNdI8O6/JZ0SZEdvQz7q09qyuJufdpCWs9adM5wwVxsQejrOAaU2eRG7EycftHaRBqM2WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRrKsHd0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRrKsHd0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F1BBC2BCB4;
	Fri,  1 May 2026 19:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777664243;
	bh=a1HVvxBli67IFW2LWFabcWygSyAIX9i8lmA4uyxDfZo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=XRrKsHd0k7kTGf+plnf/j0Dw2fiTN/KOiqASjs7GWJmzgoteNrbKOxfloY/xo4BAb
	 o45r277c1Ge6mRg+8t4nJdkxx+Extujj1nsOxKc+EngKnoJLDUgq43ub4ynp++Aar6
	 1PJWl48QaN9DDs/rTDTsyFQylcWI3qjjE8M/Em83424mhfa2rvoJkiAajegC3l8vfs
	 E1NoFiKmRbNOAXEbndBWyGCIqrJu++Ii8vMApxX0eSzlbZKVHk9U1KDUYRcIZrsFPu
	 i6OsttY0soEidqXOyRrUo8j99fs2Qd8TYWfSmHR4x+II3lGOJDizlYaICdimfuyvV2
	 nc5dm1aKpjh4Q==
Date: Fri, 1 May 2026 14:37:21 -0500
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
Message-ID: <20260501193721.GA511830@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260501010127.GA990551@rocinante>

On Fri, May 01, 2026 at 10:22:56AM +0900, Krzysztof Wilczyński wrote:
> Hello,
> 
> > Thus, wrap the for_each_pci_dev() loop with pci_lock_rescan_remove() to
> > serialise against concurrent PCI bus operations.  Add an early return in
> > pci_proc_attach_device() when dev->procent is already set, making the
> > function idempotent and symmetric with pci_proc_detach_device() which
> > clears this field.
> 
> A note on testing:
> 
>   0-day bot (recent test runs; newer builds will arrive later):
>     - https://lore.kernel.org/linux-pci/202603162306.2oKy0qcP-lkp@intel.com
> 
>   Sashiko's feedback:
>     - https://sashiko.dev/#/patchset/20260430003542.455198-1-kwilczynski%40kernel.org
> 
> Lorenzo Pieralisi did some testing reported outside the mailing list (we
> talked on IRC) on the platform he had some boot issues.  With this patch
> applied, the problems seen before were resolved.

Thanks!  Can we include a link to the problem report and maybe a
couple lines of the symptoms?

Also the analysis of Sashiko feedback?

Sashiko worried about pci_lock_rescan_remove() deadlock between
pci_proc_init() and PCI controller drivers with async probing.
pci_proc_init() is a device initcall.  Some drivers are also device
initcalls (imx_pcie_init(), ks_pcie_init(), rcar_pcie_init()), and it
looks like they can use async probing.

Does this rely on the pci_proc_init() device_initcall happening before
any of the driver device_initcalls?  That would be non-obvious and
fragile.

The second sashiko issue (concurrent calls of
pci_proc_attach_device()) also seems worth a look.  The
pci_enable_sriov() path isn't serialized by pci_lock_rescan_remove():

  pci_enable_sriov
    sriov_enable
      sriov_add_vfs
        pci_iov_add_virtfn
          pci_bus_add_device
            pci_proc_attach_device
              bus->procdir = proc_mkdir()

If two threads race for devices on the same bus, it looks like the
loser can set bus->procdir back to NULL when proc_mkdir() fails with
"duplicate entry".

This is a per-device path, but we're creating a per-bus directory.  I
wonder if that proc_mkdir() could/should be done in a bus creation
path?
