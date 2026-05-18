Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087062DC767
	for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 23:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779146750; cv=none; b=FRGHnpSINc+qUi3nE3wDchVoZkysimyNuHKJVXGsd4yl/Tw8uGStQZ0jI1/aoTajNOQb2v5NfypAHwdCmKcF4r4vJ+8xi+4UUb7h+9B71s1NkAGGwNpOMXq7EJs90Usp15AhNIECegudJP8hd/LR1xFgGNsWhDO4rUXjcUUpm/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779146750; c=relaxed/simple;
	bh=4RfscQQn/pTBnlejDUtd+8rPk4nHLoB3UAp2Ugmw2zE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YzIVMhkuwrbX9Qhspx0UtpTpdaSMYq2V5XoJdvorvsyf53Lu4mDkE6RKBAs7zzDPpALsluVzyolyoQM+HYee9SfC4+wupM5xrdHZ9cyDh133JpBqY/zCekquFpQWQT8v3IDbN5Vd2OvxLbWHfHZxPzvspEyFkUbQQRIoIMjTbgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1ULs6lQ; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1ULs6lQ"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c70e27e2b74so1108214a12.0
        for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 16:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779146748; x=1779751548; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=JF0r/iHjJb1hUKYsIq348Phvz6d6d0rLxOqdeph9mEQ=;
        b=e1ULs6lQXPOQFYnTXiLw18rogl3G1br/Y/nmrsVdZmxaOWFtid/OHoE6fH2IByxLHo
         C7qhjC3iJkyzyxoUgArXUF7DQxz40IDcOqS9XVPQQxAwlI+pxVEFuHG+hfBK+6jq7rgS
         pQB3rCjniH8k25f3h8FhhPTl50mw4qZiH1ohAWfFw8eu+5GOqaJbMaMYtuxe9PThc/VY
         7/Q4Ry2Ad+rXGPU6YSbRPWPLC7u6HUfGqm5gTP5zuP6uwY7ThEWuqqYzPK7lP4mtebmy
         s/OGf6Ugl1A6TqyIKjSWi8SdAuo4DL/TehGVESufPQ9mq5aU1W2fJYC2ypieq+8GwXHS
         W9NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779146748; x=1779751548;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JF0r/iHjJb1hUKYsIq348Phvz6d6d0rLxOqdeph9mEQ=;
        b=GaEgNsUD6Z+mDR4foJXn8Dm79ZF3dGEuDV+pkTVvt/mcCG9wEMKPpxFoFZTN8Q9xLo
         ZdQzjyMfnXuBUG+yDWxbmItPupYPEQmS2gnfsw0G/fQVyLqN1qvyENLl6Zfmfdk8dc8x
         ZZoXyzr2Ihvezp2mbbfxwZbOH2MXqhy6NmG4SaOSdeAvZIxlfJ8Iv0uqn5z5jO4dl8fx
         XYK39WVMZX81PSKhPiEzjEhXkmNLP+wCDmI3a6RSQpuxU1TgKPJwRuhJgOhZzb6or9mQ
         8ryEJLrea0ru4QqEhbhsA2JV6n0l2mD5B+0MxLe2cf2hEi7YoKpf1FyQvomVhXXaFeNj
         yzrA==
X-Forwarded-Encrypted: i=1; AFNElJ9EMmOj26FAhWQSYo8sfSXJ5VJhEzJgyOR1mRu3kDoNYzwy/Za1MzDMUtONih1zjq2BAXcYbLP4Dq4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+Ad7qGlMmCqFnHgzZgIRTLnEdO1t+NYx/y7+5kdYWjHvdB8DT
	mpVNotNdH5jnZWl4lFsrM6ElscZ8vRdIp/2H9lWRDrUfHx9MvfpAopjt
