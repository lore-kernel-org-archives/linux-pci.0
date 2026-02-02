Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193C163B9
	for <linux-pci@vger.kernel.org>; Mon,  2 Feb 2026 18:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770055570; cv=pass; b=ru8TRc8cnZ5K1l4YlNOIhKRje858jdbtsD5ZcT9Bb3SS//EQLNxjzbxEUMXwlLguuknd8e1h/VHyhzYyNd2Dm4wVvPHEvwoAV0rYP1pAYrxtQJGL3NHEH0whMCz6O029GKkVE0wt8eKZvglYxBcJN3JE1Wc+htUUqyh4F91N3O8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770055570; c=relaxed/simple;
	bh=oWJEisruruVLSlqjm3rJkqx941JFOy4FlANT0cauyEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BXWOzTUBK+6PjsprrffXph4X9v9h2p2TMeLpGot3MLpdMd+IH+9U8fnKgGAnIhtNF88Kcv4jZma4kSkURTzp3RRzocdZkER6i1/rvZ/BxlCXbSZdYkLgxk1xgjSd7TgciZm2oDhtr/SkWRjtmDTVWSBn49w5XALFW1ymTZpMsrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQx52OYn; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQx52OYn"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-65808bb859cso7156816a12.2
        for <linux-pci@vger.kernel.org>; Mon, 02 Feb 2026 10:06:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770055567; cv=none;
        d=google.com; s=arc-20240605;
        b=Ul7JWZtSYK3mqbnpaLd6FYuOJx8J44uDmSS3AW6/3R+vESyFMhleecDhsVTIHLIjyp
         hHiKeak9wiFroxF+21YI1JQMl82RSgJycroUqZgS9s3MwynB7jEkosPAikOmGLCXpCDJ
         HMWdlDz4gQ5gJ/4Va8g8vyDLhYDtDxKg34KL9PMDXV0OthtbEZ5bMgpqEr3vVk/mtaqO
         9qNGU90lP/Cre1xH9A856Tt2yARFKBCal3UP+tyZ0GKsy/yKSTR7Fltb2YVimUGy88pe
         aIHG7H1gISwAjw2crVeUAmsbgajP+jv0tOxOyncRooR0Hn6MM6iGDUn1gzW1AwQkD4qP
         EkGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hP28cdxrwSqvRO3deSNeh79vlUUMJieXCHAu3kVx4q4=;
        fh=r9b/REp1Qc8uK4z8S88MiP3QNjWmnfvPXZfWmZqfhrw=;
        b=Re4GwqsBYIGWfR8HEgQczsrqhSQOMRQFSESOen5ZUqdbE2fRMLCyqkgRXWCs4tEouk
         9LuwldOFSpO7JtpSa7qyyQTdMBd2LOj/kYmVq/cbJrTl7PEhhkoiKI0/wooF7lBoq/Jd
         r1AMUuTU9PEloWvwSih6Pw42fh4/JxRsU5f/6gXL5Qd0X/AG6bpOAMzDHEeUOeN0r7AW
         XzjnYJRTrBFCDf76yMQx52ey+qTIMYxuGf/HoZY4m9v10fn245ww6iJshXTKC6PCGgcU
         xW1V4llvAq3OSaS8tGTA5evxH+t0EeSZpzX+Ob2si63jd8YLmePa0cp1jh90Anq2zVqL
         N+Lw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770055567; x=1770660367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hP28cdxrwSqvRO3deSNeh79vlUUMJieXCHAu3kVx4q4=;
        b=aQx52OYntd42JG4s/pIlzRe9cT0jXre9Or53hSxlz7eVYHsjXnGy6xn7eoorqw0ske
         iggihDvirvVi3LM6/41fudgML2L0tlRMMShauA4O6FaUdCxYFAGeXNwlT1TXRb1xJINA
         bURBQFnCg9JQrPnvru/VMVV9xtM8VFBOciGl5urWOTiIlxeqaH+V63UXFqQ9ZS6JxA72
         ssiAmbAEEDera2eVo7yqaYchiA+NaSJ9jP/dl0EY8CGoIkoaldqqO2lmoBUitDxi+fV/
         Wiauk9yEsPszXOYDrVdsQ2lWzC5IiZ58hqFlt4HZhr8Y3aOkfwe6+nahtLc/EpaLUmml
         lScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770055567; x=1770660367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hP28cdxrwSqvRO3deSNeh79vlUUMJieXCHAu3kVx4q4=;
        b=sbThufMfZ9s06R10+JAqNnuxiGtPZzcA1BG88jTfTfw7HJvGg4+xAGZnkaaZiCpCWO
         cV8K84t9Ok7v6HWXdhvykBn6wtZ+imHk3N7dP650M4ZNybYsyVCvck4e6j95QWp61kjh
         IZ5EDdsoxmxjeOOfTvC+sI37Y/zZk1LhgmlJIUJob/cNV1Z7wObQbYzLMLZA+toaCpeI
         CRQiNXLzIPTMvNJ4xpoTTT8vShirOt/XxwzwKGjTQDbas5lEBA6CqmQ6R4eZSoebaAfY
         ZDqszydctdzawsYkYNFiFh2Y1lS7T+t19jXnssCgBEARUgY1fI4hGiGpW7LEwFkn4Vjj
         3ssA==
