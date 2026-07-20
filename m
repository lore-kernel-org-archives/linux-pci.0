Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D433A28CF5D;
	Mon, 20 Jul 2026 02:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784513939; cv=none; b=eg7Qc6iXJU6WVhXA/5T10G8yU4dC0sgL39uRO9TKfI7UOq8h8ya0Rce/86nn3edbYEX8VvjtDhDBwVbXvIDg55V2GFei5X17FpFpzl18LpVyHIvwyVEiYWhR9JGzf8nhhU2SmYeEgMGQdtFJX+jTeNvMF5o6MvzUNLktNYHRM1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784513939; c=relaxed/simple;
	bh=Ck6yGmwo3w3lBtH8uDQYvfnS3jJuxBJH3ULAfbzP/qA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=te0MgfeB8+Zxq8h7MipKt8aeftLjz9J2p68rz8XWenzDeB5wTsKfnCznPNSAPXaYZDOfI7TlR3aD5/QGrTt8xKF4ZIoXPVRwpRrmS9wp9P4C/hMNf7izX3FA/kBs1dAnlTW84/07J37RHKDVSs4ze3bP1ljepU78WIEJSFIuxr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3fKiIvL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3fKiIvL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21EB61F000E9;
	Mon, 20 Jul 2026 02:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784513937;
	bh=Ck6yGmwo3w3lBtH8uDQYvfnS3jJuxBJH3ULAfbzP/qA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E3fKiIvLEFgAfEVefNkNr29LGQmz76j0lVzQI2fVwZevoytxG5j21HF+EAeRjPkiD
	 fxh/PnogrgVAcAW+2BYrm7L8WiKZ8wALHSu4ViWiZOoi0OpV7w/WT66kjw780V+Srw
	 v57NH4z5FHmKrZic3EmFDnVEDZsiW7vG2O6Iw8Sc1qFpFsUkdk2W4wAjhK6zmISJlj
	 u6GukRbTzeIzQ2qRvaglwDh73Tz2Owe8eMigKhY/VEWXdpzIg8fbzkHzyyosmAMrj9
	 1xIj6lEM2ow1IBrc++NMX8CvUL8jEW1gAhLI+nkgHmzFMQ3l2dHCTOO6Rj8Dx9/Cay
	 lVyUZ1HeYHTvQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: PCI: rcar-gen4-pci-host: Add R-Car
 X5H PCIe4 compatible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marek Vasut" <marek.vasut+renesas@mailbox.org>
Cc: wsa+renesas@sang-engineering.com, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260720020505.315335-2-marek.vasut+renesas@mailbox.org>
References: <20260720020505.315335-1-marek.vasut+renesas@mailbox.org>
 <20260720020505.315335-2-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 02:18:56 +0000
Message-Id: <20260720021857.21EB61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Document bindings for R-Car X5H (R8A78000) PCIe4 host module.
>=20
> The binding document is deliberately using "renesas,rcar-gen5-pcie4"
> DT compatible string to discern R-Car X5H PCIe4 controller supported
> by this binding, from R-Car X5H PCIe6 controller which will use a
> separate binding.
>=20
> The R-Car X5H PCIe4 controller does no longer include PHY register
> range, the PHY is now a separate IP and referenced via the 'phy' DT
> property. The 'reg' and 'reg-names' DT properties therefore differ
> between R-Car Gen4 PCIe and R-Car X5H PCIe4, and the difference is
> handled in the allOf section.
>=20
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720020505.3153=
35-1-marek.vasut+renesas@mailbox.org?part=3D1

