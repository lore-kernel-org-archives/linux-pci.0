Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0B944AB88
	for <linux-pci@vger.kernel.org>; Mon,  7 Sep 2026 10:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788776616; cv=pass; b=n1C/Z4gUQPVbgXmnO9uCuV0nn1s0M0dk9cGDzA83VN3XUB2jM4Kgm/AWRdkpPjhAeaoDgqOLKFcBPg/1T9F/qRxNZbzOuXvXOLMNsBPuKmyFjrHyFLZsYWeUhf9PZ7wbr215fgS0Pb1Dluq1cWwKk52ojxpY6eMJcekCcq+nUn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788776616; c=relaxed/simple;
	bh=yC+o3g+oHjdn9HHHsFJRYCeY6o9z2MeGqDdEyGkihsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p0aXldo21JGPMgL6L3ppNOAAoGpE5TBLMqZd3OIZnGJAmgAJs53CqrSmth/JEZSlZO5ZSJ/gQne7mfAVxiSaVnBBoa0COq2iacEGwJkVpYyNEfWmB8k+s9OaARKeMl60dK4F9DsXJYgkCHADVaisaMUl/XQfeSnH0EEk7QGMzmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UycKmJFH; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UycKmJFH"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4843e397f74so4293980f8f.1
        for <linux-pci@vger.kernel.org>; Mon, 07 Sep 2026 03:23:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788776612; cv=none;
        d=google.com; s=arc-20260327;
        b=b7E9ymFhmu+zseTfJhmmxhveOPWfa2KSlnY+P5X/ZQYx9ZGNroD33m1YjzAkrxFdtu
         dQQFpUjtLVoHrwRdmvOknZc3A8JkWF6pLsXTq7kO/XM1n1VLdGRW0GkShQabElcfDftv
         gYwoCeCYcLpEI3CzhaFUxZQ17j2how/SuqOdGhsVywGR+twS4D24UTZ/WTxliudLBr4D
         uT/7EHzR+pOPPGd5twVaDYw0R8amAq0p731hOwBXdDkOmq3cEGPAdKou6gK75CfVnx14
         F/ifp5iP+z743lYK9MQNfWYK6JTDfXuVDU3+WFkzcS8tFK0nS+P2yvwiQfcixyxE/Tlm
         dJ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=99rrNQK9PYDQWtqeDcI+v8dFCF97V9GRd5/NAE170tM=;
        fh=RhPBoG7xbhSQ6/7j6AHHfCAHE7M+wAiwDTEdT2fYNog=;
        b=rNH3b/4i4fH6LLYaHOMCO0GoJ+KsqrgRYbkd67t4qZR+ANuOUnjvvoys9Xi7hkgFWs
         Lc527XbKcwjxyKLt0qhueJdn/tVE7r8Wp9wm+xnD9yiQ/C0hp3vrqVQ+cHY9bkFvDVrb
         nf6Bxyu+CkPtJ70pXIGMBZnAvIR79Cadov5UV6aa0iuZ41cL5yUPUdapAVuhcNhu6hL+
         fTiqefiDktHmKErFE12GR7NpBJ7cxOPsFE/cN3iy0tL1eH/Hp7xU/ScQwGBnJzmA/Q4K
         YKB7ArgW7gMu4UqJyrw9GjG89avrTka/AelYycGVUgIWPanr85BUPHeZuFRkYRLJJOSq
         NFwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788776612; x=1789381412; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=99rrNQK9PYDQWtqeDcI+v8dFCF97V9GRd5/NAE170tM=;
        b=UycKmJFHwb1nUPNveAhgLUzk0YyIDU4d0eAncrjDxOlKGOap2CshkUNXpn7ZjhEAeH
         k2HJlp6/180oGEYNynjScuLHI/PQYEIFnZWY8F4jqEcqZQSnOZ4u4QF5F9wtbMXBmoIM
         YnN/QeiDmwuX7SEwmf06V9KOAeq9Y0dVRBMW+w6fvNTQoTom2act+P1fyuX+v0VDm4YS
         ebjkIo6gPTWORFJPcxNITJDMrQniGz/MRGhYrRTxGlpFVrNx7iQljJQ2Te8/KO32fy1t
         apTWdOGMC5dO3nq8UAoaHxFGt4eyzvIjoInjlC+Ras8vpk19rfVYfu6dJMmwcFjuE7v0
         kCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788776612; x=1789381412;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=99rrNQK9PYDQWtqeDcI+v8dFCF97V9GRd5/NAE170tM=;
        b=FnIVWvtIG+qh8nPzMFqOCd3QDBdYZyXJn958cQR4JFyA9ja10P0GFWenCigs8f06yz
         c5AY8md3r+VaF3FsmlcEpFk9GQnOFbDQaeQBshuHoho8lF7z4lUCUahwL7TT/7QRrExK
         RJxIY2IFus+uUPxsFwh2tEeOtK4ONSIYFi81V4EfAefDU+oalLeYfJjVZZ93CFgkRL0J
         g3KluuyGorYi/39CLGs1OTxiEkx4KXygyUV5W5ay1iWDb8hc2OsYnbMNMhXtRJQsj42h
         FXlCDNq5KtxroEgnldhSSWjt2zkCGPl4KF2DQR9XSe4cOHVMRz8rU/nAGkukGd8ilmuX
         nS/A==
