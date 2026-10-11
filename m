Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A17225A38;
	Sun, 11 Oct 2026 02:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791685533; cv=none; b=bVO+aVnW+dXXG87TnDwGgZLcfy9S9ImG5BwbQKZzHQML3bJmvTUjObDVMVjk0pJiuqxzbETIOzOOeQ4h2tnvFqYyw43dx6PssfbmjJXuZGT4Ljgz0zjPO2h59rMa4tk/sZ2ejommvnhbdWHDxiUJLiimVH0slJGax7IFhYKtT1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791685533; c=relaxed/simple;
	bh=lWhlJ0Veup1p2CiJ+jOFbDkwkJRp4r7w3+NLUP81lqk=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=D4fDNHS+OOFdMZhJ8vtNSu4E4QbdRaySFn5jfh9Zcpr7fOOGJSQZrNSJKzx/uE+M7y2eRJ/PFLZ8kwWgvyCZ2r75A25pO8RlE6N30mlpFX/EHnytVyvhVs+pkqkMSN4PMrgotnUCxFW+/dVWRv2coJD89tp2GKfcZJmYY3k7y5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WcT84hxt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WcT84hxt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6825F1F000FF;
	Sun, 11 Oct 2026 02:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791685532;
	bh=lWhlJ0Veup1p2CiJ+jOFbDkwkJRp4r7w3+NLUP81lqk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WcT84hxtKJTd3pAUCX7A/WOdvfmHbmDGy/jbmeYaBbA61UDvigjDLCWTJCMTNqvPy
	 fNPsSD+MXUMd9iJUn5qeTvgJzPc8tvhAZrSUwJnECPK9FUMwxTwAqsuEQk0j9U4MZk
	 JNiP23a+yebmSSMbZ3j/eOgGQ8NuqsxpBr41GGQ2jNTYEcVqakszI69stZLtBN6uFU
	 taqq5MBHBjyCeRbB4B9eeawDNUJ0qCOgBxT+5sPgE/4RrvSKDFkonP3sqd0Dh4ybGH
	 OtP7pXOtwcwU+bAKw5PMDERlaphJaoQmAcy5CvsHWyQnwpjXvR89ftADDc1KOn/9Rh
	 /CBP0MutMDOrw==
Message-ID: <sashiko-outbox-166977@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 13/16] PCI/CXL: Restore CXL state after PCI reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20261011021422.3428136-14-smadhavan@nvidia.com>
References: <20261011021422.3428136-1-smadhavan@nvidia.com>
 <20261011021422.3428136-14-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 02:25:31 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Restore the PCI configuration needed for HDM access, followed by cached
> HDM decoder and CXL Device DVSEC state. Recommit a cleared locked decoder
> before restoring its lock, but leave surviving locked state unchanged.
>=20
> Stop at the first restoration failure and preserve a disabled PCI command
> snapshot. Keep IOMMU exclusion active through restoration and post-reset
> cache invalidation.
>=20
> Program the decoders from built-in CXL code that takes only a mapped
> register block, and keep PCI state handling in drivers/pci/cxl.c.
>=20
> The restore helper structure and diagnostics follow Dave Jiang's
> reference implementation on his cxl-type2-reset branch.
>=20
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/co=
mmit/?id=3D81fff5893a3140361cac625b09ada798afb92e03
> Suggested-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011021422.3428=
136-1-smadhavan@nvidia.com?part=3D13

