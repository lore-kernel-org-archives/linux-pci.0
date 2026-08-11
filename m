Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DAA4302FA
	for <linux-pci@vger.kernel.org>; Tue, 11 Aug 2026 23:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786491850; cv=none; b=ackae2LnqYhZN3bVjmz4vEUF23U5BWxx7N/UenIc6X7BY3rSpNh0hvThoUFS57XHAlCV9aoMvGdC38j0Yt0Vp1fUqcWaOj3S26F2DD6s7LmE4AOvLMxdfTokg2jj/eIQC3Rve4WGAcx+uYTcqtHp+CPnnEAXaud5/R23GA9Fn4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786491850; c=relaxed/simple;
	bh=jUT0m+GcPezAl/JXNnlBBWoADnwR5EHJs1DlkyvRe+U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t448n8vbE4oE8vzsFJqOyAMhsdgLmT8TWF2s8zqZa5BNqCmAB4gRawzdrpD5l9ijflMlf1RZXA4niBqDhbPmBF8TqugAa1NdgmGm5B4O/B+FdsFNJnKdOEHxOALGF3CpG9vA33wvOKNm+F/R8NHMrpfyJYyw/3A4CQLed8itxkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0ovCtLG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0ovCtLG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83AD61F000E9;
	Tue, 11 Aug 2026 23:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786491848;
	bh=jUT0m+GcPezAl/JXNnlBBWoADnwR5EHJs1DlkyvRe+U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j0ovCtLGbZaQJ+hG89XO/zIHyb8mUZDO5zyY6WMHSwjdNpgSSjdGB0Fpkj7//RagM
	 zhfIxFyX1CzL2EbcFqO9SST1gz+otHHTC63R3C1MbYQqHj8Y+j4Pn6tz850UBm8EVX
	 FqsVq6HVyViP5Dlk7URb6XNxLr2zJ6x+d1XZ5iLvQZ3zTLzjZsRVvOzRIj424U7fy8
	 gNsPVUzhHM2fD89OR0BiV37AFNkHhSq8Cyg5J86c95v1b3F5Mj3WnhXkW44pYir7zU
	 UVnxVzeYA3j6Dd/M+V83g8glMkRiYolNLTQIb2iWd+QcfZ/aNM39NpqPwTyAsmV8um
	 GyTZIYEnhuYNQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/5] PCI: Add pci_irq_type() to query the allocated
 interrupt type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260811233952.3000968-5-dakr@kernel.org>
References: <20260811233952.3000968-1-dakr@kernel.org>
 <20260811233952.3000968-5-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Aug 2026 23:44:07 +0000
Message-Id: <20260811234408.83AD61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add a helper that returns PCI_IRQ_MSIX, PCI_IRQ_MSI, or PCI_IRQ_INTX
> based on the interrupt type the PCI core selected after
> pci_alloc_irq_vectors().
>=20
> Several drivers already open-code this check against pdev->msix_enabled
> and pdev->msi_enabled, or even open code this helper [1].
>=20
> A common helper avoids the duplication and keeps drivers from accessing
> the bitfield directly (see also [2]).
>=20
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Link: https://elixir.bootlin.com/linux/v7.1/source/drivers/net/ethernet/a=
quantia/atlantic/aq_pci_func.c#L196 [1]
> Inspired-by: John Hubbard <jhubbard@nvidia.com>
> Link: https://lore.kernel.org/all/DKKG2QM3YJYB.Z2H2B2UXJ75N@kernel.org/ [=
2]
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260811233952.3000=
968-1-dakr@kernel.org?part=3D4

