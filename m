Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=77.81.229.115
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793265786;
	b=xV9DJobInAkt0YGcLdPDUl/zK/e+sroxFy5ZqMfXxehPn68fdLnkRUyJ0J4Yz6f8y5nb
	 erZHYUArrl+Jez1eVgQxS+8sPYK69Xftj1I9alyTa4rgT80V0Iyrf6e9xEVzUfmrSTcFV
	 dqIm2iiSDbEpAKlIyC8FiAV7PnCz+Qpyq+ZjN4iaCkfcLBy5Kr/ha7enNBKwQ+Dzjwg1D
	 g+TJasHJzJL+dtGYP2Oxy7wJ/EdKYUQpl8PNdBP2kugMIhEg6po2B1o5s/ccddKi96QTx
	 IhLqfJvsLL7N4UD0D6VmloTdtYFh8b5cnsP/Ad+uNSPqTGxah2N/0se3K+VADwn3kJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793265786;
	h=DMARC-Filter:Received:DKIM-Signature:Content-Type:MIME-Version:
	 Subject:From:In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:
	 References:To;
	bh=tjfAbDDo8h+t2m7Oll5N9+sjj2zGWKROZ1OXhj5/7js=;
	b=P9Vfg+WrHPxv0BemSJ+FkQ0gIaHlkeT39HXcq+j8HVbwBKBxwUTgjDQbinuo/BnGPMbt
	 cQCbVOHjZVirJ4JffioGgBakkGy6LTSx6sLXI0/56a3uLDfuTtpqEsNuiTMCmGJ7fYASI
	 kBG8auHjL3u63aOYQ8HYzJv6HybbmI2LBDeOdWPprcQscAngEG0ftJJxL58wr9RFBE244
	 ltbh8Rr2uVqkAqZjDPO1dOPa4jx35lUzu5kbYE+X2bjyXVzb442hJb/P3NI+dqla0lHjb
	 3qyFTG4RtgqCrfMG9bk04xOEshBTBM/APpN4csYxJFaxnskvejFW+BEJwDYSPqGzXZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chaosmail.tech;
	spf=pass smtp.mailfrom=chaosmail.tech;
	dkim=pass header.d=chaosmail.tech header.i=@chaosmail.tech header.a=rsa-sha256 header.s=mail header.b=yL2lDRgC;
	arc=none smtp.remote-ip=77.81.229.115
Received: from chaosmail.tech (chaosmail.tech [77.81.229.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A7D606A321;
	Thu, 29 Oct 2026 09:23:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01A7D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chaosmail.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chaosmail.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chaosmail.tech header.i=@chaosmail.tech header.a=rsa-sha256 header.s=mail header.b=yL2lDRgC
Received: by chaosmail.tech (Postfix) id 0122E1C87C3;
	Thu, 29 Oct 2026 09:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chaosmail.tech;
	s=mail; t=1793265776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tjfAbDDo8h+t2m7Oll5N9+sjj2zGWKROZ1OXhj5/7js=;
	b=yL2lDRgCJDJpaZDz8pZYltehrxUJx2mB+TmBFD943/OHPwTRwWms3JeGoZZCx75H9dN9TB
	U9YD8Ti7GkEr4GTe1Eao9vIg9GWutDjjVcKfHlF1Me/XLMdJEgAXiDGW7GzXlVJSwMVyYQ
	9XzUrTModweKsYsUaE6CyFELP3+Mng8=
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Subject: Re: [RFC PATCH 14/14] mfd/macsmc: add ioctl to access smc keys
From: Sasha Finkelstein <k@chaosmail.tech>
In-Reply-To: <20261029085504.3547-15-atharvatiwarilinuxdev@gmail.com>
Date: Thu, 29 Oct 2026 10:22:43 +0100
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>,
 Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>,
 Sven Peter <sven@kernel.org>,
 Janne Grunau <j@jannau.net>,
 Neal Gompa <neal@gompa.dev>,
 Guenter Roeck <linux@roeck-us.net>,
 Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 Lee Jones <lee@kernel.org>,
 Pavel Machek <pavel@kernel.org>,
 Griffin Kroah-Hartman <griffin@kroah.com>,
 Hans de Goede <hansg@kernel.org>,
 =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Sebastian Reichel <sre@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>,
 Jarkko Sakkinen <jarkko@kernel.org>,
 Mimi Zohar <zohar@linux.ibm.com>,
 Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>,
 Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org,
 linux-gpio@vger.kernel.org,
 asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org,
 linux-hwmon@vger.kernel.org,
 mfd@lists.linux.dev,
 platform-driver-x86@vger.kernel.org,
 linux-pm@vger.kernel.org,
 linux-rtc@vger.kernel.org,
 linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <525E5B4D-A947-4567-9FCD-5FFF2CA8B161@chaosmail.tech>
References: <20261029085504.3547-1-atharvatiwarilinuxdev@gmail.com>
 <20261029085504.3547-15-atharvatiwarilinuxdev@gmail.com>
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

On Oct 29, 2026, at 09:52, Atharva Tiwari =
<atharvatiwarilinuxdev@gmail.com> wrote:
>=20
> Add a /dev/smc device so userspace can talk to the SMC
> directly.=20

This should either be dropped from the series, or be hidden behind a
`melt_my_mac`-style module flag, or switched to a whitelist approach.
We do not know what keys will be introduced in new smc firmware
versions, and there are already keys that should not be randomly poked
at.


