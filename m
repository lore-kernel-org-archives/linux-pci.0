Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09C5316902
	for <linux-pci@vger.kernel.org>; Wed, 25 Mar 2026 18:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774463112; cv=pass; b=tm/31A1ZEJ73cWycZ6KOOYViJgGip4XUeHHJKkczpOY5oBRtWwy4xiybyztxwQsVdB+kv0KSR1e5EKYfIp8wQteFTqLmcK78r24bk5SjTX9YtSR6ILkfSPvIO0jM68pO7RnfSxVTEaCK49u07nsf+CnO8W3MuTMdQb6clDeTCHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774463112; c=relaxed/simple;
	bh=octYghLj3lL8jmmagJjWza5YBb4cgg47jWgO1cXXGP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HeAjpnp9+JlmM7MXtcFX+1vt0BUp1w83yTEHUw97Rt9cjSOcmYdrZsjBE5AEIm/U5UZGfs7n3MGfZ5ercSxDH16Bb0/RXu4SnQzveNXAsqSNLA/Ks+ldVcCeQ0tKOx9oTFacE1JbwnWZw9Q6BxdV8yMICyLHCjXZkBgbRvxiAtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s4QFoPDN; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s4QFoPDN"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-66a33f61d80so203173a12.0
        for <linux-pci@vger.kernel.org>; Wed, 25 Mar 2026 11:25:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774463109; cv=none;
        d=google.com; s=arc-20240605;
        b=aPLfil3MkP1NtB89UsNzYY+D9feVOYE4zZuLWLu6nlcs133flGP9DtvK4QRT0hIOmT
         4xoDbm4dNFN0X5mjnFzrlBBYdyebK4/GxHED/vs2IiyaXdVoK1RtO51VmjruWadfVbyN
         pufWp+Egn2X0MWavfmqWYpQ0+uB7y6weXUX/35BpqhTzAbHOoUMn85oBHmI38hExY9h0
         vDGqoN9umf1uaLadRQQ3OBYCRbHguK8ZE7mHVNNpq7cXS7E52IoGwzM8wlRmJ3GRFfmZ
         NLWTNCZMWW1TpYMxO1G/5tDgT+C6is01Jf9qB6//U/hmts+WX1MpRp+s1b1JWhkUtbex
         TtsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+vWMfDOSQfWlw8ZoOH44pVZOnW6Fijg7msvIoLlglLw=;
        fh=SDA+7AKovG5A9ttWcWtxcnEwR/I/7aCiOikjxVyArGA=;
        b=j0h+NvrrgCKRpm634L3s1LQt13CpsC1IQr5SCHLRpHHuTT9zyzRB4VXE1fhHNJt/S6
         6qfKytw/olO6s2oWjz3Kthum6gNygZlLUnibZ5/XhT+3gd86OyMSqUQOaroUUH6ECIYT
         dpTh4Ckgwzoz412uGzssX1yGNwk3txvbDWBe31CSzeMnY3/Q1M8gC2nMsarkbbnmdNYP
         rpOhMf6OK9rLYNp1TahXibv/kdeuoIW0vD4B35IGR4fU/2QXf1Wr0P6XdlcTENxjwZj/
         DK8TIedVN6hQVS/HfTFRNNe14rLpldahlYjV4Egv78pSkrk+Of99CL3bbwtz1vIh3Sed
         tx/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774463109; x=1775067909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+vWMfDOSQfWlw8ZoOH44pVZOnW6Fijg7msvIoLlglLw=;
        b=s4QFoPDNg3q0+s/2ZxSh4Mbot7kZkSdzixhvu3RXKCdRn6BvB3hbAUeh6H3w6YMJK/
         ZI9QdLOlQ20cYjXNkX7tHWCIKaXEY7AoLKMu9AR9Iwl+S6RCmO7cLtVSd2lPrWiXWn2S
         d5zg2G2Q51Vj+VVcmawrNn4Yl1TUAn1mEfTH9wKIGt0VrGiodTJvT+nS6oE4AEacw52K
         Ij///jx6OtzUiPVWfBJQ3JIuvQOWABIzAu9/NYYmOaOrtTeyLbYF8pR48hEAR4WkbZ/2
         3ldxLoiQZ2majG0+8JTS0jxgT8iOU21fbGL7yEfxr06MLf9l4nCVgVgOCku8or/iU8dt
         7HaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774463109; x=1775067909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+vWMfDOSQfWlw8ZoOH44pVZOnW6Fijg7msvIoLlglLw=;
        b=Wt3sTCN3BizMLTabS82LejAv0IaR1A6vAY60DmEgALT0xhC8zCS/Sjfh2Ob/zcV71U
         pXPwUYzaJZgAdUGmM+zXZjNl6yEg2tUW4CrD7iUknQhZbb6BxLOZ1IgOKCKSU8AZdioz
         teBNLdwSp8VG0KweP9W29PqFWTQHtVd+TkvUScZS0oUGQ2KEMUUEol6HXwd3lxRKoNCl
         PLd2Krm3USsrI7+7S2lVzPIrx4WRgQuK5snknfWo5yWrjyiz90YPSgKxi/rvcKcQpZzG
         NrlzKZ2s1dPaA4/+9u9U/tI1B8fhM/fpOoZi1i0H0hMcvEyjrCOt4BUJRq9NpGxtWgUV
         1Xfw==
