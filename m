Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793822018;
	b=MVDxN8hMg/auR4undrp1wEjgvjD+BBCabqDJktwqkicZ2/nc3+ly7LAB61utZzmsIe45
	 JLmtTfus5oAl8qfViCCenXfhlIA4GQhyaDKJF6+7m79KgIbf6iIJgX7JW8SRlRbXXpjwe
	 Fds9w05hIDxNQ4MrcWpcxxh2d7PHyNvG4Vlw3Zy5CIDixRm/BYMHShP2FjeuiLHe2QcWg
	 0KnbPQ010aLBrieMu/j+AdrZ7cfAdwCdtFxeb9q8TQEHToG5twE1+KgwBUiSiWCRHa4+h
	 tTvq/JnFmmzzD7Bhnjm3DjDGiihQniYdruI5eynzLli5jQJjVzTnp6Djexi1v+8YHRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793822018;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=j77TQJheY9BNkuAUNT0wTTk7+HF7XEvTQj5keMW7u/I=;
	b=jYkVTKVf+6/J2RZ71b1d0+hDiEcinpOCqTfHJVQVnOROXvF3iC/0iYJ3BsAsYhhZF3h4
	 ZAfepUYCaEUUBch2oNOAv/Zd0Vqcq9QapJjDsYVd0i6oFIlpgm/NS6SV9hRcPbtZ7phId
	 ymT4IwMZx69Zm/5nnZVTnAXmVXKXIPNX39+0zVfH4kDLRuXx/3TPLYdinK4yyJrMiEHjW
	 2cGvZ4+4+ozAqa6fZCAmVAnY6lTFu6WJoumQxTve2WnZLj72Zvy7zJwIBJZdx0LNkCmle
	 Pw3bzxyTVOXF+vDbJ7f1/+u+w2x4mlf3Grzss/Qx0ZmCMFupC7WrpyItJg+ZEBlWpeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=snwKVTUy;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F6B6097658
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 19:53:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3F6B6097658
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=snwKVTUy
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-19305bcb72cso1062207c88.1
        for <linux-pci@vger.kernel.org>; Wed, 04 Nov 2026 11:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793822017; x=1794426817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j77TQJheY9BNkuAUNT0wTTk7+HF7XEvTQj5keMW7u/I=;
        b=snwKVTUy9LvBIeZYEhCXzEnRQp2wodIFGKY4wUJ7ztWzLVbTd1bI4nr3mGXqrQXFPO
         83/HtfEisb8NH+6TKxRanc+LHldo4EqJ43kuJQJyWdqbEb2qaKJ6REpFD/Jt5EslTB+S
         zscnal0Mvh+NX91kiP+siOH9v7tqEITC6j8TarPFAWvrj5zWcfX48CLTn8neQnUjk0aG
         DdWT6beozrR7hgNmLfQYYUBVHi+K7i2h0gb1c9TLmiQO015gt7sDVMBLhaHB5Rgu8J3E
         vDvOsMZkyxTj1DF9F5rnA3mHVh2Jx0j8rAylzbJGVo40aem9854GCIhJgMsA/lSZgxl8
         K73A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793822017; x=1794426817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=j77TQJheY9BNkuAUNT0wTTk7+HF7XEvTQj5keMW7u/I=;
        b=xwnKx0P+vnNGJ2QccoPpGfeXez7mDRU6igicb2dUDFoGAB6BdmavaUsSLd/G88CsUL
         YKAQ/pQUqQomnNftGOrr+0p9MuZo/yfeiV9PaPf8V+PACKZ1r6uiI+m802uwwEWz6XFF
         2HGYEyIXUPe4E6jDZpxwIrqOhf1UlwFfzqpJ7L7pj/vJQS3vusskQxUtjQVsTlDpxzVT
         piDLR5gK0Hn7T4AZVZL9CRgh2vneR/4/Io0Y7sGgpUHhf5hKFNg2Wa+21mG/Vx2fPosK
         rQbdP6kcZWXabXyTT1FtHM7DGkuT2J1kVjPFTH3YjpSmyjmDtIx0fgZ3QgBE3xRGN8T+
         O8fA==
