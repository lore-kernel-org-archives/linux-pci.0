Received: from mail1.manjaro.org (mail1.manjaro.org [142.132.176.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F067435292A;
	Tue, 16 Jun 2026 19:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.176.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781637165; cv=none; b=OdRbMRWeAvTjrpj/+0xoCXKe34PHwbWOoCifmMwNrtz40P5QUetC424lmKdB1E7hbl2Gy/b+AxUH3alrfXlw0GQQXDzDWmVJqUEfE2mysw2NObLO1yvynIpXGWkhUOFL6moqomntSxeZBaNgeJC2ZTK+Q5u2VAFi14dLOgPKlrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781637165; c=relaxed/simple;
	bh=M6w5Yl58jg9dH7KHfJj1FBLvGV77xvI1OpZWU+uVcaE=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=Ad1ugFjUArO8mSx1X5zZDCP0TOD5oZ8u0+N0RTYTrBULUEBkaBR4FklPnqylvBHM+NPKE0PnIpwevyOKnaGMuCWbzQnSARG6Pwuv7ttKelrpcQbafVB1NqfTGNW0iGil+I3GlHL+0cf8ulloD8uccjUaN3t7515Jld+r8TcLd1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=H0W94XPl; arc=none smtp.client-ip=142.132.176.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="H0W94XPl"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPA id 14A5440F83;
	Tue, 16 Jun 2026 21:06:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=dkim;
	t=1781636817; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=rWbzq0uUdK4mFc78V/pvFY8rAJ0udBH3buweyPX5lrI=;
	b=H0W94XPl48hsbbXQ2SyO03bHTFLcwPP9aM8P635mYQvR3IyOnoypWLdfbsVfBP4qCKYEjs
	da8VEHALEE5FH4gCG8QlB3eUUd+bRYXY/wL8OfJFWFcp3xF1SQejESbkasoPR66waonOYo
	W7rA8txp6zhNe5wTG6mpzEHxGt5XRRkUe+EmFCP1XWPopHJaMxrYUBCtAmJyHDTPCF5BJm
	MXvcuYAFOJhBwHB4p0npZ+BN+pcEItu4UDfKfUFPOu1nnRZqxDxuSpEKcgcyY2/YbZz7jE
	nfssXJgS2Gefr+T5upBSyUdC6nnzrHecmNBXIHgRhj+vr8yIIbui1Q9xFAEZ7A==
From: "Dragan Simic" <dsimic@manjaro.org>
In-Reply-To: <d994f8fb3481bbb8f3972f117334a6e8aea383fb.1781622998.git.geraldogabriel@gmail.com>
Content-Type: text/plain; charset="utf-8"
References: <cover.1781622998.git.geraldogabriel@gmail.com> <d994f8fb3481bbb8f3972f117334a6e8aea383fb.1781622998.git.geraldogabriel@gmail.com>
Date: Tue, 16 Jun 2026 21:06:53 +0200
Cc: "Shawn Lin" <shawn.lin@rock-chips.com>, linux-rockchip@lists.infradead.org, "Lorenzo Pieralisi" <lpieralisi@kernel.org>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Manivannan Sadhasivam" <mani@kernel.org>, "Rob Herring" <robh@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To: "Geraldo Nascimento" <geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <ee80e2c7-8327-0000-5986-e909f0a41df1@manjaro.org>
Subject: =?utf-8?q?Re=3A?= [PATCH v7 1/3] =?utf-8?q?PCI=3A?=
 =?utf-8?q?_rockchip-ep=3A?= do not attempt =?utf-8?q?5=2E0?= GT/s 
 retraining
User-Agent: SOGoMail 5.12.3
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: None

Hello Geraldo,

Thanks for the v6 and v7 of this series.

On Tuesday, June 16, 2026 17:25 CEST, Geraldo Nascimento <geraldogabrie=
l@gmail.com> wrote:
> Drop the 5.0 GT/s Link Speed retraining code block from Rockchip PCIe
> EP driver. The reason is that Shawn Lin from Rockchip has reiterated
> that there may be danger of "catastrophic failure" in using their PCI=
e
> with 5.0 GT/s speeds.
>=20
> While Rockchip has done so informally without issuing a proper errata=
,
> and the particulars are thus unknown, this may cause data loss or
> worse.
>=20
> This change is corroborated by RK3399 official datasheet [1], which
> states maximum link speed for this platform is 2.5 GT/s.
>=20
> [1] https://opensource.rock-chips.com/images/d/d7/Rockchip=5FRK3399=5F=
Datasheet=5FV2.1-20200323.pdf
>=20
> Link: https://lore.kernel.org/all/ffd05070-9879-4468-94e3-b88968b4c21=
b@rock-chips.com/
> Cc: stable@vger.kernel.org
> Reported-by: Dragan Simic <dsimic@manjaro.org>
> Reported-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
> ---
>  drivers/pci/controller/pcie-rockchip-ep.c | 13 -------------
>  1 file changed, 13 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/=
controller/pcie-rockchip-ep.c
> index 799461335762e..9ebc227a1ef84 100644
> --- a/drivers/pci/controller/pcie-rockchip-ep.c
> +++ b/drivers/pci/controller/pcie-rockchip-ep.c
> @@ -553,19 +553,6 @@ static void rockchip=5Fpcie=5Fep=5Flink=5Ftraini=
ng(struct work=5Fstruct *work)
>  	if (ret)
>  		goto again;
> =20
> -	/*
> -	 * Check the current speed: if gen2 speed was requested and we are =
not
> -	 * at gen2 speed yet, retrain again for gen2.
> -	 */
> -	val =3D rockchip=5Fpcie=5Fread(rockchip, PCIE=5FCORE=5FCTRL);
> -	if (!PCIE=5FLINK=5FIS=5FGEN2(val) && rockchip->link=5Fgen =3D=3D 2)=
 {
> -		/* Enable retrain for gen2 */
> -		rockchip=5Fpcie=5Fep=5Fretrain=5Flink(rockchip);
> -		readl=5Fpoll=5Ftimeout(rockchip->apb=5Fbase + PCIE=5FCORE=5FCTRL,
> -				   val, PCIE=5FLINK=5FIS=5FGEN2(val), 50,
> -				   LINK=5FTRAIN=5FTIMEOUT);
> -	}
> -
>  	/* Check again that the link is up */
>  	if (!rockchip=5Fpcie=5Fep=5Flink=5Fup(rockchip))
>  		goto again;

Looking good to me, so please feel free to include

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

