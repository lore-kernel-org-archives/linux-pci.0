Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794101744;
	b=Z9oCirWcdUWGJnL8SkE02iI7nHr4EBJjvB1Ox2L0If0KoNFMnJzbg90fqubn6sJQG5hq
	 PgRZ77aRNbUHAycguDBtec/3kfnkl23Focb5DaWHZhD1CjIc5n17iHTAg6SCQWgnkRkl9
	 Hc/Ay/b6zb8G5gjDLjxTcXFKQVlEn9RLmXY8vqPx8gOyOktXGeWkG6eIFfcwmYLD9g5VF
	 21lwPKlJWcMPntd6T+B6+8YEk0CYJ/QnbhL5Rj/ooS7cniF/8E131TafpO9y+1KW1bDBq
	 9GJaqcVyuwrOgM3HOl/6bxO9CCLeKeXlut8R0BBG0bYoxxScs0YDngv83P/nDFqHk2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794101744;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=1jjWt3b9VOCOhPOBER5bc1d0BDO1F3j/SxlqU5kxk0M=;
	b=aBxNK2eMAykggAsrjTZYQHwJooM64QTQ1UVl9OeeXuspQbDcDBJQAFq8n5BGss7kJGHM
	 LtFRRrc31oKmwveFo5BZLYfgZQIrw7EWrgwpLmGot5zrrd+o5XdAedKXen3oVjzqetMnz
	 lIeScwlkpvfp+38w2jtgbLdF4kkvM1KUd6oo/ho7t4sN+KIezMCHGiSSKiNeFz9iYE3aF
	 ZQcoORs+uwXO0zXXmbJWzmhYvSLrArRTbNgCHQ2nx1+p1lRvK+1MmupcsmbegZZ8JzDyJ
	 MzGFuHkV06gVUV2xqCT8uf9L2K+cTIxfsyEaKSPgMz3S0uXN89j3temGyQXMrNiM44Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n22PmfRL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E41F606A326;
	Sun,  8 Nov 2026 01:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n22PmfRL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D1A21F0089F;
	Sun,  8 Nov 2026 01:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794101743;
	bh=1jjWt3b9VOCOhPOBER5bc1d0BDO1F3j/SxlqU5kxk0M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=n22PmfRLwH9vCJiaf/Tt+q5Pj/mzwVjj35Dl5p8BHBpV+snYXVGYXUXIVhWCH+vZ5
	 9iRoDhG4eAaL7n/LbL3EmdB5i19krST80SmH+RfJbi7mpm1MJMLpk6GW5GhPEjxoA0
	 K1z2XWKVorZ+W5HfxdjPYkrxe5kMOA/HLrMZIaZn0Hs6/5GQyVAFBoV0NwsdimITOW
	 rXF9485T/wduzPWB4ZH1hf3+Uc7dHxDmQ7j9mrS8KQaDEHfB+R7TOrBKb0RHR5Vodq
	 XttgD1WjScEcDNv+bq3zPpto7nTtuz7OA2fL8FBNfbv3e/uwy5AYOwNBsHipIlyzwB
	 2+1uX8N0AWvqw==
Date: Sun, 8 Nov 2026 01:35:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Cc: alexandre.belloni@bootlin.com, andy@kernel.org, asahi@lists.linux.dev,
 bhelgaas@google.com, bp@alien8.de, brgl@kernel.org,
 dave.hansen@linux.intel.com, dlechner@baylibre.com,
 dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, griffin@kroah.com,
 hansg@kernel.org, hpa@zytor.com, ilpo.jarvinen@linux.intel.com,
 j@jannau.net, jarkko@kernel.org, jmorris@namei.org,
 keyrings@vger.kernel.org, lee@kernel.org, lenb@kernel.org,
 linusw@kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linux@roeck-us.net, mfd@lists.linux.dev, mingo@redhat.com, neal@gompa.dev,
 nuno.sa@analog.com, paul@paul-moore.com, pavel@kernel.org,
 platform-driver-x86@vger.kernel.org, rafael@kernel.org,
 roberto.sassu@huawei.com, serge@hallyn.com, sre@kernel.org,
 sven@kernel.org, tglx@kernel.org, wim@linux-watchdog.org, x86@kernel.org,
 zohar@linux.ibm.com
Subject: Re: [RFC PATCH 14/14] mfd/macsmc: add ioctl to access smc keys
Message-ID: <20261108013526.1ce3b9b2@jic23-hlaptop>
In-Reply-To: <20261104195317.8284-1-atharvatiwarilinuxdev@gmail.com>
References: <20261101013817.22d67ea7@jic23-hlaptop>
	<20261104195317.8284-1-atharvatiwarilinuxdev@gmail.com>
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

On Wed,  4 Nov 2026 14:53:17 -0500
Atharva Tiwari <atharvatiwarilinuxdev@gmail.com> wrote:

> > If this isn't matching some legacy interface, then we need more
> > on what these do.  Maybe they are suited to some other kernel
> > interface? In particular they might need the various controls
> > on how destructive they are that something like fwctl brings.
> > 
> > Generally an arbitrary opaque path to firmware isn't a good idea...
> > 
> > Jonathan  
> 
> Here its required, if we write CPU/GPU Pstates and PPT to
> some keys (MSTS MSPC HE0N), we can reduce the temp by 10C
> And We can fix the dreaded PROCHOT signals on macs, Giving
> Same temps as macOS.

Being able to control them is good, but ideally we'd map
these to appropriate subsystems rather than having a magic
interface for them.  There might of course be some gaps
that need plugging, but custom ioctl is rarely the way to go
(except maybe due to legacy userspace we don't want to touch!)

Jonathan


> 
> But you and Sasha are right, that exposing all keys is a
> bad idea, so i have restricted writing to some keys only.
> 

