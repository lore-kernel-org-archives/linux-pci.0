Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4D83F8EB9
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 22:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785277167; cv=none; b=iZ41gjMLow1wavHyUDMrqBLq4qIhh3puyFM6I1rb3O0TtqdYhLcwLMdySkpAl6g4igOqoP7IXU09aH4PIi9UPfnYkZRUwvfuIB/Zuz2uDpXIXC1oRFlygniiRoCy06gO/33gcZUg2VmeYj938zO1LcAn+lT0ACDXaN+91tV3ras=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785277167; c=relaxed/simple;
	bh=9Y+BPfwPzm9Nqopyf3DwKUFefxQcMnUUJVIgBKIQANo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gqlRMpu+eAYyTQ97gD/VpoNUoTl+QFW2TUunhrTrvEAo5UlOWzaEto8B5CQ3yRumSE02KOdXobzcAXNesYj7kTgRHb7OeHLdvr+evYLEAt6exz/c/meklHm6QHS901hkstpoA3ovBFN/T+POdfJj6JXwqwg0QO6Hnbkbe6mSYNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fvb+kjC1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fvb+kjC1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27A8E1F000E9;
	Tue, 28 Jul 2026 22:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785277166;
	bh=9Y+BPfwPzm9Nqopyf3DwKUFefxQcMnUUJVIgBKIQANo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fvb+kjC1L9SketZawn101K7uRkBQK8NRFLbSiWAcpJAHm1j6pKrTCKJK0lbbq0wqP
	 YIgDMPSa9JvoAQVL8Cmrfnmk5tjqvUMqh9rc3fpYQH40sVszy4dj1RiWf4LtZBmh0R
	 XzXW9Ut2gerQpymrAd8vU8IsUgN7sOjwp24ur5LbevHy8QeYXd3nNxxYPo0ZgMApeM
	 BFY50YRZ7cOLhOEIqXeE+vzHjIRbZyLMQk34SRLPuA3RxQHASo39IgfubdGgOJz+R6
	 BVm1ZS/rEIEs5F62GfFa/wbRjt4NGPiSO/LyDvMpq5KWA98NGq5aw2ir5pD5fPEqv0
	 8zqgT9cKhXRTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 12/12] Documentation: PCI: Add documentation for Live
 Update
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260728221007.2098560-13-dmatlack@google.com>
References: <20260728221007.2098560-1-dmatlack@google.com>
 <20260728221007.2098560-13-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 22:19:25 +0000
Message-Id: <20260728221926.27A8E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add documentation files for the PCI subsystem's participation in Live
> Update.
>=20
> These documentation files are generated from the kernel-doc comments
> in the PCI Live Update source code. They describe the File-Lifecycle
> Bound (FLB) API, the device tracking API, and the specific policies
> applied to preserved devices (such as bus number inheritance and bus
> mastering preservation).
>=20
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728221007.2098=
560-1-dmatlack@google.com?part=3D12

