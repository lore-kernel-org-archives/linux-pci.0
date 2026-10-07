Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A417D4848AA
	for <linux-pci@vger.kernel.org>; Wed,  7 Oct 2026 14:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791382719; cv=none; b=a78zB46gp3Ygyzi2l+7WXZglowryBUv5i79ZCFNmqT2VW+z+e1Hg2xG162YkubGije8/HQuni3DiwTRzq534YD/8QPizKIG1ArbMKLrulxzrfip4LzdGy/uM76AgpF078lFNCMldQplieNWvj902GJVWQQEDhicLlVISm1XN0Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791382719; c=relaxed/simple;
	bh=0KLh3Z3ww4GoakinykQ4zKfBgplTwRL7PbZ4PZ/K2Ow=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Mb/kXR54fDuLygWXpGDefZesMbK+vdSyjHL++1rjj0HI8Vk68xwKvWsK4lkSSloSbc5A/D8AtUkmR0HFzcpcStsmmqlU7dM/1ZBjr7zSMI3/LBCcm6D/X63hUFkdel3oSYE0eZMSZ5TgmT1jzlMnkNBPoMg7g4zmMQcNX63aX3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFQGL5zQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFQGL5zQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2F061F0089C;
	Wed,  7 Oct 2026 14:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791382713;
	bh=0KLh3Z3ww4GoakinykQ4zKfBgplTwRL7PbZ4PZ/K2Ow=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KFQGL5zQ7afoQC5Vw71ATZM49FkuoCO/rKm2FzsWCjYVsjOcSeRkB2GB1oYjGihr8
	 TYT3jjTH60StSI2bMRKBeT5ZPVO5VT171U3PKNGUlWd+K5HxNqYcYxTiH485novjTO
	 OUMoReY3Kp2j83ga9t7ihRFesZpplrhz7Vdn7M3RO6NiXR8QQDIhbM3nImULQ1Thkk
	 vrt661zCYkuohyp4P3XMK2WkTYByIeaF3rQaQG3crONRcNfexkw+fgpePXmPvcbxnF
	 aL0LHyu6BlFTbZOPKZoK/lWjE8Krw5IVA0zqXsLqHxv/5B8zwbo1r3Wvm/I1sxBvBJ
	 ByXCvQYvyM9Nw==
Message-ID: <sashiko-outbox-163093@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/P2PDMA: Add Intel 0x6f00 host bridge to the
 whitelist
Reply-To: sashiko-reviews@lists.linux.dev
To: "kai zhang" <zhangkai.cool@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261007141558.59852-1-zhangkai.cool@gmail.com>
References: <20261007141558.59852-1-zhangkai.cool@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 14:18:32 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> For P2P paths routed through a host bridge, the P2PDMA core consults a
> whitelist of known-good hardware. Add Intel 8086:6f00 with
> REQ_SAME_HOST_BRIDGE so the entry permits peers only below the same host
> bridge.
>=20
> The bridge was tested on a single-socket Intel Xeon E5-2697A v4 system
> with two PCIe GPUs below different Root Ports of the same host bridge.
> Without the whitelist entry, peer access was rejected before a transfer
> was issued. With the entry, 64 MiB peer transfers completed in both
> directions with data integrity verified while the IOMMU used translated
> mode.
>=20
> Assisted-by: LLM
> Signed-off-by: kai zhang <zhangkai.cool@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007141558.5985=
2-1-zhangkai.cool@gmail.com?part=3D1

