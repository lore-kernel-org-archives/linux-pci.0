Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793284789;
	b=32SlEu1dNTmGd4queh+HJthA3BEwkuB/JMeUK5ypyeTWlNgIEP7vQ80EYDYH8M5b8lK9
	 AxuBi3PaKz9xsXEDuKvwzBDmi7PlbHV6W/AXLTJ/z3+t+MgnTyMG9yFfLHqK2o4x56vja
	 J+0kX2PSv5CN3qkIRJXaXiRPq5C2Pp4S7AO0yzgBiKqHna3f0JF4nUb+H6rWp2J417nV0
	 xb+EpJf7q0yfyovu03gBAybbLiMi5BNrBnowY38mSfvV9WjEQphjXxpLJ/TDGLO2gkcEf
	 nEYIowt9udL7xlKRVRwKSS7zhCbqvXQM5tHNXVDRH7Y09cDcxKeuY35ENLsaRM77nTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793284789;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=uBDKsqEMUUI4osJISoF5o/4t2sYaPTTraFXlQxWlPBk=;
	b=DxG4zh/FP4P6ji5psvxdXNbe8us7rADjQVUp2lg9rA2VI5uXVTPQLKXatVocfYVG0W4P
	 1QetLurqWemYoRdldECAd5NzVxJQC/A50cbT68oEz6ze0hgQgiifPxgnHQkKkflkGL6G0
	 au1vgamx1O/wuSSjZINL77wmYG7rfe1971K+t4okONRMzix8G+jWDomNV3bn6SAKpZrdL
	 DdOzB2+V0ZyqSCFgGP/wd7O3q8xYa52dUlWdcuOPxliHoIg3tvG4Mbw+05QKBZ3xIj/9M
	 2uYMWThjK3+2bbcdEpOhsE4PXSEqNZwVOd0NHxtAILemjXjOUhepmCu9jB7lbp2VSgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fPTlg3YK;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54533606A32A
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 14:39:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54533606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fPTlg3YK
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1846bc43c28so2543451c88.0
        for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 07:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793284788; x=1793889588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uBDKsqEMUUI4osJISoF5o/4t2sYaPTTraFXlQxWlPBk=;
        b=fPTlg3YKi8LCEYl7MWaRXbl+fOsMT8EooFaEX/qteZRl8FsZt88RyX9Nz4rh62atDU
         N2mi9nkHHOJC4qFeiUXhTHbjbhHQHXOF+NhhfCQK6iUf4J/Q9ypFok7z2wgCKAPn6EjK
         xZ9kY5ZnP4n+8lX6/VsHr77Tn99+eesUK7yOJOQntEtEMQGRE1D1vlqqCLeQI7lI9/6d
         T6b6GWLz4O6TATQ+xATuCOZzKNxV75JOEocPZj36+KoGY18UuoHpbDZjja7BkGHZcM0B
         8XE+KTQjlqXnRe4OF7u9IeoFkO5y9EWni2EDctTAKHudHO9Rp8OhbT05Vxxf/IOtY+cj
         QvZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793284788; x=1793889588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uBDKsqEMUUI4osJISoF5o/4t2sYaPTTraFXlQxWlPBk=;
        b=FdRSrmC5AZxbBMmAw9sPUkSoLlW8y3L2w+tkVBlMtEhgdxCd6yStKfjCgyfdxGitsr
         heoQzR6FrSKWwk8cuXAmKV3CoRAAY8EsjZEbjY8kNoEg8GoHUDbkqKUnPk5OZmCTp0hL
         EkXurlhKJe7vcQRErLyIF9Co5gwOtD1lzDo9N0soBXQwsfc13gwWBuHpqo4n1Yxx4Scx
         +Uul5qwJ+CWSmVlERQruQ1kePMGEBQ7a9En47y+U/8fV/M/MP7DHAwn8nEBc5VxmD1Am
         YN9atvdxWMpW4g6FKBEse5uwmgB9CYCJUFhZKBFwCiqmXjWz5tdoF5zG7F0nSFs05XVm
         6kpQ==
