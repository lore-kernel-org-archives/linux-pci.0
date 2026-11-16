Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794849404;
	b=QsdY83iwKfYRZnKQgGQQQj02prdwG515EGEbjCvl7RGOZ2qLtR8RHvEvpVRC6LjCh/jb
	 HD7R+9OXU8nkPgn8nu/BQdEHKyZkCIKbhjjAhOtoOdIfTbsIwCv5CETQ9j1l7VMjxcf/T
	 Sbr6ftUIFKy0C38GcwzbseRv/0+V4xP8RywQ+jlB5iHkbMnfDSBOVlHLw2/tFm/h5e1As
	 FzycIWruJ1dm6e1e6vMPjo9cMIAgUTYlCZAHNBXOoMAZAveQP3oY2YxzktlQqvS4gBeMU
	 XxVXJgBUk1o9h2cc5+8tQJx9B28HN2PPeeKmos8pW4DSDY/bB5QJJh+BXBxA0b3qxZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794849404;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=mSvoaqmjg32ifr2UgUXPIKGNa+qRJ8bbbR9fyHQLo9g=;
	b=hCrR0E0dvJDT6SV9teUJMQFF8omRaBguuHHrx3+jcX/PRsXDjt0q2OYqhlIhSP2yNMHX
	 3cHMzyupJ7rzjSizi65+agpAasfuguS6gz/ZnxTQp0ZcYEa+kiR81UoKkj+shWWdCujMm
	 fB1hRbne1pULbUSm497OZ7gAwC0Vc0l5TCzn6ITJzJPxz7PsqkP3dWlnbPe1vXIQz2ZzF
	 PW+f5e/wIXYw2xsYzZk5z4Xe9MOFrGp9bi523WJiPInBARzd31+ez+X5Yqwo86s3XTlYR
	 cIaYkcGsTKI7514uzEN7+PX+NaCCLLaXvB0HZQUSICYH4MfSAS0dxSLEr/NgenXu05Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=CxK9VZSf;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F46F606A880
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 17:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F46F606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=CxK9VZSf
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a14so18672955e9.1
        for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 09:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1794849401; x=1795454201; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mSvoaqmjg32ifr2UgUXPIKGNa+qRJ8bbbR9fyHQLo9g=;
        b=CxK9VZSfh79fNWhCp1NFP++dVlw2bcsnTNu1h5/kBzXtJKoJOtUg6+ISzBVyn9hDKL
         SUzXpSz652HmDYMenkzBqfGos4Bs9Egx3VVCquC0y3AF+QAIocBkxYjcVHcJb6MYKJHk
         xaqv962wIhXwvWlz0NyvYRpBpjny36vezEPmv5M8XpOfiWZeEWVmPH97qqZVVZ/C3x3z
         HNXVak8pSZjAVNIlduUeK1xaZ97f5RfnT3ZVoH3Hs3jt1V0k3ox+0V7yo1o7QKhYMb5Y
         Vo1NUvrTXlZyxWX0Wj1d7XzYTsrqtEeIXJXoHNnr+ITFHHXVyWLvy8xvEXhGTUBgNLIX
         V4NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794849401; x=1795454201;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mSvoaqmjg32ifr2UgUXPIKGNa+qRJ8bbbR9fyHQLo9g=;
        b=K38RST8opvmkeL56goGw5EP5jllSBp7BuG6VPZeFFhfnrhtZC+r0sBlNlU/HovE5FT
         /ekbIONVf5jR+952Bx4vh81Hg8YNAbyU0P3bITkqSsLxUkAF7KUvA5hRNPh55sd/Nrgb
         sqj6cM0ziOmVIRhfCVH2f6qxkO08WmtO49bMB4bCzf92t9OhPTxkSkjP4jat/QBWqqiz
         T7L7j/S0f6tXvroBBiQyLzrrGuRY8S/UxnddW7718M2WrpFxvfHZLDeQ7TMAJNurH/Ud
         yemsHcnOnukEOSrj0sN76KNgqwe0/fh3RRdI54RLBOhSEGYaF9i4BuW9QvFaFSLW0zlF
         L8RQ==
X-Forwarded-Encrypted: i=1; AL+hErGnWVlUkyLPAVxaOZCaxokElGe5scKqzoxUk6TvEI3LqNeNaQHgB6UkGTOq4RDR5lL/1QSPcddZHOk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+FccQpw6w4A/CGn4nOoa6pxPM/64QaRSWR/YZosAFP44/rRufS
	OyikW6+T9IP+97bWWjqOepSaqAYSuJk53kNg+T/TigvLFFuqTTiZ/RFgscZ8oZOPLUk=