X-Gm-Gg: Acq92OEH0JXLIsJ3gH/0Klze4wMTniVYGW4bynEKE6WIJw4V+dyy5kHo16M/ta9SVuV
	NMmDjF0WtO/n7dNdTSaLxuIQmybzifdgUW7fNpcrqGckGW2elEETxyo4BL+pKuftaTPxvVoi5Hy
	/2q1YKxhHH77KEIJ9MuEtLWXOsn6tCO4fuUVC9uhEEZnz+MIi9Eh3Z4vkZU5YK3l9XpZflZVYPZ
	RNrfiZocyGeHA7adFlIAtgQiwfmOPvIk3mhEj9EFak23+lnhm49vAEgDugRw52YiM5xWR4sMGNF
	NnUs9cbMCeNzeiCdDdxglADG0hZaVLXCMfY8R/C/sjT2meBQFwaTVf/r5+PfZOTG4BW4KY7d5Hh
	cOe7PL9PyxNmN7zjdyQ2v2Xbn0J950VvOHpmbkRkNmzuuFGdG1T5tnsbDnydzude7cVO3+A6Iiu
	NirAWs5JLdLx2vZJRW0EXkCrj8gBDFFZgaNYg4F5ClMXbpghxYQjgtdpCUsWbtSTIazaydiv9CK
	RtWuVmz+SQ=
X-Received: by 2002:a05:6a20:5681:b0:3b2:6988:a6fc with SMTP id adf61e73a8af0-3b26988d381mr9737443637.18.1779146748232;
        Mon, 18 May 2026 16:25:48 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb116860sm14615425a12.25.2026.05.18.16.25.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 16:25:47 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ceabda3d-47a2-474c-9792-5453acd5a84e@roeck-us.net>
