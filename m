Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244DF49E5C3;
	Thu, 24 Sep 2026 15:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790262577; cv=none; b=tmZV2MmwEXat38Y7HlCet2I2DiLDp5TbXuxfxfzKLEfML5gNhiZ+3Vn9b7ux16btCqugbesnPzqqaPntUONvyZya8rkwJOpbS37KpdwAvuD7ksVCI6xPcfsyYskxhWOBzSq6GesWiqJDL4/xhGDYiHvPPPKzw/HdcwiazOouAJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790262577; c=relaxed/simple;
	bh=2Fpo5MM6aK9/ta1wmkY99C6Svz2yUm0E6zMrs9rOfEQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DTE7pxlT9AI5MQBpEcz0yCe+wYHfzwQSefpqL0WwBoXCwTLsXaxD2UhH4rJVIxcu15fsNwcUZ2YKkTbx/Mswbu3hLuhnumv6/6Efm94NbD0v/YGw6w+9uTuFV+U5l/7s6s8HNCo6cAYhXchmyG3rQNwlKqKPZZFEpBnEojW5QbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZPD/UuR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZPD/UuR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4CE31F000FF;
	Thu, 24 Sep 2026 15:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790262575;
	bh=qnT3ixunLFIcsAjvm1MF5xUw1NS9BffymW3jO86ZhsI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mZPD/UuREFS9Ha4QKyVR/WhrKQl17lxU2vNpGjmiBcC/QBebBahskJ6YXoAbHuETH
	 45v8rkj68gKng+0vvnLzvfhlRDs42rWrQG8b6m5n882GDMgBiKZOECy083YsWtbHFn
	 zvXKdcnbIZ5aKx9u4JIOxJkjzDlcw6aA9SdW3PejO8gTmHmCqaJMYLSZZk3zUNPtTh
	 RpJAS38ca+PuWeaMKlpVAXxDYHD+F7wLelwf0/DK8wutYQC7kMk/qmBjJoeRhzG4qY
	 xs/XlffAcPCHWg+4h6W5JlUvsMoEo1ICmbRjm7CTBfK/b6e2Rupcou3rQA+qMm3DId
	 cCp5H2I8I6yag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/4] PCI: of: introduce of_pci_verify_node()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Elder" <elder@riscstar.com>
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260924150222.1179235-5-elder@riscstar.com>
References: <20260924150222.1179235-1-elder@riscstar.com>
 <20260924150222.1179235-5-elder@riscstar.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 15:09:34 +0000
Message-Id: <20260924150934.B4CE31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] pci: of: unintended error-level logging in of_pci_verify_node()
--

commit 0e8b20efbbe63f895449027a5712b691b9eeaa56
Author: Alex Elder <elder@riscstar.com>

PCI: of: introduce of_pci_verify_node()

This commit introduces of_pci_verify_node() to verify the device_type prope=
rty
for PCI devices. It adds a runtime check during device enumeration to warn =
if a
bridge lacks a "pci" or "pciex" device type or if an endpoint improperly
includes one.

> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index a51dff91b196d..5a040ed836744 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c

[ ... ]

> +void of_pci_verify_node(struct pci_dev *pdev)
> +{
> +	struct device_node *np =3D pci_device_to_OF_node(pdev);
> +	bool device_is_bridge;
> +	bool device_type_pci;
> +
> +	/* Nothing to check if there's no pre-existing devicetree node */
> +	if (!np)
> +		return;
> +
> +	device_is_bridge =3D pci_is_bridge(pdev);
> +	device_type_pci =3D of_node_is_type(np, "pci") ||
> +			  of_node_is_type(np, "pciex");
> +
> +	/* Bridges should have device type "pci"; endpoints should not */
> +	if (device_is_bridge =3D=3D device_type_pci)
> +		return;
> +
> +	dev_err(&pdev->dev, "PCI %s have \"pci\" device_type property\n",
> +		device_is_bridge ? "bridge should" : "endpoint should not");

[Severity: Medium]
The commit message states that these warnings are "meant to help developers;
users should never see them."

However, dev_err() logs unconditionally at the error level in
of_pci_verify_node(), making it prominently visible to end users and
potentially failing automated test suites on boards with legacy devicetree
nodes.

Should dev_dbg() or dev_info() be used here instead to match the stated
developer-only intent?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924150222.1179=
235-1-elder@riscstar.com?part=3D4
