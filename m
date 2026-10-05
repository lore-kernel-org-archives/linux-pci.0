Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAFD3769EA;
	Mon,  5 Oct 2026 12:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791203847; cv=none; b=Oih0Ef8B8OsAzYrgre80WWvbl/Y61vm+baRCCD0/3CeTNA4LYzDvv3VSA9drAZvMwwYd4W5tQzmznQMhWFlBOgxk0B2mcrn7cm+DJGFO2lLQUiTkgqEKnabExfFIDJiqNbDzBJj0q15qIFTXcq4s1I4TE0ye/HhHDK6iphH1/Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791203847; c=relaxed/simple;
	bh=l3OphedaPcqUbDa9OVB2ReALwEZdKEOpw+CJKoXknAw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UDKpiP81nGbFihOWrEnFNzcnD8/GD0MSk0Pfw4sn8mESvztlNxv3f1VwOhNp6IQXOALOWv4dKJyLEJKwDsGG0SBQlsehNHTYhmOeTuN7xUglursk0DwVD/CqtleV4NNBOUYoNBJ+FwtUGwOMRtw0aNoalA2YsiOWoa/m7X/JrSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E23osBtG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E23osBtG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA401F000FF;
	Mon,  5 Oct 2026 12:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791203845;
	bh=MWazUpUjiLdplpch4e2o6Zo6l4w3El+exbH9m71l7Rc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E23osBtGfk5uZQ1RZJFoXjHPTU0B+uYH3JM8zNsFoulRUouG3nizLo/30BUwKZerv
	 gWA2Lw+tV5oOuPLdk6nTe2UUu9mmAcuDpefo+jUy2773A6lLJcSqUQMEc4E6JMsB02
	 k6nYI0L8bTLCoihFpTPANC4WG1PCNa2h29LNT9ORiJHnPTZvKuzAEqB/rUQFTCpSPJ
	 kAmH/uoN9mN/DLY9Cn5BQcABS1IXgYYFhf2V1DiQHsVTdHCmT108o4dtEcr5LYGme2
	 kVcNElADzT+en8ECU9Q9FYyUFAJp8gNi0iuMvfgP3AhtvOjw+XSX6oAhb0cyGdVrL6
	 F6jAuLYsdifKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 8/8] arm64: dts: qcom: monaco-arduino-monza: Add
 QCA2066 M.2 WiFi/BT support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Loic Poulain" <loic.poulain@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org, robh@kernel.org
In-Reply-To: <20261005-monza-wireless-v7-8-5a6de7662dcb@oss.qualcomm.com>
References: <20261005-monza-wireless-v7-0-5a6de7662dcb@oss.qualcomm.com>
 <20261005-monza-wireless-v7-8-5a6de7662dcb@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 12:37:24 +0000
Message-Id: <20261005123724.DBA401F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] dts: qcom: missing clocks property in wireless-lga-connector
- [Low] dts: qcom: invalid bus-range property for downstream PCI bridge
--

commit 29a5722958bd298370461ff6846d50f2a2e13fa0
Author: Loic Poulain <loic.poulain@oss.qualcomm.com>

arm64: dts: qcom: monaco-arduino-monza: Add QCA2066 M.2 WiFi/BT support

This commit adds support for the QCA2066 WiFi/Bluetooth module on the
Arduino VENTUNO Q board. It introduces a wireless-lga-connector node and a
downstream pcie port to enable the M.2 slot power sequencer.

> diff --git a/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts b/arch/arm=
64/boot/dts/qcom/monaco-arduino-monza.dts
> index 940a03732eefc..f24a87bd7cbf6 100644
> --- a/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
> +++ b/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
> @@ -178,6 +178,40 @@ vreg_nvme: regulator-3p3-m2 {
>  		enable-active-high;
>  		startup-delay-us =3D <20000>;
>  	};
> +
> +	wireless-lga-connector {
> +		compatible =3D "qcom,pcie-m2-1418-lga-connector",
> +			     "pcie-m2-e-connector";
> +		vpcie3v3-supply =3D <&vdc_3v3>;
> +		vpcie1v8-supply =3D <&vdc_1v8>;
> +		w-disable1-gpios =3D <&tlmm 56 GPIO_ACTIVE_LOW>;
> +		w-disable2-gpios =3D <&tlmm 55 GPIO_ACTIVE_LOW>;

[Severity: Low]
Is the clocks property missing here in the wireless-lga-connector node for
the M.2 SUSCLK routing?

The clocks property is defined in the pcie-m2-e-connector binding and was
previously included in the legacy bluetooth node, but appears to have been
dropped during the transition to the new node. Because sleep_clk is a fixed
clock that is physically always running on this platform, the omission caus=
es
no functional regression, but the Device Tree hardware description seems
incomplete without the SUSCLK routing.

[ ... ]
> @@ -541,6 +575,22 @@ pcie@0,0 {
>  		ranges;
>  		reg =3D <0x010000 0x00 0x00 0x00 0x00>;
> =20
> +		pcie@1,0 {
> +			#address-cells =3D <3>;
> +			#size-cells =3D <2>;
> +			device_type =3D "pci";
> +			compatible =3D "pciclass,0604";
> +			bus-range =3D <0x00 0xff>;

[Severity: Low]
Does this bus-range property in the pcie@1,0 node define an invalid
secondary bus?

The bus-range property claims the downstream bridge's secondary bus is 0,
which violates PCI numbering rules since its primary bus is 2 (encoded in
the reg property as 0x020800).

The Linux PCI core dynamically reassigns invalid topologies for downstream
bridges, preventing functional breakage. However, specifying a topologically
invalid bus range in the DT seems to be an error.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005-monza-wire=
less-v7-0-5a6de7662dcb@oss.qualcomm.com?part=3D8