X-Forwarded-Encrypted: i=1; AKwUvBykhzdcb28oMtIG3tFcjYD9AQEApA7mA1SXoBzB+/c9p9h5cC4eE0FgI3lNSPKKxxfYiVZAQoWIBXQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z82ZHkEph7p3MuZrcgy8eztvBMx8FTDI7EF13vHixybsj9hO6fj
	KbL4NbZsFaGXsU6IX4Iks1cbGY5jhJ/bXNA3Zl7Gck8z3/ch9AtyC48=
X-Gm-Gg: AYBFou0bjC/1oiXmI7um2ymjW4xblqEYiMxL+ZBACDWv/ab/Q11/1Bz+3L4G7Q4PW3E
	j/XzEd13gpR68cT5KVZ6rzfUxafIxeK7IBgXu0zHyWQoQkbLonJaDM35/UmTkbfd25VNdXPGHEZ
	z4ul7XZiAgBgxPtJ32kzx/hwwTz3OB/pM+ouwNJ2Q7czkfXxzuoyfeW038z7XkWxF+vBlkSExDz
	8AmnmatAH9MSJE1+yJS4pidRjhSgx0PjnpaTRSRjH8dWIURanpNEbe7O+K+DMIE+f730eL0ct0V
	psHf4vHBX80eYUa18K9gGhvr7eacL1sj2FV96EsRwt6a2ElbVijiPwq6OYhfmspmQdHUrIQ8t+W
	IEMiLIGteOb5zVxk1CikbCBn7LVylO9gY7I5uWW/rqMoIPyh5sJi5DEtLj7mnV4DAJoB12WV2P+
	Y5HxJqr5UlRxck7e4YmfnRAPSGguwhK6NSCDieo7sILwnEcM1sT0ZEAeeuO+7l9dxdrZXUHMGnc
	HaTbllrzCTaywYVcAwHrSVKELTAt9TIFMIb5xTIvdoHEqHBJVMhceMQtDyILDrtXZ0jdvIkI9IN
	WXUs5DYCiO38feZHUDoQX79Lu3eEs4lOB6RcoIwM+SEkMSyeOz6vzge4T0sLtxBv
X-Received: by 2002:a05:701b:4241:20b0:143:2968:564c with SMTP id a92af1059eb24-1ac5b9cb040mr26455364c88.26.1793822016817;
        Wed, 04 Nov 2026 11:53:36 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.194.66.249])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c2d69asm9239684c88.11.2026.11.04.11.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 11:53:36 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: jic23@kernel.org
Cc: alexandre.belloni@bootlin.com,
	andy@kernel.org,
	asahi@lists.linux.dev,
	atharvatiwarilinuxdev@gmail.com,
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
	jmorris@namei.org,
	keyrings@vger.kernel.org,
	lee@kernel.org,
	lenb@kernel.org,
	linusw@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-security-module@vger.kernel.org,
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
Subject: [RFC PATCH 14/14] mfd/macsmc: add ioctl to access smc keys
Date: Wed,  4 Nov 2026 14:53:17 -0500
Message-ID: <20261104195317.8284-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101013817.22d67ea7@jic23-hlaptop>
References: <20261101013817.22d67ea7@jic23-hlaptop>
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

> If this isn't matching some legacy interface, then we need more
> on what these do.  Maybe they are suited to some other kernel
> interface? In particular they might need the various controls
> on how destructive they are that something like fwctl brings.
> 
> Generally an arbitrary opaque path to firmware isn't a good idea...
> 
> Jonathan

Here its required, if we write CPU/GPU Pstates and PPT to
some keys (MSTS MSPC HE0N), we can reduce the temp by 10C
And We can fix the dreaded PROCHOT signals on macs, Giving
Same temps as macOS.

But you and Sasha are right, that exposing all keys is a
bad idea, so i have restricted writing to some keys only.
