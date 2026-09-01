Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0864734D3;
	Tue,  1 Sep 2026 08:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252674; cv=none; b=INj/VidQc8wGYTY7S9NLgxAV+keq8IebohANp/ZBkLq+7de2f7B7UuHpq1z/vDG/qdMOvqvJMGeWAxypRGssgM9WCAsbtRzzRxdzVt2gAQuv8kGeq5fgpZpECAAQPYCESv5epObQalTsbBLvlWk0Jt6MLIdvHJ0HzHEpOQSzMqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252674; c=relaxed/simple;
	bh=8bhpuPqrKNPd3wQ5ooSMsA2/3+t9JJjXowS6BSa84ww=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jYEb5LmnDmaiQUg2gpKiY8pVEXhIxktp6AqcOXazyIzb1dAyjB6adquQQhCew45mHPaqHe6pCdzGDTxemKRRfiKHfrg50iLcg36+4OdcvxtttA559m1wbDAncSNigMNFhDvw+4fB/Iq/reCRDw+RHRXSStAdiMmnNg/kKhLB0Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNn+8kA/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNn+8kA/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3D21F000E9;
	Tue,  1 Sep 2026 08:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788252673;
	bh=8bhpuPqrKNPd3wQ5ooSMsA2/3+t9JJjXowS6BSa84ww=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RNn+8kA/7ecJjXOWiejGKHdCj57MhKcVd4C600zds6kZTj/iecghHWVVidMpLqc/7
	 ggi6KjqUMjTsAPWDXDvzQD3WzusUyL6UTyOKWxezTuhsbN+MfNzOLVXkpcJVNHh3pi
	 4Vm3zqL3n67LmOn4IKru8thcov4kZrYVnL6to+gruQoLUtGaCBd6AuW/GgtWC4vqIR
	 nPu6zEtRK4PdbiQrV0xFGl4epnoBuoTVjJVDFqH9wPrCJf9d95gjDwXkUrvvzsL7PD
	 RLIijuku8QCSf2PnN6jvPn5wEZfIzzlZtNosYv2pxQjsBVNAxfXOqQonafOlQOtnRw
	 gGCcFChjuE0/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/6] drm/bridge: simple: add Chrontel CH7218A
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xilin Wu" <sophon@radxa.com>
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260901-q8b-dts-v1-3-7de0b6a73d08@radxa.com>
References: <20260901-q8b-dts-v1-0-7de0b6a73d08@radxa.com>
 <20260901-q8b-dts-v1-3-7de0b6a73d08@radxa.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 08:51:12 +0000
Message-Id: <20260901085113.0F3D21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The Chrontel CH7218A automatically boots its embedded firmware and
> operates without host-side configuration.
>=20
> Add the CH7218A to the simple bridge driver and expose its output as an
> HDMI Type-A connector.
>=20
> Signed-off-by: Xilin Wu <sophon@radxa.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-q8b-dts-v1=
-0-7de0b6a73d08@radxa.com?part=3D3

