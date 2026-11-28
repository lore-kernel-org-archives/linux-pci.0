Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795860337;
	b=YIcnUIEHdxjloUDP6BXCUR5hnr9UhCT41KjqOjBvOUpBZ61bzePueFfXufJj+Xv4BpLo
	 VAjvPKmlnRJxv+XF0qbLcgzZQYsGAQQKgW5V91m7+9e1LQjQVuanTpUSiLppmg9Jjmzez
	 m8/3qT5mLNrpnn9Jd238hTtSeZ7d6kzE7iqENMYUnQgAMxAxny8icZK0mq1tI9QEw5Ykr
	 YBfvpMjNzUSjMN5FWwp7lDarGN6hRho0zq3rqoP4WwZNILv+7vwSHb8Q8gl2aH7DWCa0S
	 kprVPiI383H7w5BLnUcTQF0arj7wO3Ig6zHucQxGbSLDlKRr1XcC3ELNxjhLrsp8bIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795860337;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9w5PclelKfVmUJafutjcKw+jTDY6Jg40PncxFjeX0Yc=;
	b=kIKYw1PLHcbULuB51dscxEQ+8wS3BQxaUn0q8OUAJ//4ENfBaOD7E4gu9QIG+plEsb0f
	 4Apb1x+KD0vYI38lW25lbfcZXtvLWKOZYciOOXz5ROsp9xOvSOVajzzHp8D0WPGKU0g+V
	 X1R7jIZgt4o9gea1jkwzwgeaHguJGmIkTjyJhyuy1JzCwoSWdpH3j1lf+MenBiyfTS4xk
	 xzcPa4oqoQdKJLZLab1CTEpuN57PWTxa3GqhmOxnAT09HKIy8+OfhPXfxh6d9iTP8HlC/
	 bhQad++S8SNYzLXUJT2KI2w7ChQ19vYLUMXRI99NYWLdH7seZ5U0pijNbyzRTD7a7+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gOm3Q16o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B11606A31C
	for <linux-pci@vger.kernel.org>; Sat, 28 Nov 2026 10:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gOm3Q16o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575FA1F00898;
	Sat, 28 Nov 2026 10:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795860337;
	bh=9w5PclelKfVmUJafutjcKw+jTDY6Jg40PncxFjeX0Yc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gOm3Q16oL41o1A6Yrs9s3cAeJKFSjO1OHCk3FXoKTzCOClZrKiArXQRmLgRKa8Vzt
	 3yPJDrZg/G7fE1Iir2d0F9rxLWnlshecKpK3I76m+WuShBZDSWF87vmnC1A7fDyzuF
	 6DAhL8z2cqpJICX1dU6pbjTQxKE+ESCE2vl+uZt5vtJq8L7IrE++jmj9ayUVxBAdvR
	 Z8SRZjKk335c80fdq2Ixa5EJqIPJv9p6Fnh3T+w8zG7C1AfnlBGfmzWtX+JQ8WadHZ
	 N5Qu/FiAeMIWPyXRBgSHH/hfT6Bdfv/M1slXDBgaIMqZiq77VX9M8vZymV9NW0rL/d
	 rw6AlX7ySWDFg==
Message-ID: <sashiko-outbox-238619@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: dra7xx: Remove the IRQ domain with the root port
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guangshuo Li" <liguangshuo@mail.sdu.edu.cn>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261128-f81b700d6c-u40-0@mail.sdu.edu.cn>
References: <20261128-f81b700d6c-u40-0@mail.sdu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Nov 2026 10:05:36 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] PCI: dra7xx: missing link stop and EPC deinit in
  dra7xx_pcie_deinit()
--

commit d00611bbb3d39d9987ab2f13aa6f0204c6621bbb
Author: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>

PCI: dra7xx: Remove the IRQ domain with the root port

This commit moves the INTx IRQ domain and chained handler setup into the
root port host init callback and removes them in a matching host deinit
callback, while also adding a platform driver remove callback.

> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/contro=
ller/dwc/pci-dra7xx.c
> index 0d56fd5a19ea0..0264cd4fbe8d4 100644
> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c

[ ... ]

> @@ -671,6 +670,14 @@ static int dra7xx_pcie_configure_two_lane(struct dev=
ice *dev,
>  	return 0;
>  }
> =20
> +static void dra7xx_pcie_deinit(struct dra7xx_pcie *dra7xx)
> +{
> +	if (dra7xx->pci->mode =3D=3D DW_PCIE_RC_TYPE)
> +		dw_pcie_host_deinit(&dra7xx->pci->pp);
> +	else
> +		dw_pcie_ep_deinit(&dra7xx->pci->ep);
> +}

[Severity: Medium]
In the endpoint branch, should dra7xx_pcie_deinit() also call
dw_pcie_stop_link() and pci_epc_deinit_notify() before
dw_pcie_ep_deinit()?

Unlike dw_pcie_host_deinit(), dw_pcie_ep_deinit() does not stop the link
or notify bound endpoint functions of deinitialization (to pair with
pci_epc_init_notify() in dra7xx_add_pcie_ep()).  When
dra7xx_pcie_remove() then disables runtime PM and the PHYs, LTSSM_EN can
remain active and epc->init_complete stays true, causing a later EPF
unbind to access unclocked DBI registers.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261128-f81b700d6c=
-u40-0@mail.sdu.edu.cn?part=3D1
