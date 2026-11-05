Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793867957;
	b=pr8GqGSe3JmNj4OBTeFbA9PYpR4jGUlm226PVjdtS7CLPkE9NEpqEBBFfbJJrArXt5y9
	 rjx48VGAom98g+5l2y2RXK2E0giQC12s+6rcUKflX0JRrCkHDgbYhiYHIUv7/q+MiDK2X
	 4Z+2vkRCZ/D6OR8zoWFbV4DGmHgbk0hzAHJ5IBlp389+/RUCiKJpeEb7zry5uLlFwLnwo
	 JKx0ZkE1z/yx8HjmhiTA5WGGGtTypdVWETaUn8WTOkWpuRV8WBpwMaNtD/9S7WnPscuoS
	 UIRQdxS9uSg7BIBWX7g4dRjM5zAT9nvpkFWDEjIHAsO439ooBQuF8wBEou0GzW/pD9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793867957;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WwikDhoLJtWJevJzZfTXJjmgCbDcmLoB0AE1rQd6EGE=;
	b=ZGEqsA8vBjBH0xv5vXoO/4e2LRcYwGFC/0CU7wWiT+a7slznyIK/KfIr517vA7AXwg/X
	 B5tDWJ78qN1IIu299NZvdsplYOenDHXvmlrU9w3xtJxKIE6HpNnJr2TmGxH9ZNkwK5ypT
	 /sMJTB/bOsLBd42uA7+oTyjtA8gRhQq8FEZv6b09Y/leibGZ9cwTIQzDt0cYDT5kLH5Q7
	 EiRGrlbBkI02gSSdfr+aZqWw5iApsldbzYyRvrv8XZbVdcmDLTRug6EgpviWGqrlt6mqx
	 2WJbJ/KpvTDJs/O7/BdLkLwQ1JjP+yRlklw2P5KLRTKV7zwE/fdzRpWkOHgYtcOwBtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QQ85KJ+C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A0B606A31B
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 08:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QQ85KJ+C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A4D51F000C1;
	Thu,  5 Nov 2026 08:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793867956;
	bh=WwikDhoLJtWJevJzZfTXJjmgCbDcmLoB0AE1rQd6EGE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QQ85KJ+C8d+u4T+Kv4EGAaN8Kf4CrCP/hPKkBGGa7oymKJkbPy0x2V8xS1UBswVYN
	 GjYMKNMlI3iub0M4urugnDx3Y4t5g3SatXbc2biaajVN5O6EMsnQ4uO7pNYYh3igml
	 jaH55rzVtjcIdhBvs+uJ2K7a3aRLmmHCbo3JleXa9p4BV6A1xr4cgNwdNHLoYL6qfA
	 7TtgtpPYV8T92R8bWlz+w5oz1fwR3O7rau0vJkKgs0BXqU8yPiKEj/aScyhCE3ycXh
	 RdLsmxTwgbbHnzn3dyAyTHdIXoGbnDNP+WiZTfZqFppxxI7kBER4QeIrCQQlvJ8blK
	 5ph/A26T7LnyQ==
Message-ID: <sashiko-outbox-198731@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] power: sequencing: pcie-m2: use
 devm_mutex_init()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261105-pwrseq-pcie-m2-uaf-v2-2-3e1dd415af9a@oss.qualcomm.com>
References: <20261105-pwrseq-pcie-m2-uaf-v2-0-3e1dd415af9a@oss.qualcomm.com>
 <20261105-pwrseq-pcie-m2-uaf-v2-2-3e1dd415af9a@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 08:39:16 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Shrink the probe() error path and remove() by switching to using the
> managed variant of mutex_init()
>=20
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-pwrseq-pci=
e-m2-uaf-v2-0-3e1dd415af9a@oss.qualcomm.com?part=3D2

