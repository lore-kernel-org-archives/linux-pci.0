Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793270657;
	b=asVuVjvmwh1e5wymuvOiitkGMdKinaJJmoYn6jR5t2M/jR1KdRe4t9j+T3X2uB1JSOas
	 myPPh+4tK3+26/iz33UZRBniftPI8gvXMLIzPiQWJJserjIwHYRVIiliBKlChQYbJEFkD
	 eIRqb1SIu1dQE75sP+qNHhFCc2C6eS3hupzo5Ubh1hD5mtSi1MuITHFUWVT9nqhPXU+Kl
	 DHSeB+9anAN2DHJhq1EbRHk5pzFn1LqD9YaWUboU3AXSnydWuE0lKH1TkHO4/fX/K+pjl
	 e1oXj/+EXDPnKfwlgC6TxvtOLmTnVQMZk8i8ItQDpiIKhkxERUElmhcENTnuctY0PQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793270657;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+/WwjKbZcBdnKdvk2yMh2fCuGiIiefEl1kls9qfi+Ss=;
	b=wL43v264OrGj6te2lZcmqSgZwU5t8qj1swj+1xOFImuTgnu06+RXEwVBF7xayIuSFnRf
	 kYYHg59pSKyFeXGzcuu7xsfIIiPqXGjES3YtJjJmjZXZ2EhXb6m7kl4HobMJ+tR4sS/2w
	 L8HKnEDTAsZDzhbTFZ9X7jtlp+sSt2QXKq/EwDUNJpprz+DQtSoZ3+vm+CxRpwZ+ZB8LH
	 5UDIcKQUOM/V0wLtixDhB8QFlubZI0GcJBl0pyF80AdZL3qiRwHn2FMwQo8dgUMa8rlRO
	 q4lIrEMr0wUVWO6PKuPf+3VzQbhVoUEO30TUhKPVJ7O6w/ff5LMj7bqschzskvsxhmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JsZjxksa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E9D606A325;
	Thu, 29 Oct 2026 10:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JsZjxksa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97DC11F031E0;
	Thu, 29 Oct 2026 10:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793270657;
	bh=+/WwjKbZcBdnKdvk2yMh2fCuGiIiefEl1kls9qfi+Ss=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JsZjxksauwKD/Zbdj/1Z1P36BC5OSO0nr1Hi38qx9u2taRfIFuhpY5LP53DpKfI2g
	 7+FEf4A4yuPCGzMaqNu8C2Wmo/xy6bhcn3CbPuJnJA32vFybvyuUWX3selj9ZZ/jcN
	 WeSQJn3rhuCyqTx5q+lZjleH8sFR50WBV+togjaTQdq3XhEcMrgp/qjS4fELEJEBeY
	 BRnBsCS3XOTWJTOXQf4GCQ7pKXMdOS8aeR4lkELO1vgfyWkchpjKwxIQD0WjvXSIda
	 5yOFk6mq211dQgnScZ/aoNhevnqsDpF/RP6+YIXfqXcPpjBnLf1IJ5RIn7YqfD3cpL
	 wtdlSE3hdBLqQ==
Message-ID: <sashiko-outbox-189146@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/4] arm64: dts: qcom: sc8280xp: add Radxa Dragon Q8B
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xilin Wu" <sophon@radxa.com>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261029-q8b-dts-v4-3-e8e7438f5545@radxa.com>
References: <20261029-q8b-dts-v4-0-e8e7438f5545@radxa.com>
 <20261029-q8b-dts-v4-3-e8e7438f5545@radxa.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 10:44:16 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] arm64: dts: qcom: unpopulated ADC7_AMUX_THM5 channel breaks adp1=
2v_voltage
- [Medium] arm64: dts: qcom: invalid trip2 in pmc8280c-thermal breaks CPU t=
hrottling
--

commit 1587f072e6febbe214d258d0ce37a60770079813
Author: Xilin Wu <sophon@radxa.com>

arm64: dts: qcom: sc8280xp: add Radxa Dragon Q8B

This commit adds initial device tree support for the Radxa Dragon Q8B
single-board computer based on the Qualcomm Snapdragon 8cx Gen 3 SC8280XP
platform.

> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-radxa-dragon-q8b.dts b/arc=
h/arm64/boot/dts/qcom/sc8280xp-radxa-dragon-q8b.dts
> new file mode 100644
> index 0000000000000..e0fae337ab667
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-radxa-dragon-q8b.dts

[ ... ]

