Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=77.81.229.115
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793285621;
	b=RG7cL/RPfe8PqUQ+Gz2L4B+O94M9nL7f9405yvdasRr6zGmemyym/y63QLYDBbn4CCmI
	 kTtG5us5ZP1rFY0FX5bJQyXzpQFCG61z4iWJdGCJS/pH9C0WmwY0QLwFy8fdADG8bg1PJ
	 Q7iNNQYfU/vbbcIvfa3ixxsE5ZbvvVT80gpaz7wCIkBpNNq78E5fHSUsIRP5A7Hoyt0yH
	 vuwLYDlC1+grX5sv0ZYJXKH2zgvUNZOfsTQYbj2pbVokqsjwdrWzY2wsp/2bgEXUP2KIQ
	 DGhEMYpkIpSoSVaFBWOjEB8+BAyiLHKtcb7VdaWPbz2mTJJRdrTmtEZ/MGo96TO3hqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793285621;
	h=DMARC-Filter:Received:DKIM-Signature:Content-Type:MIME-Version:
	 Subject:From:In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:
	 References:To;
	bh=UbSiEL7++BWQVToI7FmOqiyK9zuBqGN72UpL4qL+D0U=;
	b=LxdT979BRUdHjVoxjtEb6xyas2BrJNGLn8f3rzNPSZLHS2xUzdzOGzXUwnTc/4VMJRuL
	 +hCKCzb/ZUKKmoYAOYBWQZwffPz52do2+Y2HC0BlNvay8AP+iiX0NzMgas9kGtXRTy8K3
	 7Yw3GGyUJfUZR8yEE6TjBVKerLHbsSWktq4M/h1pdgaLSni3Kul2LtJHt2oYIk4uWLf0B
	 vbYmUSGEU1oLwO3D0aR+HH+1FcWp62bV1rGTVP7CVvxZzZZwgWGtdaU2Ee1GrHkuXULSh
	 BRTQcUaTcEMVKetzlXUZBaRRZjHJxvDnn5XZT+ihpMNaUE5iWeHu4Hy3u8M0uD/5b5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chaosmail.tech;
	spf=pass smtp.mailfrom=chaosmail.tech;
	dkim=pass header.d=chaosmail.tech header.i=@chaosmail.tech header.a=rsa-sha256 header.s=mail header.b=JB0kqTmV;
	arc=none smtp.remote-ip=77.81.229.115
Received: from chaosmail.tech (chaosmail.tech [77.81.229.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE747606A324;
	Thu, 29 Oct 2026 14:53:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE747606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chaosmail.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chaosmail.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chaosmail.tech header.i=@chaosmail.tech header.a=rsa-sha256 header.s=mail header.b=JB0kqTmV
Received: by chaosmail.tech (Postfix) id AA44C1C8AAF;
	Thu, 29 Oct 2026 14:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chaosmail.tech;
	s=mail; t=1793285617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UbSiEL7++BWQVToI7FmOqiyK9zuBqGN72UpL4qL+D0U=;
	b=JB0kqTmVG4H4ja0Pp0Eah0YzrRch2nw5+T2+ML1Vpc13jMJHEYCHgQdssFpAxSYtsF+Vhc
	lxr/E6ukKsAYSFkTL14uCwyPFc9tJHoY58kAIAacAdrjWZvC2+VU0K1J2hjatCqtQu2uKP
	ianM2iZH8ZTIgpcbtXl0LW2Vy85GaGE=
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
In-Reply-To: <20261029143926.1246-1-atharvatiwarilinuxdev@gmail.com>
Date: Thu, 29 Oct 2026 15:53:23 +0100
Cc: alexandre.belloni@bootlin.com,
 andy@kernel.org,
 asahi@lists.linux.dev,
 bhelgaas@google.com,
 bp@alien8.de,
 brgl@kernel.org,
 dave.hansen@linux.intel.com,
 dlechner@baylibre.com,
 dmitry.kasatkin@gmail.com,
 eric.snowberg@oracle.com,
 griffin@kroah.com,
 hansg@kernel.org,
 hpa@zytor.com,
 ilpo.jarvinen@linux.intel.com,
 j@jannau.net,
 jarkko@kernel.org,
 jic23@kernel.org,
 jmorris@namei.org,
 lee@kernel.org,
 lenb@kernel.org,
 linusw@kernel.org,
 linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-gpio@vger.kernel.org,
 linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org,
 linux-pm@vger.kernel.org,
 linux-rtc@vger.kernel.org,
 linux-watchdog@vger.kernel.org,
 linux@roeck-us.net,
 mfd@lists.linux.dev,
 mingo@redhat.com,
 neal@gompa.dev,
 nuno.sa@analog.com,
 paul@paul-moore.com,
 pavel@kernel.org,
 platform-driver-x86@vger.kernel.org,
 rafael@kernel.org,
 roberto.sassu@huawei.com,
 serge@hallyn.com,
 sre@kernel.org,
 sven@kernel.org,
 tglx@kernel.org,
 wim@linux-watchdog.org,
 x86@kernel.org,
 zohar@linux.ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <0683C803-C578-4C55-B893-BC03EBF9A9F1@chaosmail.tech>
References: <525E5B4D-A947-4567-9FCD-5FFF2CA8B161@chaosmail.tech>
 <20261029143926.1246-1-atharvatiwarilinuxdev@gmail.com>
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

On Oct 29, 2026, at 15:39, Atharva Tiwari =
<atharvatiwarilinuxdev@gmail.com> wrote:
> 1. The patch is required, atleast on intel macs, as without writing =
GPU and CPU
> states to smc, the system gives PROCHOT signal under small load
> , and heats up a lot.

In that case, why are you exposing a generic smc key interface instead
of one that just does that? If you think that this data should be set
from userspace - whitelist the set of keys that are needed.


> 2. the smc dosent expose keys of nature that can physically damage the =
system
> it only exposes power/volt data, and the most you can poke is reboot
> keys and gpu/cpu p-states.

Are you willing to make that claim for every smc-equipped device, not
just T2? Are you willing to make the same claim for future versions of
smc firmware?

> 3. If a person is randomly touching keys, Its their problem and not =
ours.
>=20
> 4. There are a lot of things that can mess the system way more and =
permanently
> than smc (undervolting for example), but they are not safe guarded, =
why
> should this be then?

I think it is inadvisable to leave a loaded footgun around and then
blame the user for using it. As an "OS Vendor" you have a duty of care
to your users.

