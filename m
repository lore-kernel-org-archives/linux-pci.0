Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795083617;
	b=bMQixDnjtsQQlvuAvzDueJ3jt1ZYX7uxq6AJzGfN+EyLqnZF/fq084euVcWP2XYFyG9w
	 vYo0iaOE0X7Rh7DRHdMUlAg5IlL/4OTVlgkjth8HMXyDC9fOR5RWTsLCfsbwpGEy8oFaT
	 t8Ujh2oF37xztHN3Y05Lxldi7mBxW7RBqAkja0UsEI87l3BN/GR5K2yb32M/r4tW2v/zx
	 3qoiKNm55iojrr0g0plOlUsYT4mWX5cF5uX+NkAGiIygSTr3VsjHFKIjppXThYet9z3Wc
	 epBdXbDhfpc7t26Z8NgqapMmAtPbgXvvjV/mwkudQhTg5ZaRVJxJ2S4jN+xi8daLIvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795083617;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6ww6nt+8zloVGkdgutrI+5p2jIIaNuofdAYP8EIjH+8=;
	b=WrWvHOMfuJ+v3Gu0+NqCp/W8rzjXJaZoeYIqxRPXWmvp8ZnkH3e6pwIPWD09geOum4P8
	 yGokaOblbdGO5fc/wDH4Gv1T9yf1B0MTzapE1ePvcD2VqxPqnBrPT3zqeVL5n2bIi/HaZ
	 mlpAF5FOUbF+HJPPfqRCW0Njlu1fKVqrkQWDNSibDNzzw0BvNdnFG9OcSmZJOI+YwMu4g
	 PkxM3arS3m3iSAUUVd/ZttUW34D/iBdfQxneYxXxnMULsMcPIAv316eSRHj0mrUvxrMDg
	 a4vYefPSLJIXXYRiDGBkbUq2+ocmd8KkVqtAPXnX2fqjOg+L2p4SScGOyiPJuCq+WFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CWm3rSYs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57EB606A326
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 10:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CWm3rSYs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E7701F000C5;
	Thu, 19 Nov 2026 10:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795083617;
	bh=6ww6nt+8zloVGkdgutrI+5p2jIIaNuofdAYP8EIjH+8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CWm3rSYsNw61dKfkarjeGRmkYdw6lHBicuqn4yZbLfoAsviOpKb9/2iAGsc0bd3xx
	 /MJGzp7v/LvrlL9BPNvYT9olXyt+Dl01waktcy0o/fqFd9aYkoZfKijGObgx/HNHvn
	 eWndOau2OxmtyW53XMs59/lgv4QRxW3eWWxBDJQYFY/VC3ti6pUamYm3+GlaDC3NDO
	 dQgSdt0FwqQrfV1RCyoAlOyrIgJgjxfgyn98dY5PGtVtdylXaOsSSGwSePP1HQuUV8
	 1WH8DupepJ5HU9h1eSh/LOEHkcgwWIJTDenE1JaEZFwhgQ22lCcLkzvd5iK/FpCfUp
	 IqSWRV3QtGmXQ==
Message-ID: <sashiko-outbox-222944@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V1 3/4] PCI/sysfs: Take the device lock when setting
 reset methods
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vidya Sagar" <vidyas@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261119100628.1948990-4-vidyas@nvidia.com>
References: <20261119100628.1948990-1-vidyas@nvidia.com>
 <20261119100628.1948990-4-vidyas@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 10:20:16 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] PCI/sysfs: missing Fixes trailer for reset_method_store() lock
  fix
--

commit f6a788ffd2891c157884c924ff811b7d6b5ba6aa
Author: Vidya Sagar <vidyas@nvidia.com>

> PCI/sysfs: Take the device lock when setting reset methods
>
> reset_method_store() updates dev->reset_methods without holding any
> lock.  A reset can run at the same time: __pci_reset_function_locked()
> walks the list one entry at a time while the write copies the new list
> over it, so the reset may use a mix of the old and the new list.
>
> Take the device lock in reset_method_store(), as
> __pci_reset_function_locked() already requires.  This also serializes
> concurrent writes.  The reset methods already run under this lock during
> a reset, and probing a method does less than running it, so probing them
> with the lock held is safe.  A write now waits while a reset of the
> device is in progress.
>
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>

[Severity: Low]
This fixes a race condition in reset_method_store().  Should it include:

  Fixes: d88f521da3ef ("PCI: Allow userspace to query and set device reset =
mechanism")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119100628.1948=
990-2-vidyas@nvidia.com?part=3D3