X-Forwarded-Encrypted: i=1; AKwUvBxi2woqZHXCNshbDIz1XW21ptfiLpincknvdelcvm+j/R+ubbcpVTUVjHgABFWDN6ViKe8ynBULtZY=@vger.kernel.org
X-Gm-Message-State: AFuF++kb78IZ5vAPpUB/N9VBtpLkatqI0vCl0ojiZ6yNeU29uB5wC5IB
	o7Oi1eMipHcvoN6haOaF7v7BdtYdnW28k1scpPC4gG3dfILiwSvw6QjKiJzncwyLmFyWGXZolW1
	gVoCUM1wiqD5biNo7Nn1C9txU2+WMTCo=
X-Gm-Gg: AYBFou1CTGePNqgq47xi5ZWV3d/SEx5721sXiUcjymALZ9AlKbCs7cakmHKbjZAVvXl
	k9CjacAR4IG5pGzphYfi4eXas6l45MJ/kcl2nXBQLUGM74VpgwacG2iewUn+ftd2wRKo3bCZo5N
	QupfXz2i+OOw16MmY9A8Bg04mxZZVyqSLkpsjf+VD4IQlAOBPmRm10Q3Xie1IPb0tRrmJA2avId
	8CoYQ1QuutzGUItTymXlnmMdLPhUD/R90FGtbjIQLjSaHmdnAYHEaiaqy27GEzffh42WyKwmOXi
	V97AX/o5fqLu924meBSdq5DFjs0rBFhie0TXeAONrFlNKo7/ntgguRrPgLjGP5J60zSFn0+6wuY
	DDkY=
X-Received: by 2002:adf:edc8:0:b0:482:e658:7a39 with SMTP id
 ffacd0b85a97d-4857e5171femr24476358f8f.11.1788776611775; Mon, 07 Sep 2026
 03:23:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260905134251.67210-1-hppiscas@163.com> <apwrUYd3VybxbAm7@nickhuang>
 <wg57x6u3fomukerbnfbmmxywoljyrlqlctytfnqdlhl74jvigg@t3aygzlhtpui>
In-Reply-To: <wg57x6u3fomukerbnfbmmxywoljyrlqlctytfnqdlhl74jvigg@t3aygzlhtpui>
From: Nick Huang <sef1548@gmail.com>
Date: Mon, 7 Sep 2026 18:23:19 +0800
X-Gm-Features: AcwNN1Vp_cuM5nShreT_zeNzhbqLHFyRtdBlAeKSiWtpbuJ0qpc92MV9cu7-sFI
Message-ID: <CABZAGRFSqQh1AWF=bYO5xXQWDVHK+5NVgHt9=N8wcQY2ZuK4YQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: eswin: Publish the platform driver's OF alias
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: "hpp.iscas" <hppiscas@163.com>, Senchuan Zhang <zhangsenchuan@eswincomputing.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Yu Ning <ningyu@eswincomputing.com>, Yanghui Ou <ouyanghui@eswincomputing.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Manivannan Sadhasivam <mani@kernel.org> =E6=96=BC 2026=E5=B9=B49=E6=9C=885=
=E6=97=A5=E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=8811:55=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On Sat, Sep 05, 2026 at 02:46:41PM +0000, Nick Huang wrote:
> > On Sat, Sep 05, 2026 at 09:42:51PM +0800, hpp.iscas wrote:
> > > The ESWIN PCIe host controller is a platform driver matched through
> > > eswin_pcie_of_match. PCIE_ESWIN is tristate, but the table is not
> > > published for OF module autoloading.
> > >
> > > Publish this platform-device table. Do not change the RISC-V host
> > > initialization sequence or PCI device matching.
> > >
> > > Fixes: b593c26d081a ("PCI: eswin: Add ESWIN PCIe Root Complex driver"=
)
> > > Signed-off-by: hpp.iscas <hppiscas@163.com>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-eswin.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pcie-eswin.c b/drivers/pci/co=
ntroller/dwc/pcie-eswin.c
> > > index ce8d64f..1bb4469 100644
> > > --- a/drivers/pci/controller/dwc/pcie-eswin.c
> > > +++ b/drivers/pci/controller/dwc/pcie-eswin.c
> > > @@ -388,6 +388,7 @@ static const struct of_device_id eswin_pcie_of_ma=
tch[] =3D {
> > >     { .compatible =3D "eswin,eic7700-pcie", .data =3D &eswin_eic7700_=
data },
> > >     {}
> > >  };
> > > +MODULE_DEVICE_TABLE(of, eswin_pcie_of_match);
> > >
> > >  static struct platform_driver eswin_pcie_driver =3D {
> > >     .probe =3D eswin_pcie_probe,
> > >
> > Hi hpp.iscas
> >
> > Since this driver uses `builtin_platform_driver(eswin_pcie_driver)`, it
> > appears to be built-in only. In that case, `MODULE_DEVICE_TABLE()` seem=
s
> > unnecessary.
> >
>
> Nope. builtin_platform_driver() only prevents removing the driver once lo=
aded.
> Since the driver is defined as 'tristate' in Kconfig, it can still be loa=
ded
> dynamically. So MODULE_DEVICE_TABLE() would still be necessary for udev t=
o
> autoload the module based on modalias.
>
> - Mani
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D
Hi Mani

Thanks for the clarification. I see that builtin_platform_driver() does not
prevent the driver from being built and loaded as a module, so
MODULE_DEVICE_TABLE() is still needed for module autoloading.

However, since builtin_platform_driver() does not provide an unregister
path, the module cannot be unloaded with rmmod. Is that intentional for
this driver?

Thanks,
Nick
