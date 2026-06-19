Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29723546C6
	for <linux-pci@vger.kernel.org>; Fri, 19 Jun 2026 09:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781860263; cv=none; b=Xgh3Rc14z8GZPplyNFng3+BH8C01eFroAGdNv0YiP1/kAOrnwF/OAOUeLPy7lOPFTXqI6kZqpsT/XCkX/NvxhMHpFzpFo/iWICAWOdAxUTbhK8YzMu6alhbShEqW1KxOeZNbi07t9afCPAQl5HWxFY+nhJrAgVkg2HMDZz3QSFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781860263; c=relaxed/simple;
	bh=jQOvtT3Xz/9pP8WCqeBjZ4TaEVsUP/ho5mQcEG5kAKs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OZe+LnFQ9sPhMTuXk2qetR7o63gF3AbLoXc9mVGlh/OBMKnHNn7EiP261in/XywBEVik2qYx4RXTuoL9PcG/7xhAZi89kKcpusKYsHjch27FZxthVcWubsX0A8lgqaa/45QazZ1OQzLbETzmo6BZ8N3RzcM3QBwOoDpU26KUD3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dp1i/O0d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dp1i/O0d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E1E1F000E9;
	Fri, 19 Jun 2026 09:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781860262;
	bh=fktQrkcnSX94FpszQj/dDod/ry0jHoa256M4pGFnGyY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dp1i/O0ds1GsFXIT3xRXq/o792zZthcbPk7+c0Ocl0FlS0dhECSDgOJ4BzdkDOhCr
	 oMH1Z9Jc0mW4sruMgXykkKE/4o2bMat6zSfXG0r7J1t5PDVcQzgoNYsVttngFhNT0h
	 +6GootvFmNEentidkkxULuIxUsGm4ZhsqGlPIR0wtTQEXHvteFx4fHG6xuo8XYYhWz
	 KpPy8qQV7NFXOUEA2WLaL4IiJrwVT8WJa8jC5bOTI01csabaAsE7Z7Tfh7vYOAk5Gi
	 K2dOOU6zeitiMeLSwtNbrR9qZV5zmtwZ2GgzTrNDVeWsAVpJLPkLs6Gq34LEkf2lcp
	 Y8G7amGVpvfkQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 24/25] PCI/sysfs: Remove pci_create_legacy_files()
 and pci_sysfs_init()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260619085200.3729431-25-kwilczynski@kernel.org>
References: <20260619085200.3729431-1-kwilczynski@kernel.org>
 <20260619085200.3729431-25-kwilczynski@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 09:11:01 +0000
Message-Id: <20260619091102.44E1E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Currently, pci_create_legacy_files() and pci_remove_legacy_files() are
> no-op stubs.  With legacy attributes now handled by static groups
> registered via pcibus_groups[], no call site needs them.
>=20
> Remove both functions, their declarations, and the call sites in
> pci_register_host_bridge(), pci_alloc_child_bus(), and pci_remove_bus().
>=20
> Remove the pci_sysfs_init() late_initcall and sysfs_initialized.  The
> late_initcall originally existed to create all the dynamic PCI sysfs
> files, but with both resource and legacy attributes now handled by
> static groups, it is no longer needed.
>=20
> Remove the legacy_io and legacy_mem fields from struct pci_bus which
> were used to track the dynamically allocated legacy attributes.
>=20
> Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> Signed-off-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619085200.3729=
431-1-kwilczynski@kernel.org?part=3D24

