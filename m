Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793287367;
	b=mlw7FI4KyU9UwxpZBeCaXLzm8mJti3FRcI9ikMZAItXXEdDAofa78U65m28tL3hlC2Lc
	 axvhRh6L3dOQxbL+p3GCSbh9F1bjnx+23SYKwxrzewWJnDZTgo/51xa/2PbWX/VW7pbdF
	 AyPGOr2K4QJ8L0CyHaitDCUQmEC7B4dqSXCkriZFiMx72x3yf1CrPMSHEMFCUpY0nDDOw
	 0RlhNQPpZbExf5xmeBy1NKf0p6lN44GoXVwkyyWf1ZGtb8DLK9Kjuin4mdd8PjB4/giHx
	 7BDdVO+pDiqpOOMYt2ecx0P4FSHND/IDz/+gqC6+ZWikxiRpAF7crVerF751o+IhcnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793287367;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=v6EzKObgcBnqyhAImkQH9oFAlPaC5S/vqt9UgcwkTfU=;
	b=27idjJ1+BbHPC74nHR7qtpA8DNTanD5fFK97saHrlhybArIP/UhrTZdhEuIlU72lb7vw
	 gTmbOa6bFnZKYetjupNB6byD5Lbb7/I59dTEfgAAJ9UCzp0taOBlsOxzuGTVPlskFc7Yl
	 xcP3/IjPnvW+ykkSVdPSOM4o7Op8NM90MBFdijLqhFxxxC2nHqSdCxoWv/iALU6dDjWBF
	 b8jKBHgJbsyqhkgJ61wkXsvymOigqbCxICzLeR/DeuhZVzI8F+/gVsHFKND2kQ3M7OZ4K
	 IauFEbpyJliFZXC9wISaYChNeUJdJnDP+lK3883CvB+FIZHHa+XcypGq79+BalWE5SA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m9jsr7NH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD402606A31A
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 15:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m9jsr7NH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 373471F01824;
	Thu, 29 Oct 2026 15:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793287366;
	bh=v6EzKObgcBnqyhAImkQH9oFAlPaC5S/vqt9UgcwkTfU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=m9jsr7NHCbbVShf9W+u0ANfTMcoFHJpk6QkJH5vhWX7617Y3KWXKVvdLouOVt7JKy
	 ctwF/gpZ0SKCu/SxtJJE9qXGHzfjgWxr255s72GgEIAT3M6mOH9uW60zK6LZ3OPALU
	 8xRlEtdDC81v2Z0tYEZ+XFOJZw/v2EwTUYh687JOgB/fWeClkVbn7MPjK8FJt2wqt6
	 8N43I8a8pJbIGPVAyfc/VMPIaYDmgR4zkO315q2xMWGyL7HuttrKm5jB7VvP0XjVL7
	 xOuff8MLqMw/0N7T1/LTC6NmeMVThnh4Fmooxk1xSI7fbWFJ3i6mpNxSe0FakzFN4A
	 tsJch8xQ6nmFA==
Message-ID: <sashiko-outbox-189596@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 17/18] PCI/CXL: Restore CXL state after CXL bus
 reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261029145703.2185231-18-smadhavan@nvidia.com>
References: <20261029145703.2185231-1-smadhavan@nvidia.com>
 <20261029145703.2185231-18-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 15:22:45 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> CXL bus reset can clear HDM decoder programming and CXL Device DVSEC
> control state. Restore the cached state after a successful cxl_bus reset
> while IOMMU exclusion remains active.
>=20
> Restore PCI configuration first so HDM MMIO is accessible, and preserve a
> disabled state if restoration fails.
>=20
> Copy the cached state before the reset, then refresh its decoder settings
> from the cache under the CXL region quiesce once the reset completes. A
> region decommit during the reset updates the cache, and restoring the
> earlier decoders would leave the endpoint decoding an HPA range that the
> CXL core considers free. Keep global and DVSEC control from before the
> reset, since a refresh during the reset can read them as all-ones.
>=20
> The prepare/restore interface and decoder-refresh structure follow Dave
> Jiang's cxl-type2-reset reference branch.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029145703.2185=
231-1-smadhavan@nvidia.com?part=3D17

