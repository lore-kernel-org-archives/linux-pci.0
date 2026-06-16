Received: from mail1.manjaro.org (mail1.manjaro.org [142.132.176.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72E5318EDA;
	Tue, 16 Jun 2026 19:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.176.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781636903; cv=none; b=JaSPbprJIzAckuTKwpkZnNraqK4ZB7TRRlLRiIWuAhwax5VstUsnwVh1QLvkuJXNG7kvSQRftalHzyKFn8NhV8AOuDoclSKrEG0XBDvtpqdhmpxEjhL55cDWlBzCrIXHXsDVy1ABg3yNa65rUi5moXZdgXbaHxRjbWlPAMaO3N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781636903; c=relaxed/simple;
	bh=sfCvBp6L/d2V6c1hUc/fQXjYnb9t+lNrsac2wdud6D4=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=tW52zEvF4mAyYfvCWoPfQzqme2p58wEVIjFCreSQdfYTtFN927eUAaakwtbk8SMw5SC9ZaDJJOFxDY7YAssc4+uLC+4wSOtJCHtVSgw9bjg1GLygwqJksw4Eumtwu35LpCnLdrDafm53cGyApc/7CiHybVXzKrB285VkYaMBzmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=q/Xlcshg; arc=none smtp.client-ip=142.132.176.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="q/Xlcshg"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPA id D5997427AE;
	Tue, 16 Jun 2026 21:08:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=dkim;
	t=1781636899; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=7/iTjePusMfrSdj7g6pBjEhl+rxxuYxnDgZt7OwEz8Q=;
	b=q/XlcshgZ5d7bmbC6Av+0R7gz3PiYxIhj/Sxd1nbzT0iv2OOQOO4ZD5KEBJvFZookuTsGm
	3kZ++ozB5rnSQVv0I8dzvJfGMCMpWLuIe7EWGTluCxoQUgLNcjFwKHCH5y7BFbRb9SwiDE
	E+CEaipOAYnVRiD4Ycdb0uHEYovqA4fjAgcW6SRw7HIlq7wyh7klELU0n2m3c8YugPu4PR
	09LPAKrv/sZ1c19NzNIOJqkaXTBtHK2U/nNAwtd8G+ul6R4vPUZBC6pJ53VwmWbLvWFkDE
	/c2vsDYK8j3Cc6Rl+Dh3+LbzLIDBYwulikomP0A6IoU+/PnfuNQ6FfkD1OqJqQ==
From: "Dragan Simic" <dsimic@manjaro.org>
In-Reply-To: <68f6353e3a2ea4914de36c42b6906e41282adad3.1781622998.git.geraldogabriel@gmail.com>
Content-Type: text/plain; charset="utf-8"
References: <cover.1781622998.git.geraldogabriel@gmail.com> <68f6353e3a2ea4914de36c42b6906e41282adad3.1781622998.git.geraldogabriel@gmail.com>
Date: Tue, 16 Jun 2026 21:08:17 +0200
Cc: "Shawn Lin" <shawn.lin@rock-chips.com>, linux-rockchip@lists.infradead.org, "Lorenzo Pieralisi" <lpieralisi@kernel.org>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Manivannan Sadhasivam" <mani@kernel.org>, "Rob Herring" <robh@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To: "Geraldo Nascimento" <geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <583cf740-1687-2c0c-71d0-b3f8425c17ce@manjaro.org>
Subject: =?utf-8?q?Re=3A?= [PATCH v7 2/3] =?utf-8?q?PCI=3A?=
 =?utf-8?q?_rockchip-host=3A?= do not attempt =?utf-8?q?5=2E0?= GT/s 
 retraining
User-Agent: SOGoMail 5.12.3
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: None

Hello Geraldo,

Thanks for the v6 and v7 of this series.


On Tuesday, June 16, 2026 17:25 CEST, Geraldo Nascimento <geraldogabrie=
l@gmail.com> wrote:
> Drop the 5.0 GT/s Link Speed retraining from Rockchip PCIe Root
> Complex Mode Operation, so called host driver.
>=20
> The reason is that Shawn Lin from Rockchip has reiterated that there
> may be danger of "catastrophic failure" in using their PCIe with
> 5.0GT/s speeds.
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
>  drivers/pci/controller/pcie-rockchip-host.c | 20 -------------------=
-
>  1 file changed, 20 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pc=
i/controller/pcie-rockchip-host.c
> index ee1822ca01db3..1374a2c92b563 100644
> --- a/drivers/pci/controller/pcie-rockchip-host.c
> +++ b/drivers/pci/controller/pcie-rockchip-host.c
> @@ -328,26 +328,6 @@ static int rockchip=5Fpcie=5Fhost=5Finit=5Fport(=
struct rockchip=5Fpcie *rockchip)
>  		goto err=5Fpower=5Foff=5Fphy;
>  	}
> =20
> -	if (rockchip->link=5Fgen =3D=3D 2) {
> -		/*
> -		 * Enable retrain for gen2. This should be configured only after
> -		 * gen1 finished.
> -		 */
> -		status =3D rockchip=5Fpcie=5Fread(rockchip, PCIE=5FRC=5FCONFIG=5FC=
R + PCI=5FEXP=5FLNKCTL2);
> -		status &=3D ~PCI=5FEXP=5FLNKCTL2=5FTLS;
> -		status |=3D PCI=5FEXP=5FLNKCTL2=5FTLS=5F5=5F0GT;
> -		rockchip=5Fpcie=5Fwrite(rockchip, status, PCIE=5FRC=5FCONFIG=5FCR =
+ PCI=5FEXP=5FLNKCTL2);
> -		status =3D rockchip=5Fpcie=5Fread(rockchip, PCIE=5FRC=5FCONFIG=5FC=
R + PCI=5FEXP=5FLNKCTL);
> -		status |=3D PCI=5FEXP=5FLNKCTL=5FRL;
> -		rockchip=5Fpcie=5Fwrite(rockchip, status, PCIE=5FRC=5FCONFIG=5FCR =
+ PCI=5FEXP=5FLNKCTL);
> -
> -		err =3D readl=5Fpoll=5Ftimeout(rockchip->apb=5Fbase + PCIE=5FCORE=5F=
CTRL,
> -					 status, PCIE=5FLINK=5FIS=5FGEN2(status), 20,
> -					 500 * USEC=5FPER=5FMSEC);
> -		if (err)
> -			dev=5Fdbg(dev, "PCIe link training gen2 timeout, fall back to gen=
1!\n");
> -	}
> -
>  	/* Check the final link width from negotiated lane counter from MGM=
T */
>  	status =3D rockchip=5Fpcie=5Fread(rockchip, PCIE=5FCORE=5FCTRL);
>  	status =3D 0x1 << ((status & PCIE=5FCORE=5FPL=5FCONF=5FLANE=5FMASK)=
 >>

Looking good to me, so please feel free to include

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

