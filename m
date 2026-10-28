Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793157547;
	b=IyNCb71yBVSUpaHkHgEbeJOCi7J9U2C4l8bEXci6F3dFWdjzCYQLfJ9Hi3/u4DHuHCWt
	 HFmGw0sIY/Ci/EbQzPCb3noXezUXPYBmHdGa3XOVz7QRHhWZWiOiRQ7z/w2uxJndvDp/u
	 BED+h75o8zgcPfngiBmd7Zoqb088IQ7nnH0EceKeRynf2kziZFYvVhDtm+lQZjIPUYd1Z
	 ZcJj+j5uujCrRHHmeIiRyhHa2d5n63Njc7hp2Qxzsay6Ui3I9YcvQydTkUogCwc0uKz8m
	 r4iiEli+BH26TysPL4pNYsh2WxUm/evhx4wZK8YiMddV3O1lGw1NQMNg0vCiOc9yFCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793157547;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YtSErmCT0gq42JLpGA+pSofcTXqv/wAUF1liXP+46mg=;
	b=b3/mT/tyJt4bI4p3gheyzOmB+sJz6AhIIeQjr6foy9PzM9H2+OkLqXHeYhVK0q4Uy9gl
	 snYBjpCZfbWUQjv7i+q9M6fifHN3PjnriDlGqZxM3iNm/8u3tgFMLLLCg/H9t3QtujxpC
	 n5BW/1SPUFR8oauQWXDy7awmpX72RtKKFX28NHL+EzCa5vLSF4zC9+JSVfkB3c+7eR2TX
	 ZGiFI0ywZXGUmo2twB14bXsofmo2Xyw49NrzPHqLxEwZPz+G1LRQUEw0neqtOGI/vKU+Q
	 gx77FK1sI8ZP6BlSGYf/LxEK8S2lFM9aMIpX2a2FmwXlqh2zxu2aXsDDVr26l6VrOdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JzDgxmku;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD479606A31A
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 03:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JzDgxmku
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6497A1F01825;
	Wed, 28 Oct 2026 03:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793157546;
	bh=YtSErmCT0gq42JLpGA+pSofcTXqv/wAUF1liXP+46mg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JzDgxmku0D9x67Xag1y8LFQsOKRv+sa0UZyPH3wcCFshYWX+6tz56B+kC88DBjT8e
	 5UvHlkY8CUkSrgFHDhD53M4Z3zWwXBTmEXWr1DkeIf6w/0obwu9/2gjjM9bJ1tqYq0
	 gS6tBs1pINJpgJm82x3kPw+Z4dhh0gzqxw8BfYlyuy2l73OnfiLRcNv8ilBXb5XP3X
	 t/jwTp5ILhZ50MZzKLj8zMWJbge4M5o7KtsVk5toXNM6+yV/bIdqIq/lDauSgRc1im
	 8YAIh+vdhTDE0JnQezAnKfL6g9BuGwfV3t0CXlIeQnCoZYcuRICnTO7JGDMLtPQ14j
	 zLBZ3XRCCV3bA==
Message-ID: <sashiko-outbox-187413@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 09/16] PCI: dwc: intel-gw: Use cached PCIe capability
 offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261028030652.2917756-10-18255117159@163.com>
References: <20261028030652.2917756-1-18255117159@163.com>
 <20261028030652.2917756-10-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 03:19:06 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> intel_pcie_link_setup() is called from intel_pcie_host_setup(), which
> runs from the .init callback after the controller resources have been
> enabled. Replace the capability search with dw_pcie_get_pcie_cap().
>=20
> Signed-off-by: Hans Zhang <18255117159@163.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028030652.2917=
756-1-18255117159@163.com?part=3D9

