Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B638A2BE034;
	Tue,  6 Oct 2026 08:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791276714; cv=none; b=F4zZTih5clPluGjaAGnQZWSUpSCkUQnP0YRS3uMMKNLhxajMSzdW7feC973PGo87B5VDNSG+amclFt5GS4kEBfBQnu0J4kdNCg5bqnu/zB9dR0rLYhN5MJg4ljYtZ7zOnyomy8DE6MiX2jpSDJga0l/AxnVdnpVIy+6yI1dH0wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791276714; c=relaxed/simple;
	bh=0SzN5s7CV9Eox10Ibcb7zKIJsia3VtYiX8Adbvhxj5U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sVHh3pIk4kkH0iuKlELfbhJBbR1l6g65aM4S5THyrw9VFv0K9QmNX1csmjtHuK9TJINPccSAtXzWT7E9JDOO6fmggP28HMm7C4mi0+Arlo73nNJPbIdcRiAiqV1HL5l2HYVkvRR52DXjaGveyha1pkyPKg3Ec9nNB8QN5tFOc+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kiVyTAqs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kiVyTAqs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED971F000FF;
	Tue,  6 Oct 2026 08:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791276713;
	bh=0SzN5s7CV9Eox10Ibcb7zKIJsia3VtYiX8Adbvhxj5U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kiVyTAqse1K0zmH84cki9MZCDEARLwg1bD1rW6Rugx7ZzS5s0zOl1RZhVaOL0eWKn
	 /4/tRNJO04YXXVfuDSteQ6Nm5Ir171knKjJGIJAX5aoe7rVbK7pZnM0l9TLR0xNsfs
	 L9Z3eX5TgkhOmZbLAQv4Cu9AQRILcKRa82TipAHixNbCLciFvneP+bjyD2xHr12fmv
	 rU18OlxFGadrkeWdNRZixjvoHhzgZgWQRMdhvVh2Qw6gjRd8RcenOQsE8J2qcD5EFy
	 D2umd5VyDtf96WaFJ1Vh3vo+eZCuK31xYYPpuapGj+4uA6WdoRYSYLdDYwcvEQDQS9
	 Il9MXvJwYLhtg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/18] PCI: dwc: Export dw_handle_msi_irq()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: conor+dt@kernel.org, robh@kernel.org, wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20261006084638.3821710-6-den@valinux.co.jp>
References: <20261006084638.3821710-1-den@valinux.co.jp>
 <20261006084638.3821710-6-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 08:51:52 +0000
Message-Id: <20261006085152.EED971F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Not every platform brings the iMSI-RX interrupt out as a dedicated
> line. On spear13xx and keembay it is a status bit in the SoC wrapper's
> interrupt register that the glue driver has to check and clear, and on
> dra7xx it shares the line with other sources the glue driver has to
> demultiplex. These drivers set msi_irq[0] to -ENODEV so the core does
> not install its chained handler, and service the MSIs from a handler of
> their own. spear13xx and keembay call dw_handle_msi_irq() for that.
> Both are built-in, so the function was never exported. dra7xx can be a
> module and has an MSI loop of its own.
>=20
> Export the function so that modular glue drivers can use it as well.
> The pcie-rcar-gen4 driver, where both situations apply, is the first user.
>=20
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006084638.3821=
710-1-den@valinux.co.jp?part=3D5