X-Forwarded-Encrypted: i=1; AJvYcCXmZCjiHOQk2bUg5iMi3JUSWWirdKoDHWCXRg3+mxWcjxDmuXlJIAEWE9bAuUrJu02kLZbsbNWotrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxAlcHU3PlhEA44dtjsFWBCnXulJQ7qzt1FFtli5Hltaw6uYru
	pUY7VsvvElBcC4UDELkF4b72By2wfwivU0SvTuNCLcHdKfafjbm5lfcauvcywag4dIi2nRw511F
	x/b1c9XUb3Z7TrRO3nv85S9wkhKfoiXw=
X-Gm-Gg: ATEYQzzBhdKlv4Fh3gKzxMtEFTGVH6/Fe+LK2yKLJEoJVqS0m3f0sWcKwUX/8wB740N
	XSDi8BTagSnJNxRh6rbiYbCvV/hFZFbQ/oWSqiRrB1ucv9DvHc7IhscmZdHEfkM0I4GBMFOsvFa
	7+V63Vdx1JLqMPPsrn4+AcwMvSmAuQW/6TuwcEF2wxnUvYQqjaJGh/hBvFtiIfmtYXGpDUXN+Jt
	ScrQe5Fpbe686CENFPxpwPr63m9aCWBh4yB7Ns68l8qNemdcugn5FWrahbURlAy8jM8/XkvbIhf
	qge9VA==
X-Received: by 2002:a05:6402:1d4e:b0:669:d9a4:cd4b with SMTP id
 4fb4d7f45d1cf-66a8262af14mr3212998a12.11.1774463108886; Wed, 25 Mar 2026
 11:25:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87bc37ee-234c-4568-b72e-955c130a6838@arm.com> <f7tfshf7riljjibuqge4ubfjmludubpyh3ppdf6lasurzdzbtj@sw4xxagfhnn3>
 <5d88fb5b-e771-4ea6-8d2c-c5cfd21e5860@arm.com> <qwanhqrpztzkudik5fmberhabnzaly7v53677dohqzj5nq4wi2@6ndpiubyxcbi>
 <DGZXF3LPSRK6.2QYN63QTKUQAX@kernel.org> <cp5uktfqdf6zs53qsye57ior2ikmssgevxxdtevkzpisaif22h@7mrxspkuibow>
 <DH09EDBW3X6T.2996UB1CFCAW2@kernel.org> <55c28218-1638-4b90-a9cd-a177fb5abcb6@arm.com>
 <acNgUoWWMCi1oLU4@google.com> <DHBYL7Y262J2.263EOC2JNN4RK@kernel.org> <acP9-AfUQ7zp3kMS@google.com>
