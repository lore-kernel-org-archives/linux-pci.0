Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDD73C1D50
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 15:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785340058; cv=none; b=CT4LLsIF6w3x0YdnTwYg1q4jFC4UWFvDPrPPPAn4PxAeBkEvmV8Q4Nq2EYwrJqwMJrOlLQG56jjhnkW/DUtkOz+4ZTFJbIIH7fqrAf5KcL/VmqCbGmWDGRYGCAj+iJjKZGy3P4WHL4giZdn4uP8+oT9uWA2T+ePrtBSK2D+39V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785340058; c=relaxed/simple;
	bh=XtdoacnoTVqkWvAxQDs6k09GK103sSQs3FNGIwm6H44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X32m2CPCq/vsgUVp74O4bvqfd4BRGUDZd+AUrVTa6vVWUzjmMee2peI7HGBiHTgzpm3nO3JHJ7eInSu5LoEOqSGuL0tUZi4ObeheGllGm+Y0QBqua+rSWGKI6wDgjMXk2YBCkCnesCku/1wmrO5Z1kjaptknKyk2vyEplfN+BPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jshbmb3q; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jshbmb3q"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-4784b41f3aeso274548f8f.1
        for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 08:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785340055; x=1785944855; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XtdoacnoTVqkWvAxQDs6k09GK103sSQs3FNGIwm6H44=;
        b=jshbmb3qR6f6QfwF6xuBfROYK6fZOV0pB4N41LSiKisyENoxv9nvDZzmOhArwKhAj+
         Zzgum4lyT1ZA3fNfcwHqt/BcM/jf4rztItucyfB+SkMAvVaIjuwl42T0JaEIlu9J5Vf+
         nzbt6E+kyYtaIG5Q/oQVoJyfsqlkJrlWzv00X0V4+Nuyop/qpZ9dMPOLVlSwq+87C413
         pkOp6jkf3q0yw9AjR1yeCXqMX6mRFsMUIJQoZMY0YuUYKnB9J//WpbxQiII4lzFxjQi7
         J4OFgTB37yQw5pttITRlublvMvTWF1d7wKRnPO/vxRTKd+9s/Tmsy5gB/GOT5ztX4C6j
         HDFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785340055; x=1785944855;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XtdoacnoTVqkWvAxQDs6k09GK103sSQs3FNGIwm6H44=;
        b=LZdzUVcsx9ZvLUdkKcoUnRlcVuC/nDymHef/fPw2n+Q5iBPuTD2TNPZtjEQ2H6iAPC
         lKhkICCTLdRYhLZ7SJf34Ic9QK4bUSpSxp7TjpisRADpd7CSaPCuaUXUZEYAw5Ryp/rO
         7gPjTUMzVcLdLTSh1mlqrwUfenIv4sJPx1KS4T13+xUDWXA3wVxkLeQuuDk5dgFnKrim
         iH6SIaHE9sX+v+AoOiXy2yzHmppsjy19UnsHCirvQhID1PJ2bmkBT+Dg+uzyrJNkeuGw
         r6V7bQJboVEGt2BxzlBu2+AS9UJEtCGn0X62eR3hB+JsyQEYP4cbh1O0n5H8JkSQ7pMG
         TTxA==
X-Forwarded-Encrypted: i=1; AHgh+RqQ1W8fjW02SsIjK90uA98uK/NENDX6YSce/36YAF0l+K7iNDnxbt0hJskTYo5biz0R1PVH9Dj2V2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YycXnuFI04+PMccQwayqeFl9P2Ja3XY6UiAPMG/Gx/vd0kWur4V
	6yCDdoRyzNNdBK9X5Qj5k4xFcDcnYCPkv4mpgTiZSazTtOrhjhIdGMW2
X-Gm-Gg: AR+sD10SGTeCXTwRMP5Om0hICq9o1HeM4jXARzM+NgrW74YEu//fSuAu4EIr+mQpPfm
	/k6MyML2zZwkiTj+bSz1uVrhK78UWrW6DnpVp9TMxuRRV23WOl4fw2DWLWS+c4DyaC5+d8oR7vY
	UfvdDtA7LQtR30+g1DIuvsRj1ffOB4J/EbnkkwQcqGZeSCyrPubK/e+rMDt+7FD247YxzDWBZKg
	8iDA2Sq8icMXcgPY5VtubbspRYorNZU0LDRkjPgc7659fufCwCzbIldc4T6z6mHuKh1xJL7KvZw
	aBC/JZWXYV8eY4BKPwWdYyNsFk3dBBfp4IYHPaUPkwWH4zczJ/JUk17VlFRlq+wxEL1R5AFpQJ6
	Krf6Wt1ugygt6ZooT1h3GZp+yjQnbXTbCgk1Ry7YsLMqVgqWJHo3XBtdiBkAdJolxsWA1evzZ37
	bOxVuMZMkSC3f3qHwDfgfpBZVF2/b5FWQipjyIT8V4vi9L8DwqKFKK/3+Dw+ISFIShBWWnYsk=
X-Received: by 2002:a5d:5f47:0:b0:47f:6fd6:cfc with SMTP id ffacd0b85a97d-47fb1eb9bd6mr9519034f8f.41.1785340055101;
        Wed, 29 Jul 2026 08:47:35 -0700 (PDT)
Received: from [192.168.101.143] ([110.93.227.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6b1cf09sm9613574f8f.31.2026.07.29.08.47.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 08:47:34 -0700 (PDT)
Message-ID: <acb8ac42-32f9-45c0-84ef-ed358ce05975@gmail.com>
Date: Wed, 29 Jul 2026 20:47:30 +0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: starfive: Fix Runtime PM handling and teardown
 ordering
To: Kevin Xie <kevin.xie@starfivetech.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Minda Chen
 <minda.chen@starfivetech.com>, Mason Huo <mason.huo@starfivetech.com>,
 "open list:PCIE DRIVER FOR STARFIVE JH71x0" <linux-pci@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260713145014.740898-1-alitariq45892@gmail.com>
 <20260718133825.445041-1-alitariq45892@gmail.com>
Content-Language: en-US
From: Ali Tariq <alitariq45892@gmail.com>
In-Reply-To: <20260718133825.445041-1-alitariq45892@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Politely pinging.

Did anyone get a chance to review this patch?

I am happy to send changes if required.

Regards,
Ali
