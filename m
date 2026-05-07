Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47C71FECBA
	for <linux-pci@vger.kernel.org>; Thu,  7 May 2026 02:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778122321; cv=none; b=BHuw32SQVHcRdtzZDZoxkUUiZUlFtYu4do2pV0fT43kZ6WiJ6zRzGfF+V8oXB/S2yeu63cpf9bH0O7nPnYFnf7I6PGjM2sOkeXWv3XsNzK0yPxisSJiSk+gk/ZwIPAnn56mbMelcBbAnKx18lpOTha05DrWLUZJxwNr3HFiRUww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778122321; c=relaxed/simple;
	bh=ZzunOxEtRWovf22x4NSwe82YRiPXQweJT42C5WwKKfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HcANwN7hcJ2yxRRONAxOOMtcvZxjY+ZLvwpzi89xCESQeh3LMPZOe7wTs08Q4IgLPqHMtiBXiS/AsX4w83+d5s1IBcu5hrhD2pKXkqiL++D++lBVU7Rk+A9m8IfC5tGXU8vI6toM1BGXN9WPOqOBTbc3x9PP3PExD9U+plJCtgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hGieXcro; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGieXcro"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2c156c4a9efso480826eec.1
        for <linux-pci@vger.kernel.org>; Wed, 06 May 2026 19:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778122320; x=1778727120; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S/TiqWPCIVOUr4GYVcJCLO+QpFwEOSUT7p9be3OEgbI=;
        b=hGieXcroqCYtUkUrqY9dwcEmnARipXp5TO1l6m2gezMiE6yitUmLGDzjsmmefclfJ3
         mX2py3CSt3Ulu6+pq+BrZ9hqIHNrPQbo6gv17deBOf8NQp4CeLz3ZKmKUx8Yu2Lmie+U
         KIGbiVatjrNMjapGEq+gi1uU4/8GQGIXiMlj/ksqlwjk0JfdQbSXEPucEXtyO5rHPmxi
         TTUxc0kjEMK4cVQoenkMI8ELarOe7c8j3BSBEzUZCpu2sMaq27gUgSup3w2FqtMXkhwx
         /shP/KWuRrx9M8tmHqrvltJNH9WGHmBNUNxWTjQRoz8bdiesqK4VOzQ9Adoui2xU24xa
         jq4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778122320; x=1778727120;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S/TiqWPCIVOUr4GYVcJCLO+QpFwEOSUT7p9be3OEgbI=;
        b=IKiqIvn/VtWoG+Fw3hw0f6bXNqVoD2o3YP/EzbdOlsoyA4rJWMeJkE5KJfBwMH1ITN
         8m2DNrI20If0Zn/AEGSsE3/o8tzPuNO5gbbBAhq550/1/m6WO9wSFRj0kDebZTJF8iDl
         8KcZz7k1w5S5YTooM8hS8jxhSo0GiW1+xQlJLOQ8CXH9Fn2xEl1Fh1+wy/A8T0fUzlGK
         Qu7aJlpUcWX/PrkzFCso8UOWemOW3sVgGG2ZHXuL66NjgMcFhYEM8MXsW93xQRhAIzFI
         2TmKJXVX+zhQ4rzzySK03QW0sXjd4PQdolo828Nx0FIS1eQFpVxpldHdqoDPksNh4Gh9
         U/Rg==
X-Forwarded-Encrypted: i=1; AFNElJ/YuyhXD3D0BOaN/gWt28/ooxaNAl/nLQLG96tX49sh8+Vz7hW/nX7FOWg2Frc5MLNgsg5+JavaF8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLCUKUAdHi8FVRPoT8t//Z7E3XcWX701E89evx92Pcj2lUKzzJ
	BQhxOEPy0q/lPt1VeuiYjFCThboBnohULZmyha2DRvpOrhbvXEPD8+8I
X-Gm-Gg: AeBDiesreKAqXKafnJXBq5oohwry+zhCgzMpczoVf0reTYosfOi3WprGP9nbj+3dNDF
	Vn2LYYvL6GdlX6jbjEhRKrdr6CojTM1B5MzNiDL4r5p/OHUd0+8sJ6teK+SX8FayGQCBGjnAeps
	LqU5x2SZ746gnQ8d0FGlbiueq7W4j93g8ym/rhwGtClBdsyCmo1tBJeUeROAVLlYP2WMwa9e3a3
	IpP0qXoMTBCwRH0lS9iDQXQ45uGnk5b+9hplD02bxTgoGLRom5t5I8HK5Opld14ZtnyLI9nOTK5
	zPRhSVjRsbFtnDkVR98wuY9yWrI+wuX0RcqF+MqIn85jTtou7foswSzBganyX88aro6yGXaac5O
	jszgShyateMZJ7LgzJIX6qywYW8i4GQTTRuIH20XfYpKrGQ3MfmTG9XXwG5vprfg6K6YkGOYGZq
	CXO9V5rhvFuWBwlackdBQ+w85Y4l0P30EgRGPS+1R/M3G4dZ+2jys=
X-Received: by 2002:a05:7300:2322:b0:2ef:2878:7ad0 with SMTP id 5a478bee46e88-2f55094d023mr2547311eec.27.1778122319696;
        Wed, 06 May 2026 19:51:59 -0700 (PDT)
Received: from [192.168.86.23] ([136.25.189.61])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f56cec763fsm6263436eec.4.2026.05.06.19.51.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 19:51:59 -0700 (PDT)
Message-ID: <26361f34-f24a-4289-bfc6-799b8f189fc1@gmail.com>
Date: Wed, 6 May 2026 19:51:57 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/ASPM: Don't reconfigure ASPM entering low-power state
To: Bjorn Helgaas <helgaas@kernel.org>,
 "Carlos Bilbao (Lambda)" <carlos.bilbao@kernel.org>
Cc: bhelgaas@google.com, eduardo.habkost@lambdal.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, bilbao@vt.edu
References: <20260506181012.GA803978@bhelgaas>
Content-Language: en-US
From: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
In-Reply-To: <20260506181012.GA803978@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hey Bjorn.

On 5/6/26 11:10, Bjorn Helgaas wrote:
> On Mon, Apr 27, 2026 at 09:01:04PM -0700, Carlos Bilbao (Lambda) wrote:
>> From: Carlos Bilbao <carlos.bilbao@kernel.org>
>>
>> Reconfiguring ASPM when a device transitions to low-power state can enable
>> L1.1/L1.2 substates on the PCIe link at a time when the device is sleeping
>> and may be unable to exit them. ASPM should be reconfigured on D0 entry
>> (resume), not on the way down.
>>
>> pci_set_low_power_state() calls pcie_aspm_pm_state_change() after writing
>> D3hot to PCI_PM_CTRL. pcie_aspm_pm_state_change() resets link->aspm_capable
>> to link->aspm_support and then calls pcie_config_aspm_path(), which can
>> enable ASPM L1.1/L1.2 substates on the PCIe link. If the device cannot
>> recover the link from L1.2 while in D3hot, subsequent config space reads
>> return 0xFFFF ("device inaccessible") and pci_power_up() fails with message
>> "Unable to change power state from D3hot to D0, device inaccessible".
> Carlos, do you have a few lines of dmesg showing this issue that we
> could quote to help people match the issue with this fix?


Thank you for reviewing this. Only the error message:

[160459.607156] vfio-pci 0000:5d:00.0: Unable to change power state from 
D3cold to D0, device inaccessible


Thanks,

Carlos

