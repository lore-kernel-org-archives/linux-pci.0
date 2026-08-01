Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB838356779
	for <linux-pci@vger.kernel.org>; Sat,  1 Aug 2026 11:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785582643; cv=none; b=ElbwA3uZlyI+1I0poc2VP0EhugoZz5wyPInIOJDic5PtjoutGuu8xuJ3gI8saFgVIU7QDCr0iZt/K7JHAnUutl1L+ttUACFP7kzj2D4QQDe1ERXTkten6lPHJF71GLSUxWraA/cLNb1/3yOm2rzLilT4Cgx64VbTJk19IO8P9hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785582643; c=relaxed/simple;
	bh=eXtkkELu9DoAw69dt0845XOfW9mLtFByht1bnNjWcrQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rPAOAfhTmz+DLBO59HEM2gcMlpyjf/DQuarLp/isOYJZaZ90Wfh9r6WWSAiFnz66Ja2OgzP/GKEbKd5XigJL6srBm0Mf6aGJfZaRDkjxFaPt8/fdwmm4J9nrixX90tG3KjS144pgbZYm+fZQfqhhB8wqlOlvOwFFK+0stE6DIfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnnG5b/k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnnG5b/k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FCA01F00AC4;
	Sat,  1 Aug 2026 11:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785582642;
	bh=lvn3/WUkvDbDWwdKA0uJl9/cV/hJmK2kHfRbzwBqr3E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AnnG5b/kAJcQGPK4Bsc2COC+fRwRnHuKsEUCBgyHWtPyzpNVauiS/UfoHfmZ5Gmh2
	 Yt/dcmb8UPnC+OUfyu6r0fALDjawtnqt14IiKKQpmNm3A4NZuab3dBCMoEkx6IE4dh
	 uDV15LoNSuQn1yf1SkUk7TmSPPLotXQB3Fv/ujLpHTBwRL0UJHmRAaERDvelLt6C/q
	 uGtwOqa4gCAdsljDfG2DuZBL+Z6oQq2M586C7AG+LszSZBEYVN5aGmoT0QcI1H5kG2
	 4IiUWqic9fNzdI1FFFBEtCH46c96ZQ+UwXtCjBV/LlN1caOcvCw++E40jrIqyeDIPf
	 fgk4n40u64sRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: Avoid link retraining on empty ports when
 lifting speed restriction
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andreas Wild" <andiwild@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260801105441.6506-1-andiwild@gmail.com>
References: <20260801105441.6506-1-andiwild@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 11:10:41 +0000
Message-Id: <20260801111042.0FCA01F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Since commit 72780f796468 ("PCI: Always lift 2.5GT/s restriction in PCIe
> failed link retraining") the Target Speed quirk lifts a firmware-imposed
> 2.5GT/s restriction on any downstream port, without checking whether the
> link is up.  Where nothing is plugged in, the retraining that follows can
> never complete, so each attempt costs PCIE_LINK_RETRAIN_TIMEOUT_MS.  The
> quirk makes two of them -- the initial one and the restore on the error
> path -- adding a fixed 2 s to every boot.
>=20
> On an MSI PRO Z690-A WIFI DDR4 (Intel 600 Series PCH) with one empty x1
> slot, running v7.2-rc5:
>=20
>  0.541 pci 0000:00:1c.0: removing 2.5GT/s downstream link speed restricti=
on
>  1.541 pci 0000:00:1c.0: retraining failed
>  2.541 pci 0000:00:1c.2: [8086:7aba] type 01 class 0x060400
>=20
> [ ... ]
>  LnkCtl2: Target Link Speed: 8GT/s
>=20
> Fixes: 72780f796468 ("PCI: Always lift 2.5GT/s restriction in PCIe failed=
 link retraining")
> Cc: stable@vger.kernel.org
> Signed-off-by: Andreas Wild <andiwild@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801105441.6506=
-1-andiwild@gmail.com?part=3D1

