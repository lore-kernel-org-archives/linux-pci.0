Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1091D61BC
	for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 05:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784265382; cv=none; b=pJ3WCAzb3lKYr1CCGXQfp47/bY0kPe8OagW1QdZKaiOtSNrabFdemG9vumGzvsWXa56ecEqgr9nMHLXfJiEn7l7KcGnXu3budccPDMfZ3K9gujZoByguYi4zVkuGviQ9V23VdOobrNWTkmIrVmLRnXOvX0Ito4LmXe09nz06pDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784265382; c=relaxed/simple;
	bh=Awg7LNGXDaonBG+jQaqY+RurQJvQxM61PXlFGjpKGOU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LjMUBpbCk7przTCyT/BDDEzeWtidqV3gbT17BGTp7SLdMIBP+GyYqPyM1VJMFTZadg2VZCk25OQEfLSevTqEWPvS+3hwLcKV9eI7BNWJJ1LiZI6Yx1P9rfbCbHBymp1ZbyzruQwnvkJNSGHeYa6zdkzeqgaQXvptxe+qzhETROM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVqsQibt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVqsQibt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3AB11F000E9;
	Fri, 17 Jul 2026 05:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784265381;
	bh=Awg7LNGXDaonBG+jQaqY+RurQJvQxM61PXlFGjpKGOU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EVqsQibtbFo2Eemus8S7ilHVs45auVSHqRyQzmlI7bB13/v8B10zkdEPScnr/eIta
	 o8cZOlRF89FYh7Ip3du30g7TZUnrvQE9mQQkTQhusbI5H171ofkMR2V66V/nDL2mnx
	 unBvnqYizqEoG3b6sXgl4GUI+MoJ5TMbP6ADkDXaHl1wN7CWkY7qBTWPRyu/fc2lw/
	 75X4YjNQcK0Judt8mp7hmfW9sVU+SGuAP6f14MBXQTbnH4z1VIkKtfY0AEWcqBcGW2
	 QmWUws+gf9rUDGMogjP81CBUL81JHR9B2wzigffWjNbztRMt7cyV91H9duKoG73z6p
	 TDY9R0X/rJz+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/6] PCI: endpoint: Add API to delegate EPC DMA
 channels to the host
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260717050635.2145014-4-den@valinux.co.jp>
References: <20260717050635.2145014-1-den@valinux.co.jp>
 <20260717050635.2145014-4-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 05:16:20 +0000
Message-Id: <20260717051620.F3AB11F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717050635.2145=
014-1-den@valinux.co.jp?part=3D3

