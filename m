Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D42F225A38;
	Sun, 11 Oct 2026 02:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791685551; cv=none; b=MrTlWhBWXiLY/uLnnXjBBDkRh8eVGjVvXwH1LkNWzTrLKwyKDugC/1O+0O8g23IAdakuDohH+r4n+00TRZIXvRYV9UM9ghEzRfw2yi22uOW0qZxBrjBmL7DJEAdOUK3igGNUbmimofphP13KSmWDEcBt+1SPGP+5sEN0DgWrsvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791685551; c=relaxed/simple;
	bh=Mo72tndDsvtvziCc3u77EDzBzn6svxmVmriWnPOzNEM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=GDa3K7hXnVVC1Yw6hUJW1VQ2Vfytbm3LZzAIGz05+B7UhNcXVNGuSPvaJSV2akhpjt8yZqwzdZQpz+HFaanSUYe0zMXO+o1LiQPk85yu0YeKdAoyqeONrYKXiArPEy/BwJYkD5VbWO+yOrVduzxAzGDBuoir1j+/87mnYo6vVFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HcnVX/KO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HcnVX/KO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0029E1F000FF;
	Sun, 11 Oct 2026 02:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791685550;
	bh=Mo72tndDsvtvziCc3u77EDzBzn6svxmVmriWnPOzNEM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HcnVX/KOjUwI9fw+2xg4xvlCjoeYt4ji3CkYqSai37Sx7KNDfbOKLo/z3JbYvt1ZF
	 3ImuP/FWCxdN9FYvjeUdk2X/9NrCCLR1GimS+bYWhicVpZx4r5SACUFm1mo2iqH17S
	 VWQM7m1cbUX9c3vwccYgk2THOo+X3m3LoPfTRf+qQNJ7J70vWlqAY6TYqOAuD1MAkl
	 GN5irG9Ez++ebHWM8WYOxQOJCEmcdtDub/11maSDJdjKXkVh+xKXXpCeT+BUtVOwza
	 CKCVL9QUHVkr8yj/pmvFAAktApQg06lQT3D9jYxvXhbH5KFzbdwObHliel8M/R+Noo
	 syXVb6ufi8qXA==
Message-ID: <sashiko-outbox-166980@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 07/16] cxl: Share HDM decoder register unpacking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20261011021422.3428136-8-smadhavan@nvidia.com>
References: <20261011021422.3428136-1-smadhavan@nvidia.com>
 <20261011021422.3428136-8-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 02:25:49 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Factor common HDM register parsing into cxl_hdm_unpack_decoder().
> Validate range and interleave parameters in locals before publishing the
> decoder configuration, including enable and lock flags. Reject nonzero
> ranges whose end overflows the address space while preserving the
> zero-size range representation.
>=20
> Read switch target lists and endpoint DPA skip in their respective
> branches of init_hdm_decoder().
>=20
> Preserve the decoder ID allocated by cxl_decoder_init() when publishing
> the parsed configuration.
>=20
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/co=
mmit/?id=3D7d6ed7faf7d8e14abce8ae23902d5323738868d2
> Suggested-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011021422.3428=
136-1-smadhavan@nvidia.com?part=3D7