X-Forwarded-Encrypted: i=1; AKwUvBytgsKqigaSqKPdWYFu0i/DQAIfHeBvnwjG/X9t8a1gIiOsD9Uag1oIM8TSTIFvCCbtjuaGhkguNwY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJKjaiURyfhfhBZ1KHBGedz8iZQn0TDg2OmJzYVgL5q308mjvC5
	NzbdVznXZx6j/7cNgk6Te66KVt+aiOsblohmvEQLk50IRssPwBVT9n8=
X-Gm-Gg: AYBFou1s3Xz39MgII2Kwpk3526ykeAje4kEampgG6tGJZYKW5G28XGxocX3GT1kQcP5
	mzeSYzOW0lWZHnOclncKmtu8Jp0vCV0xhMvrBDd/HAUUnWwrRYQH6mXwwY842vDFxqAnHT15Jlq
	rL9ZcmdFeHfWlSAvosILQ+oIBiKEpsXoq8LpqVzAVBXD3Y7PeBCh0HLWofGPvUdY/5kZRNisdSj
	/GYaA0XmKODJL96ENlAGhC1VBr1mFJfXpXWE5mdbb3mequUDnBUfTPTUeubb2sO0Ufk1T+8ZWML
	I+mjYyTK++btnbXzpEZKooUF/p3q81KXXiHh9VHfWbfFnU0v21J0HNQmmHaB01uvY2D1QlJW2w5
	g9pV0d3hpAvzb4i/j22HVcaLV5IWNqpNH6jt8wVYStCV47n7vMS6Y4WHcy6wzOZDz1OzMBLzc44
	DwFGcNKcDZP/y0MK97FxuBM1RuH5G0dpdWjza8JJR+vPtKcz5gL1gZpjl2qM+zlxnPSUIPoruIz
	bc8JsalT00ddLmw61cMPjKaee8y2esWotv3Oc87mtptR43AkjEUJZ0AoSyTY/6514mTSH1jLmDE
	sgGD5Q5M+pufrPoDAmbeQt8bHt48gmdT7ZZT+jbKGb4ZgUTjvbtvPByi2SKcI/ZlK3o=
X-Received: by 2002:a05:7022:ed07:b0:1a4:c892:b14f with SMTP id a92af1059eb24-1a6ced8e7afmr7393000c88.29.1793284788293;
        Thu, 29 Oct 2026 07:39:48 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.202.115.216])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75cdd21c3sm15396439c88.4.2026.10.29.07.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 07:39:47 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: k@chaosmail.tech
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
Subject: Re: [RFC PATCH 14/14] mfd/macsmc: add ioctl to access smc keys
Date: Thu, 29 Oct 2026 10:39:26 -0400
Message-ID: <20261029143926.1246-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <525E5B4D-A947-4567-9FCD-5FFF2CA8B161@chaosmail.tech>
References: <525E5B4D-A947-4567-9FCD-5FFF2CA8B161@chaosmail.tech>
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

> This should either be dropped from the series, or be hidden behind a
> `melt_my_mac`-style module flag, or switched to a whitelist approach.
> We do not know what keys will be introduced in new smc firmware
> versions, and there are already keys that should not be randomly poked
> at.

1. The patch is required, atleast on intel macs, as without writing GPU and CPU
	states to smc, the system gives PROCHOT signal under small load
	, and heats up a lot.

2. the smc dosent expose keys of nature that can physically damage the system
	it only exposes power/volt data, and the most you can poke is reboot
	keys and gpu/cpu p-states.

3. If a person is randomly touching keys, Its their problem and not ours.

4. There are a lot of things that can mess the system way more and permanently
	than smc (undervolting for example), but they are not safe guarded, why
	should this be then?
