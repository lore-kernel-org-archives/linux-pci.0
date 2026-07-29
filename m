Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C4B451993
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 18:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785350139; cv=none; b=ndAXgrc1gRAOg4ZfhQJzGYzSLDYU7HmSE3LIS6rZNIGMFnKJ5CWiKUyHhdk2qP9aPJYMBDF8BTKLyLUX6QKZ3n6l8gutTtnlsL/MWi7XX1Ey5qbhumTT4DYBk2KNsAGj6Q4A+fj98Tupaij1xyz33WNoElqQudRvw6VxWM/JZVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785350139; c=relaxed/simple;
	bh=w8ZcsTYZq6h1WcjQ9hsHh5n9tzoVHYRugiOtWG6aBT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ffpjmXJfvWAyfUARal0S4zW7RI+lxI6j+gvvcQ5/xTyblFBtqRY63/IZTo66d9gdq6ndFFvnq0HKtR4Ij5Q0lMzLnJ5jxRq/Vzi7kIKH0W2fnBBHm5bnPaFfzmbGV0bbic/0690vxKz42TtyQ8b1ndgDDUlSMbaAJu1Q2cHKOgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQ8r3hTi; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQ8r3hTi"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cacf197759so20238595ad.2
        for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 11:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785350137; x=1785954937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w8ZcsTYZq6h1WcjQ9hsHh5n9tzoVHYRugiOtWG6aBT8=;
        b=IQ8r3hTihDiHql8XStVzAvqfjhtDRgi2V5JQUxt/RD9oDTMOWG0xFjc1UeyrzoQBcp
         fep2WMI0SlVztxeV60UEjFzToFkkJZGHq0rBJvbEMtFuzHk8EmMsbDIpWDAsznjx5FoE
         G+PfbuUo77ZBaPThehnA4rCAYfcMIDtTNrBHAW8nMAQv3tSHDD2nuPdRoP3lriEWi1w6
         8rVxNa3hAncs/f0aB6K2x18hXZE/xFD1b6s+9/9S/tJamvYR5NTYlU0NT7WC98LzTFtb
         5c10gdVBLex8w7MTwbrCos8qkWmJRyTk+K7DoG+sGeCdKx1I7/xnAB2xjy8ayPQcmelJ
         qz2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785350137; x=1785954937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w8ZcsTYZq6h1WcjQ9hsHh5n9tzoVHYRugiOtWG6aBT8=;
        b=Np5EDsu8I6Tixk2mDlbPSX3G7T+dro/m0tIc3x4MHXZ3+ewHeIiTVJqI/h39iTtMV/
         Y09xaltrlPF7ARw8rt9564ai+AZpEW9yi0vuNCZmuj8WRUA5fxKU3VwaJ7LTxL+OhVEg
         v51AFfcj8ysQNETOZS190Jj7/ovVMaoMyAVPR5Jng0NnrhSI8otkIZTIzxOLb7VLr6ug
         HpeySrDp1caUkX7VS9Tg1lUlFcL0238MqPG4Mx7JVo1aR/bM73HOd0Vc4YIelqaqAJLz
         YykQgbrAlMbSzAqlIjitnXBFxAWHFzp1iVHfzVIAGCWk2yl+yLnqFFm6gS+aTpr3pekh
         XUHw==
X-Forwarded-Encrypted: i=1; AHgh+RpOIAvRGXvZQIJUUw3xJXRMa+YQGHEEQG6TmQ3b/okOVtVfdhmgfvMuMzi7Ru8dD78Zm+2CyURVi44=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE0ZjI1JyqoW1iwgN7AxYGEd7N0aYcno5EejPmZqI4kFXnKbYj
	yOY5hKJhBI9Q5gu+QMMA5SccH/uXMc4Aw2TS2JoP1cJ1gyBp0Prz4T0=
X-Gm-Gg: AR+sD10O2twRwnC5Yw2eI/P5y8QcpMGgzyxuMz+w/ZjLEkLXwSdcuCN3lwKAojZW1Qt
	o/0sr5kjBAjS8U9lvTFm02ziKnD5rZ8ZuqKwnkQrfcSD9xAOPgQYLQh0XnvhWpV+C5uYHoatQ7A
	OtSKaqnXfhc9SM76WLcPO+w4u6kp3iR8gpivhM85hOq6hIPM1LLpbMVKwGXa7+O5r4fXFoyoKrW
	oBcWnbhhCbeiSDCmKzB83Gazfrq3AUPItDDe5tadkUSnh7RwlC+xiHdAGf68ZAvJiBiX+qdnDuF
	EPJOm7d66MpK7xKU15kIbD8/I/F9XRAd744UbTn3v3JWEOuBrYwsWlA9d3a5sQv1P2iOaUdLwNm
	2B0TzP2hY009ZgnuV/T4YvJ1HmPbglJhlGCG+BnIJTi3ZyReUieXOSHPk+rEkv8us2tjzQvfyKf
	iIwEVu9CiJ5ytVb1BhKhhMzUPdYKFBlrBeDWB1YfKq37/08GgzaHZLn6GbFEz0g4PQw+TOdFH/S
	leav+oiYMqdm4Z/YSKjlNhbRkl7usOAlkN3r85j
X-Received: by 2002:a05:6a20:1449:b0:3c3:9557:3b56 with SMTP id adf61e73a8af0-3c8ba66b71fmr9232328637.72.1785350137261;
        Wed, 29 Jul 2026 11:35:37 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009.. ([106.202.119.113])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504d37368sm22620397eec.22.2026.07.29.11.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 11:35:36 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: mika.westerberg@linux.intel.com
Cc: YehezkelShB@gmail.com,
	andreas.noever@gmail.com,
	atharvatiwarilinuxdev@gmail.com,
	bhelgaas@google.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	dev@deq.rocks,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	hansg@kernel.org,
	hpa@zytor.com,
	ilpo.jarvinen@linux.intel.com,
	jarkko@kernel.org,
	jmorris@namei.org,
	keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-usb@vger.kernel.org,
	mingo@redhat.com,
	paul@paul-moore.com,
	platform-driver-x86@vger.kernel.org,
	roberto.sassu@huawei.com,
	serge@hallyn.com,
	tglx@kernel.org,
	westeri@kernel.org,
	x86@kernel.org,
	zohar@linux.ibm.com
Subject: Re: [PATCH v5 2/2] thunderbolt: Add device links for Apple T2 NHI
Date: Wed, 29 Jul 2026 14:35:24 -0400
Message-ID: <20260729183524.1199-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728044841.GP2365036@black.igk.intel.com>
References: <20260728044841.GP2365036@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> We should not be calling PCI functions anymore from the SW CM core. We have
> pci.c for that.

That is outside the scope of this patch, this should be another patch.

> I wonder if we can put this to pci.c, rename it to tb_pci_add_links()
> instead.

Same thing as before, its outside the scope of this patch.

> BTW, why you need to differentiate T2 vs. the rest of Apple x86? Don't this
> variable do?

Because the Patchset is specifically for T2 Macs.

> I'm not fan of __free() and the like so let's not use it here.
>
> Also you don't need to scan all the slots. Just look for the tunneled
> downstream ports based on their PCI IDs like we do already.

Could you please point me to the "like we do already" code you're referring to?

> This is unrelated change.

Its not. the patch specifically says T2 macs, and Titan ridge is only on T2 Macs
so we dont need to use has_apple_t2_chip for that.

