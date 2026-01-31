Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4ED2C21FE
	for <linux-pci@vger.kernel.org>; Sat, 31 Jan 2026 09:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769852330; cv=pass; b=lHMmKGLg2IXQY9ml7oy+bU2ql1DIG6WZmdSEfEMVcMfhhtMuiICytDyjrnUGRxguG2XxW/H/YJqlKcNCCaF6ez9pRa293nmUGENWqmXx7Xpbr5XQqSg3c8CnibmauUZSTNN8t9wrednpZ67w/cdUkINCX7duKRJ2j2pykp9Kj5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769852330; c=relaxed/simple;
	bh=CS7f6UoK3EQ40SDyAI8Ub1qpTOjjADk0H3RfwxVlGqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HSvUqFdEJEJ3EAELSSz0YXArZVpwNO543g84xZw/F/txzE2o2TPSda6if8IVTCSk6WAUFQQt7XmVrbdK6Own/q40mQjG0qgFedR6yQufgAvPlx09TUGwk6c4aw8T/31pOSCbSiutM1BCQA2NZi3yM4KdCtcuDKs1BD/dGnF0nsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KiWfFQ0K; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KiWfFQ0K"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-658b6757f7fso5501953a12.1
        for <linux-pci@vger.kernel.org>; Sat, 31 Jan 2026 01:38:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769852328; cv=none;
        d=google.com; s=arc-20240605;
        b=AflVa1akvKXiZxuzsmQs9D7V8U5SxmJVxHGfNjimfwKVFqc0Db6jyU5CMTHawnST4S
         /GXzgQc0+Hj9otbmtYeFbcX57I4nAb10P+AJhroYuI4HtwS8ZGwxJrJxC5D9J0wjHWGW
         CN9J1/affOsrdpSZYBzhIU5tx5nsKfRamE99HBaS8VoW81gjgipYBIvgiqILDM1h3rmI
         /5+jcRMzWQ1J7D6g81qiSEbhPXteoSG+/cvSwcMU8ybTwI9a0eyA9zXkKDhjkOxPIF4a
         7jP6Rn3/ir17tQaUR5+O/zJMy7OIv5+j8Em6MXZbva0VP8KuKXE8V+C7yWx+yXsL2ufn
         S1hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CnkO+pyfjOjiofNSg49xQZUi6tf7VfPDjwPBlAQ3BQ8=;
        fh=veVsns+MRyFnntvlI8UiGBfTiEOvg+SBdDPbxZTCY3M=;
        b=ggKX//NFme+Rden1jV3UqCbxMWkbXLUxUMuhiM/pT7Neuwb8C/3nIUi62TuryTaWDd
         2PAPlwkTIXznvv5PZWVB4tOiD5+/DhzaBn4ESxw+FEHWNweeYO4/D1GxkApG+V38xRUw
         0HliIIOcGZp8RYPVFNE2mY/P8A372DxqNk5RbGwyiW668Gby3U61BKMrM4BBbn1eSOhm
         huqYu9x+/wl7kP+aSsVxolvrRj0q5UL5vVYwDH2cMvzbzgmrz/Y8RlV5gZKeYpMWy31N
         yvqttQTjNyWW7TgwmcLyTKeW7sbg1DOrnHWGnhAo+Z7UbPk+rP+H0iXUR9DujCGJmX9C
         DmuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769852328; x=1770457128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnkO+pyfjOjiofNSg49xQZUi6tf7VfPDjwPBlAQ3BQ8=;
        b=KiWfFQ0KsMFE/mL4FMcWJzTPlEBxPQsh/FvSIH5XKeI3bZeUmiM5bWBscvWEyrdni+
         08V6tNdAJl0Zaviv7JOVFzPiKjRCx/XOtuka0hc3qxYscateIR0Kt92SVjrR/+haPZ8x
         rlLZ7bqeld5UEEO3hHa6maHWOa12WcYn0tZd52Q6Zozslo7OOvtNakgPfrlcA0bLailP
         XHqp4G+UdC0xXCNkqYkJwV7VtK3oylkNd3gXSmfdH/VG1HXuSuACrfH3HS9NdUC7d1wi
         ITDOFklpeDKMNm62uEAAbDGakCMtVkyJrfTMmLra6RYiqqT8FB6Ma6mEc3rUD6WYpV+l
         3IaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769852328; x=1770457128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CnkO+pyfjOjiofNSg49xQZUi6tf7VfPDjwPBlAQ3BQ8=;
        b=VJrkieiVIVF0OhnIbm9Nzgm+kAJIcoP9QDUYg7k05VJC2lh/7LJG3gj5VEMXkogjaV
         bqQd/bt4lpdXZ9+9aMdK+azsqxuvUlkLRyGXWO+QvS3h40+xKIT8lGaN/vm4sJDFNKJP
         GG4RUQyq5C7t63ZRTTe5HnbYa0YHyxyytj6Te8WmbblqFMyWhVrGAXOQjdTfuGB01cEu
         Y1aFkgd7i3hH8+pHrz0ijCSor/eiiRKF5VaHM1RcAFGRzJCBzUC9uVOknu2pYd0tiRXl
         GBbmPoPW7jxTsnzeNXnJ56OonPQSOIdA0gXIjf7hZfem/7nA14C60vpOUrmiQ5iyJ9Pd
         K/Yw==
