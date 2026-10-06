Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D2A2BE034;
	Tue,  6 Oct 2026 08:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791276776; cv=none; b=Lb8B+OvBT2nFBZ1PZXXiioGRe6CSY628PXAn2/N9RzKCsXGl04r2iGMW1GEBNrAed9ZQTE65/VZt/yNaGdz46VFrOZE8cHLTGL4P0LdtiKueda6G37WqmHkMN5gs2ggzq0H8zI+JDTbNbfTx7xaIuJVcmVN0ZFN9HQmz2LMrRIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791276776; c=relaxed/simple;
	bh=Y2AEWrDvMZy6FtfjIdmUbQWI9CGojaKXFYONr2T4oGM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qt/FshKgxCeWXdx1PONcSNCjEUG0m2233h/Pcf0sOap0qPWGYz1IsQU2Z9jna5NS9gAxKt2BqOCALmJYqP2niB1AxhVSAh5dirZEEzQmU2t8lusucihxS27TaJj4Wun4AvSuQukCjWxx6t1OwGotGINILKXwy6giwbc1GN6PCfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKLOUijd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKLOUijd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E6FE1F000FF;
	Tue,  6 Oct 2026 08:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791276775;
	bh=Y2AEWrDvMZy6FtfjIdmUbQWI9CGojaKXFYONr2T4oGM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HKLOUijdxBwyg8n5zp0yM3mcep00d3IMN/IOZwK42JdhswE29041T3qNr/L6GoEw4
	 7kgseFwvnbpVcW4rxDAxToG7h1Qdy42KrfTURxX6b7OGIEdcYzZUvCUpI4DGhm3Dme
	 1nQ+9Yt95qWtIh17qu6075qXXiK3aQIHUGLX61O0jFi4mU9K69hJdTd3R/Z1I24IUA
	 Tfl02OpGzVthed/452TwQQE3D7GxMe+itZUdCXU/E68cko0thvf5PJX5DOe/ihnUbd
	 vCbLtZhTb5irU1dppd30UkZ9YSdzz8SfZVsxZjrLAmNZJKbrU/cvhVgbAEInSxaZgX
	 4yZ0cpzecssBQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 17/18] arm64: dts: renesas: r8a779g0: Describe the
 PCIe AER interrupts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org, robh@kernel.org, wsa+renesas@sang-engineering.com, conor+dt@kernel.org
In-Reply-To: <20261006084638.3821710-18-den@valinux.co.jp>
References: <20261006084638.3821710-1-den@valinux.co.jp>
 <20261006084638.3821710-18-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 08:52:55 +0000
Message-Id: <20261006085255.5E6FE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The PCIe controllers report Root Port AER notifications through SPI 454
> and SPI 461, respectively, separately from the integrated MSI receiver
> interrupts. Describe these interrupts with the "aer" name so the
> controller driver can use them for Root Port error reporting.
>=20
> Append the new interrupts to preserve the existing interrupt indices.
>=20
> Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006084638.3821=
710-1-den@valinux.co.jp?part=3D17

