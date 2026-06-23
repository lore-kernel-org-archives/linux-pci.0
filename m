Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4C41A9F91;
	Tue, 23 Jun 2026 09:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782205241; cv=none; b=Aia1dLnf8SUj1YMmpX2n5uMtRkE83Y7ZwNNUMrU2CoqnEYE7T1mAvM9cHB3hyGN44dOclepGN2drdxWCPNWNDqjdjdAmN62Ebr/L4xu8K0zUc0CeSTpAv5xyl4GHRM8/V59ISLwjSyWWRG9TASAwqWg0LuCQXylGHayqwsuhgXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782205241; c=relaxed/simple;
	bh=w6quDwGmcwSDD0L8bCzOblEqwt1xtbd38edLRQmdxBU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SlBOQN0Exg2sNwrgX3QIKnSyM+IxZOU64vlqvVEHTrkzM0fTmKhVOaE6xbgW7sVZAFsPHj6egrNiBQ7gZYBtnHgfUvqHzppq8pIsMYLbUhSazmoJefHBTVG5FTmAy71ZpRFUpPRySu2jPMVkG4cT27nY0ijtbLhtCj/DvRxYM7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ARo+nmc1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ARo+nmc1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D641F000E9;
	Tue, 23 Jun 2026 09:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782205240;
	bh=w6quDwGmcwSDD0L8bCzOblEqwt1xtbd38edLRQmdxBU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ARo+nmc1wxDwRxRgtdmBtCmfgrVk4kyjl6+36P8R3LAgoqLzG3AKMf43/CuvGkmII
	 +nOhVCijpQ5FDTK+W+YL2RykUMcPdKbQ14S4bhMoZa1JrpBURyRzgBY467JwgggQdY
	 LwuCX+MNOnXk++basEHWDvX+b4Ifzt8Vl9tuWqE/7saGYBnrgzdij2NJodQk66B/JC
	 OZfOMQ0j5treMv8BqqgsCUiiWvx9Oq8TCejMLLmw9SkAZnavG2sPFAdLdxCff36YbG
	 Vov+5G+9hfrsjwb0cfNIS3Gkm3tkEKBAlTEWq2EcmhBfW/voulNTyiIpfS3U5D2swI
	 5vMOonjKXH3fQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v18 03/12] PCI/TPH: Cache TPH requester
 capability at probe time
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260623085048.51139-4-fengchengwen@huawei.com>
References: <20260623085048.51139-1-fengchengwen@huawei.com>
 <20260623085048.51139-4-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 09:00:39 +0000
Message-Id: <20260623090039.B0D641F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Calculate the negotiated TPH requester type from device and root port
> capabilities once in pci_tph_init().
>=20
> Add tph_ext_support flag to cache whether the device is allowed to
> issue Extended TPH requests after topology negotiation. If the final
> requester type is disabled, clear TPH capability to prevent usage.
>=20
> Simplify pcie_enable_tph() by using the cached requester capability
> instead of recalculating every time.
>=20
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623085048.5113=
9-1-fengchengwen@huawei.com?part=3D3