X-Forwarded-Encrypted: i=1; AJvYcCVvq5Je7VvEpmjL2D9+4UzrNCyRGFPS4mM+BdG/XkCqOcH5j+IZesdyiaD1Ib4meWoKEvJibunVSqE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx//UuxnZM7kHbhhj8LqfXBQADsnmnuGtWjsnKUqePzb7ERJQiU
	xob7WRNMEjm3D5xuoG8d705L4nl5CHHeqNOhk9F9o3UpTJ8VWe/B0tAn5OQa1geVBFitZ7tlnEz
	0Oj3hAgDPU4pHmMfLHjPuvIAWjuQu/C0=
X-Gm-Gg: AZuq6aLm4Hzkbm4V1UuwwdO52e5pdvpYvXDI9GW5/JnPuauxAmQ1Sxx71G6ED43mYJ0
	8yTNipft/3EpDHpCfy8EbHzURFaIzM+4fzxk4m82sT7j0eTNubO8FyCAEax5q6uHm6tF8Zv3L7n
	3JjIteEXRe1T1tBr/TYWMH3H8Qwx2qOJ6NdRev5sdONRyvSYzLhjEER0oa18Y87qUV/9cxFid4S
	75YzSNViSlpKtboIwD6Qop8fv95NTPCz+VxWxMSfxCpJaU4RhJju4dYUqBjeEYAh6anrRm4z+D7
	3w==
X-Received: by 2002:a05:6402:51d1:b0:658:ba49:96b8 with SMTP id
 4fb4d7f45d1cf-658e2e9f42cmr3349030a12.3.1769852327465; Sat, 31 Jan 2026
 01:38:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809073610.2517-1-linux.amoon@gmail.com> <aXtpg0V_sifQEWHJ@grimm-nixos-ssd-2>
 <aXyHITrZ89Mmn8_J@ryzen>
In-Reply-To: <aXyHITrZ89Mmn8_J@ryzen>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sat, 31 Jan 2026 15:08:42 +0530
X-Gm-Features: AZwV_Qi4rUDA22e6_H2MBH2utJIBF_ID2Uvxh97zfsLPgTyq0rIRh2L52PovAls
Message-ID: <CANAwSgTQ-cdyzd2WjHMYCY33p7um3CpjMeTzRO7vcd0fTF6X9Q@mail.gmail.com>
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

Hi Niklas/ Grimmauld,

On Fri, 30 Jan 2026 at 15:55, Niklas Cassel <cassel@kernel.org> wrote:
>
> Hello Grimmauld,
>
> On Thu, Jan 29, 2026 at 03:06:59PM +0100, Grimmauld wrote:
> > Hello Anand,
> >
> > I have tested this patch.
> > Hardware/Kernel information:
> > - radxa rock 5c lite
> > - rk3588s CPU, arm64
> > - defconfig NixOS kernel
> > - picked onto 6.18.7
> > - DT: rockchip/rk3588s-rock-5c.dtb
> > - tested both uboot (mainline) and edk2 (vendor)
> >
> > On Fri, Aug 09, 2024 at 01:06:09PM +0530, Anand Moon wrote:
> > > Rockchip DWC PCIe driver currently waits for the combo PHY link
> > > (PCIe 3.0, PCIe 2.0, and SATA 3.0) to be established link training
> > > during boot, it also waits for the link to be up, which could consume
> > > several milliseconds during boot.
> >
> > I found that without this patch, USB 3 ports as well as the PCIe connec=
tor seemingly stay uninitialized during boot on my hardware.
> > This manifests in a bootable USB flash drive loading initrd from bootlo=
ader (both uboot and edk2) perfectly, but then fails to mount the rootfs fr=
om the drive.
> > In effect, boot is not just slower than it should be, it just does not =
boot all the way at all.
> > In that scenario, the devfs entries corresponding to the flash drive ar=
e simply missing, same for the sysfs where i would expect the USB device li=
sted.
> > Replugging the USB flash drive during initrd does seem to fix that, but=
 is tedious and not viable for a server.
> > Similarly, booting from m.2 SSD attached via PCIe fails the same way, w=
ith rootfs timing out despite the bootloader correctly reading initrd on th=
e same drive.
> > Fwiw, replugging the SSD does not work like it does for USB flash drive=
s, and is even worse of an idea.
> > USB 2 ports as well as SD card boots correctly, even without your patch=
.
> > Without your patch, i am seeing "deferred probe pending" in dmesg befor=
e boot gets stuck, which was the hint which made me find your patch.
> > I am not sure whether that is the actual cause or just a symptom for wh=
y drives are not recognized during boot, and am not quite sure how to debug=
 this further.
