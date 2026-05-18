Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA5E2FC037
	for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 23:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779145672; cv=none; b=f825NaMNBN9QG3fLMIRDgtmVFQI8KccXfuo057wpE6KLJj1xNCTZkCU21ZQsH1LjvJ8srsfsR+NBqZ1pg8RDTUSY1uNH/7rV9TrA00sNDoArPb53U4+8yvxhKIEXeObbbk363eO7uHfOBQGk7TYw1wY16icBCFtMr2q8H0DfXuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779145672; c=relaxed/simple;
	bh=IQSkyfVnVv6hMYJ0XzeA/W2XMI6fDtbK2L0AxxeJkSc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=r3z+XKXI4/izZHxWg4CnjbjkWh23i9wAe4sR8NlDUSOChFSn2uhuPjGe0yyvZbOnRak2lMoxqFlgg3Fk7QHhZSJowrxZbJJKmsV46z4h0av1t8g3JT4k3K5opmMldwqSoAmFOvHH9f2p3EOqeuwPeDFJnD6DOzGuwf0vHF076pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzhwPjMl; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzhwPjMl"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b45cb89f7eso18341835ad.0
        for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 16:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779145670; x=1779750470; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IQSkyfVnVv6hMYJ0XzeA/W2XMI6fDtbK2L0AxxeJkSc=;
        b=DzhwPjMlWqz5efX1sMgxb2Vls98hT8VhyyClZRBRC3M4GT5mFpkf/w2LTj2j6/MAWD
         pmSLpJ33QG2EhmIgJa3fryQYzxq5ibxUVGjsaVVtIcyghjY1aojLp1duJynZFN8U/8CZ
         Fu68HuJ8BJ1NF7RJmXynB7c78S1gvClezbHO05wrBtmmdToLYbpZuTgNA7sSQuDKs89L
         30HFk0ZN0qyNJdbWTkbWmUEPxcJjo5vE0GNulDFSVKOsvcmcte6fYTR/9U+PKyjPjSNP
         CN1VvZkHYgB5fiyQwvSzQXCwVpH5nez3FB3sEXqPZ876Gxm/PXfbqj7jSlFXrDAa5jSb
         14UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779145670; x=1779750470;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IQSkyfVnVv6hMYJ0XzeA/W2XMI6fDtbK2L0AxxeJkSc=;
        b=Y/7cxa+ErxHJ55UWo/keqFOEbDg+6aJ2+VT31dmD1+Omwlb6P6EeTpdPoYjgGkQ13I
         QFD2OZD58RpnranDuYgdviVtenz9QFS2j1DnNJciZ7sf08dF8QMYj/49mluCvPOjYW24
         +C55KF8dsq4tXCgGGoR/h5jRPMFjgs0qe7tCzIK5No52iw6XkiMfGQDZclRO6YpclCjo
         LukazL3lSlSDaQZUrmzQva9lAIH4D12F9ahTca+hk8uJZkQQejw9Bu50a3P27T63LTkm
         pAHUWMpwfOqmcqT8SdkyFeKs4m8W+LZab47rqaErxub3q7aFq91bq1vwTYDRdkDYK5OE
         cXTQ==
X-Forwarded-Encrypted: i=1; AFNElJ9mfElC159JWab900aIieo+qgG2qaw1SCDHJ1LHXBgvgUjnyV+TeyEyStLmfm21tSsocBNVwvAFF3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YylCQsXxgTqjH8OZauC13m6hhO5lN3CUID3rsH0G4xtEX0BRvDH
	zc8gMdaDU3uMNQJ7OI6Xjvzj2Fw9OIDQFSgQMR8ev9txVB5tTMAKFgYw
X-Gm-Gg: Acq92OGMtLTxBUZG+xR0P0QnoyJJtRVISbIIF4SivFSo9Np/5JGGEvQSOZjCvTCzjzQ
	k7rpJYlfaxAEztlb7rQ0hxCyW9SviTfKZRJp+8nebs2iHtfjXajlXDTGCt+1kY7wYcvxYqt9+Xf
	G94VQP1wY7NKIZoY7Me4wW1KnGc47ziaG+ZpRSEWGKMYgVTNnYNE7keNe3CI24t08V2iOirAxst
	LLh+ZDVShDoDUZ5J0ivQaBXFFvLubc4dEWPJ5zYjqaMS6mXZ7co/uJOJfTFuJ090UIBk7zoga8o
	iebEQnUnhqSrc9C4QW/QERP4Mhlf93HThzp2jBh4HdA+WDPwQDdUUjO02/pDioTn8H87NolgBq2
	buzdpS3AR8OpmZkCSrXfnQQv13u+ZS6p8lJhD51uSm08/f9Ee+K3WCL1ArCwcE9NQdUFcgNWdDx
	fUgaYDlI1VU5TjYTGJkL3gixoGqaRE4wiVah0aLhlclT4aLEXuUwJG
X-Received: by 2002:a17:902:ef11:b0:2be:1eb1:eaf7 with SMTP id d9443c01a7336-2be1eb1ec68mr30387365ad.24.1779145670352;
        Mon, 18 May 2026 16:07:50 -0700 (PDT)
Received: from [192.168.89.2] ([119.214.48.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d0fcb10sm161499835ad.60.2026.05.18.16.07.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 16:07:49 -0700 (PDT)
Message-ID: <79ee1d2d-1c8b-4d0e-896e-e9c09374053d@gmail.com>
Date: Tue, 19 May 2026 08:07:46 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] usb: xhci-pci: add AMD Promontory 21 PCI glue
From: Jihong Min <hurryman2212@gmail.com>
To: Michal Pecio <michal.pecio@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathias Nyman <mathias.nyman@intel.com>, Guenter Roeck <linux@roeck-us.net>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>, linux-usb@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Yaroslav Isakov <yaroslav.isakov@gmail.com>
References: <20260517130407.795157-1-hurryman2212@gmail.com>
 <20260517130407.795157-2-hurryman2212@gmail.com>
 <20260517232147.34931718.michal.pecio@gmail.com>
 <144ec61c-4cc1-4986-a16c-7c1b99f3a72e@gmail.com>
Content-Language: en-US
In-Reply-To: <144ec61c-4cc1-4986-a16c-7c1b99f3a72e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/19/26 05:30, Jihong Min wrote:
> It seems that these three functions above are everything that you truly
> want to add; the rest is boilerplate required by this two-module scheme
> to work, plus ID tables which must be duplicated and kept in sync.
>
> I wonder if a separate module is really justified, as opposed to simply
> linking this file into xhci_pci.ko when directed by Kconfig.
>
> The downside would be slightly higher memory usage on systems where the
> hwmon driver is enabled but not needed. OTOH, same systems would likely
> see reduced disk waste.

One clarification about this part:

In my previous reply I said that I could rework this either way depending on
the USB maintainer preference. After thinking about it again, I think the
current direction is the better one.

Mathias's earlier review pushed this series away from adding PROM21-specific
hwmon support directly into the common xhci-pci path. I agree with that
direction. The common xhci-pci driver should not grow PROM21-specific sensor
logic.

The current split keeps the PROM21-specific auxiliary-device lifetime
handling
in xhci-pci-prom21.c, keeps the hwmon implementation in drivers/hwmon, and
leaves xhci-pci.c with only the PCI ID handoff. That is also the closest
match
to the existing Renesas handoff approach.

So, while I previously phrased this as something I would leave entirely
to the
USB maintainers, my current preference is to keep the separate PROM21
PCI glue
driver unless Mathias or another USB maintainer specifically asks for a
different structure.


Sincerely,
Jihong Min
