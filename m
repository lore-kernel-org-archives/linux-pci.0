Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793497118;
	b=iBZj4RXBewisOAdtOftUv2+ywrYRsQ37SShQgf9IEJ377UcD3h8xpwOvWdmJvuR00WLp
	 bv3FRFEDb8nqNX69csjKhFH25U+q29J52o0Lweyq+eMwEg3myGpC4KIokTANXCpN3RY9E
	 l6Z/yrV9xmjZTNfUqGRaw1+PIfpNhlWG9mQ8rSGpVRAIiPQ9XZFCcEGrXSvdWKWUe8CuL
	 K39m0FtrVOHmZB7QeSYc9tbrett05wahuVxlvQRlDHY8qbYoitB9TWnrDKrs8D0t9rQP0
	 t/kqRbCuehkVmMRcbZpPMz1FsBq9CRg3hYuxl34L4dLMxAuTqpMsrn3zHfBvRPfJqcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793497118;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=wkggvdD4Daf1drrMBcb90xMWnEWnBOyml4nDOqyyoZg=;
	b=3fY7g2vUT4wcov7H8TuV2W9MvImf5//vz+5QG1eQIHo/n2iyedEqRSuKA7edQkjY+R8/
	 QMSrpUYsmowJ+2Ma5rzeI2ltYvAxNHMR6xQjnoVYX/HKxoKdmSniBkiDHiMTblCdDLBu2
	 0aSlbjg/dJFXVY6cQnguIWjq0Eyl8jjeZyFxSQlF7JwPm/XueMBynApq6KSkmDdXGoEXd
	 YOnF6NVk66H+5qjfW/NGgYHVT/m1gLHlFpmFvVvPMbZNu9SAw09e5GnMTjmiSibuJjlO2
	 /Z3zgamX9VCXSsLzzVmh0cvUwyX8R2VLaXkhDbSXmDYTcb9C/8yBlSbu43KLOmfnHbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="L/0GaqtI";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD50606A31A;
	Sun,  1 Nov 2026 01:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L/0GaqtI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 258EE1F000C1;
	Sun,  1 Nov 2026 01:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793497117;
	bh=wkggvdD4Daf1drrMBcb90xMWnEWnBOyml4nDOqyyoZg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=L/0GaqtIo4ljcF6HhkiYfZqgqFfzu7sb2NkCwbaTtE2OUjTcTLJRXTyZtUK1Narrr
	 BtQLDj7zRIIYxbD8+FBD4wlKou3nEAPke635eAz7vVjuDKwzzXPCAQT16jTp9CgGL0
	 ba2LaOoHCP9feeoX8BP8LKv4yveSZWwZo6yHjtlYIjXCx4V0POS1oHKma+w2QDRFaw
	 bFs3gxmRlx8fBdDMx60B/RskaLNeuJ3lyaYWZfLal9k+4P7aIxa899xvKOLsT5R/bB
	 bFVyAcYisN4dpM7gjUbRJx96JJ4SZsMz1PSkwib+7dreMZmtGyU+hikjLVEkCGsSCI
	 8TqVyGhsXxtwg==
Date: Sun, 1 Nov 2026 01:38:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
 <lenb@kernel.org>, Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski
 <brgl@kernel.org>, Sven Peter <sven@kernel.org>, Janne Grunau
 <j@jannau.net>, Neal Gompa <neal@gompa.dev>, Guenter Roeck
 <linux@roeck-us.net>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, Griffin
 Kroah-Hartman <griffin@kroah.com>, Hans de Goede <hansg@kernel.org>, Ilpo
 =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Sebastian Reichel
 <sre@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Wim
 Van Sebroeck <wim@linux-watchdog.org>, Jarkko Sakkinen <jarkko@kernel.org>,
 Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg
 <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, James Morris
 <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-leds@vger.kernel.org, mfd@lists.linux.dev,
 platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
 linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH 14/14] mfd/macsmc: add ioctl to access smc keys
Message-ID: <20261101013817.22d67ea7@jic23-hlaptop>
In-Reply-To: <20261029085504.3547-15-atharvatiwarilinuxdev@gmail.com>
References: <20261029085504.3547-1-atharvatiwarilinuxdev@gmail.com>
	<20261029085504.3547-15-atharvatiwarilinuxdev@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Oct 2026 04:52:11 -0400
Atharva Tiwari <atharvatiwarilinuxdev@gmail.com> wrote:

> Add a /dev/smc device so userspace can talk to the SMC
> directly. Some keys that need to be written aren't handled by
> any driver, or affect several drivers at once, so they
> can't be exposed cleanly through the kernel interfaces.
> 
> Keys already managed by kernel drivers can't be written this
> way, to avoid conflicts.

If this isn't matching some legacy interface, then we need more
on what these do.  Maybe they are suited to some other kernel
interface? In particular they might need the various controls
on how destructive they are that something like fwctl brings.

Generally an arbitrary opaque path to firmware isn't a good idea...

Jonathan
