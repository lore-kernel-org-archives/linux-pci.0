Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A972B46D2DD
	for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2026 11:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786016158; cv=none; b=TDzawiexYutM10062hDHSGkz60BARmdgg9Lo6X31IQ3BLUSwqWc0OFH7GwVqmFYHbo+wNgbRvt63Q8jsuI4u2ydyuZeBRxXVz0rkBKD4LVlNERQ+MhYl4JppuloOYnsS+gKlAcLNrozT+4RrSEZqZLR5vYaKTafs/XQJbnzej/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786016158; c=relaxed/simple;
	bh=tM5hZYiig8YT/S0RJlTortLynbrDkT0AmDnMWgCOgBw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kzoPWVIKk8Ynsa4rvzex52DatSaL2wbMoHjX+WQPYtjrcz9cP5VO5U8i2pYjvHXYS/iGNTNnoufeH1MDwV7EdFdd+XcsM3MazCDFEu+cvhCC0Jqg9mVc06yilVfz/2dVV3k90ltc9aNEF5L/mkzEnaXcrinN78Npiv64vy+hTPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3SeHJab; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3SeHJab"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B1E71F000E9;
	Thu,  6 Aug 2026 11:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786016152;
	bh=1s834RycEyayE9TkDpN5oF9x+wvPfOBD2DGtSWs/Ky4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M3SeHJab6Ozdy+iqQ7RpU99qC7PfqqAE7rn7SEbtUrleFzmMglYgccbbM/lX3XJOm
	 +xMudoZ6NSmWoHYvaYDCt+gnl4XhlWm43EWDtgNY16FByeGM7NfVEM+aZm953OZaRO
	 gmVOgkUeZCCZu8CGNmP28dyDFkGdFdi+n3OOv66nkMLfY6YtN1dU5M1T8sUfQgwTAh
	 99tGIaxaXd0N+lP/JmQStfx0pvKnyPPIgaotUHeeMZQK9WwhNAuU+ov5JNisniNu3W
	 GoYOVI228TjUtCQqOqHL/iFFib2wcVo7bipYMaL+ldu+Z4kaPM4T8r6NSisgwn5bxW
	 tVEYt4/tcVXcg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/13] PCI: Account for Direct Translated P2P in ACS
 isolation checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260806-fix-p2p-acs-v2-4-0cec14812965@nvidia.com>
References: <20260806-fix-p2p-acs-v2-0-0cec14812965@nvidia.com>
 <20260806-fix-p2p-acs-v2-4-0cec14812965@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 11:35:51 +0000
Message-Id: <20260806113552.8B1E71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> PCIe r7.0, sec 6.12.3:
>=20
>   peer-to-peer Memory Requests whose Address Type (AT) field indicates a
>   Translated address must be routed to the peer Port/Function without
>   redirection, regardless of ACS P2P Request Redirect and ACS P2P Egress
>   Control settings.
>=20
> Request Redirect therefore does not isolate devices below a Port with
> ACS Direct Translated P2P enabled.
>=20
> Sec 6.12.1.1 makes such a Request an ACS Violation once Translation
> Blocking is enabled, and that error "must take precedence over ... ACS
> P2P control mechanisms". Report isolation only in that case. Without
> Translation Blocking, devices below such a Port now share an IOMMU
> group.
>=20
> Fixes: ad805758c0eb ("PCI: add ACS validation utility")
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806-fix-p2p-ac=
s-v2-0-0cec14812965@nvidia.com?part=3D4

