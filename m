Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772C2480DFD;
	Thu,  2 Jul 2026 12:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782996717; cv=none; b=Oal8rbsvgMDBfGgtsbM/I08cblNQqrF7MUimVoF3uBhox7201YWnJ+QpZLRnqjoB2uoJPC/6lJSUAHI17X2vN0fRlHDRaYpEayd5XRiGB5de8BCSicrBE9hpMCnRm0WcLinfIX12bUkSZTCsJYUdyNdex+NTcJ/UFDaxmUSF9nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782996717; c=relaxed/simple;
	bh=Fk8Vx7zEcw1wJXPS2lC1UfeN3xsBnyTA08mP1g1CW7A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iFzziy8OeqiSrXnA9HJbmTS27Pf1FtdAWrrjX8k2flnLS2NS8eDE4G6aGK585qi5FESBtbNBXrBqtJnLHCSv3r4qe/R5T+bWuVKzhIbLvJ3Ej4H+GfajIz0Xylig8QJRr923HfeNKkZjpGRUck9acVBHY+0OTYskry0hfyZxBr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjJwgpk2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjJwgpk2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E2381F000E9;
	Thu,  2 Jul 2026 12:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782996716;
	bh=Fk8Vx7zEcw1wJXPS2lC1UfeN3xsBnyTA08mP1g1CW7A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kjJwgpk2tWP8FTyxxJE2J5zbMV9U0vJ/0NoDOF5GjpH5YQDC61H7v1qw8ofqHCU02
	 dSqpcmthNFlrEqZpckoKaF8fYCQFXjH0g5gEODOIm9uTEZ5E5uKOfZdyWBxYr9qz1N
	 Eb2K9Z9IaOL3qCXeBqmpSpeVZMxbIqT5VC/Btw22hJGBIqiCh2GerijrL38Z0YV09l
	 7i8ifZnHG5HrIQbxxNJgkUGfje9P6Cy+Gx9AesKwycm+VK1dS5J71+Tejc2yiludxV
	 YSQbr/8Gs3Gx9arWUennqudQKlUJdHNpJVF53MMyAlHRfEx76+Gxb6p7RoWNDQHSSS
	 Vb7EOLx3yc9XA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 01/18] PCI/TPH: Fix pcie_tph_get_st_table_loc()
 field extraction
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260702124224.57168-2-fengchengwen@huawei.com>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
 <20260702124224.57168-2-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 12:51:54 +0000
Message-Id: <20260702125155.7E2381F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> pcie_tph_get_st_table_loc() incorrectly uses FIELD_GET(), which shifts the
> field value to bit 0. But the function is designed to return raw
> PCI_TPH_LOC_* values as defined in the function comment.
>=20
> This causes incorrect ST table location detection. Fix it by using bitwise
> AND with PCI_TPH_CAP_LOC_MASK to return the unshifted field value matching
> the function specification.
>=20
> This doesn't make a difference to mlx5_st_create(), the lone external
> caller, because it only checks for PCI_TPH_LOC_NONE (0), but will be need=
ed
> for callers that check for PCI_TPH_LOC_CAP or PCI_TPH_LOC_MSIX.
>=20
> Also add tph_cap validation for pcie_tph_get_st_table_loc() to prevent
> invalid PCI configuration space access when TPH is not supported. Add stub
> functions for pcie_tph_get_st_table_size() and pcie_tph_get_st_table_loc()
> when !CONFIG_PCIE_TPH.
>=20
> Fixes: d2e8a34876ce ("PCI/TPH: Add Steering Tag support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702124224.5716=
8-1-fengchengwen@huawei.com?part=3D1