X-Forwarded-Encrypted: i=1; AJvYcCUUz4fHz2POiT4kE4q3lk+jUlS888YMaYiLQC5N1JUiEwbwTucipyKeRWze90/TAv2cX6jlSMGAmjk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr398UmT+n6Ux/FfWXQKYqXM3/bIWb2+OvwYQEnJHOH08A9euf
	iX+2H+p7KypnEN2hcrSXE9v6i6QJ5CkW9P9ff7BFgPxpSXMEjk0mbf7V3E0k5u1efxoxyqBtshF
	3aq+WihWXpLpG6yZwvxXGaoL1nFcSjyI=
X-Gm-Gg: AZuq6aKlid+oFTTnfKBJH9TAbOTsi2P7ZvZNWFOJpP7JugEoeX3rRLoQKt3eG32yXMW
	hR448dHA5Ow5P3YiXW2QzlFan0A1fX87Vbcy6LyCotXdSjjBPcvIq84RJCClz4gC3cbksodjz7a
	k8es01oBwKijJVNP8710dbMwYjhFXYmMA6MArJSyu1+sVn55ZiViExVyCw1avF4ZT+bgijokoTk
	bmtG6kfyfE3lmpB7OOD0gBiIBb28SyCC7Ykl7r/Ox7aemXVeucsL00DsOuw/zg92aM=
X-Received: by 2002:a05:6402:3582:b0:658:bd60:43d0 with SMTP id
 4fb4d7f45d1cf-658de5915d5mr6621282a12.21.1770055567216; Mon, 02 Feb 2026
 10:06:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809073610.2517-1-linux.amoon@gmail.com> <aXtpg0V_sifQEWHJ@grimm-nixos-ssd-2>
 <aXyHITrZ89Mmn8_J@ryzen> <CANAwSgTQ-cdyzd2WjHMYCY33p7um3CpjMeTzRO7vcd0fTF6X9Q@mail.gmail.com>
 <aYB0ctHF1ZeIIzbq@ryzen>
In-Reply-To: <aYB0ctHF1ZeIIzbq@ryzen>
From: Anand Moon <linux.amoon@gmail.com>
Date: Mon, 2 Feb 2026 23:35:48 +0530
X-Gm-Features: AZwV_QhVyDIKKP1nVuDrTcVF0I-NAOiYLCyqmT1Lu3YFL9MwXYNqEXtkEO2A9s8
Message-ID: <CANAwSgSR7AYCvMXSo5UskTF3LJToOnPV9JE4XBAUzrCbWGKD_w@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: dw-rockchip: Enable async probe by default
To: Niklas Cassel <cassel@kernel.org>
Cc: Grimmauld <grimmauld@grimmauld.de>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Niklas,

On Mon, 2 Feb 2026 at 15:25, Niklas Cassel <cassel@kernel.org> wrote:
>
> On Sat, Jan 31, 2026 at 03:08:42PM +0530, Anand Moon wrote:
> > >
> > I=E2=80=99ve attempted to reproduce the warning but was unable to trigg=
er it locally.
> >
> > I have tested with the built-in module
> > CONFIG_R8169=3Dy
> > CONFIG_R8169_LEDS=3Dy
> >
> > As well as the module
> > CONFIG_R8169=3Dm
> > CONFIG_R8169_LEDS=3Dy
> >
>
> I'm running with:
> CONFIG_R8169=3Dy
> CONFIG_PHYLIB=3Dy
> CONFIG_REALTEK_PHY=3Dy
> CONFIG_REALTEK_PHY_HWMON=3Dy
>
I feel CONFIG_R8169 should not be built into the kernel image.
Since the driver is registered via module_pci_driver(rtl8169_pci_driver),
it is intended to be loaded as a module. In addition, this driver
requires external firmware
during initialization, which could make a built=E2=80=91in configuration pr=
oblematic.
Keeping it modular ensures proper firmware loading and avoids
early=E2=80=91boot failures.

