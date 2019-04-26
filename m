Return-Path: <SRS0=ROz5=S4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B787C43219
	for <linux-pci@archiver.kernel.org>; Fri, 26 Apr 2019 15:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F790208CB
	for <linux-pci@archiver.kernel.org>; Fri, 26 Apr 2019 15:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JeFknnAT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfDZPcZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:32:25 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51265 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfDZPcY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Apr 2019 11:32:24 -0400
Received: by mail-wm1-f66.google.com with SMTP id 4so4342571wmf.1;
        Fri, 26 Apr 2019 08:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I4MGBuWRGmxPPAJ6mB/3KWSAA/+b7SFqqRwTPeUtz98=;
        b=JeFknnATAzCHq5Fb0a4EgZcpY3ciCKfyny4/qF5QNe5HZ0T5fgZbUB2g2qDHwc6QYa
         GLIRR1G3suFmTXLFk7MA7VgUoeYCP8VOqXMNg7EsonzrQ6JxPifwuPn49w+cifaXOUoI
         7b1HIblomLhdWdOnIh92dLGbk+PNvWwPXjJFbma+1mqHpTUZEl70B44ppcJEoIPWgbqD
         8eSXIZclZlldISDrhZF27e6CDgheLtNAC4/nWvyWB20MJq8SdePu7V/m1+oGsHinZRXe
         BKiajMmJPqr5E40yDlEs5aYKARdyqE/zdN/52ixhJDn8GxasAxvfZpHG5TIEUJx8e5JC
         Yd1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I4MGBuWRGmxPPAJ6mB/3KWSAA/+b7SFqqRwTPeUtz98=;
        b=ulAhPI4rde8Tn/irRKge3a/Xl+hduH+gznZ/sdEKZkFCYCudzDFphCWffSmjjW0N/K
         Kt5CjCHSvBLb+XbsaUcR/fqhgtXVFRxdAq1GkqcBEenS5LzRDlxUEqCn0T9Yexf/16+R
         6vz5UkphIEbA60Cf6NGeZUc3lPoSMkF0mzaGk+7J4gBK6ZQvpf3qNJYriQABEozXuZ7W
         ODd7MXDRisAuAn6ZjAbZNlUBKrU51CCcgxS1dPsJTtXzCI/ERye6i+06MBoFR6ykHNbr
         jxYxVTb7uNiRICO6z+VNIGDTs1vtT35iUCJ6PdNQpXS4G9HTJ+YqURtuUC4QGjA5YxeO
         WVKg==
X-Gm-Message-State: APjAAAUQsxiNCYp4BWL9ShPhufv1h8HasCrOx9H96ewht28GZv0awkHE
        jU+Ib0KRJTwcUoM8JjWDXSwB4MrrjAk=
X-Google-Smtp-Source: APXvYqxMs1UTiN0e/sd4qGVc0vl6Rq9Wj9HEZnj2NGpFzKhGnt06ssZfN4dmM7opLJPwnybgfQN7Kw==
X-Received: by 2002:a05:600c:2199:: with SMTP id e25mr8473099wme.36.1556292741866;
        Fri, 26 Apr 2019 08:32:21 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id u17sm18195380wmj.1.2019.04.26.08.32.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 08:32:20 -0700 (PDT)
Date:   Fri, 26 Apr 2019 17:32:19 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V2 18/28] PCI: tegra: Program AFI_CACHE* registers only
 for Tegra20
Message-ID: <20190426153219.GE19559@ulmo>
References: <20190423092825.759-1-mmaddireddy@nvidia.com>
 <20190423092825.759-19-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="maH1Gajj2nflutpK"