X-Gm-Gg: AYBFou1JELb4E1mnD2ti6dx2/ITn/N54MEdtLmJL76gSPERKL+A2gI0uM8dPnrq7LOK
	AdTp6EqxL4ccFRxfgVFZe7l/6yvjDE2jHoosWo2aCVcjxmCPIkG+Q6G55oXczYogRx5FMSJmWH5
	STdS2pzK4dxcFGck7EaGCkc8u+0zZig0KqMPZgIjmZyN7Tg4v2Z31YkF4/pShN3qX2ryd4BrCCa
	Uq91jynLo20s4ELc3wQhdu/qfKLcXbIhC/TUnO9p6mq5QKbGC8qNPWzftE9n58hETGUOYJ7KOv7
	noorfeSqt02KNOKp2oip4bFDKOTeNb9IzrBMiNoqarwzn86WRlzihzAiHZAz/9D3oyUTzWXpyE5
	ATLn7Zq57vyRxOBrJf3O0m/yddSBGd0t8DtHj1jpJaAFDEhRkzndHSwfQOQsoJfMTV6nTSXJwgZ
	nQmmcE/iwIefwD2q0kQGFsIMy4DM7ejidzPjLpPhElkWnXWk4rmMr6rX2KcVJu8ljXbKGmd70Gv
	+heh/LF4oq7r83t0sAChwpVoYV2orcF2mz2q4vvVeFx0aD25EgY6TqytnuHDfS6+FWvqMlIBdNi
	APFLJVqUTpzxEQc+/G55ssrpYqJSW+PmyPifAWFGrVOFXfA1hcOmVmYjALDMcxd5Yts4n+SvE4V
	85ccHk0qlYs04leyinT4i1cJly9pgo/SbEa5TYaU=
X-Received: by 2002:a05:600c:3ba5:b0:4bb:741d:eba with SMTP id 5b1f17b1804b1-4bb741d1238mr63980765e9.13.1794849401463;
        Mon, 16 Nov 2026 09:16:41 -0800 (PST)
Received: from localhost (p200300f65f19a90439293c698a65b414.dip0.t-ipconnect.de. [2003:f6:5f19:a904:3929:3c69:8a65:b414])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-49c5fb58fefsm25945708f8f.26.2026.11.16.09.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 09:16:40 -0800 (PST)
Date: Mon, 16 Nov 2026 18:16:38 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Dan Williams <djbw@kernel.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Ira Weiny <iweiny@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Zhang Rui <rui.zhang@intel.com>, 
	"Mario Limonciello (AMD)" <superm1@kernel.org>, Saranya Gopal <saranya.gopal@intel.com>, 
	Gergo Koteles <soyer@irl.hu>, Jakob Riemenschneider <riemenschneiderjakob@gmail.com>, 
	Yauhen Kharuzhy <jekhor@gmail.com>, Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, nvdimm@lists.linux.dev, linux-pci@vger.kernel.org, 
	Kai-Heng Feng <kaihengf@nvidia.com>, Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Chu Guangqing <chuguangqing@inspur.com>, Andy Shevchenko <andy@kernel.org>, 
	Mika Westerberg <westeri@kernel.org>
Subject: Re: [PATCH v1 0/4] ACPI: Use named initializers for acpi_device_id
 arrays
Message-ID: <avs5thXfoZA4TBnE@monoceros>
References: <cover.1794567577.git.ukleinek@kernel.org>
 <CAJZ5v0jC5YXsLgB6Qd55KNCU0oCsN86X5WpRfL+Ycz0MJ8vGqA@mail.gmail.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xs75une3ctdjt36i"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jC5YXsLgB6Qd55KNCU0oCsN86X5WpRfL+Ycz0MJ8vGqA@mail.gmail.com>


--xs75une3ctdjt36i
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 0/4] ACPI: Use named initializers for acpi_device_id
 arrays
MIME-Version: 1.0

Hey Rafael,

On Fri, Nov 13, 2026 at 05:17:30PM +0100, Rafael J. Wysocki (Intel) wrote:
> > Uwe Kleine-K=F6nig (The Capable Hub) (4):
> >   ACPI: Unify acpi_device_id list terminators
> >   ACPI: Drop unused .driver_data initializers in acpi_device_id arrays
> >   ACPI: Use named initializers for acpi_device_id arrays
> >   ACPI: Unify *_device_id list terminators
>=20
> All patches applied as 7.5 material, thanks!

While rebasing these patches (as part of my wip tree that contains a lot
more similar patches) to next-20261113 I hit some merge conflicts. If
you tell me where you applied it, I can take a look and provide my merge
conflict resolution to allow double checking.

Best regards
Uwe

--xs75une3ctdjt36i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmr7OnMACgkQj4D7WH0S
/k5UDgf/Zh/cCBQS3AfcJY+xVzINeExpvzUmIZMMajOqIRB1Ogb1iu0eC9qNdona
axu6POUJXrXH/4pRKQXevRF3+h/9JnryHBdTIe266MjPuRwUmMbGA8WFTkyAB4B1
QWyO8s+I+vnTdOB8Epy5gtqS4T4GHHGkl77vuo+C1qWDCVa9rLVrAvtFGSJ8ULGz
w1dFA50z67Fbkzs1CIqH/smn3i2pPtGjZvfJ3APm3MUbEXCY3U5vKugaE9w7fFF/
RnDbWck5jZ7cSr2Z4gmAk05o1kwfeDTGzRJ6/1zxIdAlPzXZFzMQWhDcgVE+3pQm
cX2okMKS7qwTP1K50XaZeXSwd0t3mA==
=+qin
-----END PGP SIGNATURE-----

--xs75une3ctdjt36i--
