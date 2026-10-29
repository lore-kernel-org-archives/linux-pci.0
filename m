Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793265542;
	b=eo9JREOBYahrPQJnNbscyK7i1FNlyQl/gFAaQp3o4N883vHEgwLEZcKup6kEm8bCQJyp
	 860hrTPDQFfCUf4hX6p+7DVVpoU0hku3BarHdxumrJgMdlIwVMfh9LxgvkdhyAsOidxY9
	 dd+05jCKpXqG44h0RRmGXoAO1/D/0Pkk0bsBPm5fmK4tEwIlOM0emlaO7FCXjdSj2xCAc
	 i79ijaja7i3mOm+BvzVy0Ej7hU7Eq9N/XqD6aGWRQB/wbOyJPACyunakmwboVY3VG3++y
	 TiKlACC4TjFOyp6kMWAfNOxC5md2QMUuA1PHQWwyMav5tAJ1jMOS2RhhZOrBBhJWjOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793265542;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=K8/wO6efzf7QfGo7UjnxZLJIdIjLyvIF1IuitRjLdAk=;
	b=vththT5gsrzeea3duE4T96M++2eWmLPE8EDOwJqyo+pDsKwPcUgfxZr9lYI8tGsjmyqu
	 Gx2axxxxs9szgaYnckoShSf4nr4Tu1inLsVaPqIcvBFvLu3laY9jHWe2+1RuXfkKJgrMC
	 SIzyCcQQFo7f5hT6hu/WAv7t4tURwmvdnko80jLo2PbLjZEL99wVOV9wVUk2rHqYQUG96
	 IerRUxpDqNfRpCit0oFEgqNpR6Mci6dXYmfw4aYr4WeMuL0dEYzfs8T4ArCNGijM/Yl1F
	 41vSOjDoGyHgB6UTXSpmWbQ0OzpguXb2aT7MeTGYvDv+Edhs4hn6xIfccMNqEQuNSwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RLEdbc1y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA559606A31C;
	Thu, 29 Oct 2026 09:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RLEdbc1y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D26C1F01828;
	Thu, 29 Oct 2026 09:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793265541;
	bh=K8/wO6efzf7QfGo7UjnxZLJIdIjLyvIF1IuitRjLdAk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RLEdbc1ym6XGbIUVf1ivgJKSb+SzFDM0KeXRD/81WAKkE3jYIES4xuIodf6G6F1vA
	 gxBbC/J4PC47yAW1NU5uojI0DCLwMOxbo7haqo9dZVWptYL7vKSw6Pgnqupc0rP1NX
	 uosEiLfsRBzyXMxMS+i9VVLIuUD+wArZVIUoSg91didLC3f3Et4kelKklTpZkNlkef
	 hYFK7FWy/wOrdFdTsZdPNmVJg6DqUrA9IX6hedsxkwrPe8x5R5Hp3m74rcx0a3OY3p
	 z+7l/obYvsh5xrNHDLO7tZ6nC6ViBR2rGTjkNMHHMIjbBJaRv+4NXWw0H8x5a5TkiX
	 9kOGF86wP7y7Q==
Message-ID: <sashiko-outbox-189021@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 12/14] hwmon/macsmc: add more types
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
In-Reply-To: <20261029085504.3547-13-atharvatiwarilinuxdev@gmail.com>
References: <20261029085504.3547-1-atharvatiwarilinuxdev@gmail.com>
 <20261029085504.3547-13-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 09:18:58 +0000
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
- [Medium] hwmon: 32-bit integer overflow when scaling values in macsmc_hwm=
on_read_key()
--

commit 8d01f24623ebf973c1f3f366376ae2ac53217c82
Author: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

hwmon/macsmc: add more types

This commit adds support for reading common integer (ui8, si8, ui16, si16,
ui32, si32) and fixed-point (fp* and sp*) SMC key data types in
macsmc_hwmon_read_key(), and allows writing fpe2 keys for fan speed control
in macsmc_hwmon_write_key().

> diff --git a/drivers/hwmon/macsmc-hwmon.c b/drivers/hwmon/macsmc-hwmon.c
> index 1500ec2cc9f83..2e74dcd6651b3 100644
> --- a/drivers/hwmon/macsmc-hwmon.c
> +++ b/drivers/hwmon/macsmc-hwmon.c
> @@ -221,6 +221,313 @@ static int macsmc_hwmon_read_key(struct apple_smc *=
smc,
>  			*val =3D (long)ioft;
>  		break;
>  	}

[ ... ]

