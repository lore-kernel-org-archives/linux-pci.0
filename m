Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792939852;
	b=CWW2x2zRfXOl7K69t3tmHCqe4bnaIAtVU64Iu12EacfO/ITM1rP4F8W6zr/aY/fz5z6/
	 erOvwF7/MehlcOM5bI4/clDz83vgoOEdQQXyUbYeA7mNPvqtMz0hcLnlN5dA7qO/SUpYp
	 6lQoLUvVLxOdaN6j5omf2a2rxtgxi3Gh7oQRWk/FoYRt7CETC+c+Va7u25ZgtPY2sHPs/
	 7zVzaNkWKrZXfYLTaE2inD5fNVwuC0cq5yzW0dtNanEiNqgRSdeeDS2xW5r8wmvz3g+BR
	 VHNxGtRkWCj4yQzTqccZHMoAFQCJlAXk/NKy6CrisjdtmaV2bVJQnJYNxxuOonJSdDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792939852;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=PA72TJOn96rTm0l6KrCuswMCgsDDGiF/Lj452tWSU2Q=;
	b=IdwCrepvnOPQJ8nMGxTGx35oh/HUuq3bfL0HsxdQRsnDtKynXE6hr6xEV+JrfQYq7bXc
	 9v+ZOi2eBjyTCM3J0hw5UPxPGOS75ScrI9f5XjYXgQwswT+KJeLyVS8uMnn0O/wyamRPV
	 ONfewf4SZ7Emk1+6298Y96V8nee+P5MW37w+YkzlhkGZEXIrctK/1KYhMwOe9xfG/9RK1
	 haFSywGuhtH/oJiid7Fj4x6OGmMt+dRe53NsaDw62miUlFBdjgibjAAaG+9Ks23IuPLI8
	 MBpHWK9aSIozJ7YskptQH8itfsE2G2WScxelIXNifLEp+emDl/eGFshC96yKfuI/OLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=j9T4F5OG;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6422D606A31A
	for <linux-pci@vger.kernel.org>; Sun, 25 Oct 2026 14:50:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6422D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=j9T4F5OG
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-355724d032fso281322eec.3
        for <linux-pci@vger.kernel.org>; Sun, 25 Oct 2026 07:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792939851; x=1793544651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PA72TJOn96rTm0l6KrCuswMCgsDDGiF/Lj452tWSU2Q=;
        b=j9T4F5OGt/GvWnCF/LtEZHkEkRFO/GwdoG7tZ9TBRqOSbJ/un2GPh6qS6VV1m4UN0s
         C1PMcbCwLoMXk4IhKyNJU9a1XWYUciYATLE+8wwrXtM5LCfjzl2t8i7edkDP3Qm4L1xE
         RAfQT3tjceo2XHgNziLQDhs9x3868J7jeMdM96byPm75GXmegHVlaKK3A0/s9hJsaQ01
         dnG4wRhk6r5HWPZTAGQmrraByG3Yr4ZdfRDYR5C39izP5KSO6wbIJpb3fwenXZhoKsB9
         8ekTLvlyl5EBwUBXvU2tMYpKG5bpjoYBYHX+C+v4HnGTZ4MC/wYTfXeNNBGv+KCX/W30
         5pXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792939851; x=1793544651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PA72TJOn96rTm0l6KrCuswMCgsDDGiF/Lj452tWSU2Q=;
        b=IFgHUHZXY9n60d0i3yPyLDBo1fJ0XRqLV/FBB4LuKBlbLRpEnPKyjgMNbY2SDCa64r
         PqdEzqBJ8J5wUSU7/XGsJnQdrOgfJOF/XcrG53Fli5CNETVIUyzDOWh4e6d0u/o8rxfY
         ivaelBqEBtLbxAk2ALiCb725gxGnP3IN0xdMwz2crp0QgmOqXMDZPGPA+CMhui/kD5vU
         0w5+7Xknoza+gAnjhVdUYIWuVQ2yRt8sDaKzc8rc7XKRbMOAYxYmasS/uGh03D4NUEsc
         A9yZqrnj2xTIGEXDwR8ba4S7Pczqsf2Ay5FfMciIsEpk8VyPEYDOCIJnAJkTGK3t2Eio
         qfOw==
