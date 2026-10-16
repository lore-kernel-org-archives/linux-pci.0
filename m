Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49B52F83B5
	for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2026 08:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792140208; cv=none; b=c1yFErbg49JnOzNK1Igr4gyD2HzH6nNfPcW2T938/RbEYDIEcy0cpMhOYcU6rx0wBaZxo0jxPtkWutrDVp18z/z+08kuL9l8r8csSTIGMpKrcVfNXh+mZQiYTwIia8U2YIC/JCuZDHIunY0rCeHk03sodPMRYYctOvmUBSusxbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792140208; c=relaxed/simple;
	bh=9ytjh5h9nCKW6lRtRba8cDTN0tvYqToRzL6rsiKLUvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YhN8seWejK8XAzEdpH6DjtJElp2xdtxLRtfh7Xt5uKVl1x3tzBbAqj+v9FefqmAvf+AKHYF/aitSFHn3XVd7J0oTYJvZL4oYY3PnhcR3+TLwAyy5E3MiBkJOxd0tOvdK0b63/q+wova/ujPs1RuzVkyCWiazGD7w1rqdliZYAl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UdgMeqJb; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdgMeqJb"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3584f70a5aaso819509eec.1
        for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2026 01:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792140206; x=1792745006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9ytjh5h9nCKW6lRtRba8cDTN0tvYqToRzL6rsiKLUvQ=;
        b=UdgMeqJbSyAnx9bLBdu2kQDFZCh6iKG+GtIzs9ycPlZ5yj0Kg/VyeCvPxSRm2URWXx
         bWUg23QM/+8KfjBxWDe/H+AMcj/0vJN5vo2MHwrMA2rhjNvqcwe2GaFW/XKdWu92iIV+
         vk0Bf/8mPSFXVbXXCKUDFP01ZclE9pDcWZDfDArdHnBAjxEixhMPyNOBVGyPr5M9IfD5
         Z4ihYbbAho/u3jgiW5tkVS91RwCvTqMk7JuntNeABXh6NCHCmepjO5atHTusRdTc/MAx
         REFvvH7Z4J1/QHZxS1GnX2/k0tJ28yrgV2R/8kvEEnkmUMUrO7h0ZzDKi5GKHretWIhd
         Kdmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792140206; x=1792745006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9ytjh5h9nCKW6lRtRba8cDTN0tvYqToRzL6rsiKLUvQ=;
        b=ZWx36H5EDGHjbJkJRefFou8iD43INurZjfImVVKpD4YDyOqj7iuk1nkzrwUtV1ujP2
         twFGU8tnAyVl/2f72Gdgqtu9hf7vLTH2g6W87xmqhUB/t2hRbycIR/EJHCkZ0zokaZJH
         wAZA/RLyN7NN7bxk4T4//PAdEhe2ze/NsROxxDoA+dvEGG9lFH3t0Jn3/s+HV4evSIby
         nZTE1ouNvUgkr1nMcA6ABQwiyQ1fW1vHBTYCWiq1r6fv7qQXoe8NQ14SvRpvCHX+n0hd
         dAqt/kzPaH8wEJ68yK9fSn9x6z4ksbx587YZg7UDk7nSOUGe1LmBE9hfjEHNFbO+CJqL
         sDsA==
X-Forwarded-Encrypted: i=1; AKwUvByUxgrpNjI2mln/E7E7OUHW3iOnJThmzvr/UcW42YsNX7mELobPCSdMCGuCFbsIRKX6S677/9K4RLk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLIW1nM8GuKT4kpMMTqQSXAJcH7Yl9rtA0Pkg74bVKWayP1lo3s
	jeE9t0NEnzxrzOOGQzLIt/JevnLdCLiwm7Wj2BHzJiCfpzSBDSRmW1+D
X-Gm-Gg: AYBFou3fMOFwBvS3uOP9teDtu+Hi6WwfYMwAmrCP1mGIM/oj+56+YJohQ6skkZ2Ty3z
	he30F21p+rIrDhWBnZ6/3Vrwul0zxPMOV38jlHNSzvMZcoa22pZUfT76hc2A7AhBpyie2su6jDz
	4YkeC5ez06N/RrcF7395eNPBbjnX6u+BDX1l5+Wyhf7IHlLSyXRxEosNGP30U8SITigPM9SNFwk
	xJI1+tlS6hS4+btnI9PmxMng5gbfT3FQ2RRNb5GnMDyqh72d+M44uYYzgz3CNzIPwpWMFnp2XoG
	9UYql9gqLzjPItw+tynrYnkplbe3X4Yy9Rc4h9pw5mxdLUgKT1GkMJW3E8pVpoZVqhqEN2BnUql
	MMgUlAYQwK9DFfT7lEjNz0ewD6yVrc9lteqSznyBOuraSGcVO2HkGpKyGvdsMdqfV3RlztVKClR
	/gnXmZZeMpf82AX7bWFC2GnuESGXbLuxp0/7u3OPRML7qPBoYDHxh6C/Zv5I0/U2FhnNgqgq1LT
	WDPPFIt8IBi4bXSViBUzyvIAyYb7h/wDvGRUwF9jRSgo6aKL8t0JB1nEgu98GgNT1eO/df1RNDk
	cObN6t58QoiPYVzOEX4ub4Vi9PDRhmOOeQ==
X-Received: by 2002:a05:7023:a5b:10b0:147:d430:7322 with SMTP id a92af1059eb24-16a5bc5bd84mr42237796c88.1.1792140205626;
        Fri, 16 Oct 2026 01:43:25 -0700 (PDT)
Received: from cachyos-aura ([2409:40f2:311e:5e21:4c93:81a8:d3d8:4d1c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831b75be5esm5793636c88.16.2026.10.16.01.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 01:43:25 -0700 (PDT)
From: Navon John Lukose <navonjohnlukose@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Mario Limonciello <Mario.Limonciello@amd.com>,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Skip the suspend_noirq config save if runtime-suspended
Date: Fri, 16 Oct 2026 14:13:16 +0530
Message-ID: <20261016084316.22761-1-navonjohnlukose@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260923022511.24932-1-navonjohnlukose@gmail.com>
References: <20260923022511.24932-1-navonjohnlukose@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Bjorn,

Gentle ping. The patch still applies to pci/pm on top of Mario's
pci_pm_suspend_noirq_common() split, since the !pm branch it touches is
unchanged there.

Thanks,
Navon
