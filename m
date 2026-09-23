Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E384334AA
	for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 18:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790187103; cv=none; b=pJUYSfGWluco7lIrfUHsgooXNCdsTN7EFBwH68iyx5iFOFoNp4wfcRzd85Krb2AAOSx/5fQyHHvNw7h9TvG8CB66rfLoYP5zaAdrnidq3kuhfScLUikDZbwdt5NHUJeFGl/KYusheSr2H0CKwdZn/3sOI9PhH9X4/7Uq6Qh7/CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790187103; c=relaxed/simple;
	bh=wctSuqX/YOLK9/1occacvJTMGRAtQ80Pr4KdTTBTCZE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Os/AaXm46VnMP+x1iZ1tvOSUaJQYNuu3xvb5dqZISXiITZa+PfQfYdNUEit3i2duaSi46bh93gNDkH9wXFtpqvKT8sQaXSVTCQ2qmeEmgXw13CYZFlQU0PBS39ytAQwlqWfMCtVSx0GYrdOz3h5MbvIUTF2AiBga8bKAbdmvWMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XlL9EKU4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XlL9EKU4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308E31F000FF;
	Wed, 23 Sep 2026 18:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790187098;
	bh=wctSuqX/YOLK9/1occacvJTMGRAtQ80Pr4KdTTBTCZE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XlL9EKU4xC05Q8cHhKIrh1yJqqEOaCmuJYgdxbg3lt/3Z09ZsYds/OFrA5XjcSNbr
	 b7P6mmwgFS6hmYxBEHsFh6L6terD46q7GsRxKD81xH8AIcgO6RnHktNE6MZp6/jmJq
	 P2gE/GQgqplm1m9G6YTDAVAfdL6zV9j5mia1m0SGj2CE/0dl+GOc/4ZwWFw6eZFm0y
	 lvnm5uEtyjsL81PKKOmufSD/NzSgfGn2hdEd+vv6gnO/Z1WamK9Idk5f0XBBhA6t9U
	 6ens7qMVnM8lZ/XtRO8fIBIUWHjVgTn0bQ0zHLc/v1ijOnL8a4I/4Wp+Ayy38DdA7x
	 zPePBcU4xoYcw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: iproc: Use __free(device_node) in
 iproc_pcie_msi_enable()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fuad Tabba" <fuad.tabba@linux.dev>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260923180703.3901185-1-fuad.tabba@linux.dev>
References: <20260923180703.3901185-1-fuad.tabba@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 18:11:37 +0000
Message-Id: <20260923181138.308E31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Declare msi_node with __free(device_node) and drop the out_put_node
> label and its goto: the scoped cleanup puts the MSI controller node on
> every return, as the label did.
>=20
> No functional change intended.
>=20
> Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Link: https://lore.kernel.org/linux-pci/61488ddc-b346-4ba3-b32a-e972a3bd7=
5a4@mailbox.org/
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923180703.3901=
185-1-fuad.tabba@linux.dev?part=3D1

