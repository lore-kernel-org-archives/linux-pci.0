Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793649626;
	b=SiIPAoUWAGopIKrVhrsFtxVBdZDzNg+xt4HaUjT10O8GEAEfeYWiB3EmdwiyflFMe/Za
	 eXMx9E8Gjnh40wZL8jBkXXo+6cWK5TXlJCH9LES4N4J5zzrE+jvck7HD/pju6U12Bb+Pu
	 3oW9/pO6kGfHatOT90cx2lVaRhHHYhO0Q7Kfidq2yGUi4Y908Z4ErRgzqezaP7XpMWgeU
	 5B/mmgPbExF1wPoVGtOGEPHAGZlTRMcTy1u7VPj9mcfrCurN0vcl3Ups1vSfb2mLnZeVH
	 XIFDYNOVAtzrkpKROaI9kcUz+0YMmA+DlgUzpFkS5S5fYVwDeE3ZdyCofv6mOoeWIyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793649626;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pw4bkvDpuiL/hzi9jyCr3CtaBL8vV0hgtyQ1BXGeGLY=;
	b=BnlsrtiKjNCAKvG2HCvZOYq9F/ySwwszrsee5njUSlyv5C6c1k3Ui14GvmuRU5NJVso4
	 z0QWw87n58dF+Dqm+ZfXa9yg+jvGXsR56ehseLX7jzkfQckS8EOvoMh4yT3HFOAehk4b2
	 RGVKB9+DjJY00KVVkSlant97oze5LM8P6Hbm9H7cBeyZ5irRi1TGOsqRgKpzcvnsBLpA6
	 7Rqp2I/pmOu4lgyyVF/LUSi26SMiIMRdmE86qgzQemJpFyJftVWG34LL2riTrw9IgenQ9
	 ix4mCbtw56TDloAbnbELgpEaplFzbbC5yABHW4ydxWI4dwkSv6kAbFHSygMeOwD7nZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mHAqgNVX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012DE606A32C
	for <linux-pci@vger.kernel.org>; Mon,  2 Nov 2026 20:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mHAqgNVX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D8A81F00A16;
	Mon,  2 Nov 2026 20:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793649625;
	bh=pw4bkvDpuiL/hzi9jyCr3CtaBL8vV0hgtyQ1BXGeGLY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=mHAqgNVXg8t7a99a6Smxvra+c6gmLNgCzaL2QElJSTigknCF/slzoCm5y+jMN8uE0
	 DhqGYsWbHQw+bO9rPBteeildfP71A6qxm0kKYHvAoGsFP+RSfoi/SNqSnLzzoP0H0V
	 vJStUjK/H4fXJWnbUwdNS28xjHkUluCYxGZhN+9M5TEa2GrffviiDfdPMbXZQTHULF
	 Ol5joKiXEWdyiZSm58PW8Q6pEad9c8tgonSCa/11nU/4jFF+iB5gH7k6DcEXVOoVic
	 aejHUmc44YvWZStalDco117VslOWuSByX2G+M1LxOI0INviN1w/dUSCet8ekkNdaov
	 SxS5slaZq5jhg==
Message-ID: <sashiko-outbox-194043@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] PCI: epf-mhi: use dmaengine_desc_set_callback()
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com, =?utf-8?b?b3BlbiBsaXN0OlBDSSBFTkRQT0lOVCBTVUJT?=
 =?utf-8?b?WVNURU0=?= <linux-pci@vger.kernel.org>
In-Reply-To: <20261102195534.4088523-1-Frank.Li@oss.nxp.com>
References: <20261102195534.4088523-1-Frank.Li@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 20:00:24 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Frank Li <Frank.Li@nxp.com>
>=20
> Replace open-coded assignments to callback and callback_param fields of
> struct dma_async_tx_descriptor with calls to the
> dmaengine_desc_set_callback() helper.
>=20
> No functional change intended. Prepare to make struct
> dma_async_tx_descriptor private to the DMA engine.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102195534.4088=
523-1-Frank.Li@oss.nxp.com?part=3D1

