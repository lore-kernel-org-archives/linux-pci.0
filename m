Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795136746;
	b=HPWM8pFLgfcd5SVIurOJevXMk99u2LhpiPxSTXuKNZ1y1cbC+VJFZhdNLT/w+soCtj7L
	 kdY3vbZI10NRqgpyFtHjlY1xugPn+RmPee5UrN8VKatnKVaDqvpg6xKjAWIYM2zmHGYMF
	 20H93qCEW/Vb26n08Cm5FllXhZES66smeTM05WOUxsW6qLcxBjJ8GU3wVmVZgA2sRHkpA
	 /LGGIt6eAoVh73yBVJkHlSaL4s+IRtv56DnyJoVP09YI1bJDDH51H8VY4W3u0ehxVwRpD
	 bIzeUrKEu53yqlQZcrKHVhBIixKpugR8KsPWh/oQSK+6hCkQSJ1J2txm4vDz21TN4GA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795136746;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=OpzooKDHNgCiysUKol+Ja6SYQLhEkHVY1LVwsqINVmM=;
	b=QuVSOuRnY+xN5347hlIrlRdkpUcWNpKAgk0OzREhzI6rcb3A8+0Ki2ESpfTzmzNy7c/H
	 jf/KMpfyFtcla/lc2QHPR2MBLASf8OUFywzl+eaw+E8sFDB8KeZkjN38NDDCIgpzcPoGV
	 azlnjdBomkrtUtVbshg9TgyWgGKkw1bAjrVyJq/y2v347qHXVvbJSVqTKyNskM3y7RUUL
	 exMdzFPxp6OEC1a6OxDdCwd4KJjkMyyYbOea1GGXj5nc+qmQppFNxFmOQkdUg8fmAXl4t
	 kkJhnzazed3ejj2cUwFFUJI8/junXcOOQVh+tmocgSSXA/N8adz5mi9Opf3DOZJ0j7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IUWp6nVD;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A1E606A326
	for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 01:05:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47A1E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IUWp6nVD
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1ae58d17cd9so386680c88.1
        for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 17:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795136745; x=1795741545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OpzooKDHNgCiysUKol+Ja6SYQLhEkHVY1LVwsqINVmM=;
        b=IUWp6nVDYBX5bW+ppvRphFePfE+SGvSsGg3yM4B+6k/G7yBH9MY1k94ICPKtn+3B90
         QjL4IonBDVBiz/loGfjoUoIpQvoKlJeHBogHrNhgnYIdwKJwTWLZLTdvM5SAG1NEEJlt
         eC23OT+IjWbnP5D3r2Tv2/IFBlM4L8KIO+BPGT+f+UwnPGH7dIIL+mkUkBppA5wNyZuj
         hJ5ZQRXYEubO0gObZR2BdirJGm0ZAO4THy/Pff4oE/KfwF9/L3NnxjcUBv47sITYqd64
         yVmWuyEd0wlFrF+ZRddyW8YpBFTnGFlPYHlAlR6aS0p+X5+vzDWBcTdIAGRZcYeTlVKH
         K92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795136745; x=1795741545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OpzooKDHNgCiysUKol+Ja6SYQLhEkHVY1LVwsqINVmM=;
        b=rcBHxV/2ZU6uKqqV+jYIAudm9jmXTA1RT+1y5NwvrSnX+2AAfs5UPcocagqRLRtAtX
         3PLRn6RkX0kFXKgPPC/q0MZCSiveaJcd2r4/acHZ8v6Q/oJ4nhbsg7HFFUmucymrUPRC
         /IDjCHNBzqcwpV9COE9MruCjykZBmRNEsmKBRaAMplc5ONqL4A07HAbLQth1JAIvsz+H
         1OnT32lUTn3EIcaY3kocys4ZdlDGrn0aWwKrWie3hLOAyKc5yThvRf0FwMlE+U1yhsB4
         7wSL4u6elWzV5C26xaAk7FTeGKDUYlx5OnJBQV/vOuk44brte3NPZmDaJm2e3sLB5a9q
         EQmQ==
