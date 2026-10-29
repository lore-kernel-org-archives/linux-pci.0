Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793265982;
	b=DcZepHrnXX8YJdc9e9HD7qOVxavh3/zK+DM/CdKzDUTljXxDLIij1ks1eJQqduUp4YgS
	 I+xBoYp9B3rihZlLcOB5G+BIBt17ynsB3aE03e3tmsENYn5ih798XU/AQ8H4/T6j8aoAh
	 zO0+BXmfA6pPW452oIa44Wuv5FRPlsUazeZQJvMIzoGrv5du58oOq7kK4kZB7+d21JkU3
	 Ce+jru1nKC1lfVltEy5PGPRsA6Xn0R/lX8sTzvP6R2klOV4LCvfMX42wv/mpj5yvd/c32
	 Ur81WBlHa4CFVH6SCCbUHfr2YeWxvBuPEf6waTJAlu8YC8NI0n2Vd/7mVZnMGLGhndw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793265982;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4Xbj3/i9atnWntAjbez4qPemNAtJuDYWyOhE+0HbibQ=;
	b=lZq5PA9tNGZXqZp24T3P5uztBLJxCGBQINgBPU06Kp8S0Jmfn/Im0D1FmbgKMaZqC2Dn
	 CsQ3WJA+FSw+XcYw7L/mAl/bJuDeHKV7IUYYcKpR0CrnOCmaXiBwU9hvirNuHmkRA1buK
	 dhxJq86d32WrAZUMHsiKKp6hEJw3XiRKMlGadabBie8NzScBBxP/xuqsIewgrwIGRBwDp
	 InmLE8MmWXpSD8qalhYa2tNfLPpELVoumuop3F1ooUKbMo+HU5RruBcmVDjoC7eYSXGg+
	 x+9sELWjpkEBgrsGv0Cz3wnQBrVu3Mv8CfoSOUHGjvuV8fhFKKRhaA5GsaGe1o/HYMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ja91PU4v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EB6606A31D;
	Thu, 29 Oct 2026 09:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ja91PU4v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D64B1F01825;
	Thu, 29 Oct 2026 09:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793265981;
	bh=4Xbj3/i9atnWntAjbez4qPemNAtJuDYWyOhE+0HbibQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ja91PU4vPbX6rgW3/SqQiH2C6ahMYlFn1iM6Yhk5K2vsH1AUrHvwaGV0losZneLPc
	 fkPuK0pVqZdLmW0pnU61e0jrAM3xHVc7rt+gZByXNX2jssRbiGf7zzpJ0TeyD9NS4s
	 36k58aSpT2pqxM589jOx5Mvq5xI9Ph8In1/NYDGdLPpaFE8yKd2lrkDxm82ET9xuJX
	 TPSnSkwvymOwucPYiKI7/qqjfT8MF6aps9Xp6WPuxjToTXg6bepqbIX9SArnXiGiy8
	 Q54QoRp37OpUs72qZCw8uiJBVzrw7Waq3mjq2e5UG7SKpMbkFmwzX4HnMeJAMisnrk
	 7sKxUnqKW19zA==
Message-ID: <sashiko-outbox-189036@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 14/14] mfd/macsmc: add ioctl to access smc keys
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
In-Reply-To: <20261029085504.3547-15-atharvatiwarilinuxdev@gmail.com>
References: <20261029085504.3547-1-atharvatiwarilinuxdev@gmail.com>
 <20261029085504.3547-15-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 09:26:19 +0000
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
- [High] mfd: macsmc: use-after-free in apple_smc_fops_ioctl() after device=
 unbind
- [Medium] mfd: macsmc: size_t in ioctl payload breaks compat_ioctl in appl=
e_smc_fops
- [Medium] mfd: macsmc: incomplete write blocklist in apple_smc_fops_ioctl()
- [Low] mfd: macsmc: return -ENOTTY for unknown cmd in apple_smc_fops_ioctl=
()
- [Low] mfd: macsmc: commit subject violates MFD prefix and capitalization =
rules
--

