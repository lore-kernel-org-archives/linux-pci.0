Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C493D6491
	for <linux-pci@vger.kernel.org>; Thu,  2 Apr 2026 10:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775125866; cv=pass; b=JxYKB7rGV1ABS6PLd29TZkK6U2r/GEFF7F/r8uqLFJJiVarHq5Q0CpXv5B8DmHwCfEI/N9C+zpPlG3HMMLCpihasziGJDT9wT5F+DilraThI22bNFMrHXZ+fR0SS95gu0YS4fIA5LssBzAsnjFD9a1aZXGsqltgMc1Vk4imhj3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775125866; c=relaxed/simple;
	bh=MUZx4Y9OyelgL3hyVBr4k6AAzEQS/l7Wd93ZjmObqWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mei17O3QU+3qJioPjn4s5tpLmGnH5Ht9ReozsGV9R4X6B552eL1m+QUJfDQeEi3Oo79pMBkLKJAZeCyiue1pvzW2rj5pfs0VOiUqBGB8zR6RfQonAKVwijsCRqZgmsS+/3Eywj3wOTAnD991ZsnoeGKxsyRkz0o8yJJ9FrHHcuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTxuec0E; arc=pass smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTxuec0E"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-953b9fd8ebdso480888241.1
        for <linux-pci@vger.kernel.org>; Thu, 02 Apr 2026 03:31:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775125863; cv=none;
        d=google.com; s=arc-20240605;
        b=VGH83T3U5VgS1SL+n0aUe2xojBS/bXqlWqD+1KZn8HVKPzjDZiUIbVqdvtOgOVaD0z
         ro56gbx8gjifnEtLEpWdjC21U6C2FIJqIIpYRZomvtl2zgcF0ePxoZcy+V/aSDzpadlz
         ILRNXHsr/0L4fm/QwycdRI+k3k27FrSqoIxVt5yBJK7QGkiYQVMz5NvV8chOveXGshEM
         9AgvQs3pGn1HZEzjDuisKmI1e5PM2fP3TAcIrfSvB6zgkIrEi/BtwLBwcPhzGvTXdgu3
         u07QaFrVmUg0mI5Y9HoTPyM0ULC4toNo91zf//2u02XJIp9RV2L5UoykZAZX/t+EnrTu
         cgHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4Ob4WvASBXKLoNDxbRXnh3mN8JCXap6XQdaiWgxzkgI=;
        fh=680Pyatwe9V+lQ1+0tYlq9z7xnreOAIuuqXct9e3olY=;
        b=cMcOuM7lX5bCDLZC46FXpvjmGQIh5ElEZ4MDqVOUyWZbanzxj79nArRRzQ36dSU7Cm
         A0tM3MX6ClN0yJVijMj74iyc74Evrz0QUv077b7k8REh27CUOS3I9rGgikd/B9h/iNAg
         e1ad9Mpk7tDJgUz/Hl8UbP/NL6yi4kju+34BiScj1wpK10+54mEk1Ed2qtAOaKSEdGr8
         Y+kU9bFIvm0GEJHNlzZYBpSo7yAFO5yT/TK7uuFBNn7xJMMCSixB47hZBvyWIwdwdSqc
         s1gqu1mlZFVR96yt/+/dfOareU9Z/gYeOC+gux37xuyhQAp9K72L7H7RefT/0T2ch9j+
         P8UA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775125863; x=1775730663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Ob4WvASBXKLoNDxbRXnh3mN8JCXap6XQdaiWgxzkgI=;
        b=UTxuec0EMljOElkQdGAzDus6SYqvMppVh9GQZVaCS9Vy8i/LrsHJMDQrYO9CBPBiY4
         4n3tgBvjxhz/jP2KybP1b4APUcm900XPsGEld37rYe8hJZc2XKHInjZcFm/r9NS2IIzS
         EgFnCSJqwqBjpEGebQmNhnCiKcAtULdOja8UQ8MaV0GYygeaTwgwMpaswyE0fL+IWQCc
         Q1qH/i2pcy3MiS8IQY64gMPkxBvjuNw2aBq705zgWD9/Bh43bArg9KYKOhGRFqYAB1GK
         xDIWNZ/chFP8Ep6TevUE1zSYZTcivEbdBZgh39hINlW3g68r2wDb5oWPg7Ac7KAF31x0
         SFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775125863; x=1775730663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4Ob4WvASBXKLoNDxbRXnh3mN8JCXap6XQdaiWgxzkgI=;
        b=bPSgBQhH9VHoGKwy+kHGGMSgI3TNb2OV4tFI5aD3i/GE+cDkob7oiSByO8GFefUWfC
         58sE0mTImQ3hD3wCXYpCMldYUeLVl2CBr/JVLikVa8pjmTBDAkLBh3dMUw7soeuaSvLk
         2BfRgBAZrIvrd8i824gF3idYnPOjYC3iQ1H3U67pv3Qhupcau3LMJQnCrzq8sC7pXymd
         CxaGTNfkYKdi0kdt6LXeyQw0q+PulzfF4asUP4txnsnJBzXnQU8U4GLq329aI4wE6Mj5
         Uyp9At191WVxA498+lhF/eOKl4WqR60s55DfhH9kt67Vjw1XG5zzj7nsWDZAO2kOJ3Wy
         t+4g==
