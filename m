Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB3E39479F
	for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2026 07:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792137080; cv=none; b=QmTlfQW+sHA7uJMJYPNAtcDB6Kh/1eLO8OtJfio4BJqvdmSy8MvKfPhjfxH+Fln0EQX3n4dOwMBGElsl0crRpoCthlhsB2kHb1TzMpArpYgDf4H8cOZDlnGk3aP13cJbe6ywzQQNklSNAXRCohMlxM8++AH7XTKGwciJKtHZhOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792137080; c=relaxed/simple;
	bh=wQ/fVW1xr03pGt97/npBTMPkRL5D2ex8/EyrfkjEcVc=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=QxapfrZ1yC3Gv0judmTOQlgqYJ2ZVTxDwNpz+7WGfqb9xpffQL8mGUI1f+Szgw+u3f5n1mIhgo3t0FCqdX+puufhrRmbMmnMnKqk9yLP+gq7U1fAgGiRlboygKoa7eP0ZbTFIud04wJYEQPRqMiq2rsidwVKhHfOynsAlHugWYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ly8knyRW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ly8knyRW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589701F000C4;
	Fri, 16 Oct 2026 07:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792137079;
	bh=wQ/fVW1xr03pGt97/npBTMPkRL5D2ex8/EyrfkjEcVc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=ly8knyRWnv+wmE4RlEazOZxDCdMa0F4nV3OHGwsqPZZZzcfk2rBDhulYhhU/4q32B
	 SOCzmGrKWcfmNeAvQqZ1De61DvWpSC/6GnYwcb16xV2m302T8DO8jCQiWIS8olTKtS
	 0DzORXUZn6AmoW8XNp+Ec1eD+GmrMweqkl2vI4wwjgg+C+RxzmONjBDJyM1yVDGxjI
	 VS1ehVvLR3udo6uSnN8Akjx9+lpRiv3BHj8LE1gNELNiIMZFc0rHhLt9KdE/m1xn5B
	 t28EVZxTKCLTglFtizjC4WPf+EprOOKBBm5hTiCJ0NGnHUEe2IZm1Yf3tSJUbajbo5
	 9Y+q8CbOGnRoA==
Message-ID: <sashiko-outbox-173973@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/5] PCI: tegra194: Use FIELD_*() for register fields
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manikanta Maddireddy" <mmaddireddy@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261016074026.564302-3-mmaddireddy@nvidia.com>
References: <20261016074026.564302-1-mmaddireddy@nvidia.com>
 <20261016074026.564302-3-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 07:51:18 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Several Tegra194 APPL and DesignWare register fields are programmed
> with open-coded shifts, which makes the register programming more
> verbose than necessary.
>=20
> Use FIELD_PREP(), FIELD_MODIFY() and FIELD_GET() at the Tegra call
> sites where values are shifted into fields. The LTSSM state constants
> are converted from pre-shifted register values to unshifted field
> values for FIELD_GET().
>=20
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Link: https://lore.kernel.org/r/20260515070753.3852840-2-mmaddireddy@nvid=
ia.com
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016074026.5643=
02-1-mmaddireddy@nvidia.com?part=3D2

