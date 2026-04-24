Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD419339875;
	Fri, 24 Apr 2026 17:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777050383; cv=none; b=hM4GqrJQOciDG+l6MsWqfYrPYOBMU5j3j+rrDG30tXVDzpVNAMKR9odZjQKpSl1Fx/XODR+cxvEXo0WEiuvcf8oKmbje6vGC3cCmW9oNNff8Ta5R4Exf6Kad4ZqcGlYaFS7jDQClx0fC2RgvFzLteS3W8d01N8yW5QYfF4GJQQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777050383; c=relaxed/simple;
	bh=xCE79Wvi8Mkp+ZGDctaw2DzfjgrYbScCrXQDDCMokJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FEGOkgyGta+JcJykrFhwJx4E38qTRG8QctMceRlqeilK+Sc8K1o75FxN+izyoSk/0fghJP0ppg3Nw3QVSdQAPG26AIU6CGSt2Yg+n/1N0Lv1yLSxjcjSoEuWPoCu9JBCZpkxBvRWwwMwCqJc2Q4J7UBjh2GfZxJmmvDgD8W32f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=soS8YKrq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="soS8YKrq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36EAFC2BCB2;
	Fri, 24 Apr 2026 17:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777050383;
	bh=xCE79Wvi8Mkp+ZGDctaw2DzfjgrYbScCrXQDDCMokJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=soS8YKrqJfBO4XBWAY/r3mngcqtyBkbOm8Ya3Dw6bovRKTuOlbOKpmFdFqTA4EhkC
	 Q2hn+QQD8fqQwASYJb94Fkf8BPk2sYBXuPW0Vj/3xVdAs1OUii1XE/NRBRHAkPWUMK
	 moriP1FVBiXjoiD8txVJ3H1nnoUharRuugzbvcdOSIBlPiPfyFZRWp1U3r0N1OEZe6
	 7LnXlI3tyzqrRLYC6aY36nGLdPOFsn2McuvsBW+ahjgMbgsB4Yu8J5LyeU6ixWMcEe
	 RiEij5Wajx0XvZE5elE8qSGz7+cJIXmaAL9fuOGkP0bWGFw0d30q6I5ONPPBh09vS0
	 johWnH51n3CAw==
Date: Fri, 24 Apr 2026 18:06:18 +0100
From: Conor Dooley <conor@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	bhelgaas@google.com, frank.li@nxp.com, l.stach@pengutronix.de,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] dt-bindings: PCI: imx6q-pcie: Add intr, aer and
 pme interrupts
Message-ID: <20260424-sinless-unfiled-d1087a894da5@spud>
References: <20260424025735.1490772-1-hongxing.zhu@nxp.com>
 <20260424025735.1490772-2-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="H0L8i4gwKKUpxCZw"
Content-Disposition: inline
In-Reply-To: <20260424025735.1490772-2-hongxing.zhu@nxp.com>


--H0L8i4gwKKUpxCZw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 10:57:33AM +0800, Richard Zhu wrote:
> Add optional 'intr', 'aer', and 'pme' interrupt entries to the i.MX6Q
> PCIe binding to support PCIe event-based interrupts for general
> controller events, Advanced Error Reporting, and Power Management Events
> respectively.
>=20
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---

This binding supports lots of devices. Do they all have these additional
interrupts?

>  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/=
Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> index 9d1349855b422..badc7fcbd556c 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> @@ -58,12 +58,18 @@ properties:
>      items:
>        - description: builtin MSI controller.
>        - description: builtin DMA controller.
> +      - description: PCIe event interrupt.
> +      - description: builtin AER SPI standalone interrupter line.
> +      - description: builtin PME SPI standalone interrupter line.
> =20
>    interrupt-names:
>      minItems: 1
>      items:
>        - const: msi
>        - const: dma
> +      - const: intr
> +      - const: aer
> +      - const: pme
> =20
>    reset-gpio:
>      description: Should specify the GPIO for controlling the PCI bus dev=
ice
> --=20
> 2.37.1
>=20

--H0L8i4gwKKUpxCZw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaeujCQAKCRB4tDGHoIJi
0sbBAP9Y8BcAd/MDAAh/RMkRDbsa5ilgaKCx0jwcHj/+rWm2twD+N71s+zgqihzj
hrfWyfc3pLzNgNi0wFP5B7kAHGteAg8=
=fyjc
-----END PGP SIGNATURE-----

--H0L8i4gwKKUpxCZw--