In-Reply-To: <acP9-AfUQ7zp3kMS@google.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 25 Mar 2026 23:54:51 +0530
X-Gm-Features: AQROBzC57btNYqd28tboSY034eYP0IcSkF3_Hl9bgfxidfp7h8unSgphUiRekA8
Message-ID: <CANAwSgR7ABawrnSG6CievYT-BZ447TaFC_kqCYc+oqxkD6Uxjg@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: dw-rockchip: Enable async probe by default
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	Niklas Cassel <cassel@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, 
	Hans Zhang <18255117159@163.com>, Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
	Wilfred Mallawa <wilfred.mallawa@wdc.com>, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Grimmauld <grimmauld@grimmauld.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	driver-core@lists.linux.dev, Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dmitry/ Robin,

On Wed, 25 Mar 2026 at 20:57, Dmitry Torokhov <dmitry.torokhov@gmail.com> w=
rote:
>
> On Wed, Mar 25, 2026 at 04:13:03PM +0100, Danilo Krummrich wrote:
> > On Wed Mar 25, 2026 at 5:13 AM CET, Dmitry Torokhov wrote:
> > > That means that you are kicking the majority devices (for now) into
> > > deferral path. I do not think this is optimal.
> >
> > That's not necessary, we'd only need to kick those into the deferral pa=
th that
> > have PROBE_FORCE_SYNCHRONOUS, no?
>
> Yes, it may limit the fallout, but as I explained in my other email
> there seem to be a serious disconnect on what synchronous and
> asynchronous probing mean.
>
> I wonder, don't we get issues with phylib in other cases? Don't we ever
> have a module resulting in creating a phy device triggering loading
> another module on the same thread? Won't that result in a warning also?
>
> Thanks.
>
> --
> Dmitry

In comparing the Orange Pi 5 Plus and Radxa Rock 5B schematics,
I noticed a key difference in regulator implementation for pcie2x1l2 node.
While the Orange Pi uses a dedicated GPIO (GPIO3_B4) for ethernet_power_en,

Reference: orangepi=E2=80=915=E2=80=91plus schematics
[1] https://drive.google.com/file/d/1cVT7lSLlgtIvHh4PllijP5E4zz7pxCyh/view

On the Rock 5B ties the LAN_EXT_CORE regulator directly to the VCC_3V3_S3
PMIC rail without a control GPIO.

For LAN_EXT_CORE regulator POW_EXT_SWR/ENSWREG is defined
as enabled by this regulator, but with no GPIO pin linked to toggle.

Reference: Radxa Rock 5B schematics
[2] https://dl.radxa.com/rock5/5b+/docs/hw/radxa_rock5bp_v1.2_schematic.pdf

Because the Rock 5B lacks that GPIO toggle, the existing dummy regulator
definition is redundant.

By stripping out the dummy node and pointing the PCIe supply
directly to the PMIC rail,

If somebody could verify these DTS changes

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-5bp-5t.dtsi
b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-5bp-5t.dtsi
index 668b19c05f7e..cf7d9d516d0e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-5bp-5t.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-5bp-5t.dtsi
@@ -81,15 +81,6 @@ vcc3v3_pcie2x1l0: regulator-vcc3v3-pcie2x1l0 {
                status =3D "disabled";
        };

-       vcc3v3_pcie2x1l2: regulator-vcc3v3-pcie2x1l2 {
-               compatible =3D "regulator-fixed";
-               regulator-name =3D "vcc3v3_pcie2x1l2";
-               regulator-min-microvolt =3D <3300000>;
-               regulator-max-microvolt =3D <3300000>;
-               startup-delay-us =3D <5000>;
-               vin-supply =3D <&vcc_3v3_s3>;
-       };
-
        vcc3v3_pcie30: regulator-vcc3v3-pcie30 {
                compatible =3D "regulator-fixed";
                enable-active-high;
@@ -480,7 +471,7 @@ &pcie2x1l2 {
        pinctrl-0 =3D <&pcie2_2_rst>, <&pcie20x1m0_clkreqn>;
        supports-clkreq;
        reset-gpios =3D <&gpio3 RK_PB0 GPIO_ACTIVE_HIGH>;
-       vpcie3v3-supply =3D <&vcc3v3_pcie2x1l2>;
+       vpcie3v3-supply =3D <&vcc_3v3_s3>;
        status =3D "okay";
 };

Thanks
-Anand
