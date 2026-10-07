Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E3A4766A5
	for <linux-pci@vger.kernel.org>; Wed,  7 Oct 2026 13:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791379373; cv=none; b=RIwu9IwFR7Dqa3/UWF0KLmroYjb+jFnk+tXoWWAGCCELOdp3zGzRuxXriKwuF5HLAyJCWiLQLcZN2E9Dw/63mkHJVwnawAcQ0Nr3YwDE+/qQ/aPYpZh3dH3armvh9XohDbZDUVF22aJiCuyBl/QWBQ5Kx0GaCMr0K7W8p3cmFYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791379373; c=relaxed/simple;
	bh=HRmyLoDJk+xLrAP9w/RUJ3eYW2U6Zk7FEuR6F04Yoy8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=px73hfs9b1xzpiNoDJdG6vwsaGmnrLCkTSxHMJEThf2d81j8BnHuUSmkvtY+dkfJSSgQO6xNY6krPWiVIAzreuQaiy1iayn0zeQq2U8xRhs9pG16XgxVIWcWj2OVlBEmP5zqL/1s9eJCTOtbKBM2bkW6xk1od7+eQwlmE8jI718=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WE8OUeua; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WE8OUeua"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCBDF1F0089B;
	Wed,  7 Oct 2026 13:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791379355;
	bh=SjRjBBi48l5txjvR4gOWfw5JXP/fktzN9C9sDMchAfQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WE8OUeua3zBJG+Lr1BakodtwvtQcvIi8GnZ67NR6IqPA9Z/gDEWd4h4BXw9CzfHjV
	 645MELl/mjcQ/6O5xEpRaF0Ud6U5mS1PfV89hvNG2o7CUIE8lSl/4/KUJxS5JYYCYd
	 L4XZsZrChtqBCCCY4OolPeIcn5iDwF3EHwnnrSgN6d51H1Aht0ilTiyThMkShXBqdi
	 Kpf+WptW3+ZusHqLxyjCv0ZYyWOydSLhsUmGIwOtX+qRd7tlMRZHPQuFJNPbH2j40r
	 KCKfL+/raJsyFUwBQ1gwpjDquxEXLUBuIvrNDpXNS8ICGpVyMf0IaEf4Sck+gn4u6T
	 pYe6omAB7dUJQ==
Message-ID: <sashiko-outbox-163037@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Set supported_speeds in set_pcie_port_type()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stian Halseth" <stian@itx.no>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261007131304.309511-1-stian@itx.no>
References: <20261007131304.309511-1-stian@itx.no>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 13:22:34 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> sparc64 and powerpc create PCI devices from the device tree in
> of_create_pci_dev(), which calls set_pcie_port_type() but not
> pci_setup_device(). Since d2bd39c0456b, supported_speeds is only set in
> pci_setup_device(), so it stays 0 for these devices.
> pcie_get_speed_cap() then returns PCI_SPEED_UNKNOWN, max_link_speed
> reads "Unknown", and the failed link retraining quirk passes
> PCI_SPEED_UNKNOWN to pcie_set_target_speed(), which warns on a SPARC
> T7-1:
>=20
>   WARNING: drivers/pci/pcie/bwctrl.c:125 at pcie_set_target_speed+0x284/0=
x2e0
>=20
> Set supported_speeds in set_pcie_port_type(), which all three paths
> call.
>=20
> Fixes: d2bd39c0456b ("PCI: Store all PCIe Supported Link Speeds")
> Closes: https://github.com/sparclinux/issues/issues/109
> Signed-off-by: Stian Halseth <stian@itx.no>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007131304.3095=
11-1-stian@itx.no?part=3D1

