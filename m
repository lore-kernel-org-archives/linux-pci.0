Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA694ABBCC;
	Mon, 28 Sep 2026 11:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.3.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790595943; cv=none; b=SkxrcOpOGo5OxbNkeOnqwPOTSX8yRGKSvyvbQxgXKdoCwojNooVCQ828Onb3675vN42OBekjozxg4NqTNRLtGMQ3J1jd2ohGgDKZ3JO4JY+4uS63+yjODxdohD47fbOWZ0Rf/RMuF6UHshYIqA8OTghoafL1340XXoH9udbLPEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790595943; c=relaxed/simple;
	bh=e+52jJ9jaL3CmNOBgW6VBGnbc1ROvbMtnuuxRgQ5TcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GQXc6D+J4e2+AKVs83Ik4lXawyVsZGODsY1yY+UxYthI91wtgvhgCg44JbmnJFtmb/zql6a6DPLc33NZyuIMn3QHB1yk7PrwiZJi1R64AJOwd+ZuJ3bxtveVtp61wFXo/RU8HQy07pwIrcuuh1CPgbrHehzoaJlRuoV6jqldOTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=l05XfVCO; arc=none smtp.client-ip=188.40.3.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="l05XfVCO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=ew.tq-group.com; s=default2602; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=z2vdG/ru8rw1Y5ayEWt8P3IH0H9UUvdg+EVu0ifmHCE=; b=l05XfVCOFvsk9DdwzUCAsnavXx
	PJO1n1k0F9xm4SEFbbmjUhhQK63SKyApZsdpzEY5RB+fpBBNxTJwzqESP6kTSv5J6N66COgaDQcfZ
	o0vlA5aRL2RjNSwftywHozraCEogY9FOGiCmHQPbXjrbk9P73Qb+mHtufFr9AaJyUtvVcvVuPl+oF
	QCL4awUXjwwGTDj8p4pR78dQo8TTXtkgvNaFRnNGezTpeQTJSftzaaE4mbq6mGC2fq9L1xID+ApWD
	amIGNKryYAeC+JWIMu68jQ/jx1AqpLDyEYf8vsE+VRZpZqeabfFmHLR35EJOperLZyUQEOk2RJl91
	HnYeO3hQ==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <alexander.stein@ew.tq-group.com>)
	id 1xB9ne-000M8U-33;
	Mon, 28 Sep 2026 13:45:39 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <alexander.stein@ew.tq-group.com>)
	id 1xB9nd-0007Qc-1D;
	Mon, 28 Sep 2026 13:45:38 +0200
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof =?utf-8?B?V2lsY3p5xYRza2k=?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: imx6: Use dev_err_probe
Date: Mon, 28 Sep 2026 13:45:36 +0200
Message-ID: <3441664.44csPzL39Z@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20260619112535.1127850-1-alexander.stein@ew.tq-group.com>
References: <20260619112535.1127850-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Virus-Scanned: Clear (ClamAV 1.4.3/28137/Mon Sep 28 08:24:12 2026)

Hi,

Am Freitag, 19. Juni 2026, 13:25:33 CEST schrieb Alexander Stein:
> pci_pwrctrl_power_on_devices() might return -EPROBE_DEFER resulting in
> an error message. Use dev_err_probe to silence this non-error message.
>=20
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Is there anything missing after receiving Frank's r-b?

Thanks and best regards
Alexander

> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controll=
er/dwc/pci-imx6.c
> index 98e1db751132a..b7a502e9a1c59 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1381,7 +1381,7 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
> =20
>  	ret =3D pci_pwrctrl_power_on_devices(dev);
>  	if (ret) {
> -		dev_err(dev, "failed to power on pwrctrl devices\n");
> +		dev_err_probe(dev, ret, "failed to power on pwrctrl devices\n");
>  		goto err_pwrctrl_destroy;
>  	}
> =20
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


