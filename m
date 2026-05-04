Received: from mail-oi1-f225.google.com (mail-oi1-f225.google.com [209.85.167.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750433DE43C
	for <linux-pci@vger.kernel.org>; Mon,  4 May 2026 15:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777908609; cv=none; b=mvL+Vp7u8uE7HyK5cBDDQ/81mOkw+IfmZ0gvOGA6UglbhRFGkGvJJZ1pa9MDEMGLpLlS6emiQyx94ypM0YL3T328O05484wwTlXGHfqa18Le2QK6R1ahJIhDAJ5QCFR+blcB6Ndw3Sg9xWQrK6O+vhePzWSnfK5RWZ1i4/PkjiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777908609; c=relaxed/simple;
	bh=0qohyuiP+DPmUBppqn3cpGbod6J8Lh7dWX7+XuzExKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WihMoiaJrg2qBQkoxsRzEK7/++NQUBuYNlkSYRnYVZkE4kcPhJaoyy5JhvLT1wsOvmf/qSigmCp3bfmKTon2gE/gr3BmugvNIO6Sr/sgMu7898TA8/i1TiKy4RI2ZOw0tfE/MOT4MMytQvqJ52lE3hCsbvxKTLYE7QkmhpXlHw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Vo41WBIt; arc=none smtp.client-ip=209.85.167.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Vo41WBIt"
Received: by mail-oi1-f225.google.com with SMTP id 5614622812f47-479d85152c9so1413738b6e.2
        for <linux-pci@vger.kernel.org>; Mon, 04 May 2026 08:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777908606; x=1778513406;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hJSeNXAMFi5H2eJOjdROuJb8G84v8F7tHqaU+U6vWeA=;
        b=LprP3wjZgoHK/8YEKVuhWRBZb8jOADTqkEqI9i23SmaTPAhL/6zv1uD65s788J9c3a
         +cXseY62K1t3vLga/psxdBYv8XcvSvhsMxl0d8uOKxNTSfGbt3j6AYJJcydpjo3DYi6e
         Y7URnwtswraIOLR17Y7f0ipDKGRLR4yQqxVpQ/VQUuJIPxO11IvtMfwkknXM5wyxWfEN
         dtuQvXx3gPyiNovNMLlnqQpkCLrPiWzbkBJms/WPUR5qXnr/05kJGOGRDmzE0yAHzgEg
         Awcq/QxtpVvWh8/PGPvM7ak6zAf0LZMuTo9AXRDKQrgFg0yza86iW/jKDBOik2KqeAoO
         PbDw==
X-Forwarded-Encrypted: i=1; AFNElJ/JAT7G3goiVyW44hrD7rjuinjv8OrlXXfg8ZlcxwLOdmPi2vhB9OiZbTl8MVpNKdQF/9NklaeD1Uo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrYH1V0Zd2llYdMlkPWBaA8zHKlZlYysRldn9exl98x205qGES
	VsRdTMfVFawL5ALPmSPTOjrH21LYsUX+B2QEK8/+8126VLFxTD9UOLFWFA4F+cduUsKLEni3/P1
	dv6/rdRZ4VltkqN4vvAiKJPws7G08+11siSlE5Y5kkash0u8wSWiaqIzUxZ3wfBhJgkLoFwutgC
	UtkRLB/qEQGSSOy+8bXkyUd4DeGN/ZqpJVntP+xRTVo8teNOckRJVIsrK33HjN/oWU7aOZ8Ra0N
	0OZIU0LeVw=
X-Gm-Gg: AeBDietNQl7OHWx9eWdoBW69dgKiV05JXb192xkERnqRk/QkcYmsWRX0aulH2YBrvnd
	WDXg6+dAWyrvwUK93n+u8lD8icO75s4WdeD64Em0G5/QsvD5+nHemYOvKYz+Sat8CYRz6i1OIOy
	wlPYFr+secJTNVUb/JovLdH+p7gvS6t3RylWsZu5y6ivAQaxeD3Bz4NDzJSCh7j9qlKGCei6PT9
	5O8kP6ZWhSQ+GBzPyS6Vx+iOmNgkztIFBpk5pxMrI4WarposqZQCyr1ry2b/f95ksUhAW29gIdz
	alWHHm0ZSTxfnkpUT4bJCN3Pgv2JYbh2eR1TKTXHwjFX1mqRJieCM+oTLUyhJ33VufNMXW6dhdq
	L5jUBgNSvz3rxdTWedxIIz1KavktPciOLZoOyRzUv8hRDtFL4U/xkbddXYNEtlbyr2h++5yIgSX
	kiHDrY8mqC
X-Received: by 2002:a05:6808:170a:b0:47c:3c56:c96c with SMTP id 5614622812f47-47c892c9f56mr5023614b6e.39.1777908606240;
        Mon, 04 May 2026 08:30:06 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-434548b595asm925664fac.2.2026.05.04.08.30.05
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2026 08:30:06 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-671656523efso4105209a12.2
        for <linux-pci@vger.kernel.org>; Mon, 04 May 2026 08:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1777908602; x=1778513402; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hJSeNXAMFi5H2eJOjdROuJb8G84v8F7tHqaU+U6vWeA=;
        b=Vo41WBIt+XCpPQhZdmIwfWPFpHe/jMXJjrvIIplGr6bGptTcKHd0pDdCzle5Ff52IP
         qj94zin8XRqSuhvSqrssUJPfGi1AnqUpdE4OYZ1x2ujHEfUVC1vVoCrrV1hLSozBS59n
         aVHMo4b2MXeIRKej3Dc+941pvysKjs919AQEI=
X-Forwarded-Encrypted: i=1; AFNElJ+pTEo4hUdWq9MpG06TsjMk9ud+uDW/zl9hx5jd3GV4a6bRTTnW2GyDQZawSTQFXOnC7NNzN9ko+TY=@vger.kernel.org
X-Received: by 2002:a05:6402:14d2:b0:678:8f3e:2bbc with SMTP id 4fb4d7f45d1cf-67c19d18453mr3545408a12.9.1777908602324;
        Mon, 04 May 2026 08:30:02 -0700 (PDT)
X-Received: by 2002:a05:6402:14d2:b0:678:8f3e:2bbc with SMTP id
 4fb4d7f45d1cf-67c19d18453mr3545380a12.9.1777908601747; Mon, 04 May 2026
 08:30:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430021628.1343154-1-mark.tomlinson@alliedtelesis.co.nz>
In-Reply-To: <20260430021628.1343154-1-mark.tomlinson@alliedtelesis.co.nz>
From: Ray Jui <ray.jui@broadcom.com>
Date: Mon, 4 May 2026 08:29:47 -0700
X-Gm-Features: AVHnY4IZVBVWjMpgEUdrwkzJr8zC0ryOJqfMFnmPzBfXliEmzHLaU67t6k-Xujo
Message-ID: <CAJ8Y1dT2w4snELKXAgjAs__DjdzFVPDQ2U8YTmfZUpunmh=a+w@mail.gmail.com>
Subject: Re: [PATCH] PCI: iproc: Restore map_irq
To: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Cc: rjui@broadcom.com, sbranden@broadcom.com, lpieralisi@kernel.org, 
	robh@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000b61b690650ff9a89"

--000000000000b61b690650ff9a89
Content-Type: multipart/alternative; boundary="000000000000a69e870650ff9a65"

--000000000000a69e870650ff9a65
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 7:16=E2=80=AFPM Mark Tomlinson <
mark.tomlinson@alliedtelesis.co.nz> wrote:

> Some time back, the PCI bridge map_irq and swizzle_irq were set up with
> default functions. The iproc PCIe driver was broken by this change, with
> the mapping function ending up being set to NULL. Restore the original
> (and intended) behaviour to use the default functions.
>
> The iproc pcie kept the mapping function in a private data structure,
> which was then copied into the pci_host_bridge structure. As the private
> data was initialised to NULL, the NULL would end up being copied. The
> fix is not to keep the mapping function in the private data, but just
> set the function pointer directly when needed.
>
> Fixes: b64aa11eb2dd ("PCI: Set bridge map_irq and swizzle_irq to default
> functions")
> Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
> ---
>  drivers/pci/controller/pcie-iproc-bcma.c     | 2 +-
>  drivers/pci/controller/pcie-iproc-platform.c | 2 +-
>  drivers/pci/controller/pcie-iproc.c          | 1 -
>  drivers/pci/controller/pcie-iproc.h          | 2 --
>  4 files changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-iproc-bcma.c
> b/drivers/pci/controller/pcie-iproc-bcma.c
> index 99a99900444d..593418c2bc3a 100644
> --- a/drivers/pci/controller/pcie-iproc-bcma.c
> +++ b/drivers/pci/controller/pcie-iproc-bcma.c
> @@ -64,7 +64,7 @@ static int iproc_bcma_pcie_probe(struct bcma_device
> *bdev)
>         if (ret)
>                 return ret;
>
> -       pcie->map_irq =3D iproc_bcma_pcie_map_irq;
> +       bridge->map_irq =3D iproc_bcma_pcie_map_irq;
>
>         bcma_set_drvdata(bdev, pcie);
>
> diff --git a/drivers/pci/controller/pcie-iproc-platform.c
> b/drivers/pci/controller/pcie-iproc-platform.c
> index 0cb78c583c7e..4c9a0c4bb923 100644
> --- a/drivers/pci/controller/pcie-iproc-platform.c
> +++ b/drivers/pci/controller/pcie-iproc-platform.c
> @@ -98,7 +98,7 @@ static int iproc_pltfm_pcie_probe(struct platform_devic=
e
> *pdev)
>         switch (pcie->type) {
>         case IPROC_PCIE_PAXC:
>         case IPROC_PCIE_PAXC_V2:
> -               pcie->map_irq =3D NULL;
> +               bridge->map_irq =3D NULL;
>                 break;
>         default:
>                 break;
> diff --git a/drivers/pci/controller/pcie-iproc.c
> b/drivers/pci/controller/pcie-iproc.c
> index ccf71993ea35..c22d0aecaaac 100644
> --- a/drivers/pci/controller/pcie-iproc.c
> +++ b/drivers/pci/controller/pcie-iproc.c
> @@ -1502,7 +1502,6 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struc=
t
> list_head *res)
>
>         host->ops =3D &iproc_pcie_ops;
>         host->sysdata =3D pcie;
> -       host->map_irq =3D pcie->map_irq;
>
>         ret =3D pci_host_probe(host);
>         if (ret < 0) {
> diff --git a/drivers/pci/controller/pcie-iproc.h
> b/drivers/pci/controller/pcie-iproc.h
> index 969ded03b8c2..c4443f236ca3 100644
> --- a/drivers/pci/controller/pcie-iproc.h
> +++ b/drivers/pci/controller/pcie-iproc.h
> @@ -61,7 +61,6 @@ struct iproc_msi;
>   * @base_addr: PCIe host controller register base physical address
>   * @mem: host bridge memory window resource
>   * @phy: optional PHY device that controls the Serdes
> - * @map_irq: function callback to map interrupts
>   * @ep_is_internal: indicates an internal emulated endpoint device is
> connected
>   * @iproc_cfg_read: indicates the iProc config read function should be
> used
>   * @rej_unconfig_pf: indicates the root complex needs to detect and reje=
ct
> @@ -91,7 +90,6 @@ struct iproc_pcie {
>         phys_addr_t base_addr;
>         struct resource mem;
>         struct phy *phy;
> -       int (*map_irq)(const struct pci_dev *, u8, u8);
>         bool ep_is_internal;
>         bool iproc_cfg_read;
>         bool rej_unconfig_pf;
> --
> 2.54.0
>
>
Thanks for the fix.

Acked-by: Ray Jui <ray.jui@broadcom.com>

--000000000000a69e870650ff9a65
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Apr 29,=
 2026 at 7:16=E2=80=AFPM Mark Tomlinson &lt;<a href=3D"mailto:mark.tomlinso=
n@alliedtelesis.co.nz">mark.tomlinson@alliedtelesis.co.nz</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">Some time back, th=
e PCI bridge map_irq and swizzle_irq were set up with<br>
default functions. The iproc PCIe driver was broken by this change, with<br=
>
the mapping function ending up being set to NULL. Restore the original<br>
(and intended) behaviour to use the default functions.<br>
<br>
The iproc pcie kept the mapping function in a private data structure,<br>
which was then copied into the pci_host_bridge structure. As the private<br=
>
data was initialised to NULL, the NULL would end up being copied. The<br>
fix is not to keep the mapping function in the private data, but just<br>
set the function pointer directly when needed.<br>
<br>
Fixes: b64aa11eb2dd (&quot;PCI: Set bridge map_irq and swizzle_irq to defau=
lt functions&quot;)<br>
Signed-off-by: Mark Tomlinson &lt;<a href=3D"mailto:mark.tomlinson@alliedte=
lesis.co.nz" target=3D"_blank">mark.tomlinson@alliedtelesis.co.nz</a>&gt;<b=
r>
---<br>
=C2=A0drivers/pci/controller/pcie-iproc-bcma.c=C2=A0 =C2=A0 =C2=A0| 2 +-<br=
>
=C2=A0drivers/pci/controller/pcie-iproc-platform.c | 2 +-<br>
=C2=A0drivers/pci/controller/pcie-iproc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 | 1 -<br>
=C2=A0drivers/pci/controller/pcie-iproc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 | 2 --<br>
=C2=A04 files changed, 2 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/drivers/pci/controller/pcie-iproc-bcma.c b/drivers/pci/control=
ler/pcie-iproc-bcma.c<br>
index 99a99900444d..593418c2bc3a 100644<br>
--- a/drivers/pci/controller/pcie-iproc-bcma.c<br>
+++ b/drivers/pci/controller/pcie-iproc-bcma.c<br>
@@ -64,7 +64,7 @@ static int iproc_bcma_pcie_probe(struct bcma_device *bdev=
)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0pcie-&gt;map_irq =3D iproc_bcma_pcie_map_irq;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0bridge-&gt;map_irq =3D iproc_bcma_pcie_map_irq;=
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bcma_set_drvdata(bdev, pcie);<br>
<br>
diff --git a/drivers/pci/controller/pcie-iproc-platform.c b/drivers/pci/con=
troller/pcie-iproc-platform.c<br>
index 0cb78c583c7e..4c9a0c4bb923 100644<br>
--- a/drivers/pci/controller/pcie-iproc-platform.c<br>
+++ b/drivers/pci/controller/pcie-iproc-platform.c<br>
@@ -98,7 +98,7 @@ static int iproc_pltfm_pcie_probe(struct platform_device =
*pdev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (pcie-&gt;type) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPROC_PCIE_PAXC:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPROC_PCIE_PAXC_V2:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pcie-&gt;map_irq =
=3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bridge-&gt;map_irq =
=3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/p=
cie-iproc.c<br>
index ccf71993ea35..c22d0aecaaac 100644<br>
--- a/drivers/pci/controller/pcie-iproc.c<br>
+++ b/drivers/pci/controller/pcie-iproc.c<br>
@@ -1502,7 +1502,6 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct =
list_head *res)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 host-&gt;ops =3D &amp;iproc_pcie_ops;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 host-&gt;sysdata =3D pcie;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0host-&gt;map_irq =3D pcie-&gt;map_irq;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D pci_host_probe(host);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0) {<br>
diff --git a/drivers/pci/controller/pcie-iproc.h b/drivers/pci/controller/p=
cie-iproc.h<br>
index 969ded03b8c2..c4443f236ca3 100644<br>
--- a/drivers/pci/controller/pcie-iproc.h<br>
+++ b/drivers/pci/controller/pcie-iproc.h<br>
@@ -61,7 +61,6 @@ struct iproc_msi;<br>
=C2=A0 * @base_addr: PCIe host controller register base physical address<br=
>
=C2=A0 * @mem: host bridge memory window resource<br>
=C2=A0 * @phy: optional PHY device that controls the Serdes<br>
- * @map_irq: function callback to map interrupts<br>
=C2=A0 * @ep_is_internal: indicates an internal emulated endpoint device is=
 connected<br>
=C2=A0 * @iproc_cfg_read: indicates the iProc config read function should b=
e used<br>
=C2=A0 * @rej_unconfig_pf: indicates the root complex needs to detect and r=
eject<br>
@@ -91,7 +90,6 @@ struct iproc_pcie {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 phys_addr_t base_addr;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct resource mem;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct phy *phy;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int (*map_irq)(const struct pci_dev *, u8, u8);=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool ep_is_internal;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool iproc_cfg_read;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool rej_unconfig_pf;<br>
-- <br>
2.54.0<br>
<br></blockquote><div><br></div><div>Thanks for the fix.<br><br>Acked-by: R=
ay Jui &lt;<a href=3D"mailto:ray.jui@broadcom.com">ray.jui@broadcom.com</a>=
&gt;=C2=A0</div></div></div>

--000000000000a69e870650ff9a65--

--000000000000b61b690650ff9a89
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
Kea1UXiDNimY9XcISXAUrVauS3TPqfSofCP4tOVkOfR2zFsciCJ7DPbmanfMXAR2cY6kCgkZCqxY
9Szy6beT2XZUSE9/jFymRSjXZNnLqAe30YCaVeVQUqW9X3NqlPdzO9Ce8AqKdgBlVt4isO6s3zJ5
djaWSUM3zrweXgaVpSRF3iBUxK45Nb0qOkvz0hrBYM2r+iLWR2YbF+Z7W7lw2QMvkbeT1gXn+4pC
K8f1aWKsB9e6Id7uBOkCAwEAAaOCAdgwggHUMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAA
MIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEFBQcwAYYtaHR0cDovL29j
c3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1UdIAReMFwwCQYHZ4EMAQUD
AzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5n
bG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAyhjBodHRwOi8vY3JsLmds
b2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwHwYDVR0RBBgwFoEUcmF5Lmp1aUBi
cm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQwHwYDVR0jBBgwFoAUACk2nlx6ug+vLVAt
26AjhRiwoJIwHQYDVR0OBBYEFLfOZFpVhKW7s+LOyKdJX5PQH0f8MA0GCSqGSIb3DQEBCwUAA4IC
AQB5Y3tHNG503cqE6g1lZJG3Z1SbuQD8ZXUbYqDNZCnUAd/+zUCraK7TYIOI83X+oof/CscTxVhf
5mazzhESPjHYlC3TLkkxDHQZi06GwKbI00651REpC78vd9dOdZnKnGjpFeDiwJKNxdarSaYiZi/t
6cZD3FIvDaJwYIQ+8HvZOm7FBicC41sMoaxGWZ/tdC6yRoLFckWRvhq0e7wyaBOH2ae8l30V6NXB
RtJd4XemoNk74ybCcGMro0zyBCzQhREo2slK5r/uflroC607XCCIGjLuB6TptSxV97L/9/QSrE2U
4JteFGVwRBJw1s7k8ICf4s22debUZ+OlB0mXjI+8EUDt6vdMeregn5ilQQSsDmBMnz2GzHfV30tb
X92uoE5xui1g4Q3BWkUVwd9wVHaganr3rzc+lQDnQq5cddu1supu3SWp5FqKq36rtf3RX/3zHZ0C
P2pCAlilDHYH2NRF8CYb+gqFySS/PUxwPmFWuD897Hewokex+ux0oZscsuRe0IttCbYfjl/+tSA0
a6Rd+AmkiyASFgEHsLGl6q2OTPYU1PikjUe5RXTp0UC7bdPQXzxaORlh/KWilnz/kV2XblDdybuc
Qz3eVIGvTANnIqPpz94oImrgHX48hMGiH5gGNznLwDBoQl4ZSfvlSi01TcUsYlHJD3LRZWbsh4VG
PDGCAlcwggJTAgEBMGIwUjELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2Ex
KDAmBgNVBAMTH0dsb2JhbFNpZ24gR0NDIFI2IFNNSU1FIENBIDIwMjMCDCsjlIbQJoxUU3h/cTAN
BglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgXJfu4E99nQtweeIT+ASIdNEGPUH/H1D+
TFRVgit+EOswGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjYwNTA0
MTUzMDAyWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZI
AWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEB
BQAEggEADdBxdd9/hBQJzdZW6zJs3VuUb2dzty5mv5RsaDWRjSp/cVJ7beRBfiJbhCP7PL9Ib5Wt
f7www+Fu41jqsclL0ZBaIOn58FppsnVDaR+OHvgh7WCegm4AS46AW8jgivmKGxZ8JxL8cMpkn5Jr
FGjqdCKvYhV4SK5IdwGyHC5Rk7F0tvXvjI2eT0GfZ6C9HCU0x/MdhqCDODB/oeCHIQa+ryXTH11G
Q319epAqjPILZ1BMKOL32knQOFog21TIENYulQX33QPCZVvCmMm98FHTjUAyovu/kmGkCVYqut4c
6m8sfChRlnkBhEtnhGBnW6WZjwt8S1p8yjidFD84lkO+7w==
--000000000000b61b690650ff9a89--
