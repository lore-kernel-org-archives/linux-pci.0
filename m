Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793265630;
	b=jPqp1k8IVPt5o/GJGRcANxkoi4BzIFWEH23WStQS9TKAlEiNiE+0KytUJvhiKhqxzslz
	 Gnwvvw8fPoFzfKDZh5pKiavxvioXlSLOM+/6IvGlaHTrlNrfngJLmvw2PGodIv51NnbJO
	 +Pts/6v37C6iqfiqBDWhB1sF+tpBVN0mgU1vsnlxvx939lQ1cchgorRYNsdXa2NnmaSUK
	 asUkbAZEMCSLY10vWS1jkCT0iO45bNgzajIja/CA7HQJj0v+wHqtF0pGc/QlDWZJ5C0Sw
	 6NwiUfkRjvETFmusaGROz4a9GXQ4/NwVTA6ovzegWbOyM/zrGxzNbnb5SJPVZ7QYnnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793265630;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5RR5kihfrdPaS8RZVjjuFZs4WwUuezwWmmbVwCww+l0=;
	b=jGSQ8MU/ISfIxqXjCmgDUPmdi1W7WfPKeIgZzU9fSOrwoPfXiqpXST9Q+JBIvparoNwn
	 f1gZ+CacE4jy9iOizikMDZTfJyTS3LblkvvtrldLGMnqemN+X0AihQz2zGRN0olBG5aZq
	 lQQC1NCw2GeNSvcqUG1taVIB8zDrSxAscyNea6JWxOsuVbmFdJAror08L0BJIMC5yaY0E
	 XQRN1+r6PP7LALswsdMiLIGS/O2k+d9Gey+1OKkDulYmJd3r6miGqnGD+SEs1uTCWW7Ry
	 bYot02HerfayNScnebfe55Xn0SxSv6LnQCOCi8facNRuLaSphhf2ZKpIFZvSlamCNZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AQZUrT35;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B11606A326;
	Thu, 29 Oct 2026 09:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AQZUrT35
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A8B01F01829;
	Thu, 29 Oct 2026 09:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793265630;
	bh=5RR5kihfrdPaS8RZVjjuFZs4WwUuezwWmmbVwCww+l0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AQZUrT35scEV2G6+eTUjxU/qbIMLP//HkL2hnNJrwPX6x54RXVlIMIu0gOboH6z12
	 qc2v5XZWXfg1vIaaq42QH119j+lsIfDhJ18K0uaAfCSfvQN2zX1dV40Nn9zVcNKqi7
	 kAw3Aq4v/EXyHojggFeVNZWnzb4Lwh3+5VPNfI33HWAm7DdrKHh8hmArFVdEcVfvpn
	 zF/rlwZ9zz7kDipZ7x8ZAAlcUkFxikyS16BA9MsVVIyb22zOjs0p8lA1HLA/YJmP5q
	 Dcuo6ZgvGmPh9MNwGfxSSfmJDoUJMxRUgbMWDBLk77j9QlBckIvU5WrElJXW5WH3vd
	 3yKurh9FrmNtQ==
Message-ID: <sashiko-outbox-189027@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 13/14] hwmon: add support for x86 macs in
 macsmc-hwmon
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atharva Tiwari" <atharvatiwarilinuxdev@gmail.com>
Cc: "Bjorn Helgaas" <bhelgaas@google.com>, "Thomas Gleixner" <tglx@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>, "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org, "H.
 Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Len
 Brown" <lenb@kernel.org>, "Linus Walleij" <linusw@kernel.org>, "Bartosz
 Golaszewski" <brgl@kernel.org>, "Sven Peter" <sven@kernel.org>, "Janne
 Grunau" <j@jannau.net>, "Neal Gompa" <neal@gompa.dev>, "Guenter Roeck" <linux@roeck-us.net>, "Jonathan
 Cameron" <jic23@kernel.org>, "David Lechner" <dlechner@baylibre.com>,
 =?utf-8?b?TnVubyBTw6E=?= <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, "Lee
 Jones" <lee@kernel.org>, "Pavel Machek" <pavel@kernel.org>, "Griffin
 Kroah-Hartman" <griffin@kroah.com>, "Hans de Goede" <hansg@kernel.org>,
 =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, "Sebastian
 Reichel" <sre@kernel.org>, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, "Wim
 Van Sebroeck" <wim@linux-watchdog.org>, "Jarkko Sakkinen" <jarkko@kernel.org>, "Mimi
 Zohar" <zohar@linux.ibm.com>, "Roberto Sassu" <roberto.sassu@huawei.com>, "Dmitry
 Kasatkin" <dmitry.kasatkin@gmail.com>, "Eric Snowberg" <eric.snowberg@oracle.com>, "Paul
 Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-leds@vger.kernel.org, mfd@lists.linux.dev, linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <20261029085504.3547-14-atharvatiwarilinuxdev@gmail.com>
