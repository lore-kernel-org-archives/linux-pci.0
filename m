Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E85550DBE;
	Tue,  8 Sep 2026 15:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788882147; cv=none; b=M0w/XwkeNi8dP1l7EccV8o10/jBFWM0/yidP7QjZhTk9EyEgkjFfSwsTqXpo+YHC6JYCZ3cnUNvx86z3p7zY2+n/amjTkvYcVovAT44FH3OkRGHqn73lsQwC5EwcvUaS+AdYPj6+P4SWXlX0VoH79VxMmcBm2UqdjyGmWV+aC7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788882147; c=relaxed/simple;
	bh=gpXIqvcsWu3k5PBYYwLgojfkEo7p4v/88ZEi+fP/94g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tUkjfkJUJKpK0fTi7OCVuM6yVoM9DznW7JDzx83XQpLCbs7aZTX6GmPRRe3KCI99ACKB50NgoRglQGn6C15Tzar7bpr0aWA+AqF6THHzbfItZLSJQWdoqfXiwStipzSawwlMTVfOtDH9nJC5h7N6DZHzGEpJoZrTrqJ3JIdqMbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 263CC1F00A3D;
	Tue,  8 Sep 2026 15:42:25 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/5] arm64: dts: qcom: qcs6490-rb3gen2: Enable TC9563
 embedded GPIO controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lorenzo Bianconi" <lorenzo.bianconi@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260908-pci-tc9563-aux-v4-5-c7fc7778292b@oss.qualcomm.com>
References: <20260908-pci-tc9563-aux-v4-0-c7fc7778292b@oss.qualcomm.com>
 <20260908-pci-tc9563-aux-v4-5-c7fc7778292b@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 15:41:54 +0000
Message-Id: <20260908154225.263CC1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but in `pci_pwrctrl_=
power_on_device()`, if powering on a child node fails (e.g., returning `-EP=
ROBE_DEFER`), previously successfully powered-on sibling children within th=
e same loop iteration are not rolled back, leading to left-on power states.
--

commit f88f26b5508f76a873435c0070f5f6adab4564f7
Author: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

arm64: dts: qcom: qcs6490-rb3gen2: Enable TC9563 embedded GPIO controller

This commit adds the TC9563 embedded GPIO controller to the QCS6490-RB3Gen2
device tree. It describes the switch node as a GPIO controller and uses it
to drive the PERST# reset lines for two external downstream PCIe ports
(pcie@1,0 and pcie@2,0).

> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/bo=
ot/dts/qcom/qcs6490-rb3gen2.dts
> index a13315bf0fb07..4da7342ca90d6 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts

[ ... ]

> @@ -891,6 +891,9 @@ pcie@0,0 {
>  		pinctrl-0 =3D <&tc9563_resx_n>;
>  		pinctrl-names =3D "default";
> =20
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +
>  		pcie1_switch0_dsp1: pcie@1,0 {
>  			reg =3D <0x20800 0x0 0x0 0x0 0x0>;
>  			#address-cells =3D <3>;
> @@ -899,6 +902,7 @@ pcie1_switch0_dsp1: pcie@1,0 {
>  			device_type =3D "pci";
>  			ranges;
>  			bus-range =3D <0x3 0xff>;
> +			reset-gpios =3D <&tc9563 2 GPIO_ACTIVE_LOW>;
>  		};
> =20
>  		pcie@2,0 {
> @@ -909,6 +913,7 @@ pcie@2,0 {
>  			device_type =3D "pci";
>  			ranges;
>  			bus-range =3D <0x4 0xff>;
> +			reset-gpios =3D <&tc9563 3 GPIO_ACTIVE_LOW>;

[Severity: High]
This isn't a bug introduced by this patch, but adding multiple downstream P=
CIe
ports under a single power-controlled switch node here exposes a pre-existi=
ng
resource leak in the PCI power control core.

In pci_pwrctrl_power_on_device(), if powering on a child node fails (for
example, returning -EPROBE_DEFER for pcie@2,0), previously successfully
powered-on sibling children within the same loop iteration (like pcie@1,0)
are not rolled back:

drivers/pci/pwrctrl/core.c:pci_pwrctrl_power_on_device() {
    ...
    for_each_available_child_of_node_scoped(np, child) {
        ret =3D pci_pwrctrl_power_on_device(child);
        if (ret)
            return ret;
    }
    ...
}

Because the function returns immediately on failure, the regulator and clock
enable counts for the earlier siblings are permanently leaked. Since probe
deferral is a standard boot path, this leads to unbounded resource enable
increments.

Should pci_pwrctrl_power_on_device() be updated to power off successfully
processed children during the error path before returning?

> =20
>  			/* Renesas =CE=BCPD720201 PCIe USB3.0 Host Controller */
>  			usb-controller@0,0 {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-pci-tc9563=
-aux-v4-0-c7fc7778292b@oss.qualcomm.com?part=3D5
