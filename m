Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4248536AB6B
	for <linux-pci@vger.kernel.org>; Sat,  5 Sep 2026 13:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788616336; cv=none; b=bnwKVFREHyH4DfpxXd+/9UCJxEZANXXFdsoK6Zdzq7uxxfYzy8DgSUmw+ytcbV/OKBIsgsjwgB+FkDHp8H/C4rdQvQN9rVHiuzxVOOlbjtB9whZID2E5xNo80XOEmGN9Ju7edb2o1EDJh7Tglr82KHhUEx+d4gfOk7SmA+8ii+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788616336; c=relaxed/simple;
	bh=eoaqP1cpmgdeqA13VuoN62OPJ9Zf7oNSZ1XwyXsfHwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2rwu3C1uvEJ5usvhewUZKMkd49jmH/b2TZGWM3XzBbMI0osnKM2SO+TGAlj6yk7ooo0QfUX+XmlNdrUsMfit7JxE/AnGwnbBdja9x4ay1/ZvUfQkgYgOxNU5i/xVrEzz+kmQHbrHqRZSx6sLAT7bD4uCKz+IDjb8a4iSBMHDE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kuJWeO0d; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuJWeO0d"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49ccfbe062eso17223545e9.3
        for <linux-pci@vger.kernel.org>; Sat, 05 Sep 2026 06:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788616333; x=1789221133; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=goBUo0KyzYl6adZ9zmSf9yB7LNuxO2AIINcuATmiu7w=;
        b=kuJWeO0dgZQTmZ4lvjdt2TC96iy1B3f2JCpJh90IMy/u0mrueqKBgA5+dof864twtH
         PpXdxEQgM4nrUGvsNl6JjEdHsohYe4fLJpmfUu9Z+FmIxB2sw9uputBnpT6Ts1Ggeeyf
         harjJLbstSTUJeN0XbYkn9k1XbgDqMNoFh1J2KUma9cEad5yhTxmjYRILMGyglrkhT8+
         +Zs+1mKGYwUyiBCAHZzeH+KyVKFD5blnvLA8tD8W4L21Y44LtobO6P2oN3oEj9Iwo/Vv
         9qjbsPpJQ/VchoG1Z9gmyqG+YcASsUE7Sy8VxtD6Jw2l0ylTuqPx/BfEjHfjnQ7Wc5LE
         +4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788616333; x=1789221133;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=goBUo0KyzYl6adZ9zmSf9yB7LNuxO2AIINcuATmiu7w=;
        b=Ws/wBpRsmVqTMHaen1m/ZOWaTimv4NsljldZRwhiCKszSWcHxWLdF9WEVQlvrQVlCs
         9Sy4DOTEHf8sdXnXC1HEPG0pm6hkmsFj8QPpiyRmNsOf3Ds+5ICqx0ig8y/+FME3Ky84
         S9wOogr7gC3YrjCgY9eTzyEt8C3xbtW4uljDbJ17AzgP4J6SVXAebnDRy5R/VKHJ82A4
         DKWIgRUIL4tSty5+UH4TkwFRmKEIk5KzdSIswuBHqasEeSrjvKNIfXJjF+Mef3eS6SDb
         mkHIPCDU7nR6+7InZYws0M5p4qWxbv+6Nkh3w588isWKIcUD3ccGwbuKRN9XK+Vb6auD
         0k/A==
X-Forwarded-Encrypted: i=1; AKwUvBw5iYvGqIi6gsqhjg1wZGeUkkJ+qL46n+GuU5GndV8A1bzQb0nyCgVgAW35qAbRsQZFLXZcAIyJwkE=@vger.kernel.org
X-Gm-Message-State: AFuF++maokrG4pLoVp0TA9zaPkytOVpwvY6cTFL88xP18kV4fD9nEIRD
	zGVJBdQxH2/QAgInqIEweNaSd4LmVi7FUGrT7nlGoLTpUwPJ0fjwgCHN
X-Gm-Gg: AYBFou1axU61zms5Cco6kBPz6MgokZDJXtvn4FRxWcsKsPcZ2XKBDO9jcg66fCihG10
	/g6Nul+JbkTjakG+YO3saV3zEdQgubHtEOq3kneHfmTF30myutrQ5FclCjLjVcFQtSs63407nEH
	AMzR1ZHecH477qIc7j8WzTlwvY54+BZ9LObW1VMpUi4UTdSSiE7/2MlBJyxfQncpcnAU4VMbJU8
	VdIUfP257S2yk2K+qTYO7+LsWzKU1higbs9vChcrRn/lzT8LD99hPKODC2zVWUyluM3lF8k9Teu
	FaDfvUIWWL3IiuyHA1B30FB6U9FM0lmTpwK2xCMebD3d815ZSso2fNf8hEo5AHvplcA4iyt0Fko
	OCikYuJukwHqXZ/wYk3vWhyOcqe9CYlGcZ0yQ/0UHm0CuB3AJ/vnoxIAfsH2iFkj8Q9ZMID0rsJ
	beETwYvWFxlZN0d8nVczNLpcKXG3yOkqlvxFmxqqXzVBJhneAGur9ktcQDPTN3hSqijSoUST3r+
	U7Seca3drFreiguFOPZnq3U2iCEMqk6nYg5wJXQdhdenfhXfneoeD46RUw7J54s6faABqxcubGK
	gf+b6FbKsxy/H8Au5ZVXbrus7Dj//3JQZ1Tj2cc1SeGHc9qfhSlKBHFGId0LvDXB
X-Received: by 2002:a05:600c:4691:b0:49c:fea1:f792 with SMTP id 5b1f17b1804b1-49cfea1f79cmr86204765e9.12.1788616333161;
        Sat, 05 Sep 2026 06:52:13 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf75ce49esm258560335e9.1.2026.09.05.06.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 06:52:12 -0700 (PDT)
Date: Sat, 5 Sep 2026 15:52:10 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] Documentation: PCI: Point the pci_device_id kernel-doc
 at device-id/pci.h
Message-ID: <apwdZWsGOa2W16HU@gmail.com>
References: <20260905084916.40196-1-kmehltretter@gmail.com>
 <apv6yQ1U-HhNglyV@monoceros>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <apv6yQ1U-HhNglyV@monoceros>

On Sat, Sep 05, 2026 at 01:21:32PM +0100, Uwe Kleine-König wrote:
> there is prior art that can be found at
> https://lore.kernel.org/all/ede7ce64f20e10660ebf6bc1b41836dad750ae3b.1783349758.git.ukleinek@kernel.org/.
> My patch is more complete, but I didn't respin yet to address Randy's
> feedback and so it wasn't picked up yet.
> 
> If you want to take over caring for this patch that would be very
> welcome, there are too many open threads in my mailbox and I'm happy to
> be able to close that one.
> 

Thanks, I did not find yours when I looked. I will take it over and send
it as v3 with Randy's file nit applied and your authorship kept.

This patch is then superseded, please consider it withdrawn.

Karl
