Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193B930C156
	for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2026 09:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786009385; cv=none; b=jMqgM8kEVeo8McVCPQUrnjTl1CRtNZawUy5D05nt8xMDB5i0MOgWpGNxrJk2sKLeQEjbewFHx6g+8YeuUF/9hS3WV8SDkYC7LSvIJ/MvdHc7w7Vp4t0CbREFkaDFbp1iptg4sUc5FahmVRcOJ2TiAWQbRt41cx0vd3IkD4uvngg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786009385; c=relaxed/simple;
	bh=C3Rptn7IDy3arP2d+GoCe2IFF7m8kAi183TRNYCBh3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PQDQMBAmaukzWaoEf2ETs7MYFJ6Iw1KN/xclt++GUw8eAeP310beT4kUthRvxXpOHoi6RsnmUFzrXYFZvilPBGeCpVgyPZ6v7JVE1zZm457RP1w0QqNY7uqECgfrQtdjvatwmXlcWjyDWvgkYzD5T8FMyZDMOS1TgWY1T94TTss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAxLuHR3; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAxLuHR3"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cf50c6f235so24306315ad.0
        for <linux-pci@vger.kernel.org>; Thu, 06 Aug 2026 02:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786009383; x=1786614183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C3Rptn7IDy3arP2d+GoCe2IFF7m8kAi183TRNYCBh3c=;
        b=gAxLuHR3mpR25aU3KSm/Ue3P4ftodMwUfrESg9iWf4Hx++yqHbGlvU4naFcsdDx98e
         QiZHXFvH8P0AhWbtWJ8u+kUrPpgfIlnppPD3dZ+/YQ/h4nmlMH5eN01yoJZ/AbvhCEun
         1SFZsSIX8DEvx37kHKfi2RNOCyyNRp+rYmT82f0OU+KvP2TwLA2VmdGva4KWAuewN9LI
         rVDeJ/xJcXvh4xRsrYDZXsqP6Ka4uq4UMCoPe3wNMsuAVPeRsAzUhFyH8gT2Alj5b2Y5
         OBBs68IImaKKMjDD25VM+hKK49aUFQ/S0b/FkUDKFVQO5f4es1G0TpOCbapbFWKK+2e0
         Qb1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786009383; x=1786614183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=C3Rptn7IDy3arP2d+GoCe2IFF7m8kAi183TRNYCBh3c=;
        b=FP+Uct8GpNyD2+J9+p4PqItmEA3AGNopdB+vRHaVyKSrJmvU9w8w6dffTPOCV9VdEn
         6j3lMjV1bKp5gSQy/2usyMHTS/E7q9awD/gpP67qrJhXIOt4njE8UPSxdcz2dB2VeX8v
         2O4Zhy20W8m0vaBvnkO1HTx6PdSmaUrVmbZTSbJ/4nAix34+TYfsVLdv0LCKg+1x+YeF
         3KsiyfRV1UifRICQOTM5a4mFNfuBK1Qel9E2x8gC5rNf9oJzreWvwBkdJ5DjqHVgT5hf
         B/Q/hm+kykhn+fiH+CvruuKxN53YO8HNU/T0j6+1DFqmwJeprZ94ul6c5ERrCxn+aalB
         rcRQ==
X-Forwarded-Encrypted: i=1; AHgh+RrLdqwQzqAntTN+K7eAMF5YKELzQKtUvDW1NrhWH0QQQyJFcSzn/SmeMiqPXYntoxW5DplNDikokYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgSoPNhSiaRexT294pFXwJOj4oUe9a2KwSh4gpvIUPWdLU5F3d
	FaYSHW6hHXIOOgBghn61s38cGuTSNh/tziOEtDJtRT2chTp5sckpRo/+
X-Gm-Gg: AR+sD10lUNcuWBlPASlg2Kd0Bb/IskQbI59Tyg9NEIZUEJy6hFoBHkqqLls3WwaOajX
	EH6TyblqurPSZmcIeFmEjUZp+F2Xg4zRcJlzEKIhA0q5Nnd0otZi9WJaUdOE0DHMF/LA0OPpmy8
	3Y+0Qty/Bx0n3CK2cLbYEqNmpMU47+nHUvghJvzHz0PCOvw0Jjh++YgAQO+2j8/MJaLKbB0QHqg
	UDUUucUdE25iWeE8ie34+KP93pM8i4J0/g05lBYV/5R8k73yfe52TGVRQq3fN8EaQQyO3RIloE4
	NWv7Np6DtdItJSGPC37hWTFBz5y3olQ5kR5cKo+kMIfL7A7jT1V7DjGKuZ0ulO02CCKMlQ1jJ6k
	swz5tTAu0/FmQCI9o+rzRx1NGrsiqQdvJShtrOWpFgIkOUMVllf877VIsy8iJiWuHmopUayTSwZ
	hvdl+OKonabLG+RtVLg1mTiF4csCEzTU1Qpjak4ixSUjf823DIJ7U55+roweGU
X-Received: by 2002:a17:903:2312:b0:2c9:d88e:f996 with SMTP id d9443c01a7336-2d0ca7fa497mr143228755ad.9.1786009383289;
        Thu, 06 Aug 2026 02:43:03 -0700 (PDT)
Received: from ubuntu.. ([219.241.133.184])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa49295asm29610525ad.45.2026.08.06.02.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 02:43:02 -0700 (PDT)
From: Rihyeon Kim <rihyeon8648@gmail.com>
To: tarunsahu@google.com
Cc: bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	djeffery@redhat.com,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: [PATCH v2 1/2] PCI: Handle dev_set_name() failure in pci_setup_device()
Date: Thu,  6 Aug 2026 18:42:59 +0900
Message-ID: <20260806094259.58687-1-rihyeon8648@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <9huz1pcem2qt.fsf@tarunix.c.googlers.com>
References: <9huz1pcem2qt.fsf@tarunix.c.googlers.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you for taking the time to look at this, much appreciated!

Rihyeon