> +	/* unsigned 16-bit integer */
> +	case __SMC_KEY('u', 'i', '1', '6'): {
> +		u16 ui16 =3D 0;
> +
> +		ret =3D apple_smc_read_u16(smc, sensor->macsmc_key, &ui16);
> +		if (ret)
> +			return ret;
> +
> +		*val =3D ui16 * scale;
> +		break;
> +	}
> +	/* signed 16-bit integer */
> +	case __SMC_KEY('s', 'i', '1', '6'): {
> +		s16 si16 =3D 0;
> +
> +		ret =3D apple_smc_read_s16(smc, sensor->macsmc_key, &si16);
> +		if (ret)
> +			return ret;
> +
> +		*val =3D si16 * scale;
> +		break;
> +	}
> +	/* unsigned 32-bit integer */
> +	case __SMC_KEY('u', 'i', '3', '2'): {
> +		u32 ui32 =3D 0;
> +
> +		ret =3D apple_smc_read_u32(smc, sensor->macsmc_key, &ui32);
> +		if (ret)
> +			return ret;
> +
> +		*val =3D ui32 * scale;
> +		break;
> +	}
> +	/* signed 32-bit integer */
> +	case __SMC_KEY('s', 'i', '3', '2'): {
> +		s32 si32;
> +
> +		ret =3D apple_smc_read_s32(smc, sensor->macsmc_key, &si32);
> +		if (ret)
> +			return ret;
> +
> +		*val =3D si32 * scale;
> +		break;
> +	}
> +	/* 2.14 unsigned fixed point decimal */
> +	case __SMC_KEY('f', 'p', '2', 'e'): {
> +		u16 fp2e;
> +
> +		ret =3D apple_smc_read_u16(smc, sensor->macsmc_key, &fp2e);
> +		if (ret)
> +			return ret;
> +
> +		*val =3D mult_frac(be16_to_cpu(fp2e), scale, BIT(14));
> +		break;
> +	}

[ ... ]

> +	/* 1.14 signed fixed point decimal */
> +	case __SMC_KEY('s', 'p', '1', 'e'): {
> +		s16 sp1e;
> +
> +		ret =3D apple_smc_read_s16(smc, sensor->macsmc_key, &sp1e);
> +		if (ret)
> +			return ret;
> +
> +		*val =3D mult_frac((s16)be16_to_cpu(sp1e), scale, BIT(14));
> +		break;
> +	}

[ ... ]

> +	/* 15.0 signed fixed point decimal */
> +	case __SMC_KEY('s', 'p', 'f', '0'): {
> +		s16 spf0;
> +
> +		ret =3D apple_smc_read_s16(smc, sensor->macsmc_key, &spf0);
> +		if (ret)
> +			return ret;
> +
> +		*val =3D (s16)be16_to_cpu(spf0) * scale;
> +		break;
> +	}

[Severity: Medium]
Can these scaling calculations in macsmc_hwmon_read_key() overflow 32-bit
integers and corrupt sensor readings when called from macsmc_hwmon_read()?

In macsmc_hwmon_read(), scale is 1000000 for hwmon_power and 1000 for
hwmon_temp, hwmon_in, and hwmon_curr, while the scale parameter in
macsmc_hwmon_read_key() has type int:

drivers/hwmon/macsmc-hwmon.c:macsmc_hwmon_read() {
	...
	case hwmon_power:
		/* SMC returns power in Watts with acceptable precision to scale to uW */
		ret =3D macsmc_hwmon_read_key(hwmon->smc,
					    &hwmon->power.sensors[channel],
					    1000000, val);
		break;
}

First, in the mult_frac() calls for the unsigned (fp2e through fp88) and
signed (sp1e through spd2) fixed-point types, the first argument has a 16-b=
it
type (u16 from be16_to_cpu() or s16 from (s16)be16_to_cpu()):

include/linux/math.h:
#define mult_frac(x, n, d)	\
({				\
	typeof(x) x_ =3D (x);	\
	typeof(n) n_ =3D (n);	\
	typeof(d) d_ =3D (d);	\
				\
	typeof(x_) q =3D x_ / d_;	\
	typeof(x_) r =3D x_ % d_;	\
	q * n_ + r * n_ / d_;	\
})

Because typeof(x_) is a 16-bit integer, q and r are promoted to 32-bit sign=
ed
int, and n_ (scale) is also a 32-bit signed int. Both q * n_ and r * n_ are
evaluated as 32-bit signed int multiplications before dividing by d_
(unsigned long from BIT(n)). When scale is 1000000, any remainder r >=3D 21=
48
(possible for fp2e, fp3d, fp4c, sp1e, sp2d, and sp3c) or quotient |q| >=3D =
2148
(possible for spc3 and spd2) overflows 32-bit signed int into a negative
value, which then converts to a huge unsigned long when divided by BIT(n).

Second, for the signed sp* types (sp1e through spd2), passing a signed x_ w=
ith
an unsigned long divisor BIT(n) causes x_ / d_ and x_ % d_ inside mult_frac=
()
to be evaluated as unsigned division and modulo whenever x_ is negative,
corrupting negative readings.

Third, for ui16, si16, ui32, si32, and spf0, the multiplications by scale
(such as ui16 * scale, si32 * scale, and (s16)be16_to_cpu(spf0) * scale) are
all evaluated in 32-bit arithmetic before widening to long *val, which
overflows when scale is 1000000 (for values >=3D 2148 on signed/16-bit type=
s or
>=3D 4295 on ui32) or 1000 (for 32-bit types).

Would it make sense to widen scale (or cast the operands and divisors to
signed long / s64) so that the multiplications and mult_frac() divisions are
performed in 64-bit signed arithmetic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029085504.3547=
-1-atharvatiwarilinuxdev@gmail.com?part=3D12
