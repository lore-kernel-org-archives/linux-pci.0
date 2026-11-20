Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182843;
	b=SzXcJxxvXx+IDmDsAAUApsW4NDV8dWAUh3PGmlke30vZKe/f+6m4gHU4hU0GCIuMsB8c
	 TwSmO7EcoLkApTMEk0OCv5qyWMpjYR6dgWOkLXPohUrVWh1+T/qGqNlN4RxQ8+wRw6hXt
	 O8qRTxh/AYR7pGWfduz/lpqWBt4VZZXL7v/LuYBBo3RQ/q4X+9wxVlJX3bW3/TtQZ8upi
	 /ohUacxURtsh5yfZApOcwWeYtdBmEa2QGCfv07hZ/IpeVYZQIVlO0tBK9u2xUpCytKYsw
	 PP2pQsG1MqHC2MyHPWknhYAePvaDAUn5d857HA35k58aD9DU5fepGGABxn5QfWJIJWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182843;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6hZol7Pua8pig2etktVI0g9c+4xYi2atutDkrGQjGbw=;
	b=TS5eUA1F0xCwwQXMf95XhDuOgzQopSje/ZSm5+cGBHctCuB+1J3x+IIaAOfZ+mLACvKU
	 BVH5jS1ZQDjUt0gNUpPdHq6EkTr8QvjkqVaLMWVbPjAkHufsemp2nadQlpA2khCjOmZnw
	 4J4h4Sz4x2RxJQ18ljDFPl0mw6oVYcTjqYU4DVUacIzli/Z3fjx1p2THhWPwnr8KtzJrd
	 7abu9OLlq8MNp3p98nrrsgDV0BFrHHW9d33C72gcHktxFacskLcddC1L8HaV1FS5YP4Wm
	 X58u5pMFTKyDh1hbNgmcRX+f2zwjSX2rc7k2v4HJi4H+IP1Sgs5ESQUWJgFMDrm/HGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XlOE6rcj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C4160A2617
	for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 13:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XlOE6rcj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 991B51F000D8;
	Fri, 20 Nov 2026 13:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795182842;
	bh=6hZol7Pua8pig2etktVI0g9c+4xYi2atutDkrGQjGbw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=XlOE6rcj0KmZAND4E0wq5fTw9dJWramtLNXesHOXiJiJSvpTKtxHxTnkUNIspwWiN
	 JzAIG+/et5VBgnVx8cmMe4nUEh+9YwhEaz2s+BPHqMiganji8lIaG2ZeIdGRMs7/1n
	 cq/YBHm7q098LYqBAWYQgPraY+ixzOM/M8hzVVNwhglLWQ2C+DucMVwaZEl/jNqHAa
	 eEwaHDfOyv5JDD5RHt0mIRnCQIJbp63mNISN3etd5P0RnbE+jrmJIhM3gmWjnleQcM
	 cvqyEYe5ARZvaAisCc5AxyYMmrXVAerHx318tquunJLCSbL+RZ0/CJAVcdfbKuw8L+
	 XWupEWqszhgvg==
Message-ID: <sashiko-outbox-225294@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/16] PCI: Use guard() for pci_bus_sem in
 pci_do_resource_release_and_resize()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261120134716.3027-4-ilpo.jarvinen@linux.intel.com>
References: <20261120134716.3027-1-ilpo.jarvinen@linux.intel.com>
 <20261120134716.3027-4-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 13:54:02 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> pci_do_resource_release_and_resize() releases pci_bus_sem on its common
> exit path, which it shares with freeing the saved resource list. Move
> the body into __pci_do_resource_release_and_resize() and take
> pci_bus_sem with guard() in pci_do_resource_release_and_resize() to make
> adding more locking simpler without mixing goto-based cleanup with
> guard().
>=20
> pci_bus_sem now also covers selecting the bridge window.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120134716.3027=
-1-ilpo.jarvinen@linux.intel.com?part=3D3