X-Forwarded-Encrypted: i=1; AL+hErHY2izntzmvGHG83lgJdoKKhohACs48gcBy2scSnyCzjKiM+2kE6ZIGPxh6wZFR3/HYhVy6tGEsOjA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8kKbxfmVruhYgbTIl16iH3uYIG8O4r8gWtTZjpUwtQiMvAOMzt
	LM2+H5ea4OyE/cQSMZos5IjKvYPDliv7/oM6HkoYXBF5l+WJsAWGJmZFwqW6x30=
X-Gm-Gg: AYBFou3XKG/OxA/m3Rc7lx8+sltGNGYS/T9jsRROthPkxVIaOmbu4YwswTYctFJs5b0
	CQjZ9/enem6+d0affNsmR5SvOpT60afU6EEc3+ueJ00FJpzhAxiFm/wMy/89wTk4/UaMjm3OSJX
	1zy2nMjTMN4P7ibH6YztepSsOK7OgbdC9QdA0VzNa/YFlTaRkFeRkCUPKJWI0RLXUoeyoAzfUsu
	9M8P2vzgV9E0sRNWyRrQDAmC7hUPO6pb/z1ReD2e2u9ZOcjsQIUS611brzsHT/3Bp9dI3/i7zIV
	JNKx1ZT+Ud49lo5Jg603XdHWZOc/joGYfjRt+8dVxC9h5R4k7dV7PxVXpqzm7sK6UZ7+fseiKx7
	mx533LbbJSxxmUrAQCQofZMPB2GG260attTV8NIZIGdGRb6wJKXu1RIFAQSaxNlZDO4h0YyesYN
	7aaWDuUJoUKPGhCMGNu10Qu+G8ml7Yvwelwg/bdieNrRPKI8wNoZfhXzsjKqv8lXelQMsawGGeV
	dTnwop55MRnMu3Dkdyppifkq9SqZfhKcT8q/LRCvZvsV5Upb6bQ2OY//s4i9w0gbNNZDiwpVTpR
	TVqOMuXftxdeYVERNG79/bIjLRJRdn+sWgugUX/Kr7YL10u93Echj/qYgow6iA==
X-Received: by 2002:a05:701b:2604:b0:1a3:dbb2:478a with SMTP id a92af1059eb24-1b5568b9037mr1336710c88.27.1795136745320;
        Thu, 19 Nov 2026 17:05:45 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009 ([27.60.23.101])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55682d301sm2292732c88.10.2026.11.19.17.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 17:05:44 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: lukas@wunner.de
Cc: atharvatiwarilinuxdev@gmail.com,
	bhelgaas@google.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	mingo@redhat.com,
	tglx@kernel.org,
	x86@kernel.org
Subject: Re: [PATCH] PCI: Add quirk to mask ACSViol on XHCI on iMac20,1 And iMac20,2
Date: Thu, 19 Nov 2026 20:05:36 -0500
Message-ID: <20261120010536.1182-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <avrfAD_puIZm1yR1@wunner.de>
References: <avrfAD_puIZm1yR1@wunner.de>
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

> See this discussion:
> 
> https://lore.kernel.org/r/CAL0aDZ_HOq1Sof90GJoBDzPo7Gmr7P_rSnYJaN75QH4K+iodpw@mail.gmail.com/
> 
> It's an LTR message with a zero Requester ID.  This needs to be fixed
> more generically, not with a model-specific quirk.
> 
> Thanks,
> 
> Lukas

I also did not really like the patch tbh. it is now obsolete however
the problem was in the thunderbolt controller, we are basically done
fixing thunderbolt (all apple systems from alpine ridge to icelake)
you can see the code here if you want to:

https://github.com/kaiT2en/KaiT2en-Fedora/blob/main/patches/runtime/thunderbolt/0001-thunderbolt-add-Titan-Ridge-and-Ice-Lake-RTD3-on-Apple-T2-Macs.patch

(this is not complete, some acpi methods like TRPE and SXFP are missing, we
are trying to add that, and the code should be done)

Thanks,

Atharva
