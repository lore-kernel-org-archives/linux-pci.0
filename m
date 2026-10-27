Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793104368;
	b=tMQ6Wlr1nZ/a3DFDz6d2QZzccRU5+FPP9xWqhUl989DNkNHf5iJBXneRFr7wmCk6DHxK
	 NRJLUowNN4ER5JRgU2I34XtLlZNggalFF4vbSdkwRUH+qQtmsEwEhqXrp993+MrjxW1hu
	 1sG59U9At/VSUUr9WAPE6cN91m+cjjRVXjm/oUCjqBevkxPm7pB1hzxYpByx3t0EHrae+
	 TSRMkA4zBx9O0RolpExby2TMZKnto8hvg0xrVatUEgUel8GY0+ljMvKqkHKVZmfN/Oj1C
	 jYO2mqVt7HohN2mItiF4QLPghPznnokoXtWTQYgZDNj5F9Cy21oG88JJmFc40cA08Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793104368;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/T49XbycD6r/8mY6UWMTmnYjDZ2ZWcL1Gk3TIpkVmhw=;
	b=BuDPiYp/p/5dhJuQ1GNzfRQ2dxZyCaxG24+5k/Jg0t9G6gQsP1t8AA2GFgxQRGuUwcMp
	 QgPCAgf0kDL1gBwfbY0PHAJ5B71iwFIjsB7aj0JU4pTvA9HoLUkmvu0BnIdgJLjsg8cic
	 ik18ZWFutdh+LXdkvtZk0MAWblWlPiYR+fwxy7kV7pfw9ek8GWTPBIaKM/BJqdZ/VYzIE
	 7qFOeNN1J+dQ8L+jnzte/zt4lD6VIKM2nxmquvxwdQ/2PNYqAlVd+/t8Td3C0mcQFiQzO
	 3V0jQpCx89CWjgJGo4UF2ycalzzeoKI7pefKZWOHN6gdOYJwxAn+gC4VLBnTbm8Gxtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O79MhHFq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A74606A324
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 12:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O79MhHFq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89711F01825;
	Tue, 27 Oct 2026 12:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793104367;
	bh=/T49XbycD6r/8mY6UWMTmnYjDZ2ZWcL1Gk3TIpkVmhw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O79MhHFqeqNNdjNz/zW2yW0ZsLl5YMLWKGLmYsrPe+v0j4ODTnoso86aRZRLfZITd
	 iPJMIEayr2Bo//bDMSOTHKK1bx1axcicDsAU81thtHXvTHNHKzZm36/Z3HC0QVn8HI
	 xWGr3rpL3wi8mNRXifXmDJpjTJJBVKivBk+k1Yo8SE2mCPRjqC2RqNDevOxKxG1TXl
	 q0CiAv1x8P9Mzj/4uROl0gQdhgFlMUGBluD9ujSAz8W5moRVjNYrqDKK6a/J1aKN0R
	 EkRzMVNVK1ltaHtHKaGCmUJnjkiKf7f80+J4E9n9jpAyYJ+KLAiQ+iGHMXu1rDfT70
	 koCOgG4rRovvA==
Message-ID: <sashiko-outbox-186557@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/16] PCI: dwc: rockchip: Use cached PCIe capability
 offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261027122827.2725643-7-18255117159@163.com>
References: <20261027122827.2725643-1-18255117159@163.com>
 <20261027122827.2725643-7-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 12:32:47 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> rockchip_pcie_enable_l0s() is called from rockchip_pcie_host_init(),
> i.e. from the .init callback, which runs after the controller clocks and
> resets have been enabled. Replace the capability search with
> dw_pcie_get_pcie_cap(), which reads and caches the offset at this very
> point.
>=20
> Signed-off-by: Hans Zhang <18255117159@163.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027122827.2725=
643-1-18255117159@163.com?part=3D6

