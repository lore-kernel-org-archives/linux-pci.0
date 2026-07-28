Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB6E3BE652
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 22:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785277358; cv=none; b=i6wRKYLbXzT9sdd2zhPQVCn+MwwCoyfwu5J7G+0GjKks7ntKrwawTRA3R6RD0kLTh2QBB1tE8vSpnFB2y2nK0YhUy9g1GLb//Hns8qaeDbEnQ0AGH7nZ02A9kyeazob+w659hyu41d05hdnkdoH2ljQrL+jbr7kCStKbJWxtr+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785277358; c=relaxed/simple;
	bh=6NvAPxx0i85YwQj1PdKKj1j1bYjKd0Th059bsSDNar8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y0KFxXPHARTNTEF+aj/pH9uKs0GJGgYdFr23kANvu1Q2yOgyT7UwuPRexfZ/gOTluqbXG0MPYe4OR16wtHfawKx3TVVynkeDwZFaRwh3vSJI7K9ghgeSaow+HoFstIeH23lxkBb4JR59sDaxWFXbuawRjtu8UP0VLTvsbSjHiKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LEHvOHVp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LEHvOHVp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C2241F00A3D;
	Tue, 28 Jul 2026 22:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785277356;
	bh=6NvAPxx0i85YwQj1PdKKj1j1bYjKd0Th059bsSDNar8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LEHvOHVpi3cZ8xnAvtT+weJcfULxr5o1MVWHslaeCQKmKsDY9NUWQg2XCyG44rHuw
	 7bZwHjJDV15hzub466VPVF0B02INtSR7A5JSyM3IKs+9avaDRseFU+gTdCN4Ol2UZG
	 iMJK0cGYpr1V6jkzflEQNQ0nGDlMasK7el5Q8QHenu/5laklkdahnn1C/WozhdeVMF
	 1KItXI1xnr6APkxiyoyYZuVmPqX4eo2TfRVB1CGNSPmjDzNZ0lV2cDCfcgoUwI0YDB
	 rRXcr7Mu8RZakLJ1tkTqnKt0dG0mzSUqWR1VNXAMJegNMsVoORDBsb93stMvQyf/B2
	 BbNuiH9SQNUyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 08/12] PCI: liveupdate: Adopt ACS controls in
 incoming preserved devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260728221007.2098560-9-dmatlack@google.com>
References: <20260728221007.2098560-1-dmatlack@google.com>
 <20260728221007.2098560-9-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 22:22:36 +0000
Message-Id: <20260728222236.8C2241F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Adopt Access Control Services (ACS) controls on all incoming preserved
> devices (endpoints and upstream bridges) during a Live Update.
>=20
> Inheriting ACS flags avoids changing routing rules while memory
> transactions are in flight from preserved devices. This is also strictly
> necessary to ensure that IOMMU group assignments do not change during or
> after Live Update.
>=20
> Cache the inherited ACS controls established by the previous kernel in
> struct pci_dev so that ACS controls do not change after a reset
> (pci_restore_state() calls pci_enable_acs()).
>=20
> To simplify ACS inheritance, reject preserving any devices that require
> quirks to enable ACS as those quirks would also have to take Live Update
> into account.
>=20
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728221007.2098=
560-1-dmatlack@google.com?part=3D8

