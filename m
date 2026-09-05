Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E5930567F;
	Sat,  5 Sep 2026 21:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788644033; cv=none; b=KBgQkxxWCVLA77L+4kd0yM1qlbO+CCEy52HPISF9I5rwfAxgfnOcPHiawYK7hlX+KAnNYOm+PrwrYRTF8hxPtEucm1QfGKkOzNZOXZDqRoRneuY46WkoB1sMJHxkSVMiLKgonBuxgxOD0EsW/r9Q5yTkE2JJ/Zeo8Z5KbCgNNOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788644033; c=relaxed/simple;
	bh=bLQyKpVfUwkwmCuMH76hmo8LygiWBuv13+7nPEODNZg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h2zbN7JGyiMxC6ePhRfuUHMFlsoo47W6x19kHJU+rQxWX26QSLRRW6+qzc6S24BRfoaIphM+jqNqBHtfxHVD4N5cBw8s3FJfrPOg8EUWOCIk8H+qkjMSGcIOjsIg8C3Vhxvb1plVV2ru1S+M2bICshF6XJe0oFNQRImMKTTs9ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RtdueHP7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtdueHP7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F37D1F00A3A;
	Sat,  5 Sep 2026 21:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788644032;
	bh=bLQyKpVfUwkwmCuMH76hmo8LygiWBuv13+7nPEODNZg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RtdueHP7dixPeCZuL5C3Dlfs0JiMWbGgzq+lhCXPO6qXVWYIHJImHkvzho/T+43Gs
	 nIMY6IpIFmFV0MmC2yqOyb0vS0bWXhK9kLGpyTDEwjQ962o72a6lv7p2PIV/i5Ndg5
	 xViGDi9rtCQj1ZD7Td4F2vidHfXDgXO20j1j0TapnRCBCPGTSpgEQp4BgDH4FRLQHb
	 8j3EWbOHbjzdTNyJ6oIiF1x62MWaAzCt4c2VYGVVwm69nT8DCMoAjvSZSrwDtFb62i
	 2c2MQPJpRq23eJH1IAE3F1+uDPLI8Djc+nIN1+2ADqV1dT+2ui0PuGrNKczd6OFadG
	 z4Ao8U7r+hxHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/6] PCI: dwc: rcar-gen4: Rework
 rcar_gen4_pcie_drvdata .additional_common_init into .init
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marek Vasut" <marek.vasut+renesas@mailbox.org>
Cc: wsa+renesas@sang-engineering.com, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260905212649.360498-3-marek.vasut+renesas@mailbox.org>
References: <20260905212649.360498-1-marek.vasut+renesas@mailbox.org>
 <20260905212649.360498-3-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 21:33:51 +0000
Message-Id: <20260905213352.2F37D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Rework the current complicated initialization callchain that invokes
> host_init->common_init->additional_common_init() for host and
> ep_init->common_init->additional_common_init() for endpoint into
> simpler host_init->init() and ep_init->init() .
>=20
> The init callback is now always implmented for all R-Car Gen4 SoCs,
> therefore there is no need to check whether the callback is not NULL.
> For R-Car S4 the .init callback is rcar_gen4_pcie_common_init(),
> for R-Car V4H and V4M the .init callback is implemented using a
> new function rcar_gen4_v4h_v4m_pcie_init() which calls the common
> rcar_gen4_pcie_common_init() followed by R-Car V4H and V4M specific
> hardware initialization. The hardware initialization sequence remains
> unchanged.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905212649.3604=
98-1-marek.vasut+renesas@mailbox.org?part=3D2