Date: Mon, 18 May 2026 16:25:46 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] usb: xhci-pci: add AMD Promontory 21 PCI glue
To: Jihong Min <hurryman2212@gmail.com>, Michal Pecio <michal.pecio@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathias Nyman <mathias.nyman@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
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
 <7ff352be-05d2-4c21-931e-18238172e4d7@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAmgrMyQFCSbODQkACgkQyx8mb86fmYGcWRAA
 oRwrk7V8fULqnGGpBIjp7pvR187Yzx+lhMGUHuM5H56TFEqeVwCMLWB2x1YRolYbY4MEFlQg
 VUFcfeW0OknSr1s6wtrtQm0gdkolM8OcCL9ptTHOg1mmXa4YpW8QJiL0AVtbpE9BroeWGl9v
 2TGILPm9mVp+GmMQgkNeCS7Jonq5f5pDUGumAMguWzMFEg+Imt9wr2YA7aGen7KPSqJeQPpj
 onPKhu7O/KJKkuC50ylxizHzmGx+IUSmOZxN950pZUFvVZH9CwhAAl+NYUtcF5ry/uSYG2U7
 DCvpzqOryJRemKN63qt1bjF6cltsXwxjKOw6CvdjJYA3n6xCWLuJ6yk6CAy1Ukh545NhgBAs
 rGGVkl6TUBi0ixL3EF3RWLa9IMDcHN32r7OBhw6vbul8HqyTFZWY2ksTvlTl+qG3zV6AJuzT
 WdXmbcKN+TdhO5XlxVlbZoCm7ViBj1+PvIFQZCnLAhqSd/DJlhaq8fFXx1dCUPgQDcD+wo65
 qulV/NijfU8bzFfEPgYP/3LP+BSAyFs33y/mdP8kbMxSCjnLEhimQMrSSo/To1Gxp5C97fw5
 3m1CaMILGKCmfI1B8iA8zd8ib7t1Rg0qCwcAnvsM36SkrID32GfFbv873bNskJCHAISK3Xkz
 qo7IYZmjk/IJGbsiGzxUhvicwkgKE9r7a1rOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAmgrMyQFCSbODQkACgkQyx8mb86fmYHlgg/9
 H5JeDmB4jsreE9Bn621wZk7NMzxy9STxiVKSh8Mq4pb+IDu1RU2iLyetCY1TiJlcxnE362kj
 njrfAdqyPteHM+LU59NtEbGwrfcXdQoh4XdMuPA5ADetPLma3YiRa3VsVkLwpnR7ilgwQw6u
 dycEaOxQ7LUXCs0JaGVVP25Z2hMkHBwx6BlW6EZLNgzGI2rswSZ7SKcsBd1IRHVf0miwIFYy
 j/UEfAFNW+tbtKPNn3xZTLs3quQN7GdYLh+J0XxITpBZaFOpwEKV+VS36pSLnNl0T5wm0E/y
 scPJ0OVY7ly5Vm1nnoH4licaU5Y1nSkFR/j2douI5P7Cj687WuNMC6CcFd6j72kRfxklOqXw
 zvy+2NEcXyziiLXp84130yxAKXfluax9sZhhrhKT6VrD45S6N3HxJpXQ/RY/EX35neH2/F7B
 RgSloce2+zWfpELyS1qRkCUTt1tlGV2p+y2BPfXzrHn2vxvbhEn1QpQ6t+85FKN8YEhJEygJ
 F0WaMvQMNrk9UAUziVcUkLU52NS9SXqpVg8vgrO0JKx97IXFPcNh0DWsSj/0Y8HO/RDkGXYn
 FDMj7fZSPKyPQPmEHg+W/KzxSSfdgWIHF2QaQ0b2q1wOSec4Rti52ohmNSY+KNIW/zODhugJ
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <7ff352be-05d2-4c21-931e-18238172e4d7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/18/26 16:06, Jihong Min wrote:
> 
> 
> On 5/19/26 06:37, Michal Pecio wrote:
>> That's true.
>> Making this possible is the whole purpose of "if IS_ENABLED" here:
> 
> I re-checked the Kconfig cases, and I think you are right here.
> 
> The two cases I was trying to avoid are:
> 
>    1. the sensor driver is built as a module, or loads only after the
>       initramfs stage, but the PROM21 controller has already been bound by
>       the generic xhci-pci driver, so no auxiliary device exists for the
>       sensor driver to bind to;
> 
>    2. the built-in generic xhci-pci driver rejects the PROM21 controller, but
>       xhci-pci-prom21 is only available as a module and is not present during
>       initramfs, leaving USB behind that controller unavailable at that
> stage.
> 
> Looking at your proposed Kconfig shape again, it handles both cases.
> 
> If SENSORS_PROM21_XHCI=n, then no sensor support is requested and
> USB_XHCI_PCI_PROM21 can stay disabled. In that case generic xhci-pci binds
> the controller, which is fine because there is no sensor driver that
> needs an
> auxiliary device.
> 
> If SENSORS_PROM21_XHCI=m or y and USB_XHCI_PCI=y, then
> USB_XHCI_PCI_PROM21 follows USB_XHCI_PCI and becomes y. That means the
> PROM21
> glue is available during early boot, creates the auxiliary device, and the
> hwmon driver can still bind later if it is built as a module.
> 
> If USB_XHCI_PCI=m, then xhci-pci itself is modular. In that case needing the
> PROM21 glue module in initramfs is not a PROM21-specific built-in/module
> split
> problem; it is the normal requirement for a modular xHCI PCI setup.
> 
> So I agree that tying the hidden glue option to whether
> SENSORS_PROM21_XHCI is enabled is reasonable.
> 
>> Currently, you have a weird situation where xhci-pci-prom21 always
>> binds on x86 and xhci-pci on other platforms (with the unofficial PCIe
>> card you mentioned), plus the sensor cannot work on other platforms.
> 
> Agreed. I also agree that the X86 dependency is only a heuristic and is
> not a
> good restriction for a PCI ID based driver. PROM21 is mainly used on AMD x86
> desktop platforms today, but the unofficial PCIe card example shows that the
> device can exist outside the normal AMD x86 chipset topology.
> 
> I do not know whether other PROM21-related functionality is supported on
> non-x86 platforms, but this driver does not need to prevent the xHCI
> temperature sensor path from being built there.
> 
>> One could further argue that neither should it care whether some hwmon
>> driver exists at all, or which kernel releases it exists in :)
> 
> Right. I think the cleanest result is:
> 
>    - generic xhci-pci handles PROM21 when no sensor support is requested;
>    - xhci-pci-prom21 handles PROM21 only when the sensor path is enabled;
>    - the hwmon driver remains the user-visible option.
> 
> Unless Guenter or the USB maintainers object, I plan to change the next
> revision in that direction and test the Kconfig combinations locally.
> 

Ok with me if you are sure that it works. When you send a new revision,
you might want to also change the error path as suggested.

Thanks,
Guenter

