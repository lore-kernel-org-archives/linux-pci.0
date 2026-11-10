Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794284777;
	b=TaEWiauSw14Fz+2yjonyy9VGcs6OOaboBLjOAF7Vwq3QoKIRGWJZdS9q3Pzzl3G1TZef
	 Ny9qhLceh1zrO3nZWPDD9SNl7fww3fhTw3eDHJSArcoMZqfioECkDhAbDiru8yflT/NhG
	 0M8lvjo1Syvj0oksE6aMXsuMlyMyzwhaHNSdDgddMGxT9c7r+sKbyLtaQafGuOsfS4e0t
	 STP6KQWTgF2TZhQYX/j8r1DnEedslZF7yFyEmopPMLiSgE1U0IQJsaB9huRPprKnX6yKW
	 uX9zsK3mU2m29GfuWFCmH6zq3MjxwJYnRA4asmpTX2monXKzsYqJ6ao7Nl+/DNPwqVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284777;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=n59Lw+EuXZpbRr8qWavHqt2yTBABAAXW19phlDr2oyg=;
	b=vMvw5EONVXYUgHuw5Gtel4hVsd4a1611TzQhWMDxriD5UAdQ3q18cvARxvR0EqiaXRqG
	 auf9OLIfDyYn8KwsG+gMbq6/gf1vdPO4xGFW1v28i8YAecrbKsWHbL9RAXPnOdlW5UZJU
	 ZKT8zH9MFDWdmR5nYaa8DcULzn62xs/yQnmRjEcRSjkM/EEgERfeWpeLC/Bzmkcz31Pfk
	 pMuD2FXYSJuj9mKEO+MyrP66zSbEPhd0av0hDhVBXQPDaEsmWB2iivmVPvquNQe0ZYp1A
	 QuR70T1AsYIiHeQqiGC0Qm9fWwzhNXedUGCADY+BeTnxZdhI/B7H/JMRpDnDcT0NHKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SwqDErAC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7B0606A723
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 04:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SwqDErAC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A42D1F0089F;
	Tue, 10 Nov 2026 04:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794284777;
	bh=n59Lw+EuXZpbRr8qWavHqt2yTBABAAXW19phlDr2oyg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=SwqDErACjJIzjp+areLgYlBY72uND0Czy//UF1Hod/lhCYdqHXAkJbM23Xt4g+sHn
	 O76c//pNkjbVd8TI3yu56JsNFGQ1iAyqmN3pePWwBpPYklVmpkaSrKO97N2KnMwqS4
	 2bSe6uKKHWUU7mH6HWBgxYwHZYbF2kcIesiME9eBKd+44KdOFQ0g3Ebr163TJ8+AKV
	 36vPMYgxrd5Vhta5o4P3crjk2snG7j7KiQG5GzK3H/y2TSU/UcnM/b9K3itUhg6Umr
	 bIsl8BC5WDqCh4kco00pBkHnCFjgVq87WzqwV/5okEut6YdIl+8Hv/+TCFoWJCpEa7
	 ZVoSXoOKIanWA==
Message-ID: <sashiko-outbox-206196@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 05/25] X.509: Parse Subject Alternative Name in
 certificates
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com, linux-pci@vger.kernel.org
In-Reply-To: <20261110041832.1730924-6-alistair.francis@wdc.com>
References: <20261110041832.1730924-1-alistair.francis@wdc.com>
 <20261110041832.1730924-6-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 04:26:16 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Lukas Wunner <lukas@wunner.de>
>=20
> The upcoming support for PCI device authentication with CMA-SPDM
> (PCIe r6.1 sec 6.31) requires validating the Subject Alternative Name
> in X.509 certificates.
>=20
> Store a pointer to the Subject Alternative Name upon parsing for
> consumption by CMA-SPDM.
>=20
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Acked-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110041832.1730=
924-1-alistair.francis@wdc.com?part=3D5

