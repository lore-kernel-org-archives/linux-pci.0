Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF23A1EB1AA;
	Fri, 16 Oct 2026 22:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792190297; cv=none; b=oEvO0Eh29zQY41XBDXx6y2gvTxiB44Mu/0qf0HP8ojPenEKhLRzlbmQhtfPCvZjQXTak1wzkG1eBXaMZ21ssCqtX8J8+9adaPc+hL6U7wisWmb80yKhUHDNyG0H8E7VPi/zdgJBj4xhQEocWjqAa6JUtJ/rhdPx/XDzXUsoPwlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792190297; c=relaxed/simple;
	bh=n5lHVCc5c4ufCyPkWGEBoNS/TH5ZYTjzchZc1CNvmJ8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=VfU7l3AujqBMUaEETKatxTyTswEwWQ6+Ji1Oq1rIIVrgHAW5R/k3+DlKm+oweIfJNKtRvqVHGy7FM92lZ1BMzuWB3PrIV6ALCTQPjaGKuXyC+9vIfJ6/BlbLQJNoBNJM3kaN7ZodGcOgnPcVzSCUiMt7fJ47OV6Nl5+hrq9pZ4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqaIw04F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqaIw04F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5252A1F000C4;
	Fri, 16 Oct 2026 22:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792190296;
	bh=n5lHVCc5c4ufCyPkWGEBoNS/TH5ZYTjzchZc1CNvmJ8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CqaIw04FYV6W9/GmGaHLBwYKJsC7tHK59Gvh7pm3KIMU/IvuwfkPDU+7SrVcvIGBm
	 ZPRs6a1KdxIYx9Ug3v3JKzDIrfbsRIv3hUMkYi/QeoSQiBYT1+OYFXn6TGjW2arF7F
	 bWRH94OCUAewUmgpFd3ay+sh0NrRWXrAVi6wn7+HriTCgyzH7Yl6rr81ies7VAiZVG
	 sLhyPcVPzK8QOj5/f9PHfde+DLjvYEFVYOiC5XhYu08eeaxFv/FPKpBfYRZgktai3R
	 oMqNE0qrcIi/0g4VZMm60Q/PpKer1jfyjdtD+DzzcQWRdq9vB0CpyW17SoTuGXE9J5
	 i0zW64ckrQohg==
Message-ID: <sashiko-outbox-175023@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] PCI/P2PDMA: Allow P2PDMA in Hyper-V guests on
 Intel hosts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pavel Popov" <pavel.e.popov@intel.com>
Cc: virtualization@lists.linux.dev, linux-pci@vger.kernel.org, "Michael S.
 Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261016223402.19991-3-pavel.e.popov@intel.com>
References: <20261016223402.19991-1-pavel.e.popov@intel.com>
 <20261016223402.19991-3-pavel.e.popov@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 22:38:15 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Peer-to-Peer DMA (P2PDMA) between two devices requires either a shared
> upstream bridge or a host bridge matching pci_p2pdma_whitelist[]. In
> Hyper-V guests, each passthrough device appears in a PCI domain of its
> own without a host bridge device. Consequently, P2PDMA checks evaluate
> endpoint Device IDs against the host bridge whitelist, causing P2PDMA
> requests to fail regardless of host support.
>=20
> This affects discrete devices such as GPUs, NICs and NVMe drives.
>=20
> The P2PDMA host bridge check does not work in a Hyper-V guest. Apply
> the same bypass as for VMware, on the same Intel Xeon generations.
>=20
> Tested with the Intel Level Zero P2P benchmark (ze_peer) on Arc Pro B60
> cards in a Linux guest on Windows Server 2025 (Emerald Rapids host).
>=20
> Signed-off-by: Pavel Popov <pavel.e.popov@intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016223402.1999=
1-1-pavel.e.popov@intel.com?part=3D2

