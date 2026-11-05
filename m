Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793881394;
	b=cm+LG2MgguF7O/r93Y57MvVK5eugsFB0xt4Aa0qaSrEkoyxQnUpaOFEukxoDBptqSCgG
	 dvl14Dp5c6OmsDRuioR+Hlinev04UI//6XYRc5ynJBCXrQr2GXNRLgXH2Hp7w8TOOxq+2
	 UV1LEGdrrVmlWyfDZLAvmoj8NIx6K0QoTi8wvroTbAAS4tEI81xDkSfzzsq0DezuspxYV
	 CfuQLCKootLPzGi1RSvgQwtOf+MN4wdtfuG3OEUGaHYfq4YZsxOdxNT9CU8BI2kzSkV1+
	 mU4+uRYC1I8n4+3tq1R4BMWQEFEzviO78VW6rh3lXn/p6eyEfrNBPLAmKhxyy8AKk+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793881394;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=AaiS4Lhu3Gc12pXmISRStNRQ98+XBetbUVdlh6qdn2I=;
	b=RhUMNZg60X6VRMBC0+nqgJtVnUgSw0Oaq0uRVY79tNQLYAldGCwyT+sBZHWVVjH+hnud
	 XgzUnMqxuVEj4bRusH5PGxIeYuZ9WRojRplZqgXm5pR7xl1YrH+59Idyj+h+m/zaGRgWA
	 3JRZaWjlia7+RvQ7Kkiae7bKBMe7+gyR7ydJjF/0WA9vYS2xn7ftveVH5Tse/m4VxwZqd
	 fodcOdUF5EZJn+YrTwAAknQhfADfbjvrhNNwoLIAcUeixgmh3jy+wRoP0hV3lYz0oVQwL
	 GlmvSZDPUNdiZLlfMGBEvlfcThrZdHvAzr7Zsrn31NyxmO3S0ZI0mfWb4XLmZj3g9Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R+XDdZWS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92DE606A326;
	Thu,  5 Nov 2026 12:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R+XDdZWS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9491F000C1;
	Thu,  5 Nov 2026 12:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793881393;
	bh=AaiS4Lhu3Gc12pXmISRStNRQ98+XBetbUVdlh6qdn2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R+XDdZWSeB01xzdwaOgG3108M/kGN83vSH7Ry40EEjvC+GKicYKAkwW91XAjvSZlk
	 5JRslvcVNnIEyl4Sf/XtbNmRvI4d69Q5qDhBHjg/2vTsFaymBRcJFR5OF3xbb7wZK+
	 kc0ZYIpS7oV+iUImBLR9NtioBe8scemTIB9mjZSAM9O9QbuRdhCA6zApbGmdp0n5F6
	 m7yIXTuCvBc8xDRn20AgNvPT/UNwy79JvGCGiu21CXpXI/PKBUQ5dn1A4a+2YO7W6I
	 U09+FKgesD61ti7ug40xWZtrAH6Ke0YY8I2+FCY4Y6ZVpYWaSYyA2trPArpkSxvWZs
	 FteFHx6FP0IeA==
Date: Thu, 5 Nov 2026 13:23:10 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Enrique =?utf-8?Q?Hern=C3=A1ndez?= Bello <ehbello@gmail.com>
Cc: shawn.lin@rock-chips.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, mani@kernel.org, bhelgaas@google.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de, dlemoal@kernel.org, 
	iav@iav.lv, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: PCI: rockchip,rk3399-pcie: Add
 PERST# inactive delay properties
Message-ID: <20261105-exuberant-finch-of-domination-3fbd6c@quoll>
References: <20261104215848.2087944-1-ehbello@gmail.com>
 <20261104215848.2087944-2-ehbello@gmail.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20261104215848.2087944-2-ehbello@gmail.com>

On Wed, Nov 04, 2026 at 09:58:46PM +0000, Enrique Hern=C3=A1ndez Bello wrot=
e:
> The driver holds PERST# asserted for T_PVPERL (100 ms) before releasing i=
t.
> Endpoints disagree about what they want there: some need longer than the
> default to settle, while others stop answering configuration reads when t=
he
> reset pulse is stretched that far, because PERST# stays asserted for the
> whole wait.
>=20
> Describe two properties so a board can state what its endpoint needs, nam=
ed
> after the ones the Rockchip vendor driver already uses for the dwc-based
> controllers:

Vendor driver does not matter, it is antipattern. Do not mention it here
as reason to do such change.

>=20
>   rockchip,perst-inactive-ms      - the delay used at probe
>   rockchip,s2r-perst-inactive-ms  - the delay used when resuming

No need to repeat the diff.

>=20
> Both are optional and the defaults preserve the current behaviour.
>=20
> Signed-off-by: Enrique Hern=C3=A1ndez Bello <ehbello@gmail.com>
> ---
>  .../bindings/pci/rockchip,rk3399-pcie.yaml        | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie.y=
aml b/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie.yaml
> index 720a5f9..7ac915c 100644
> --- a/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie.yaml
> @@ -40,6 +40,21 @@ properties:
>      maxItems: 1
>      description: pre-reset GPIO
> =20
> +  rockchip,perst-inactive-ms:
> +    default: 100
> +    description:
> +      Time PERST# is held asserted before it is released, which is also =
the
> +      width of the reset pulse. The default meets T_PVPERL for a slot th=
at
> +      is powered at the moment PERST# is asserted. Some endpoints need m=
ore
> +      settling time than that, while others stop responding when the pul=
se
> +      is that long. A value of 0 selects the 100 us minimum the PCI Expr=
ess

us or ms?

> +      CEM specification sets for the pulse.

What is the nature of this timing? 100 ms is a lot. Are you sure you are
not describing RC delay (we have bindings for that already)

Best regards,
Krzysztof

