Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793267904;
	b=hT8D0XNCWtoW5dARP67OtqEZSua4c9QAnGVEifbtc4gnssAwKHjcqC4nPdg85zA+yDnf
	 tOnl0jskW03M/LnXq8OLXcBG2FVadZHp7EHkiHpd7u+7+msG4GVwHQzccbRmOfJXx2/kO
	 dP8BQqD1WiZiCvDP6RBOp7LVjMxlK33U/cvgNrbnEkisxe9RNsfurrZWNViwkoU9qEaDI
	 mWcbMI25ES1QaKYjfDjPe+SNmTJ2GFdnFv2bs5WNPu6xdUo3R47/rhAswv86cyWp//hot
	 KJWXnygzalS0PDuOx/fyxCoeX7LVvPgj8z46wHIR6biOoCmDOMbVyNGZV0oDcvgrMUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793267904;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Ehad/V6Xbh5JId3uEy79I5nAeDepddQdYNwUbSw35YQ=;
	b=aUU+lRagF5XHwvPv6VujsbzP0kz1Fy5Yqr2akCVqUl4A/Zl1TTYj8zBlyMAxxwxawT76
	 BxMgVtPil8JuKR1nPkG0XkvAotjlQQNFOpGD05JxU2tJdvfVrmQbYSrWsqykQZWXo4jJX
	 IVoCqhvlvVqi3Kr+9+tVVSFxb0RQ+feYtRGQVW1CEow0gesnb5/346f1kKQUsNJ1AwsMF
	 uR+8qwQ8mxtesudHzYEZMeMphZofA7wU9mCDcQHmxDsc4BseO/HcRUzjjzJokCdBTkj3F
	 P2LUul6VKJpceePhm/jJjzGAMHgm8b4XQcFAKgSkQRFmlQtsjjTlC0oQ7S/lZr0yd0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AOqBrbBi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D667606A31C;
	Thu, 29 Oct 2026 09:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AOqBrbBi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8444B1F01828;
	Thu, 29 Oct 2026 09:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793267903;
	bh=Ehad/V6Xbh5JId3uEy79I5nAeDepddQdYNwUbSw35YQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AOqBrbBi1Cm+XWBBqmePq72TskRADhH1xnlA2zy1SJwy2BOYe828/clupJ1f81wDG
	 DHWTpp3NJR5LSslc1nXspp/VraMBsqaycO3ZysDz3pw3vhcCUx9cJAUlojcmujKDew
	 6pqnYy2uQj00mtvaNYEH4Fsj0OyjIhngGsBsDGGH8e+nbrN83AxCnwPvqGz2krozw2
	 ZmSq97eDnlQADoY6Yd/d2372rRVkkDVgmeXLzln8eTvrZe/pJsEI1eHFTynMBXU6a0
	 FTE1amNS+rSJv5sR43XLMbR9t5jxSNSULfHMThivHt+cEwQrNtZDmjrrwI7mqjgVSg
	 jb7Zmq9KEzLEQ==
Message-ID: <sashiko-outbox-189075@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] arm64: dts: qcom: sc8280xp: add Radxa Dragon Q8B
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xilin Wu" <sophon@radxa.com>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261029-q8b-dts-v3-3-655696dfec45@radxa.com>
References: <20261029-q8b-dts-v3-0-655696dfec45@radxa.com>
 <20261029-q8b-dts-v3-3-655696dfec45@radxa.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 09:58:23 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] arm64: dts: qcom: missing pinctrl properties on uart2 in dragon-=
q8b
--

commit 806aef47629e5a5fdf23480747e829d1b21764d6
Author: Xilin Wu <sophon@radxa.com>

arm64: dts: qcom: sc8280xp: add Radxa Dragon Q8B

This commit adds initial device tree support for the Radxa Dragon Q8B
single-board computer based on the Qualcomm Snapdragon 8cx Gen 3 SC8280XP
platform.

> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-radxa-dragon-q8b.dts b/arc=
h/arm64/boot/dts/qcom/sc8280xp-radxa-dragon-q8b.dts
> new file mode 100644
> index 0000000000000..fd1e29ce83b27
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-radxa-dragon-q8b.dts
> @@ -0,0 +1,2049 @@

[ ... ]

> +/* E-key Bluetooth */
> +&uart2 {
> +	uart-has-rtscts;
> +	status =3D "okay";
> +
> +	port {
> +		uart2_ep: endpoint {
> +			remote-endpoint =3D <&wlan_uart_ep>;
> +		};
> +	};
> +};

[Severity: Medium]
Should the &uart2 node in arch/arm64/boot/dts/qcom/sc8280xp-radxa-dragon-q8=
b.dts
include pinctrl-0 and pinctrl-names properties?

In arch/arm64/boot/dts/qcom/sc8280xp.dtsi, the base uart2: serial@988000 no=
de
does not define default pinctrl properties:

    uart2: serial@988000 {
        compatible =3D "qcom,geni-uart";
        reg =3D <0 0x00988000 0 0x4000>;
        ...
        status =3D "disabled";
    };

Instead, the pin configuration state qup_uart2_default (for gpio121 CTS,
gpio122 RTS, gpio123 TX, and gpio124 RX) is defined separately under &tlmm =
in
sc8280xp.dtsi for board device trees to reference.

When qcom_geni_serial probes uart2 for the M.2 E-key Bluetooth interface and
activates resources via pinctrl_bind_pins() and geni_se_resources_on() ->
pinctrl_pm_select_default_state(), the TLMM pins for UART2 will not be muxed
to the qup2 function or configured by Linux without:

    pinctrl-0 =3D <&qup_uart2_default>;
    pinctrl-names =3D "default";

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-q8b-dts-v3=
-0-655696dfec45@radxa.com?part=3D3