Content-Disposition: inline
In-Reply-To: <20190423092825.759-19-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--maH1Gajj2nflutpK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2019 at 02:58:15PM +0530, Manikanta Maddireddy wrote:
> Cacheable upstream transactions are supported in Tegra20 and Tegra186 onl=
y.
> AFI_CACHE* registers are available in Tegra20 to support cacheable upstre=
am
> transactions. In Tegra186, AFI_AXCACHE register is defined instead of
> AFI_CACHE* to be in line with its MSS design. Therefore, program AFI_CACH=
E*
> registers only for Tegra20.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V2: Used soc variable for comparision instead of compatible string.
>=20
>  drivers/pci/controller/pci-tegra.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/=
pci-tegra.c
> index f74930654443..9b841b0392ac 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -323,6 +323,7 @@ struct tegra_pcie_soc {
>  	bool program_deskew_time;
>  	bool raw_violation_fixup;
>  	bool update_fc_timer;
> +	bool has_cache_bars;
>  	struct {
>  		struct {
>  			u32 rp_ectl_2_r1;
> @@ -932,11 +933,13 @@ static void tegra_pcie_setup_translations(struct te=
gra_pcie *pcie)
>  	afi_writel(pcie, 0, AFI_AXI_BAR5_SZ);
>  	afi_writel(pcie, 0, AFI_FPCI_BAR5);
> =20
> -	/* map all upstream transactions as uncached */
> -	afi_writel(pcie, 0, AFI_CACHE_BAR0_ST);
> -	afi_writel(pcie, 0, AFI_CACHE_BAR0_SZ);
> -	afi_writel(pcie, 0, AFI_CACHE_BAR1_ST);
> -	afi_writel(pcie, 0, AFI_CACHE_BAR1_SZ);
> +	if (pcie->soc->has_cache_bars) {
> +		/* map all upstream transactions as uncached */
> +		afi_writel(pcie, 0, AFI_CACHE_BAR0_ST);
> +		afi_writel(pcie, 0, AFI_CACHE_BAR0_SZ);
> +		afi_writel(pcie, 0, AFI_CACHE_BAR1_ST);
> +		afi_writel(pcie, 0, AFI_CACHE_BAR1_SZ);
> +	}
> =20
>  	/* MSI translations are setup only when needed */
>  	afi_writel(pcie, 0, AFI_MSI_FPCI_BAR_ST);

You need to squash the below into this patch. If I do that, then
TrimSlice works again.

Thierry

--- >8 ---
diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pc=
i-tegra.c
index 7071fd026a80..fc61074f6886 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -2530,6 +2530,7 @@ static const struct tegra_pcie_soc tegra20_pcie =3D {
  .program_deskew_time =3D false,
  .raw_violation_fixup =3D false,
  .update_fc_timer =3D false,
+ .has_cache_bars =3D true,
  .ectl.enable =3D false,
 };

@@ -2558,6 +2559,7 @@ static const struct tegra_pcie_soc tegra30_pcie =3D {
  .program_deskew_time =3D false,
  .raw_violation_fixup =3D false,
  .update_fc_timer =3D false,
+ .has_cache_bars =3D false,
  .ectl.enable =3D false,
 };

@@ -2581,6 +2583,7 @@ static const struct tegra_pcie_soc tegra124_pcie =3D {
  .program_deskew_time =3D false,
  .raw_violation_fixup =3D true,
  .update_fc_timer =3D false,
+ .has_cache_bars =3D false,
  .ectl.enable =3D false,
 };

@@ -2604,6 +2607,7 @@ static const struct tegra_pcie_soc tegra210_pcie =3D {
  .program_deskew_time =3D true,
  .raw_violation_fixup =3D false,
  .update_fc_timer =3D true,
+ .has_cache_bars =3D false,
  .ectl =3D {
   .regs =3D {
    .rp_ectl_2_r1 =3D 0x0000000f,
@@ -2645,6 +2649,7 @@ static const struct tegra_pcie_soc tegra186_pcie =3D {
  .program_deskew_time =3D false,
  .raw_violation_fixup =3D false,
  .update_fc_timer =3D false,
+ .has_cache_bars =3D false,
  .ectl.enable =3D false,
 };


--maH1Gajj2nflutpK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzDJIMACgkQ3SOs138+
s6FRyw//ZS6UBzIotFfM5JANKOTd3CpkJIsA24iH8V+oRwOgvAwHptuXe3PUtzkp
YyoJLo7vOoA7uH6LTotob3X2rxs4pYO5q5tF41BugoOBbFEi3jkBz/zMlOKLN19i
G0/LS31A7zGquz860WUfhYHw1cmTgWSO4C7Ne/k1UPx9iuiR5xQb+Pywh0XDaFqL
oPk1tAXF6G6mlCLeEwPYDnG3hod1tgbx33izsn9zRPIbkSnawm5F4ifHtZUzziLs
e2g73cr/r/N5HvfLY5yc+pPws7mDp5W2CpjdKV5kT2JGFUhNNBmIKtVviOuw2bCZ
1F698005VzYoQS893xmerqZ12TlA7CojorheBBMqAG6AZok2/pms2oEVa8AX6WOi
XCkPQKQ75ixfZN2t1rIvJMXPWaLdVjYs854SzuUgMz2DPZwPHVtPQVTcdTsRLYgZ
s15FF0LG2UeEF2cHbJTpHOrY6/di3qWW3pbji6ok1unfG7EeVR8rF/AF9knkmppI
9mVOahmluHIBp2+X91zoRPDU2UkaZqaglSPswn81oEj0W50A/urZT/19Na08/hRP
Ori0588ZUahasBORmpBjCcd3ci17SefF/RItNX7xlds15vPaYTamWJ9uBP03/Rgd
t9XC+syol/1BQ2BY2uaUdd5UJbyX73A9Szlgn36Cztwz5LGrZRw=
=7P50
-----END PGP SIGNATURE-----

--maH1Gajj2nflutpK--