commit 352ee7db8cfde297319806ac2e104b433cfad104
Author: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

mfd/macsmc: add ioctl to access smc keys

This commit registers a /dev/smc miscdevice in macsmc-core to allow
userspace to read, write, and query Apple SMC keys via ioctls, while
blocking writes to a static list of keys managed by kernel drivers.

>     mfd/macsmc: add ioctl to access smc keys
>
>     Add a /dev/smc device so userspace can talk to the SMC
>     directly. Some keys that need to be written aren't handled by
>     any driver, or affect several drivers at once, so they
>     can't be exposed cleanly through the kernel interfaces.
>
>     Keys already managed by kernel drivers can't be written this
>     way, to avoid conflicts.
>
>     Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

[Severity: Low]
This isn't a bug, but the MFD subsystem convention uses the prefix format
"mfd: <driver>: <Capitalized description>". Should the commit subject be
formatted as "mfd: macsmc: Add ioctl to access SMC keys"?

> diff --git a/drivers/mfd/macsmc-core.c b/drivers/mfd/macsmc-core.c
> index bc4200f574bd5..a30f7386ef9cd 100644
> --- a/drivers/mfd/macsmc-core.c
> +++ b/drivers/mfd/macsmc-core.c

[ ... ]

> @@ -112,6 +115,144 @@ static void apple_smc_disable_notifications(void *d=
ata)
>  	smc->be->disable_notifications(smc->be_cookie);
>  }
> =20
> +static long apple_smc_fops_ioctl(struct file *file, unsigned int cmd, un=
signed long arg)
> +{
> +	struct apple_smc *smc =3D file->private_data;
> +	void __user *argp =3D (void __user *)arg;
> +	int ret;
> +
> +	switch (cmd) {

[ ... ]

> +	case IOCTL_SMC_WRITE: {
> +		struct ioctl_smc_rw_payload payload;
> +		struct apple_smc_key_info info;
> +
> +		if (copy_from_user(&payload, argp, sizeof(payload)))
> +			return -EFAULT;
> +
> +		ret =3D apple_smc_get_key_info(smc, payload.key, &info);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (payload.size !=3D info.size)
> +			return -EINVAL;
> +
> +		if (payload.size > 32)
> +			return -EINVAL;
> +
> +		switch (payload.key) {
> +		case __SMC_KEY('C', 'H', '0', 'I'):
> +		case __SMC_KEY('C', 'H', '0', 'C'):
> +		case __SMC_KEY('C', 'H', '0', 'K'):
> +		case __SMC_KEY('C', 'H', '0', 'B'):
> +		case __SMC_KEY('C', 'H', 'T', 'E'):
> +		case __SMC_KEY('C', 'H', 'L', 'S'):
> +		case __SMC_KEY('B', 'C', 'L', 'M'):
> +		case __SMC_KEY('M', 'B', 'S', 'E'):
> +		case __SMC_KEY('C', 'L', 'K', 'L'):
> +		case __SMC_KEY('C', 'L', 'K', 'O'):
> +		case __SMC_KEY('O', 'S', 'W', 'D'):
> +		case __SMC_KEY('N', 'A', 'T', 'J'):
> +		case __SMC_KEY('N', 'A', 'T', 'i'):
> +		case __SMC_KEY('N', 'E', 'S', 'N'):
> +		case __SMC_KEY('M', 'O', 'C', 'N'):
> +		case __SMC_KEY('L', 'K', 'S', 'B'):
> +		case __SMC_KEY('N', 'T', 'O', 'K'):
> +		case __SMC_KEY('N', 'T', 'A', 'P'):
> +		case __SMC_KEY('F', '0', 'T', 'g'):
> +		case __SMC_KEY('F', '1', 'T', 'g'):
> +		case __SMC_KEY('F', '0', 'M', 'd'):
> +		case __SMC_KEY('F', '1', 'M', 'd'):
> +		case __SMC_KEY('F', 'S', '!', ' '):
> +			return -EPERM;
> +		}

[Severity: Medium]
Does this static blocklist miss other keys actively managed by MFD child
drivers?

In drivers/hwmon/macsmc-hwmon.c, macsmc_hwmon_create_fan_acpi() registers
all fans up to FNum using keys F<num>Tg and F<num>Md, and
macsmc_hwmon_create_fan() registers fan keys from DT on Apple Silicon:

drivers/hwmon/macsmc-hwmon.c:macsmc_hwmon_create_fan_acpi() {
	const char num_char =3D num + '0';
	...
	ret =3D macsmc_hwmon_create_sensor_acpi(smc, &fan->set,
			__SMC_KEY('F', num_char, 'T', 'g'), NULL, 0);
	if (ret)
		return ret;

	if (apple_smc_key_exists(smc, __SMC_KEY('F', num_char, 'M', 'd'))) {
		ret =3D macsmc_hwmon_create_sensor_acpi(smc, &fan->mode,
				__SMC_KEY('F', num_char, 'M', 'd'), NULL, 0);
}

On systems with more than two fans, fans 2 and above remain writable via
IOCTL_SMC_WRITE, which bypasses the min/max RPM validation in
macsmc_hwmon_write_fan() and desynchronizes hwmon->fan.fans[channel].manual.

Similarly, drivers/gpio/gpio-macsmc.c (registered as macsmc-gpio) manages
and writes PMU GPIO keys gP00..gPff in macsmc_gpio_set():

drivers/gpio/gpio-macsmc.c:macsmc_gpio_set() {
	struct macsmc_gpio *smcgp =3D gpiochip_get_data(gc);
	smc_key key =3D macsmc_gpio_key(offset);
	int ret;

	value |=3D CMD_OUTPUT;
	ret =3D apple_smc_write_u32(smcgp->smc, key, CMD_OUTPUT | value);
}

None of the gPxx keys are filtered here either, allowing userspace to
modify GPIO outputs behind the kernel driver's back.

[ ... ]

> +	default:
> +		return -EINVAL;
> +	}
> +}

[Severity: Low]
Should the default case in apple_smc_fops_ioctl() return -ENOTTY instead of
-EINVAL for unrecognized ioctl commands?

> +
> +static int apple_smc_fops_open(struct inode *inode, struct file *file)
> +{
> +	struct miscdevice *misc =3D file->private_data;
> +
> +	file->private_data =3D container_of(misc, struct apple_smc, miscdev);
> +	return 0;
> +}
> +
> +static const struct file_operations apple_smc_fops =3D {
> +	.owner		=3D THIS_MODULE,
> +	.open		=3D apple_smc_fops_open,
> +	.unlocked_ioctl	=3D apple_smc_fops_ioctl,
> +	.compat_ioctl	=3D compat_ptr_ioctl,
> +	.llseek		=3D noop_llseek,
> +};
> +
> +static void apple_smc_misc_unregister(void *data)
> +{
> +	misc_deregister(data);
> +}
> +
>  int apple_smc_probe(struct device *dev, const struct apple_smc_backend_o=
ps *ops,
>  		void *cookie, struct blocking_notifier_head *event_handlers, bool is_a=
cpi)
>  {
> @@ -150,6 +291,20 @@ int apple_smc_probe(struct device *dev, const struct=
 apple_smc_backend_ops *ops,
>  	if (ret)
>  		return ret;
> =20
> +	smc->miscdev.minor =3D MISC_DYNAMIC_MINOR;
> +	smc->miscdev.name =3D "smc";
> +	smc->miscdev.fops =3D &apple_smc_fops;
> +	smc->miscdev.parent =3D dev;
> +	smc->miscdev.mode =3D 0600;
> +
> +	ret =3D misc_register(&smc->miscdev);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D devm_add_action_or_reset(dev, apple_smc_misc_unregister, &smc->=
miscdev);
> +	if (ret)
> +		return ret;
> +

[Severity: High]
Can this trigger a use-after-free in apple_smc_fops_ioctl() if the backend
device is unbound (or if a subsequent devm_mfd_add_devices() call in
apple_smc_probe() fails) while /dev/smc is open?

In apple_smc_probe(), smc is allocated via devm_kzalloc(dev, sizeof(*smc),
GFP_KERNEL), and smc->be_cookie is similarly devm-allocated on the backend
device. When /dev/smc is opened, apple_smc_fops_open() stores a raw pointer
to smc in file->private_data, and misc_open() only pins apple_smc_fops.owner
(macsmc-core, not the backend driver).

When the device is unbound or probe fails after misc_register(), devres
runs apple_smc_misc_unregister() -> misc_deregister(&smc->miscdev) and then
frees both smc and smc->be_cookie. Because misc_deregister() does not wait
for in-flight ioctls or revoke already-open file descriptors, any concurrent
or subsequent call to apple_smc_fops_ioctl() on the open file will
dereference freed memory via file->private_data when locking smc->mutex and
invoking smc->be callbacks with smc->be_cookie.

> diff --git a/include/linux/mfd/macsmc.h b/include/linux/mfd/macsmc.h
> index 4b4368b99adb6..29fd7b20ce9c8 100644
> --- a/include/linux/mfd/macsmc.h
> +++ b/include/linux/mfd/macsmc.h

[ ... ]

> @@ -141,8 +144,32 @@ struct apple_smc {
> =20
>  	struct mutex mutex;
>  	spinlock_t lock;
> +
> +	struct miscdevice miscdev;
> +};
> +
> +struct ioctl_smc_rw_payload {
> +	smc_key key;
> +	size_t size;
> +	u8 buf[32];
> +};
> +
> +struct ioctl_smc_index_payload {
> +	int index;
> +	smc_key key;
> +};
> +
> +struct ioctl_smc_info_payload {
> +	smc_key key;
> +	struct apple_smc_key_info info;
>  };
> =20
> +#define APPLE_SMC_MAGIC 'S'
> +#define IOCTL_SMC_READ           _IOWR(APPLE_SMC_MAGIC, 1, struct ioctl_=
smc_rw_payload)
> +#define IOCTL_SMC_WRITE          _IOW(APPLE_SMC_MAGIC, 2, struct ioctl_s=
mc_rw_payload)
> +#define IOCTL_SMC_GET_KEY_INDEX  _IOWR(APPLE_SMC_MAGIC, 3, struct ioctl_=
smc_index_payload)
> +#define IOCTL_SMC_GET_KEY_INFO   _IOWR(APPLE_SMC_MAGIC, 4, struct ioctl_=
smc_info_payload)

[Severity: Medium]
Does using size_t in struct ioctl_smc_rw_payload break 32-bit compat ioctls
even though apple_smc_fops sets .compat_ioctl =3D compat_ptr_ioctl?

On 64-bit kernels, size_t is 8 bytes with 8-byte alignment, which adds 4
bytes of padding after key (placing size at offset 8, buf at offset 16, and
making sizeof(struct ioctl_smc_rw_payload) =3D=3D 48). In 32-bit userspace,
size_t is 4 bytes with 4-byte alignment (placing size at offset 4, buf at
offset 8, and making sizeof(struct ioctl_smc_rw_payload) =3D=3D 40). Because
IOCTL_SMC_READ and IOCTL_SMC_WRITE encode the struct size, 32-bit compat
callers will pass a command number with size 40 that fails to match the
64-bit kernel's command number, or have mismatched field offsets and copy
8 bytes past the userspace struct if invoked with the 64-bit command number.

Also, since these ioctl structs and macros form a userspace ABI, should they
be placed in a header under include/uapi/ using fixed-size UAPI types (__u3=
2,
__u8) with explicit padding rather than in the kernel-internal
include/linux/mfd/macsmc.h header?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029085504.3547=
-1-atharvatiwarilinuxdev@gmail.com?part=3D14
