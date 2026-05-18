Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118132F9985
	for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 23:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779145600; cv=none; b=iXpTGpDvQIS2BNTiSDZ02vYa2cXfaD9L/Z7obqVU8MJoKtuJSgQUCOC7OyI8bOz3cYeHqgJbTlgYQowRTjpT3+KNvOuEozWBd8ILoI3zZyz9q8DBUf/xon0Vpm3QroiRKKQGv7eAQnwl2CMYtPRH/u2tBXWjIR0ttTNd/DuP2SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779145600; c=relaxed/simple;
	bh=tdQX6z5Ow34bb/pGtk3dNyrAbcLCh7UCBhe9r1uuApA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JbA1XwveObtAIGF3UUtRbsxv4/eikj+CIFzDo3RLT62VqgIP50NyY5wNZO1wRsVWkZn9Cn9tfREhCUAuw/vEbBByG/bzpMVjAnMQbJAumwToFkZzqmO8DfU8cWGVdRMQV5nxrnltLV2xLHsmrXQsT8r9gUfVvBAhO6NnfzFzClE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iKifQGEz; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKifQGEz"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2bcd3ac3307so15894155ad.0
        for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 16:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779145598; x=1779750398; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J6fRPsUXaMKX0qPKfz3OqQyhzwCYHmD71RB3fhnMJPw=;
        b=iKifQGEzAh3nSIZfpJZ9YmMOaA3tTspIJSBXVF+njJnVFVRWhMr60osRzOcmOzsKRX
         YrGDT1oBgngfvbxZW/hzH6hciFB9fdnt4qrI18QoiRjMG7ybEfkCnD+4hvYqTZzhgQyc
         HY1KpuxlP1Ql7R7Jm+eHeVN9Rj4CHp7JTNTqapF1TLxPuF/vokhvpCnrCujUlIHNNUK0
         FO6byZ4mQg+RBG8hEiFzs5o5LAnIiBvAgVoWjtCusn2O0n/OX+RGKGvJh6uznc45IezW
         3vI3xm5nYYRaDpNWpariflH0kh6b4/zXJNo7FWWFvPY6IL27dfbkncRf+YIwT2VgCx5F
         mHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779145598; x=1779750398;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J6fRPsUXaMKX0qPKfz3OqQyhzwCYHmD71RB3fhnMJPw=;
        b=ce3QVbll9WnALRLyuYbXy5J1mEcIl+j8UoA0l2tS+ivNQ8yNzzqD6GhA04hu+61mmQ
         ogvLfSLYwnGCW1LnejaVE8pCXmeMyU7hmXJJHAlXtHXe7p6w6NQ8reu+YAyyQueUTFZR
         mEWrLQI3PF5hKEHbQt5+WUuNOJB9qcrCN46dIV0qMs3OlDmbmigoK7Y/XAkW1TJN+QvT
         IhoWs8rLqRgoUZYhrMB1LNE2bOxWVYP7CGW0D0XUeU1vQ1GuJNv7hbzqz94UHGmmpw28
         Vcf1/Lxfqj+P8jTgxMhzsw78sdG8dAj/aF1iLXhazCWL1TaFlOac08ZkLmkGFOQrvUPt
         I2cA==
X-Forwarded-Encrypted: i=1; AFNElJ97dFjNuzSQQDc5RA19Blb/O5BhhUmlQ6SW2TpCeMhASKeProNLH2DHgp0XW5lsH7U5CDf1G5lRMok=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV825evn1dTEexGC4aGuIMTzTSp07sReKGQ+MhH8Azobd4gIJA
	cx5/my7BlhZaiv2bdc9Q69y+wCRUyzWoGhkdkTMp92bahp2xJCjyyXrl