X-Forwarded-Encrypted: i=1; AJvYcCVP5TqKOtmEcu0IKXAwowTd8y/KR9prXJN0tFG5uoOgbGGKjKqmQgOePxqZm4M6HqWinDaLLqtiKv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGQXEuYM/gKj1JDxLRRhcbxFaJ4RI/4oSfAS97F6mSAsn2gSjI
	PJZHvdF5zWNHwBXRIKQfTbHfFnSDezSKdFZjqEhW7UrXwgXPK4NWRkFsfOnBJxnYjvk9X970FNl
	M5Py8OWyNVvzUOc46fOpUFr1m1s89sq8=
X-Gm-Gg: ATEYQzzCiFzgnoQ2yr/FDCHvj75spmvFu+CBxRmQ+OFQxpU0ZRaMH1ivfiqvz+lAeEz
	J7U67Kx3y3lJCqawXVdWyOycPhY+mTkAPh4vVXiHXuSGVCaCZezaB3VzWS2j6lOQCbKFkFYGuSN
	BoW8NufweZGxxVR8DxwymnUWK2ESrf8HRvGQqYXZX5zPk37MvcJb3KWBpEQXvgZWaMZDmiEYhTr
	grOveO38JU0jDtCZGKwWXK0vUp/1mBoLYOv6rLTynTIMvKSUZStjSXTsfgyG+kxAcFoX7hB+dFy
	6LIofIiCi7CVR7tbIXbR5X+It4kt69Ni9wlCtkE=
X-Received: by 2002:a05:6102:5343:b0:605:17b8:16db with SMTP id
 ada2fe7eead31-605681ba7d8mr2632044137.25.1775125862274; Thu, 02 Apr 2026
 03:31:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331171248.973014-1-gaohan@iscas.ac.cn> <20260331171248.973014-3-gaohan@iscas.ac.cn>
 <MA5PR01MB12500707BE1C6E11EC3F4B94FFE51A@MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <MA5PR01MB12500707BE1C6E11EC3F4B94FFE51A@MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM>
From: Han Gao <rabenda.cn@gmail.com>
Date: Thu, 2 Apr 2026 18:30:49 +0800
X-Gm-Features: AQROBzCGzBaggmtPSR3_A5qLKsf5xg9SqM3fnlQMsletNH9S6oyqQ5RfqOQtIhM
Message-ID: <CAAT7Ki_BkfYCN_AJtksOEopU2r0iYPybuEQfm+pMLpsm8+EJkA@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: dts: sophgo: Add dma-coherent to SG2042 PCIe controllers
To: Chen Wang <unicorn_wang@outlook.com>
Cc: Han Gao <gaohan@iscas.ac.cn>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Inochi Amaoto <inochiama@gmail.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Zixian Zeng <sycamoremoon376@gmail.com>, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, sophgo@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 4:44=E2=80=AFPM Chen Wang <unicorn_wang@outlook.com>=
 wrote:
>
>
> On 4/1/2026 1:12 AM, Han Gao wrote:
> > SG2042's PCIe root complexes are cache-coherent with the CPU. Mark all
> > four PCIe controller nodes (pcie_rc0 through pcie_rc3) as dma-coherent
> > so the kernel uses coherent DMA mappings instead of non-coherent bounce
> > buffering.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
> > ---
> >   arch/riscv/boot/dts/sophgo/sg2042.dtsi | 4 ++++
> >   1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/d=
ts/sophgo/sg2042.dtsi
> > index 9fddf3f0b3b9..3af770549742 100644
> > --- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> > +++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> > @@ -417,6 +417,7 @@ pcie_rc0: pcie@7060000000 {
> >                       vendor-id =3D <0x1f1c>;
> >                       device-id =3D <0x2042>;
> >                       cdns,no-bar-match-nbits =3D <48>;
> > +                     dma-coherent;
> >                       msi-parent =3D <&msi>;
> >                       status =3D "disabled";
> >               };
> > @@ -439,6 +440,7 @@ pcie_rc1: pcie@7060800000 {
> >                       vendor-id =3D <0x1f1c>;
> >                       device-id =3D <0x2042>;
> >                       cdns,no-bar-match-nbits =3D <48>;
> > +                     dma-coherent;
> >                       msi-parent =3D <&msi>;
> >                       status =3D "disabled";
> >               };
> > @@ -461,6 +463,7 @@ pcie_rc2: pcie@7062000000 {
> >                       vendor-id =3D <0x1f1c>;
> >                       device-id =3D <0x2042>;
> >                       cdns,no-bar-match-nbits =3D <48>;
> > +                     dma-coherent;
> >                       msi-parent =3D <&msi>;
> >                       status =3D "disabled";
> >               };
> > @@ -483,6 +486,7 @@ pcie_rc3: pcie@7062800000 {
> >                       vendor-id =3D <0x1f1c>;
> >                       device-id =3D <0x2042>;
> >                       cdns,no-bar-match-nbits =3D <48>;
> > +                     dma-coherent;
> >                       msi-parent =3D <&msi>;
> >                       status =3D "disabled";
> >               };
> For binding changes, LGTM. But I have a question regarding this change
> in dtsi.
>
>  From your patch description, I understand that enabling the
> `dma-coherent` attribute requires upgrading the firmware `fip.bin`. If a
> user only updates the kernel (which is relatively easy) but forgets or
> doesn't know how to upgrade the firmware, enabling `coherent` might
> cause the kernel to skip all explicit cache maintenance operations.
> Could this pose a subtle risk?
>
> Wouldn't it be safer to leave the upstream unchanged in dtsi and allow
> users to add the `dma-coherent` attribute themselves after they upgrade
> the firmware?

In the firmware, fip.bin and devicetree are distributed together.
So matching issues are unlikely.

>
> I would greatly appreciate your guidance.
>
> Thanks,
>
> Chen
>
>

Thanks,
Han
