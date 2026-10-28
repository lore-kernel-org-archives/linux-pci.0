Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793157323;
	b=aV3bi0ktab3iZB5mtnt5NuYDfM3VmYmHQ4iaJLldqPuq5q5gBYdTtKzs97Y/aX1Vkfpx
	 Fw7xXirLeIqBW7g4L8WParyBKa9pymG6sAIMw7VvSx3DseIT+zfDByiO4VbLm521ElnA9
	 XJ3kjIsKEZz5aocHjbTx5eTW7z76pw2Elg94vM8KmVYh8ik8fzhbKpPjjUQNowiCUhJH0
	 GdBO7HBXftRQGaqbMciWDbuTG74gue20FMW9x8mE001rlRTYGw699FQTuSZ6/nOT4ihft
	 76dBEJkBO3q3OWzGC8VY9Nixepcf2imERLOjyyqfLiClikhu5QzAn7AiPogi9hK9YrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793157323;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=i6iz+LUCGAVQ1KBX9ZhP47LsrroCotq+hzV0v/72Rzc=;
	b=t37jBTA9y2jD9Ax4tZ9KG/RdNH7S1buQrCXUM3qtVZH7EajMzN5d700sl7d0Xj1BrOEk
	 hVUqdPFbZodMgWE7iiAfF4nnl3Xq74CL4YyKZCxv4MYXHmVxHxA13Ajkb6JfdwYKeTHaj
	 6DVH0fpRlNmWvfv6aHXCR/qJnJYzMgwIKSNBzkwsaD7YS2jax1HWABqEamH9lZeOqzOD/
	 aDolUoEuhuq2fdUAGf54naF68tOgNq5Gr+Z/T4HDj1gWsshjoX3GArVis/7e3kedJIj6W
	 X/GE9aP34ejj9SKtyX8tgubKY6n0ekfRO4aeBVuEnh/Qz5+3C8Ur0NRF3naWHL9S/UQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SSv49GFD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEE2606A322
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 03:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SSv49GFD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A191F01828;
	Wed, 28 Oct 2026 03:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793157322;
	bh=i6iz+LUCGAVQ1KBX9ZhP47LsrroCotq+hzV0v/72Rzc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SSv49GFD1rccox+ixxsmCP32g8wcAQQujxHhtCLfyiXy4z4Y44W4AEgIjfUXiwMVm
	 pU956ffVzmO0lbS9fhL/9EWmVjpuRc97Z7Gefpuchsqt3Ona2GAd0im4BnXYoHjAba
	 ruDrhDvnx+VTeHs4sgWUTWnyWQk/lVSgn566nYPK+eXq4Fcsb1IdEB7ACols3tKs6t
	 mfQL/EikWDKBWqL5yJsgDpJ64ypssOjoTohHXc18g9wh5lq10W/EL3iV47EPWN/Pv4
	 ntXIwAsQVG1mussQlDwsigdaQJOExtunBZ0nJqmI0BWqSNpnxxN5YIEyAWfpu2kfEN
	 OwpyurT1Jv1Og==
Message-ID: <sashiko-outbox-187401@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 04/16] PCI: dwc: layerscape-ep: Use cached PCIe
 capability offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261028030652.2917756-5-18255117159@163.com>
References: <20261028030652.2917756-1-18255117159@163.com>
 <20261028030652.2917756-5-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 03:15:22 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Replace the dw_pcie_find_capability(pci, PCI_CAP_ID_EXP) calls in
> ls_pcie_ep_probe() and ls_pcie_ep_event_handler() with
> dw_pcie_get_pcie_cap().
>=20
> The probe reads the Link Capabilities register to save the values
> configured by the Reset Configuration Word anyway, so the offset is
> cached there. The link down event handler runs in hardirq context and
> can then simply reuse the cached value instead of walking the
> capability list every time the link goes down.
>=20
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Hans Zhang <18255117159@163.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028030652.2917=
756-1-18255117159@163.com?part=3D4