> >
> > > To optimize boot time, this commit allows asynchronous probing.
> > > This change enables the PCIe link establishment to occur in the
> > > background while other devices are being probed.
> >
> > With this patch, booting from SSD or USB 3 port works flawlessly, and i=
 have not seen any regressions with SD card or USB 2 boot, nor any other ha=
rdware component.
> > This setup has worked for multiple boots without fail, both with tradit=
ional ext4 and zfs rootfs being loaded from USB 3 and PCIe.
> > Because i require this patch to run my rock 5c from SSD, i am currently=
 running a custom patched kernel, but would highly appreciate this patch ma=
king its way to mainline eventually.
> > There might well be something else going on here. The proposed patch ma=
y not be the "proper" fix to the issues i am seeing, but it does at least w=
ork.
> >
> > I have NOT tested boot from eMMC (either with or without this patch), t=
hough i have no reason to believe it would be impacted.
> >
> > I am happy to provide more info as needed. First time posting to the LK=
ML, i hope i am doing this right...
> >
> > Tested-by: Grimmauld <grimmauld@grimmauld.de>
Thanks for testing this patch.
>
> I tested this patch again on the latest kernel, and it still results in
> the "requesting loading a module with wait allowed while being called fro=
m
> async context can result in a deadlock" warning from the modules code.
> (With the calling code being phylib.)
> See the phylib splat that I previously reported in this thread.
>
I=E2=80=99ve attempted to reproduce the warning but was unable to trigger i=
t locally.

> Note that I've built the network PHY driver that phylib wants to load
> (CONFIG_REALTEK_PHY=3Dy) as built-in. As long as the PHY driver is built
> as built-in, I don't think that the problem the modules code is warning
> about can happen. (But I also don't understand why it is trying to load
> a module when the driver is built as built-in in the first place...)
>
But both CONFIG_PHYLIB and CONFIG_REALTEK_PHY are selected as buildin
for R8169 module.

I have tested with the built-in module
CONFIG_R8169=3Dy
CONFIG_R8169_LEDS=3Dy

As well as the module
CONFIG_R8169=3Dm
CONFIG_R8169_LEDS=3Dy

> Anyway, my networking is working perfectly fine even with the splat.
>
>
> Having async probing for the Rockchip PCIe controller driver, which is
> used a LOT of rockchip based SoCs, is a good thing, so I don't think it
> is right to avoid enabling async probing just because it results in a
> splat on a single rockchip based board (rock5b).
>
Yes, this could help in the module probe pci module.

Earlier, I thought gmac will control the r8169 module, but I was wrong.
Could you please try these changes at your end? These changes are
related to MIMO..

$ git diff ./arch/arm64/boot/dts/rockchip/rk3588-rock-5b-5bp-5t.dtsi
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-5bp-5t.dtsi
b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-5bp-5t.dtsi
index b3e76ad2d869..fb3a8ba4085a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-5bp-5t.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-5bp-5t.dtsi
@@ -477,7 +477,6 @@ &pcie2x1l0 {
 &pcie2x1l2 {
        pinctrl-names =3D "default";
        pinctrl-0 =3D <&pcie2_2_rst>;
-       reset-gpios =3D <&gpio3 RK_PB0 GPIO_ACTIVE_HIGH>;
        vpcie3v3-supply =3D <&vcc3v3_pcie2x1l2>;
        status =3D "okay";
 };
@@ -535,6 +534,12 @@ pcie3_vcc3v3_en: pcie3-vcc3v3-en {
                };
        };

+       rtl8211f {
+               rtl8211f_0_rst: rtl8211f-0-rst {
+                       rockchip,pins =3D <3 RK_PB0 RK_FUNC_GPIO &pcfg_pull=
_none>;
+               };
+       };
+
        usb {
                usbc0_int: usbc0-int {
                        rockchip,pins =3D <3 RK_PB4 RK_FUNC_GPIO &pcfg_pull=
_none>;
@@ -550,6 +555,19 @@ &pwm1 {
        status =3D "okay";
 };

+&mdio0 {
+       rgmii_phy0: ethernet-phy@1 {
+               /* RTL8211F */
+               compatible =3D "ethernet-phy-id001c.c916";
+               reg =3D <0x1>;
+               pinctrl-names =3D "default";
+               pinctrl-0 =3D <&rtl8211f_0_rst>;
+               reset-assert-us =3D <20000>;
+               reset-deassert-us =3D <100000>;
+               reset-gpios =3D <&gpio3 RK_PB0 GPIO_ACTIVE_LOW>;
+       };
+};
+
 &rknn_core_0 {
        npu-supply =3D <&vdd_npu_s0>;
        sram-supply =3D <&vdd_npu_s0>;

>
> Kind regards,
> Niklas

Thanks
-Anand
