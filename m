Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C173DC4B8;
	Fri,  9 Oct 2026 05:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791522731; cv=none; b=TdvzwvaquA3u9OCKOPNwL1NxZD6mw1m04WIM7auJ+7QeQ01cGb4Xpzk22v7ZYTGVCzMhApNbSvMqhpBzFL8a9bpITktJAHdp24FyYREfvey498e0yvcDA+KWMVq3WeMX9MkI/iOZSgnQV/4q/Ow9ktKH6JIQI6T56m+7sYT0wg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791522731; c=relaxed/simple;
	bh=E2a/q+4YkNO1KaBMTuWTiPooZNOUygRnwacYlaMwsv4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Cc2cky1umiJgAS9DMevlTEVut+a1fIFlR5x+NIddAUeIhvJKnGJnrpShzbf1Ky4epIkXeVwxsU13AI9iZFUCiCn8EzWA2DyzJehM+Pp2EYc9+XZvST8TUekiSrOjA4x8b2G0jDrXt0HRpu4EjjoqHY6Wls0wHk4f9BJ2Rs3DZlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2VqJ82H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2VqJ82H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B7511F000FF;
	Fri,  9 Oct 2026 05:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791522729;
	bh=E2a/q+4YkNO1KaBMTuWTiPooZNOUygRnwacYlaMwsv4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U2VqJ82HnI6PdRy+A1poMfCjl1jwvL6XQZjC7YqZJMmqjtGgwxGVLPl0fSu6bnSfD
	 3jLzeF38OGwcZA13VHKZpY3TgNgQRMVyDh8eOAQ9JlQIq4IehclLKRS4Ukjp270Xbt
	 pWyglBeIaw6A1gGtlXtBjRoiKkB08+0eqvSqGH9uhWkXi9xoRDsvp+Zn+3pY24tpWc
	 G/NqcBamb47du2bdEYP86tklIhfvuTNzHvGbBG2sRW7DZBEwhjOHZPv51pnjsN6gOz
	 +kwVZ6wEBGgqxzg8CRFJRjgT0pSdo4Urd3SG22kHdSKaur1WBTkLN/s/VfIZ3zPL2B
	 uy3AaSOpNWV1g==
Message-ID: <sashiko-outbox-164874@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/7] PCI: endpoint: pci-epf-vntb: Allow DMA and MW to
 share a BAR
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, ntb@lists.linux.dev
In-Reply-To: <20261009045949.1109871-6-den@valinux.co.jp>
References: <20261009045949.1109871-1-den@valinux.co.jp>
 <20261009045949.1109871-6-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 05:12:09 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Some endpoint configurations have no spare BAR for DMA resources. Allow
> dma_bar to select an MW BAR and place the DMA ranges after that MW.
>=20
> DMA submaps have fixed BAR offsets, so a shared MW translation must cover
> its configured size. Report that size as the translation alignment and
> require it to be a power of two.
>=20
> BAR sharing requires ntb_hw_epf to parse the DMA extension, since older
> versions treat the whole BAR as an MW.
>=20
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009045949.1109=
871-1-den@valinux.co.jp?part=3D5

