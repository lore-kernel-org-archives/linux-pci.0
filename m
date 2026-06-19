Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E2F311940
	for <linux-pci@vger.kernel.org>; Fri, 19 Jun 2026 09:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781861297; cv=none; b=KaywRdhC390KJ3Gv0k/KVl7XvxOLGLNjY6KOOWiP13u6n8nPjlrAYwy+nC7Cv6bvQcJB6P0RnPWCJaPl/ZDoj0nWQjt7hFYnxRPvbVBqhSASYQTkOeR92ZZcvmIS8HrwSgamVsgFkaRxZvSGOIBbGL8rvfH1eQDCW2JjzcO9+OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781861297; c=relaxed/simple;
	bh=R8jcD3+JDpGhFp2sEPvXB/Aw4w10vYaKr0z33KvoN8k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iPFLMdsgcL2SbJt6hrYVi9jObAJYw5ubV1oT7UCtGpRxp6ol4MX/IoeBeNiioQDiaeiXpRbb6xf3T82d6GbltZkKR3WEd7NOrpQPd1yhOp4Y4ntPaJPxpgOibMwz+CIE8VJAmi4X3opa6va5rW2a4wYC+lQkU2j0axqoY5NG3GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jiJL4ECF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jiJL4ECF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C4F21F000E9;
	Fri, 19 Jun 2026 09:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781861296;
	bh=R8jcD3+JDpGhFp2sEPvXB/Aw4w10vYaKr0z33KvoN8k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jiJL4ECFxFoUh9H8AMUGeWZi64dcpQshronDkAR4Tg42OZRbSx9CUbiEtTUhOieiF
	 5qZm6GopRMSktMx5kIsuwWsySGVdWRqowLgbYQDL7c/atjFdoxmU1aOtcOdvfFt7UO
	 lZ0URDZuBvz370ondzlGPdkYBiROskihL0QQueMeLvC7gp6nYo8WocBbF7IcxYMC8t
	 IZYNoHYwjDH192q3u0mByrC9e4FIHhM2MqwfhSMMHRGsRrQb8r08en3Ru9QL6eLU3J
	 gGaWF9A/OFI5lYWNdIMvKMedbcsfZiHA9B3mEdpDydj2kvF1UK15PtGe+MvulkfClx
	 BASzq/YJwi+aw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 09/25] PCI/sysfs: Add stubs for
 pci_{create,remove}_sysfs_dev_files()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260619085200.3729431-10-kwilczynski@kernel.org>
References: <20260619085200.3729431-1-kwilczynski@kernel.org>
 <20260619085200.3729431-10-kwilczynski@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 09:28:15 +0000
Message-Id: <20260619092816.3C4F21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> On platforms with HAVE_PCI_MMAP or ARCH_GENERIC_PCI_MMAP_RESOURCE,
> resource files are now handled by static attribute groups registered
> via pci_dev_groups[].
>=20
> Thus, the pci_create_sysfs_dev_files() and pci_remove_sysfs_dev_files()
> can now be stubbed out, as the dynamic resource file creation is no
> longer needed.
>=20
> Also, simplify pci_sysfs_init() on these platforms to only iterate
> buses for legacy attributes creation, skipping the per-device loop.
>=20
> Move the __weak stubs for pci_create_resource_files() and
> pci_remove_resource_files() into the #else branch since only platforms
> without HAVE_PCI_MMAP (such as Alpha architecture) still need them.
> Guard the res_attr[] and res_attr_wc[] fields in struct pci_dev the
> same way.
>=20
> Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> Signed-off-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619085200.3729=
431-1-kwilczynski@kernel.org?part=3D9

