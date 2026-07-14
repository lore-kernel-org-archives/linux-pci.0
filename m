Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA8C376BF1;
	Tue, 14 Jul 2026 10:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784026488; cv=none; b=knZqd0J7K+SVni6r4b1fr5L+iIKlKXA1X5MXOaf8eLN4Oj6nvEP5TiIUe3CSFdTOJPPGRyjSBhJeOxlEVKLbpdIJiHusPrVsm0NhXIJMUKJoeue60cIPSAuTmjGe7kMtjXVJm5iaylfwHm74v66nNALY4r0b60ccYrH5mIurYT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784026488; c=relaxed/simple;
	bh=N/tQIhaIipfOqt6r7veUrPNCM8ElTg233gjep4UuKmE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s0yeNzXY4SsgoHafhsmmWEDJkMoCPDn39g9V4MCAE5qgb1M7JR+FcZhf/sSW+ztqXYbfACRUIp6/8QHr/XWp+lytqNr54nfxJ+yNDfB1OI/tj0n5W4EZuK96QbygGYRDAI2ELWtLIoWSis/6rGFnt3jqGTVhtV43bhMDbdi10TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8YiJulT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8YiJulT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D32FB1F000E9;
	Tue, 14 Jul 2026 10:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784026487;
	bh=N/tQIhaIipfOqt6r7veUrPNCM8ElTg233gjep4UuKmE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S8YiJulTczJj+tKYMGRNVQzudDb1Q19pAoTkX4AsHcCQCMbF0cxQSD2Ar4wgh8vah
	 JRHrBPMEw/usUmZYQlKh4fp83QxYGjJRgSY6DedS5ba/ksi7nNLNZX72Aml8ET9YA+
	 /qP3DjAh4Fd4qyjW+TjRV21Kw360UlTUqwd1ZeYxGxBSWB9+oxf7EGeURdIG9B1QVN
	 /TZtjDIy8KhOvF7wVABxkKeL82TXFJ+dkiZOvpzfgdCVCtbqHdTps4YlLt3k0JEeH8
	 D3YiTcn/fTcoF5iJTmwYqcF4u/cbIlQCWmQcyCTQo8HsbUQf5GNzznruBubA+4s3Tv
	 BFIBj5gTkLWTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 04/16] PCI/TPH: Fix pcie_tph_get_st_table_loc()
 field extraction
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260714104325.54444-5-fengchengwen@huawei.com>
References: <20260714104325.54444-1-fengchengwen@huawei.com>
 <20260714104325.54444-5-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 10:54:46 +0000
Message-Id: <20260714105446.D32FB1F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714104325.5444=
4-1-fengchengwen@huawei.com?part=3D4

