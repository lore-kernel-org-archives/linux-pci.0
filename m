Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810182;
	b=WeTe75bTQ2SdirLlt+XeWeSGm+t4ME+F06m4CTUE6GMG/sxE7cyUhPq1E41Gh89Lbspf
	 z6Jk/SfU1x/PXVN8BQtprouzVh/mY78MqJe+Jr1RAEjwqM1b/50OH6kYkt5avIze1th50
	 OE4Tk5ebueRY9/vjtJzAeVMaRyXuPhcw8NfFRtO1yQYEkfCZ0I+rewuTPKmlPSkcOq1bB
	 m1MTO8gy9e+DhHih6fhu+kl62frhSeqhoAywiPrCuuXnE0EArAeiQn9ep/kDxLsp2AfGr
	 7UKj9r+59UEzoGlYFcXI+7CA8Qnd6l/ev8hNitIzLjswNCbEZ5ry/TPnhGPeBHKpeFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810182;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ecEPPMgrTp6BVClbqOQilv6Uj3ohppRaHotmNCirk9M=;
	b=vOsa+iLUyEGWVcfp6C+pFPOhM1jVMYtdxMcP2yTLwamwLuk2pBMeHH1Bm26oI3Pd+JDD
	 gM6pLqFJJGfpGns9MA3YVOpuum6TAhjmweMZ7h/P3NpU9Es3ucxdsbnm7kqjg+q5GpYq8
	 5vGnbujLLi6aEZclxl9NL0+29D9UZVruYQetiIljseb6NQ9HlWymUY5r0tu443K7HwzBg
	 a5hrFW6uZnFUKnLncm3VNCcGkQq8Zq4kUN43fmlyTy8syhCipN/mHNmJnvTVIO+BxTZAc
	 q3bWrbwclmq7RDCZj9ZefmTKB/t8uzRdyDRiVQhqj1iQgUfnT1r4cN7Q1M51VqqBIRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Or/YYAW4";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72077606D83D
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 16:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Or/YYAW4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E02441F00A16;
	Wed,  4 Nov 2026 16:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793810182;
	bh=ecEPPMgrTp6BVClbqOQilv6Uj3ohppRaHotmNCirk9M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Or/YYAW4BFRRLY7s288Y8/VHHDE5CD8WPc8Njtty8+hVUqOamgyBZ9h1uFLyp4OgC
	 ithcqRdKBZG7EKerCj4iHHETPahvgdQisil/pvZIC1e3lQ9LHpgFrThpPATx0j0sHv
	 uhokxhcdjccN4ARpDiWsrYt1hNfhLO46Hjt1iz0iTNLCbb4OlmLS/AIcnF0ZZ7pPB2
	 G0H3AgfgAh65+slzE5raJ97U+8JEwobgTQ6KEkGWQjsI0/vY0IGOCEuPIUH1QQHWhk
	 rLTk5+XvAXv5wIB5+tR3hWd0c4d0fEbq4Iw5EHqPAts/49zZoelvgIGcPCpgNiX7kW
	 /jY78NC/Vm0AQ==
Message-ID: <sashiko-outbox-197627@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 04/15] virt: coco: tsm: Require PCI operations when
 registering a TSM
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261104161632.3547423-5-aneesh.kumar@kernel.org>
References: <20261104161632.3547423-1-aneesh.kumar@kernel.org>
 <20261104161632.3547423-5-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 16:36:21 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Reject a NULL pci_ops argument in tsm_register(). Every registered TSM
> then has PCI operations, so registration no longer needs separate paths
> for TSMs without them.
>=20
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104161632.3547=
423-1-aneesh.kumar@kernel.org?part=3D4