X-Gm-Gg: Acq92OFMGC7ptOJp8STPy6HSM3jqZQub1v7eXYbEkgetdJQiSSU1YCUsTus4493J2Yj
	CASiRFetrLh/nlxIdDIuK3tg529+2tO4Z1F/Kr5AhpfFCaIkVRjQqGoJbU9Cptw4bae7INKUcps
	tbFaVJipEYOQvXnQZDvA5JTy+DBNQbECzggsmzV4WICa0FEISI39Bo+1V5AnCUf8NzIwimxpNjX
	2LAV4ZCycyyABVxOiKKamS/TNP6h2X0D2QknVn6Ub6zSoDUVRy7aWUq6hC9XihulB7SoZyf4jx7
	jtv9lM+TdtRih5b5fjDpZ1FbikQovLUxWISTvmeat/ntt1ozQVr99AcafqzQA52/Df1VWdpfoRS
	PRZWTmJaTJo6U4sHLa8/oC1lre9iaI5Q0rjWHlCppsF0j1DjvXxzdbYQwhuBmlBM9dyLldjvrGS
	qXf2JSx7FPiG+iyzokeJSWLuM+IhjmnVM=
X-Received: by 2002:a17:903:3c43:b0:2bd:e43c:12d0 with SMTP id d9443c01a7336-2bde43c14b7mr63463745ad.28.1779145598364;
        Mon, 18 May 2026 16:06:38 -0700 (PDT)
Received: from [192.168.89.2] ([119.214.48.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5fb35sm159558035ad.12.2026.05.18.16.06.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 16:06:37 -0700 (PDT)
Message-ID: <7ff352be-05d2-4c21-931e-18238172e4d7@gmail.com>
Date: Tue, 19 May 2026 08:06:34 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] usb: xhci-pci: add AMD Promontory 21 PCI glue
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
 <20260518233711.4c99cc72.michal.pecio@gmail.com>
Content-Language: en-US
From: Jihong Min <hurryman2212@gmail.com>
In-Reply-To: <20260518233711.4c99cc72.michal.pecio@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/19/26 06:37, Michal Pecio wrote:
> That's true.
> Making this possible is the whole purpose of "if IS_ENABLED" here:

I re-checked the Kconfig cases, and I think you are right here.

The two cases I was trying to avoid are:

  1. the sensor driver is built as a module, or loads only after the
     initramfs stage, but the PROM21 controller has already been bound by
     the generic xhci-pci driver, so no auxiliary device exists for the
     sensor driver to bind to;

  2. the built-in generic xhci-pci driver rejects the PROM21 controller, but
     xhci-pci-prom21 is only available as a module and is not present during
     initramfs, leaving USB behind that controller unavailable at that
stage.

Looking at your proposed Kconfig shape again, it handles both cases.

If SENSORS_PROM21_XHCI=n, then no sensor support is requested and
USB_XHCI_PCI_PROM21 can stay disabled. In that case generic xhci-pci binds
the controller, which is fine because there is no sensor driver that
needs an
auxiliary device.

If SENSORS_PROM21_XHCI=m or y and USB_XHCI_PCI=y, then
USB_XHCI_PCI_PROM21 follows USB_XHCI_PCI and becomes y. That means the
PROM21
glue is available during early boot, creates the auxiliary device, and the
hwmon driver can still bind later if it is built as a module.

If USB_XHCI_PCI=m, then xhci-pci itself is modular. In that case needing the
PROM21 glue module in initramfs is not a PROM21-specific built-in/module
split
problem; it is the normal requirement for a modular xHCI PCI setup.

So I agree that tying the hidden glue option to whether
SENSORS_PROM21_XHCI is enabled is reasonable.

> Currently, you have a weird situation where xhci-pci-prom21 always
> binds on x86 and xhci-pci on other platforms (with the unofficial PCIe
> card you mentioned), plus the sensor cannot work on other platforms.

Agreed. I also agree that the X86 dependency is only a heuristic and is
not a
good restriction for a PCI ID based driver. PROM21 is mainly used on AMD x86
desktop platforms today, but the unofficial PCIe card example shows that the
device can exist outside the normal AMD x86 chipset topology.

I do not know whether other PROM21-related functionality is supported on
non-x86 platforms, but this driver does not need to prevent the xHCI
temperature sensor path from being built there.

> One could further argue that neither should it care whether some hwmon
> driver exists at all, or which kernel releases it exists in :)

Right. I think the cleanest result is:

  - generic xhci-pci handles PROM21 when no sensor support is requested;
  - xhci-pci-prom21 handles PROM21 only when the sensor path is enabled;
  - the hwmon driver remains the user-visible option.

Unless Guenter or the USB maintainers object, I plan to change the next
revision in that direction and test the Kconfig combinations locally.


Sincerely,
Jihong Min