> CONFIG_PCIE_ROCKCHIP_DW=3Dy
> CONFIG_PCIE_ROCKCHIP_DW_HOST=3Dy
> CONFIG_PHY_ROCKCHIP_NANENG_COMBO_PHY=3Dy
> (PHY for the PCIe 2x)
>
> $ cat /proc/cmdline
> root=3D/dev/nfs nfsroot=3D192.168.1.10:/srv/nfs/rootfs_rc,nfsvers=3D4 ip=
=3Ddhcp earlycon rootwait loglevel=3D8
>
> Considering that all PHY drivers (for both Ethernet and PCIe),
> and drivers (for both Ethernet and PCIe) are built as built-in,
> having nfsroot=3D on the kernel command line should be no issue.
>
> But, perhaps that is the reason why you cannot reproduce it?
Thanks for sharing your setup.
>
>
> > >
> > > Having async probing for the Rockchip PCIe controller driver, which i=
s
> > > used a LOT of rockchip based SoCs, is a good thing, so I don't think =
it
> > > is right to avoid enabling async probing just because it results in a
> > > splat on a single rockchip based board (rock5b).
> > >
> > Yes, this could help in the module probe pci module.
> >
> > Earlier, I thought gmac will control the r8169 module, but I was wrong.
> > Could you please try these changes at your end? These changes are
> > related to MIMO..
> >
> > $ git diff ./arch/arm64/boot/dts/rockchip/rk3588-rock-5b-5bp-5t.dtsi
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-5bp-5t.dtsi
> > b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-5bp-5t.dtsi
> > index b3e76ad2d869..fb3a8ba4085a 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-5bp-5t.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-5bp-5t.dtsi
> > @@ -477,7 +477,6 @@ &pcie2x1l0 {
> >  &pcie2x1l2 {
> >         pinctrl-names =3D "default";
> >         pinctrl-0 =3D <&pcie2_2_rst>;
> > -       reset-gpios =3D <&gpio3 RK_PB0 GPIO_ACTIVE_HIGH>;
> >         vpcie3v3-supply =3D <&vcc3v3_pcie2x1l2>;
> >         status =3D "okay";
> >  };
> > @@ -535,6 +534,12 @@ pcie3_vcc3v3_en: pcie3-vcc3v3-en {
> >                 };
> >         };
> >
> > +       rtl8211f {
> > +               rtl8211f_0_rst: rtl8211f-0-rst {
> > +                       rockchip,pins =3D <3 RK_PB0 RK_FUNC_GPIO &pcfg_=
pull_none>;
> > +               };
> > +       };
> > +
> >         usb {
> >                 usbc0_int: usbc0-int {
> >                         rockchip,pins =3D <3 RK_PB4 RK_FUNC_GPIO &pcfg_=
pull_none>;
> > @@ -550,6 +555,19 @@ &pwm1 {
> >         status =3D "okay";
> >  };
> >
> > +&mdio0 {
> > +       rgmii_phy0: ethernet-phy@1 {
> > +               /* RTL8211F */
> > +               compatible =3D "ethernet-phy-id001c.c916";
> > +               reg =3D <0x1>;
> > +               pinctrl-names =3D "default";
> > +               pinctrl-0 =3D <&rtl8211f_0_rst>;
> > +               reset-assert-us =3D <20000>;
> > +               reset-deassert-us =3D <100000>;
> > +               reset-gpios =3D <&gpio3 RK_PB0 GPIO_ACTIVE_LOW>;
> > +       };
> > +};
> > +
> >  &rknn_core_0 {
> >         npu-supply =3D <&vdd_npu_s0>;
> >         sram-supply =3D <&vdd_npu_s0>;
> >
>
> I tried your patch above, but I still see the splat.
>
> But as I said, I don't think the splat should be a showstopper.
Thanks for clarifying this issue. I will resubmit once I have
conducted further testing.
>
> Kind regards,
> Niklas

Thanks
-Anand