X-Forwarded-Encrypted: i=1; AKwUvBzbWd9ZNgThoqqksIBiicmSgQLsmkoNsx4ObWg2kjJMUYlLl9pIrHrxGKZhA+DeZA6ZwRuhzpM7fu0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLlA25M2XQaxGOTeG3ZKT0yce06hm/+VY1xGd2/EahfLsIi16Vl
	GsgSCQLoKRofSx9lgtVzndeFKIWSTgS9/yU1q2vb4D6s2YjkNLPsfhJA
X-Gm-Gg: AYBFou2uObk+xLel04t22WDEfDl1Etjhf90tWRD3IqB2Cvb5jdE1+tHS5YSAuEeV7ei
	1PtV4FZ/WRRswX4Z1npqGDc1v/ccze+gRBmAALKPz/e7+7CrAxWulKqd27bgFfdSH20UJalyqiI
	VhVUtErtT8okkVMQwnzSGGk3b1DtlkbBCFMb8/MVNIFE45dfie8Lzh0X2t6kfiXl0V86QcFIRzA
	eKwRFGv4ypT8dbXdcl5NrYc0ohTJBaAAj1rkwdIO82lhxcCrDWstDzzPPSOFD2XkV0A0BY1cwUk
	3kgcgFz9KsTjbjHidsMcnjSK72hsukNzmMeqqw0bUziKWd3AiyekqI58cWVndZpHZIS8BOsZ1CV
	ElZzymM9gcLpc/VeqJD7w3tRnqN+6neFf+rdKZrlWsxt4cRfBvADNMm2rQaJkFTofZkw2De/kyg
	Hwj91NYHDZEnprP1wkgeMO2hPZLxBcOK7XB5lYHxbH0VjqBx7YsatTx3QK3/fKoWQ0WqUo1gPRC
	IMkgm49KEdwAcDQpQQbO9oIQ80gq3qw+j7Gl4WulyxSlIEqKjlxqu7K2rvn0CYAy+MJBMWlPR2N
	iRTPwfAuJzG8p63vD5PokyTI9YXd8fyCxgRb6YwIn5Fvm6+jEzBCY/Ckxe68+hZ6/hwvNGJFsdN
	8r81IQatGJ3kUmTp7X4Id
X-Received: by 2002:a05:7301:19c:b0:368:1f8c:5f23 with SMTP id 5a478bee46e88-369e821311amr10255537eec.0.1792939851044;
        Sun, 25 Oct 2026 07:50:51 -0700 (PDT)
Received: from cachyos-aura ([45.112.149.26])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8d8a690sm16770605eec.12.2026.10.25.07.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 07:50:50 -0700 (PDT)
From: Navon John Lukose <navonjohnlukose@gmail.com>
To: Nika Krasnova <nika@nikableh.moe>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/PCI: Disable D3cold on Intel BE200 Wi-Fi on Lenovo IdeaPad Pro 5 14IAH10
Date: Sun, 25 Oct 2026 20:20:44 +0530
Message-ID: <20261025145044.22228-1-navonjohnlukose@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260722021321.68902-1-nika@nikableh.moe>
References: <20260722021321.68902-1-nika@nikableh.moe>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Jul 22, 2026 at 04:13:15AM +0200, Nika Krasnova wrote:
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "IdeaPad Pro 5 14IAH10"),

The Yoga Pro 7 14IAH10 (83KF) fails the same way on the same root port
(00:06.0), so this should cover it too. Matching "14IAH10" would catch
both.

Keeping the card out of D3cold costs nothing measurable here: across six
90 s s2idle cycles, S0ix residency was 92-96% either way.

I've withdrawn my iwlwifi recovery series in favour of this.
