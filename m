Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB6B3932CE
	for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 20:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779136253; cv=none; b=bpDi+KP/EIBH+2DOHPDo6+zXEcJ9fsMHvvVb95j8Zbp2HgrCEeIKQrr+YcvNDcGgd8X/yvqnjoyQbJ3JOLBimQBn+bDIFauLYwQBLach0pFlGzWo4+S8kUik9d1IFDtaoAit5gy8e9WFBKVjrNFE89Q5lgno/Up8UevBhLLST+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779136253; c=relaxed/simple;
	bh=+AXWZ7VWZu++/J9Ox1DjhblJnRVzqBe9blE5RidmFX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n7Kzz54tF5Jfb3vgRpXrPiZvx2RdSHCSV3LxNdJcOXzHsGBBYoeDs3kvhFARLkMpWF7wBlvXuDnFHAWEKgIG5U1HGSPOgvhbkVoQYWP5SrUCUl86urLPTtBKQTRCDHENtQrLXP/KtgLX9HQdnB+Y7M/k0OwaU8Z/D2rrKBi2I9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxZfAP/4; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxZfAP/4"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2bd266f6fc0so13146855ad.2
        for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 13:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779136252; x=1779741052; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DlBfJe+9ZxBm7v8GCX+TON5gbGwp1e0878LuEL7rsgM=;
        b=JxZfAP/4U5fDo6s60PKFQHaFHBl+YMl8Uninfca6pyHv78ysYZBWfH+or94oSdEgZX
         GZGCn5UyLeefVm2gTHCSvCplLNp1lDG/0dydv9OjH4GOSzYk6xY9vTgPRTIrZLGNlqQB
         U8xdxdefwUbwh9MAe6PiFVc+0KZitzA4ZyDhFYbFd43cuNCMWFwFn/xUGGoTDd3uCHzQ
         iqtNJVMWRL5PLHypnsnfdR8EFoKLgodcTRDvRuGLBPxCOkSIGAdF2G7EIvcIpWL8DlxT
         nc8qgZcW5XQd47jwnb8CQI2W9pfW5ehvCRiVOnGXh0wp583XSswrNEZHH0jUjwnY89JW
         gAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779136252; x=1779741052;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DlBfJe+9ZxBm7v8GCX+TON5gbGwp1e0878LuEL7rsgM=;
        b=Z0c4DEgbjMULoJWngXU3tdXuSbeoP9vjvzzLuJrE61fAUHve+wd+pw+65sNa/dHzlj
         pUndkdSPk6Vc4FmO9GEmXH8h23l9u7ln40QsExyqEHOBbZIx7dDfgU56UY662PGLBxAK
         28mrZzLDa1zP9E2aOOxPrR7vrv+PVw5B7ZaIg4rWl2kHAkck1ItRawtHbLue6PciDTug
         3DyqQ7vfKsQrJhOE7fpUSA1miEb64c4B9afdEayK4vH7kRYMe2vCVCssMOeZUEwC+C9s
         NmfsysNGUXn0SkVZXmzcRKsMr8XWXy+8GtdJ8J+RLwQVRc7MQ576ie5n12BRxYnd12qn
         dZhA==
X-Forwarded-Encrypted: i=1; AFNElJ+MQRBxen3gO4K2E6zK4gwktXZxRiLDFCa1p7a0iLw3ri4OXipMFrjiMUj3x+QRMNquTTlvwQvjPRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkJ+3pSxSBVnUOpT+WP95J+wUyDsjqNxoENDvrQG3MkSUTw7eE
	+lgzzMoxqpdefy452GPADitqsZeaRj2yXw4sfdZGN52roaUZw83wXZ4g
X-Gm-Gg: Acq92OHlk6cVympWmJhF50BZtnArSB1xQW24w5phL3UGJZCddk52Xj3XJl1i1KEJQU/
	5LVZQxU4yGmEmTpOT49onUzPDy5HlOeXYKjJ3p1UkNSwbfOJ9HscTXu2ANV2aGQdnmX7haja8Hl
	ZIkFMte8Ca2bChRdPcgtuY/x617P/AuqzCAbj5/3OEvHem3DJtMpfEG/KaoSDSJg0xI2zueBbUx
	WOr6+u0AxdcCLrz+5jPxf+5oVpMyWctnC5+wQlE0Ko8vZkaYEsq7gF949ctvVBkFdH8P21jk6j8
	vfk4MKOl8Y3K2wJ9G1qTZ01hOKt4YCql5JwLBJ15ka6OsAtVVsBvp14MNgM8Tz4YnbbwmF2NjDE
	IFDF7suOL8JQ6qv0e2xsMDUHJ48oh0UuvhRAxq0RnRIlOTowmN3w6CkhaWIpJ0pRHkEEW1ujPRO
	TuEnMWUvZM41Sezx4HcYyj9ps+6fYFpZA=
