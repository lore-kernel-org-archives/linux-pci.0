Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9831D28505E
	for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 11:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790507432; cv=none; b=TvPcgnwOYO8ZDNlAMb8qN360QXyDo2z5la0s1jmso+/90IzrKARMKH0etouYNGL4Yebb0o5LvF1LtfhWFaTVg8H7OwqWKVUk5SHOHU78xbncYqhFP5GB0S9FSf9IUL08hxn4su7OQh6/Th6bFNHhyUfH2YWmfxda8DOwMZiJlNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790507432; c=relaxed/simple;
	bh=tY650C/wo9mkeqFjBm7mjUaqMYyJlPDa6dela41mnHU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fBMRgtUccWu7PLkI4HrB2E4po1AricIYTdhZ5KImfcT2PQBsgd00g/3HiPXxmDntMr8W7lEuujWdZ7IDeWm4Ri+WXRW4pfXtn5P9rOP9peWroeloU+6MBCYa71CjAiiYulUflpPutmI7faNpOMbI8zW4W/lNU2UHrNv9p9iZcMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfqtXqeh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KfqtXqeh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E671F000FF;
	Sun, 27 Sep 2026 11:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790507431;
	bh=tY650C/wo9mkeqFjBm7mjUaqMYyJlPDa6dela41mnHU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KfqtXqehIBDMj+pRqRgxpYETmiONJEXZ6i/ffmquRsD40HYN7UpjMcgj+p9ZoFGNi
	 VLcaK7yceS6+GKdkJc8ITb7/tdMoTm+YdByz2kEOudqPr3aHMDWw6zArMYFdDJDeHh
	 1W/LjkVdSf81s7zuGeiptmrEhL61+N8mhAN+Ho3d7kvCmQAwFMT/fPZcdyB0zXYOlv
	 A7EKIcdriAj2PXe58ycb1O8IGV272JhBeGT4MP00YM3+LebUqq9DhXBc2lry3Y0UIe
	 LwvRg6mLZ26eGBXag66GrcvJXfx2uQ7F2r1mUzthrqI+fDMSgR67qeT/fDXDjmusBA
	 MKNnvVsZugFUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] sparc/pci_msi: Clear the MSI descriptor irq on teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Imre Kaloz" <kaloz@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260927105515.8701-1-kaloz@kernel.org>
References: <20260927105515.8701-1-kaloz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 11:10:30 +0000
Message-Id: <20260927111031.06E671F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Since commit 2f2940d16823 ("genirq/msi: Remove filter from
> msi_free_descs_free_range()") the MSI core expects msi_desc::irq to be
> cleared by the architecture teardown before the descriptor is freed.
> sparc64_teardown_msi_irq() never clears it, so disabling MSI or MSI-X
> warns in msi_domain_free_descs() and leaks the descriptor.
>=20
> Clear it once the MSI has been torn down.
>=20
> Fixes: 2f2940d16823 ("genirq/msi: Remove filter from msi_free_descs_free_=
range()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Imre Kaloz <kaloz@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927105515.8701=
-1-kaloz@kernel.org?part=3D1

