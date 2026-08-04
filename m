Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA7C374170
	for <linux-pci@vger.kernel.org>; Tue,  4 Aug 2026 03:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785815091; cv=none; b=ChqFGoybQaLWQrWNNpv/uT8ALSZNVOK3WtNXo+EdSQNEgAlaPsDd1zaJHM8QAMxgY8AWJmw/RJsgkyiIgyvkoiQkN3R7p3o+zEpiK83H8SjdnqWrC9T/I3dgdxq+UL8P5KaLVdabIcatWTW6+3n9HhBGPUTymU3mE5NOpRXYnec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785815091; c=relaxed/simple;
	bh=ZtqYcwYj+ChUhSABZwI8eAubxey+OVawZ+WnAxvMng0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ozVWoyfXd4yVFqdJ/IvnWEE2YyA5LKo2MG5hja27k0tyrEu4rbETfFT4ZJdA+z+AFjBahW+awHMsq+ImD48uzVpJOVs7xZwX6B7t45c+7p3dmAynWiycF96PdpL9bNMYZ3afOolE++nTCcvMhhHpg0xLm1SPB49RFt1taIXAAbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxdcBz34; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxdcBz34"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F081F000E9;
	Tue,  4 Aug 2026 03:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785815089;
	bh=ZtqYcwYj+ChUhSABZwI8eAubxey+OVawZ+WnAxvMng0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QxdcBz34jQ8OB6uQs8YTNxdmPemg9fX7EePCpq4ZXXQLvKT1oFLXacb2TNMUEOHLp
	 +DyBiQ/5l47tC9CgewpO2mAyQpIUPkKKfAFSSVi3zmlu68+eowBFOaT1xjC8C0WQNo
	 BUVTSKHUzv/yox0m5ecDMUuGuRLnAcVdxteNgyZUR/mvbBIsyS8TPS4QThbCKDOhn/
	 UACsrAeoSoySXqsYFuaX7aKwtHIAQNJuFGq/awjMhPUo+E8dh19nlaVjSNWzTIBjXz
	 H9PifYWIXvX2pfBWg2EbW1kSTOs/Xwm2dm9bnajZOGSZYFJ1eeHm8no23aDx5vBdIS
	 y8m7AJnK09uOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/6] PCI: endpoint: Add API to delegate EPC DMA
 channels to the host
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260804033855.2115817-4-den@valinux.co.jp>
References: <20260804033855.2115817-1-den@valinux.co.jp>
 <20260804033855.2115817-4-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 03:44:49 +0000
Message-Id: <20260804034449.C0F081F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Some endpoint functions expose an EPC-integrated DMA controller to the
> host. The endpoint function should not need to know the backend-specific
> mechanism used to reserve a channel locally and hand its programming
> interface to the host.
>=20
> Add pci_epc_delegate_dma_chan() and pci_epc_reclaim_dma_chan().
> Add matching EPC operations. The public API returns an opaque handle,
> while the EPC backend keeps any private channel state. This lets generic
> endpoint functions delegate channels without depending on a specific
> DMAengine provider.
>=20
> Let reclaim callers tell the backend whether hardware exposed to host
> programming needs to be quiesced before local ownership is restored.
> The quiesce may cover a provider-defined sharing group, so callers must
> hold every delegated member and stop peer programming before reclaim.
> Bind failure paths that only unwind local reservations can skip quiesce.
>=20
> Reclaim is best-effort because it runs from teardown paths that cannot be
> aborted. The backend always consumes the delegation and reports any
> quiesce failure itself. The opaque handle is always freed.
>=20
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804033855.2115=
817-1-den@valinux.co.jp?part=3D3