References: <20261029085504.3547-1-atharvatiwarilinuxdev@gmail.com>
 <20261029085504.3547-14-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 09:20:27 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] hwmon: macsmc: NULL pointer dereference in DT sensor label handling
- [High] hwmon: macsmc: macsmc_hwmon_create_fan_acpi() treats positive read=
 return as error
- [High] hwmon: macsmc: unchecked fan setup in macsmc_hwmon_populate_sensor=
s_acpi()
- [High] hwmon: macsmc: endianness bug in macsmc_hwmon_write_old_fan_manual=
()
- [Medium] hwmon: macsmc: macsmc_hwmon_write_fan() swallows target write er=
rors with > 0
--

commit 4bcde7b8b0bda2dbb66c2bfcaa1b0806af093c48
Author: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

hwmon: add support for x86 macs in macsmc-hwmon

This commit adds support for Intel Macs to macsmc-hwmon, exposing readable
sensor names for temperature, power, current, and voltage keys, as well as
fan speed reporting and manual control on ACPI platforms.

> diff --git a/drivers/hwmon/macsmc-hwmon.c b/drivers/hwmon/macsmc-hwmon.c
> index 2e74dcd6651b3..29e43ff4b4feb 100644
> --- a/drivers/hwmon/macsmc-hwmon.c
> +++ b/drivers/hwmon/macsmc-hwmon.c
[ ... ]
> @@ -47,7 +52,7 @@ MODULE_PARM_DESC(fan_control,
>  struct macsmc_hwmon_sensor {
>  	struct apple_smc_key_info info;
>  	smc_key macsmc_key;
> -	char label[MAX_LABEL_LENGTH];
> +	char *label;
>  	u32 attrs;
>  };

[Severity: High]
Will changing sensor->label from an inline char array to a pointer cause a
null pointer dereference on Device Tree platforms during
macsmc_hwmon_probe() -> macsmc_hwmon_populate_sensors()?

In macsmc_hwmon_populate_sensors(), the sensor arrays are allocated with
devm_kcalloc(), leaving sensor->label initialized to NULL. When
macsmc_hwmon_create_sensor() runs for a Device Tree node with a label
property, it still writes directly to sensor->label using sizeof(char *):

drivers/hwmon/macsmc-hwmon.c:macsmc_hwmon_create_sensor() {
	...
	ret =3D of_property_read_string(sensor_node, "label", &label);
	if (ret)
		dev_dbg(dev, "No label found for sensor %s\n", key);
	else
		strscpy_pad(sensor->label, label, sizeof(sensor->label));
}

And if a Device Tree sensor node does not have a label property,
sensor->label remains NULL when macsmc_hwmon_populate_sensors() immediately
dereferences it across the current, power, temperature, and voltage loops:

drivers/hwmon/macsmc-hwmon.c:macsmc_hwmon_populate_sensors() {
	...
	if (!macsmc_hwmon_create_sensor(hwmon->dev, hwmon->smc, key_node, sensor))=
 {
		sensor->attrs =3D HWMON_C_INPUT;

		if (*sensor->label)
			sensor->attrs |=3D HWMON_C_LABEL;
	...
}

[ ... ]
> @@ -599,6 +605,23 @@ static int macsmc_hwmon_read_fan(struct macsmc_hwmon=
 *hwmon, u32 attr, int chan,
>  	}
>  }
> =20
> +static int macsmc_hwmon_write_old_fan_manual(struct macsmc_hwmon *hwmon,=
 u8 val, int channel)
> +{
> +	int ret;
> +	u16 buf;
> +
> +	ret =3D apple_smc_read_u16(hwmon->smc, __SMC_KEY('F', 'S', '!', ' '), &=
buf);
> +	if (ret)
> +		return ret;
> +
> +	if (val)
> +		buf |=3D BIT(channel);
> +	else
> +		buf &=3D ~BIT(channel);
> +
> +	return apple_smc_write_u16(hwmon->smc, __SMC_KEY('F', 'S', '!', ' '), c=
pu_to_be16(buf));
> +}

[Severity: High]
Should buf be converted with be16_to_cpu() after apple_smc_read_u16() in
macsmc_hwmon_write_old_fan_manual()?

Because apple_smc_read_u16() reads raw big-endian bytes into buf without
byte-swapping, modifying BIT(channel) on the unswapped value and then
passing cpu_to_be16(buf) to apple_smc_write_u16() swaps the high and low
bytes of the manual fan bitmask on little-endian systems. For example, once
fan 0 is placed in manual mode (0x0001 big-endian, read into buf as 0x0100),
clearing BIT(0) on buf is a no-op and writes 0x0001 big-endian back to the
SMC, leaving fan 0 stuck in manual mode.

>  static int macsmc_hwmon_write_fan(struct device *dev, u32 attr, int chan=
nel,
>  				  long val)
>  {
[ ... ]
> @@ -625,7 +649,10 @@ static int macsmc_hwmon_write_fan(struct device *dev=
, u32 attr, int channel,
>  	if (val >=3D min && val <=3D max) {
>  		if (!hwmon->fan.fans[channel].manual) {
>  			/* Write 1 to mode key for manual control */
> -			ret =3D macsmc_hwmon_write_key(hwmon->smc,
> +			if (hwmon->fan.has_old_manual)
> +				ret =3D macsmc_hwmon_write_old_fan_manual(hwmon, 1, channel);
> +			else
> +				ret =3D macsmc_hwmon_write_key(hwmon->smc,
>  						     &hwmon->fan.fans[channel].mode, 1);
>  			if (ret < 0)
>  				return ret;
> =20
>  			hwmon->fan.fans[channel].manual =3D true;
>  		}
>  		return macsmc_hwmon_write_key(hwmon->smc,
> -					      &hwmon->fan.fans[channel].set, val);
> +					      &hwmon->fan.fans[channel].set, val) > 0;

[Severity: Medium]
Why is the return value of macsmc_hwmon_write_key() compared with > 0 here
in macsmc_hwmon_write_fan()?

The relational comparison turns any negative error code returned by
macsmc_hwmon_write_key() into 0, causing hwmon_attr_store() to treat failed
writes to the fan target key as successful.

[ ... ]
> @@ -871,6 +1475,57 @@ static int macsmc_hwmon_create_fan(struct device *d=
ev, struct apple_smc *smc,
>  	return 0;
>  }
> =20
> +static int macsmc_hwmon_create_fan_acpi(struct apple_smc *smc,
> +					struct macsmc_hwmon_fan *fan, int num)
> +{
> +	const char num_char =3D num + '0';
> +	int ret;
> +
> +	ret =3D macsmc_hwmon_create_sensor_acpi(smc, &fan->now,
> +			__SMC_KEY('F', num_char, 'A', 'c'), NULL, 0);
> +	if (ret)
> +		return ret;
> +
> +	if (apple_smc_key_exists(smc, __SMC_KEY('F', num_char, 'I', 'D'))) {
> +		char buf[17];
> +
> +		ret =3D apple_smc_read(smc, __SMC_KEY('F', num_char, 'I', 'D'), buf, 1=
6);
> +		if (ret)
> +			return ret;

[Severity: High]
Does checking if (ret) after apple_smc_read() cause
macsmc_hwmon_create_fan_acpi() to abort on success whenever the F%dID key is
present?

On ACPI platforms, apple_smc_read() delegates to apple_smc_acpi_read(),
which returns the positive number of bytes read (16) on success:

drivers/platform/x86/macsmc-acpi.c:apple_smc_acpi_read() {
	...
	if (ret < 0)
		return ret;

	return size;
}

When F%dID exists and is read, ret is 16, so macsmc_hwmon_create_fan_acpi()
returns 16 early before initializing fan->label, the min/max/target/mode
sensors, and fan->attrs.

[ ... ]
> @@ -990,6 +1645,101 @@ static int macsmc_hwmon_populate_sensors(struct ma=
csmc_hwmon *hwmon,
[ ... ]
> +static int macsmc_hwmon_populate_sensors_acpi(struct macsmc_hwmon *hwmon)
> +{
> +	int ret, i;
> +
> +	ret =3D apple_smc_read_u8(hwmon->smc, SMC_KEY(FNum), &hwmon->fan.count);
> +	if (hwmon->fan.count && !ret) {
> +		hwmon->fan.fans =3D devm_kcalloc(hwmon->dev, hwmon->fan.count,
> +				sizeof(struct macsmc_hwmon_fan), GFP_KERNEL);
> +		if (!hwmon->fan.fans)
> +			return -ENOMEM;
> +
> +		hwmon->fan.has_old_manual =3D apple_smc_key_exists(hwmon->smc,
> +				__SMC_KEY('F', 'S', '!', ' '));
> +
> +		for (i =3D 0; i < hwmon->fan.count; i++) {
> +			macsmc_hwmon_create_fan_acpi(hwmon->smc, &hwmon->fan.fans[i], i);
> +			if (ret)
> +				return ret;
> +		}
> +	}

[Severity: High]
Was ret meant to capture the return value of macsmc_hwmon_create_fan_acpi()
in macsmc_hwmon_populate_sensors_acpi()?

Because ret is not assigned when calling macsmc_hwmon_create_fan_acpi(),
if (ret) always checks the stale 0 from apple_smc_read_u8(), ignoring fan
initialization failures and leaving hwmon->fan.fans[i].attrs as 0.

Also, if apple_smc_read_u8() fails after modifying hwmon->fan.count,
hwmon->fan.count can remain non-zero while hwmon->fan.fans is still NULL,
which would later dereference NULL in macsmc_hwmon_create_infos() ->
macsmc_hwmon_populate_fan_configs().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029085504.3547=
-1-atharvatiwarilinuxdev@gmail.com?part=3D13