> +	thermal-zones {

[ ... ]

> +		pmc8280c-thermal {
> +			cooling-maps {
> +				map0 {
> +					trip =3D <&pmc8280c_alert0>;
> +					/* Throttle X1C cores to 2496MHz at 105C */
> +					cooling-device =3D <&cpu4 5 5>,
> +							 <&cpu5 5 5>,
> +							 <&cpu6 5 5>,
> +							 <&cpu7 5 5>;
> +				};
> +			};
> +
> +			trips {
> +				pmc8280c_alert0: trip2 {
> +					temperature =3D <105000>;
> +					hysteresis =3D <0>;
> +					type =3D "passive";
> +				};
> +			};
> +		};

[Severity: Medium]
Can this trip2 node in pmc8280c-thermal work as intended alongside the base
definition in arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi?

In sc8280xp-pmics.dtsi, pmc8280c_thermal already defines two trips on
pmc8280c_temp_alarm (which has no io-channels property):

	pmc8280c_thermal: pmc8280c-thermal {
		polling-delay-passive =3D <100>;

		thermal-sensors =3D <&pmc8280c_temp_alarm>;

		trips {
			trip0 {
				temperature =3D <95000>;
				hysteresis =3D <0>;
				type =3D "passive";
			};

			trip1 {
				temperature =3D <115000>;
				hysteresis =3D <0>;
				type =3D "critical";
			};
		};
	};

Appending trip2 at 105000 mC results in three trips ordered as 95000, 11500=
0,
and 105000. In drivers/thermal/qcom/qcom-spmi-temp-alarm.c:

1. On GEN2 rev2 hardware, qpnp_tm_init() ->
   qpnp_tm_gen2_rev2_configure_trip_temps() programs the three hardware sta=
ges
   in DTB order and then enforces strictly increasing thresholds:

	for (i =3D 1; i < STAGE_COUNT; i++) {
		if (chip->temp_thresh_map[i] <=3D chip->temp_thresh_map[i - 1]) {
			dev_err(chip->dev, "Threshold %d=3D%ld <=3D threshold %d=3D%ld\n",
				i, chip->temp_thresh_map[i], i - 1,
				chip->temp_thresh_map[i - 1]);
			return -EINVAL;
		}
	}

   Because threshold 2 (105000) is less than threshold 1 (115000), probe
   fails with -EINVAL.

2. On GEN2 rev0/rev1 hardware without an ADC channel, qpnp_tm_get_temp() ->
   qpnp_tm_update_temp_no_adc() only reports discrete stage temperatures
   (37000 mC in Stage 0, 97000 mC in Stage 1, and 117000 mC in Stage 2):

	if (stage_new > stage_old) {
		/* increasing stage, use lower bound */
		chip->temp =3D qpnp_tm_decode_temp(chip, stage_new)
				+ TEMP_STAGE_HYSTERESIS;
	}

   As temperature rises, the reported value jumps directly from 97000 mC to
   117000 mC (crossing trip1 at 115000 mC), so trip2 at 105000 mC and its C=
PU
   cooling map will never activate before shutdown.

Should pmc8280c-thermal override trip0 (or wire an ADC channel to
pmc8280c_temp_alarm) instead of adding trip2?

[ ... ]

> +	adp12v_voltage: voltage-divider-adp12v {
> +		compatible =3D "voltage-divider";
> +		io-channels =3D <&pmk8280_vadc PM8350_ADC7_AMUX_THM5(1)>;
> +		#io-channel-cells =3D <1>;
> +
> +		/* R470 (110K) in series with R471 (10K) to ground. */
> +		full-ohms =3D <120000>;
> +		output-ohms =3D <10000>;
> +	};

[ ... ]

> +&pmk8280_vadc {
> +	channel@108 {
> +		reg =3D <PM8350_ADC7_AMUX_THM5(1)>;
> +		qcom,hw-settle-time =3D <200>;
> +		qcom,pre-scaling =3D <1 1>;
> +		label =3D "adp12v_det";
> +	};

[Severity: Medium]
Will channel@108 and its consumers adp12v_voltage and iio-hwmon fail to pro=
be
at runtime when using PM8350_ADC7_AMUX_THM5(1)?

In drivers/iio/adc/qcom-spmi-adc5.c, pmk8280_vadc (compatible "qcom,spmi-ad=
c7")
uses adc7_chans_pmic[]. That array defines [ADC7_AMUX_THM5_100K_PU] (0x48),
but has no entry for unpulled [ADC7_AMUX_THM5] (0x08):

	static const struct adc5_channels adc7_chans_pmic[ADC5_MAX_CHANNEL] =3D {
		[ADC7_REF_GND]		=3D ADC5_CHAN_VOLT("ref_gnd", 0,
						SCALE_HW_CALIB_DEFAULT)
		...
		[ADC7_AMUX_THM5_100K_PU] =3D ADC5_CHAN_TEMP("amux_thm5_pu2", 0,
						SCALE_HW_CALIB_THERM_100K_PU_PM7)

When adc5_get_fw_data() initializes channel@108 from adc7_chans_pmic[0x08],
the zero-initialized entry leaves iio_chan->info_mask_separate as 0.

When drivers/iio/afe/iio-rescale.c probes adp12v_voltage via rescale_probe(=
) ->
rescale_configure_channel(), it checks the source channel capabilities:

	if (iio_channel_has_info(schan, IIO_CHAN_INFO_RAW) &&
	    (iio_channel_has_info(schan, IIO_CHAN_INFO_SCALE) ||
	     iio_channel_has_info(schan, IIO_CHAN_INFO_OFFSET))) {
		dev_info(dev, "using raw+scale/offset source channel\n");
	} else if (iio_channel_has_info(schan, IIO_CHAN_INFO_PROCESSED)) {
		dev_info(dev, "using processed channel\n");
		rescale->chan_processed =3D true;
	} else {
		dev_err(dev, "source channel is not supported\n");
		return -EINVAL;
	}

Because neither IIO_CHAN_INFO_RAW nor IIO_CHAN_INFO_PROCESSED is set on the
source channel, adp12v_voltage fails to probe with -EINVAL, and the
downstream iio-hwmon node defers probe indefinitely.

Does adc7_chans_pmic[] in drivers/iio/adc/qcom-spmi-adc5.c need an
ADC7_AMUX_THM5 voltage channel entry before this channel can be used here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-q8b-dts-v4=
-0-e8e7438f5545@radxa.com?part=3D3