X-Received: by 2002:a17:902:d511:b0:2b0:6e60:9582 with SMTP id d9443c01a7336-2bd7e8cb160mr173923295ad.18.1779136251551;
        Mon, 18 May 2026 13:30:51 -0700 (PDT)
Received: from [192.168.89.2] ([119.214.48.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd60275sm150934905ad.7.2026.05.18.13.30.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 13:30:51 -0700 (PDT)
Message-ID: <144ec61c-4cc1-4986-a16c-7c1b99f3a72e@gmail.com>
Date: Tue, 19 May 2026 05:30:47 +0900
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
Content-Language: en-US
From: Jihong Min <hurryman2212@gmail.com>
In-Reply-To: <20260517232147.34931718.michal.pecio@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/18/26 06:21, Michal Pecio wrote:
 > Instead of the X86 heuristic, would it be possible to build glue
 > code if and only if SENSORS_PROM21_XHCI is enabled?
 >
 > This seems to work:
 >
 >   config SENSORS_PROM21_XHCI
 >          tristate "AMD Promontory 21 xHCI temperature sensor"
 > -       depends on USB_XHCI_PCI_PROM21
 > +       depends on USB_XHCI_PCI
 >
 >   config USB_XHCI_PCI_PROM21
 >          tristate
 > -       depends on X86
 >          depends on USB_XHCI_PCI
 > -       default USB_XHCI_PCI
 > +       default USB_XHCI_PCI if SENSORS_PROM21_XHCI != 'n'
 >          select AUXILIARY_BUS
 >
 > I don't know if it's the best way, perhaps it would be preferable for
 > the hwmon driver to select the glue, but then I'm not sure how to force
 > glue to become 'y' when xhci-pci is 'y'.

I think I should keep the current hidden glue option for now.

The PROM21 PCI glue is part of the PCI binding path for the xHCI controller
when enabled, while SENSORS_PROM21_XHCI is only the optional user-visible
hwmon driver. Tying the glue to the hwmon option would make the sensor 
option
affect which driver binds the USB controller. As Guenter pointed out, that
would be too strong; the USB controller should not depend on whether the
optional hwmon driver is enabled.

So I would prefer to keep USB_XHCI_PCI_PROM21 as hidden plumbing that 
follows
USB_XHCI_PCI, and keep SENSORS_PROM21_XHCI as the user-visible sensor 
option.

 > +static int prom21_xhci_create_auxdev(struct pci_dev *pdev)
 > +{
 > +	struct prom21_xhci_auxdev *prom21_auxdev;
 > +	struct usb_hcd *hcd = pci_get_drvdata(pdev);
 > +
 > +	if (!hcd)
 > +		return -ENODEV;
 >
 > Shouldn't be necessary after successful xhci_pci_common_probe().

Agreed. I removed the unnecessary NULL check from
prom21_xhci_create_auxdev() locally for v7.

 > +	prom21_auxdev->id = ida_alloc(&prom21_xhci_auxdev_ida, GFP_KERNEL);
 > +	if (prom21_auxdev->id < 0) {
 > +		int ret = prom21_auxdev->id;
 > +
 > +		devres_free(prom21_auxdev);
 > +		return ret;
 > +	}
 > +
 > +	prom21_auxdev->auxdev = auxiliary_device_create(&pdev->dev,
 > +							KBUILD_MODNAME, "hwmon",
 > +							&prom21_auxdev->pdata,
 > +							prom21_auxdev->id);
 > +	if (!prom21_auxdev->auxdev) {
 > +		ida_free(&prom21_xhci_auxdev_ida, prom21_auxdev->id);
 > +		devres_free(prom21_auxdev);
 > +		return -ENOMEM;
 >
 > The usual "goto error" pattern could be used instead of increasingly
 > long sequences of xxx_free() calls.

Agreed. I changed prom21_xhci_create_auxdev() to use a goto-based 
cleanup path
locally for v7.

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

I understand the concern. Linking the PROM21 auxiliary-device publisher
into xhci_pci.ko would reduce some boilerplate and avoid the extra PCI
driver, while still keeping the hwmon driver itself separate.

The reason I kept the current split is that the earlier review direction
was to keep the hwmon functionality out of xhci-pci and bind a
drivers/hwmon driver through an auxiliary device. The current PROM21 PCI
glue keeps the PROM21-specific auxiliary-device lifetime handling outside
the common xhci-pci driver and leaves xhci-pci.c with only the PCI ID
handoff, similar in spirit to the Renesas handoff path.

That said, I agree this is a tradeoff. If Mathias or the USB maintainers
prefer the PROM21 auxiliary-device publisher to be linked into xhci_pci.ko
instead of being a separate PCI glue driver, I can rework it in that
direction while still keeping the hwmon driver under drivers/hwmon and
bound through the auxiliary bus.


Sincerely,
Jihong Min

