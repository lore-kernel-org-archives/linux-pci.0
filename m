Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4679C470106
	for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 07:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784706746; cv=none; b=N3NHIHPmp84UDBkmv0anSCw9FQp0HwWqGcU07drEOU3LhuqtGITf/vqOVekwR+e8lL1kKHTBOqz6D+e81QfD0+aBqH3WxarX4QmlH0UIsEGWPAUIxZT9UQSceeRlnTvRbk35gSdI5kZ516lmepK5v8eq2xwRNI/U9Z2RF6VQE3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784706746; c=relaxed/simple;
	bh=sYtd6uwqxcUFK4Rg99rDn7TVzRInnzERpbcDvFNGJQg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RzFYyzDKntH2KIMO9fam1E1HWYae8QuX5b/r3y+1dnVHMQAY3MwPaF7DNxigcmhZjDpNGlFhy9Pjab/WA+48r9npKhuIsjwCvyE0buAycSTeGax++0Y99zJp9p/BLZQJWTkCx8IyZ8cKew2KQfWthF73ps5nDII0bFR1W/RdABI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPXcB+2i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPXcB+2i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 921E81F00A3A;
	Wed, 22 Jul 2026 07:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784706744;
	bh=sYtd6uwqxcUFK4Rg99rDn7TVzRInnzERpbcDvFNGJQg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UPXcB+2iB/WMkgDagdMp+41/KzHV03N4YavBKM5XKnKL/Gm0FWtLnA3IrMvMeE/21
	 XSIhD5Mgivd1adqEVhXsINwfXSpYEDypEqSOyHaR+jPlsAF79Qh/MixoJ5phNWX7M2
	 EXUt98mYHionEqDTP0hAOnl9BVpz8Pi8DZqBTmLkxXSAtUu6SNiinjoJIQbGT50g9J
	 rpfGcuVYMMnQZ4wbEfwP3qNELv1bDLlhYSugrt5DDuW2uTBKRebBX0g9Q0ZqnfWzEO
	 3m2gVVYaWZ+3gaxCdVNyMNX1vRxyo+m0B52iZ+1PCXC69gy+7vSMhqmsm19Pa4bSQS
	 2hmUDxqtvso3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/6] rust: pci: add sriov_get_totalvfs() helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhi Wang" <zhiw@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, linux-pci@vger.kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260722073913.1807677-3-zhiw@nvidia.com>
References: <20260722073913.1807677-1-zhiw@nvidia.com>
 <20260722073913.1807677-3-zhiw@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 07:52:24 +0000
Message-Id: <20260722075224.921E81F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Expose pci_sriov_get_totalvfs() to Rust PCI drivers so they can query
> how many SR-IOV VFs a device supports.
>=20
> Use a conditional C helper because the !CONFIG_PCI_IOV version of
> pci_sriov_get_totalvfs() is a static inline function and is therefore
> not emitted into the Rust bindings. Return Option<NonZero<u16>> so Rust
> callers must handle the zero value that represents unavailable SR-IOV.
>=20
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Cc: Alexandre Courbot <acourbot@nvidia.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: David Laight <david.laight.linux@gmail.com>
> Cc: Gary Guo <gary@garyguo.net>
> Cc: linux-pci@vger.kernel.org
> Link: https://lore.kernel.org/all/DJHPRE4TGGT8.BUTMYOF5YE05@nvidia.com/
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722073913.1807=
677-1-zhiw@nvidia.com?part=3D2

