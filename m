Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792648921;
	b=St8RGcr4znSSh8zgCsOHv180fHVKaN/xZQBSQEBPhD+FHs/itzKEffk1ipCT7C65ks3V
	 2V3a/EnCSAeL0xQEhP9IkkHi6dN/dfHq8N8l6e6HR+gvxuqZ2QN/PPv1zlOsSn2pamb2S
	 6uC/b8j7wsExMKqUhAQX+i6q7PTXKDiS9Yb0m0Sl+B1fcUIu5u1roJUOnrExyMzOQN35/
	 BQB436waPqH0v8mBG2hFiwX+HN3wmyqElrJOMl5ILWy6ZqGDYUN+lAU767fgKT6lnWmfj
	 KzefEOAS3FppTUW0B+Tv6AvgniNAxLetX27t/BRATHKMtOkBSSraLgzLFAQSymPBI3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792648921;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HSj0gSUTxnkHgUO5BiJ9pnrrugcJoDz1Q9O7w0bxFW0=;
	b=eb6h9s9gK2T/LEMTGuGSN7ENwBnklr7SXcLtuMAYh8BE5G6VywYyorZEu/m9+HysXrIw
	 7S00ILKG2+kdssegHf0Jb7DT59N5h744dSFM7nogJFLkGipfYvUK3QfxWEFXvTkSv5bBr
	 p8ZRBn/FSN7wfdXpYKPD9GJttJixD//ysfQKMB6iQN5LdPsBstoRvYC3sXa0QvMyy841m
	 IM9QP1NGutCWI4EIJuS49RlhJjTv3bIREr8c1+ouuh5FUVA5G1377kDwIonxsSNlscP6L
	 e54slZu6DH9u9IP3i9cdV6vlLBAqZftjH8Y5F1b0E7C1tEfoZcg/VvUnkb6gx676qjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IJU0bjY+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5F4606A319
	for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2026 06:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IJU0bjY+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EBEC1F000C3;
	Thu, 22 Oct 2026 06:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792648920;
	bh=HSj0gSUTxnkHgUO5BiJ9pnrrugcJoDz1Q9O7w0bxFW0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IJU0bjY+pi4lRhCt0Y6moFEWyvoAZzYz/qxoGFUjxFz3t3KVTFzvjL3osF+x+NAfm
	 j9YwAusRD178ngm/42ha7qJsBzOTu8KjHh3WHQDuxCOVHIomHVzNF089un3zTqh2XD
	 U0zPoocXQZQ4l4TPeuWN9AmYGQEnfT8Dc8o/7H+6bN/nZkGkrKTfA3bCGZIMUwkZmL
	 8SphJV4Yvoc5iC7cgWIUi4HGHXkkabxttG8yck8MXPznMkzMuHmNoptS8QUFuwLD/q
	 5P1uCZUXmk+hj7T3NyXTIpKRwqOggzbG/aYmVP4pZC+litDGIgPpSWqIH6mYl7a9Kp
	 hVG/V1Ebm9XmQ==
Message-ID: <sashiko-outbox-181047@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Ignore Immediate Readiness on Samsung PM9D3a NVMe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sun Yuechi" <sunyuechi@iscas.ac.cn>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261022055814.2566044-1-sunyuechi@iscas.ac.cn>
References: <20261022055814.2566044-1-sunyuechi@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 06:01:59 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The Samsung PM9D3a [144d:a80e] (MZWL63T8HFLT-00B07, firmware LDD5702Q)
> advertises Immediate Readiness, so pcie_flr() doesn't wait after FLR,
> but the drive returns ~0 for up to 6 ms.  The config restore runs about
> 1 ms after the FLR, so the BARs and Command register are lost and
> neither vfio-pci nor a rebound nvme driver can reach the device:
>=20
>   pci 0008:01:00.0: reset via flr
>   pci 0008:01:00.0: restore config 0x10: 0xffffffff -> 0x10010004
>   nvme 0008:01:00.0: error -ENODEV: probe failed
>=20
> Ignore Immediate Readiness on this device too, so pcie_flr() waits.
>=20
> Fixes: 10baa9b4df40 ("PCI: Drop unnecessary retries when restoring BARs")
> Signed-off-by: Sun Yuechi <sunyuechi@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022055814.2566=
044-1-sunyuechi@iscas.ac.cn?part=3D1

