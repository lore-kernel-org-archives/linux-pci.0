Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA17377EAC
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 18:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778264164; cv=none; b=Oz3n2XMqlymaCKF2hopz/GXsfMwBch2qmiZy+3Re4i7LrsBS0QR0N0LowLAaekTZ98z0LsvbZqkPCaIjU1kqpYtMWs95/YHXwI+EnAGDoh3Q3NT8AbgssBj6q9Kr6fBfAH4rUaIk89PYQT/5+mh0LEErDdybVawnsuCLg80raNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778264164; c=relaxed/simple;
	bh=LZCGgKEGEvKGeWkO7nM1Ue0hldFHRuium3dlrfRKmow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VGYcSdt+poy+hCZ9dku6hBU5IGLf9V//Hl8enZPR96ByNYwYwJIOEEGPLVltjxCU8qWlXxXVXGJx4zWbpQzlqmqdd+qpwansDl3g1X5Gk+e4ViRymRpVN4QJH6DxFQkh+lnlTyr9jKlqjwaZ7JvY4iGWyP9ts+jPGNw+XXI59P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NfM8b4LV; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfM8b4LV"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2f0d3e07e30so5996109eec.0
        for <linux-pci@vger.kernel.org>; Fri, 08 May 2026 11:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778264162; x=1778868962; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=IM2/rTMkyCbqZ8kLdve8nrdCK1JQ4NVvOGN00DRH8wI=;
        b=NfM8b4LV2t49DTTjvxGqrkKthY/sXbxZdnIdkye8qwpJiuBMn6vtWpmNJiiHxFdqvZ
         IrUD0ndyFk3ycgAtUrSi2Gx0LsAhWz7cpVW5MhKsLBLHNvZ8Xt6MSaC9F1wLuWsHanGX
         hkTAEeTKQyZLOKH2QE20KcXPohgH/OZFZlzOyviKC92CyxMkAnEp8d6qYUYQVOvHm6/G
         Nc90cZ5pCE2JaUJTCgE7345hyg5xemVB2K7ijH0L2wFCpRz+SdtDK1Rmda/koFywAYul
         /XLzJyQ6ErUidrEKiKN0ryIw4VbYjrbdn0gw93Ai9MeR8D24EXrvnk6eOP14Wm2DVVb4
         1+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778264162; x=1778868962;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IM2/rTMkyCbqZ8kLdve8nrdCK1JQ4NVvOGN00DRH8wI=;
        b=G9wUdeH9/H680ryO67fffGdK1FcQr030D6ZCKks6vDe+BZT3qfc8JbfDHByTtze/ea
         3jpjsbDwDrOsyIsJRDo709el1KFyAPWin46EJtOcQIEgwoAKo7zViYEONWfA6wqIuvmS
         bE3YPF5A9c793Ax9MxSdAnQRutBXMszzeNsPM5XlE6tRjjfcYsKs/NNeMZc9sEV5G+bf
         IMZqR0pm8l3xxITCxu4BXK6ceGwm3JHsemKkKuRgkyQr0xYJav4q2l/aSDccnl/QctES
         hS8nivlBPw7yC9igke9oetQypBvXNYA+iDBRmhuZjz0K3N0VCdARsLSL6ntWr4xBdBnY
         f3sw==
X-Forwarded-Encrypted: i=1; AFNElJ940GtKmVCS136BvXUuB4nrIMYniT+SYdUDcWGBtDhG7p5hOoOVrCTiRR8/cRE2EpcX1ccaruTjzZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6qqERsQAD4dnqNHB+p7uvGON3ylRQBMzBp5hfWVMI5TVl2VcW
	hKgs82di/xdB52Q9awca5UrqW2vXqjDssz+2In1k3OPWAMCXn/00rSn/
X-Gm-Gg: Acq92OEZA0VpdjPeHDcVi3a5G9es2K3O/TqlHTWdXyZRntMYCx9E1RGwUA199QJqjTV
	JbwMau9Hc4ghLY4sOiXHgcMzkYBRZ0E3h58o4ogvbnC8S6QieOzY9CMiCniTDTcw/jwmDatJWIh
	noXXahQ2ifJbtu+QfqOGn62kBK5Xxt+dNtWcHq8aMa8x6chWj3/YaReQgffWIsz3b6GCuJu5qWn
	MCNLPhrRNiZWT14TJICjuvYEB6Qo9cfiWejBa6r94n3vj0R13sBhBnAUIHzA5llgFYWHoXvNSQ5
	E0wOszfs38xQg5XDRj3hS8pyoyIpuezbcu8o4xA5sJxWhwRCpJdDD0oKfQOv+TfVmItP3K8L9Mu
	1ZyJUTKbnFgL35THhHJgwnvDjQ9pIOUL7LTJynKrSWC45Z7syB22Bzgk++3KxZjv9p4HrzWLtM3
	DsQejGiVc/46Sw6SIfxUVAHVdIT/oDNdA7L6zmjRvb1TstelL6DQxGhf5Ak4cHXN5YqlcTFFqn
X-Received: by 2002:a05:7301:9f10:b0:2b8:5159:eca5 with SMTP id 5a478bee46e88-2f54948f6ebmr6791259eec.14.1778264161953;
        Fri, 08 May 2026 11:16:01 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f888d3af4esm3280193eec.25.2026.05.08.11.16.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 11:16:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <053b019e-9c6a-4eb3-aa69-0c07cd6e7f12@roeck-us.net>
Date: Fri, 8 May 2026 11:15:59 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] usb: xhci-pci: add AMD Promontory 21 PCI glue
To: Jihong Min <hurryman2212@icloud.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Jihong Min <hurryman2212@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathias Nyman <mathias.nyman@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>, linux-usb@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260508143910.14673-1-hurryman2212@gmail.com>
 <20260508143910.14673-2-hurryman2212@gmail.com>
 <ad41d70b-e9c0-446e-8bd0-4528de75b592@amd.com>
 <0d518d40-e239-4d93-8e71-0d2e140f00ca@icloud.com>
 <966c9e07-10e6-4abe-9cb5-77b974f31302@amd.com>
 <b8372128-c922-4b62-91c5-46f848180bc5@icloud.com>
 <2657e1b7-126d-4c4b-8027-012a6d3ffee3@icloud.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <2657e1b7-126d-4c4b-8027-012a6d3ffee3@icloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/8/26 11:11, Jihong Min wrote:
>>> Something else I was thinking about while reviewing this series.
>>>
>>> Promontory 21 is only on AMD platforms and AMD platforms are only x86. I think the Kconfig should be conditional on AMD CPU support being enabled and X86 architecture so that we don't bloat other architectures with dead code that will never run.
> One related Kconfig question: would it be acceptable to make
> USB_XHCI_PCI_PROM21 default y with the X86 && CPU_SUP_AMD dependency?
> 
> This would only default-enable the PROM21 xHCI PCI glue. The hwmon driver
> would still be controlled separately by SENSORS_PROM21_XHCI and would remain
> opt-in, so the undocumented temperature register polling would not be enabled
> by default.
> 
> The concern is that, without default y, distribution configs may miss the
> PROM21 PCI glue and then SENSORS_PROM21_XHCI can not bind even if the hwmon
> driver itself is enabled or available as a module.
> 
> Would you prefer this, or should USB_XHCI_PCI_PROM21 remain explicitly enabled
> by distributions?
> 

How about "default USB_XHCI_PCI" ?

Guenter

