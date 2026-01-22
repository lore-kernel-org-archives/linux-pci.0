Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932E02BEFE1
	for <linux-pci@vger.kernel.org>; Thu, 22 Jan 2026 17:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769104195; cv=none; b=nNdCqabuoUycaz2cJfH/AApPHNUGr1l/15FixiyD9pM0U9uXQStQTJn/AsVztyFsQIobawQAbOFUcNYE+X18sV64HsCz64Ih+Hu5M4baSq2Fm/8aDvLK8FdQ3dbxrE9UrCz1GKTC9RLenwMMioTWiYqsCo/bCsNh58SduDQKcz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769104195; c=relaxed/simple;
	bh=Fy3XirdW3o4O+QTo79Ey4FXxvk1xhYIcaqrUFj49MDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4A8rlpbHZYuQ1SnrhQQ4rdRToYydbUD1D17y/oS0hLNDeAHkDJfhbhJFSmD7RkDR+R1H68tyItmJDFQCpXLdKI/9rZnWwqtCIJpnh2smiLuLaO+GNuW6xN2zjBkSgtWO0pXbqB0xodpXs+ovTAaBA0v9VWbYLaXWz6I9w5g/9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FUnbEHcI; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FUnbEHcI"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1233b953bebso2763302c88.1
        for <linux-pci@vger.kernel.org>; Thu, 22 Jan 2026 09:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1769104183; x=1769708983; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Cts/XmrIsitUkgW4W0CPI9+Y5A4oJrjzrlI5Y9vqVAc=;
        b=FUnbEHcINfzrYaeQhEuTNy4kGslu9mp46Mq5Qinf3z8vY1geZH0osl34Mtmw3GXf35
         rDX3D+99W8wn0o1SVPrYJHun4mo5OzD7LC8w7Rn3I6h82TW8FPRszv7Y5RwWBzj8oEzd
         SZJrnu5rkwXwao29Wmo3IuwpMzm5OQr4pToyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769104183; x=1769708983;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cts/XmrIsitUkgW4W0CPI9+Y5A4oJrjzrlI5Y9vqVAc=;
        b=KB+RIFDeIupfLlMfoC0iBowS5pE7ya8l512DvZltF5z4YIO3sJeOSwB+nrMkIN2dd5
         ZEp4QwkPAjuLrpa2fmCUp1QtjEFlRKFEMSqkbJpZI+KpNrcDMB0i2TI/3LIPC+zC69xG
         2wWgj0JLxQqxTa4kkAMyPNZgwHENeICG7X5OcG16n8Z0CbXDk3+UG5EQ0crvvEWtqU33
         bjn1KinRX7V9HQlbBMUgfPk9IV/CcZtpHUEPLvwZT+FAc6aWPdO4N56rdV46jYtwi80p
         JFAuhDJbvmaLrYvhPXJgMa8u4X9nxpTEq7EMfBglnhSopdb2uEM72Dg/r9oC/+/bcpTs
         aFeA==
X-Forwarded-Encrypted: i=1; AJvYcCVPc0D4WPhqjc2dMI3YBx7TDbYlHN7tmjSK3J++Z6S+zyu4vxC/tubKHI8Kdcz/Rw24dwndJXbUCA8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk1G7kKIZXHE4I+m6u18vUjBa9dSJyu5uN6oqf2sAZwduGTuqk
	A1bVjQB9bTsezrLSCTLfrW1e4pxLD1OSnm10yV+8cYL4KtPx4CIQiN72J0+G6i+6XQ==
X-Gm-Gg: AZuq6aIv4qc7JSD26Hk7hGtlju+qpBoGy2Dnf8xS2ETyWroqFupwYr4L+D63oUotQvJ
	O0mgWZ5fIP31KUiYihHQuBHm3AoGL2Zj+9I55NfA6+ZSFUv+uuoL1XvjvGEZjmlJhPmBIKqBznN
	y8L7Fp4UMHdVQC14wDylbivMc6BBGiQ2V8F7sYbEtGntYpYJyyZBa3fkmpNlMqoIoOUdEzSuJds
	u+IU95IiePccGC8nPWfZCCGSTjF44J5wCskeHoyRYtuirjGB00qd/EQNOToml5Hez3QpdoxWYT7
	RSPOMge30CMSV8J1ALZmUrZ+4J6B8DA6oV4/nCFwfe74cv94oaUzMViinWJPn/SEHORFeozm8Uv
	l5EHudfm21otNAAgwIi0x84bQxibx6AENEzoxwMCrALOxggXNDBKrdyok9AHsJ/D+rFr+xcE2t6
	kEmAoZ+uS8MTujKI3W8cMjKFUmk8W+KAOzpqkiixq13hgIF5ASvA==
X-Received: by 2002:a05:7022:660c:b0:119:e56b:c75a with SMTP id a92af1059eb24-1247dbf8d14mr61525c88.31.1769104183224;
        Thu, 22 Jan 2026 09:49:43 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:f995:553f:5ab5:f684])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-1247d997f7bsm197174c88.11.2026.01.22.09.49.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 09:49:42 -0800 (PST)
Date: Thu, 22 Jan 2026 09:49:41 -0800
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v4] PCI/PM: Prevent runtime suspend before devices are
 fully initialized
Message-ID: <aXJjNfqcZrXw1_h2@google.com>
References: <20260106222715.GA381397@bhelgaas>
 <CGME20260114094643eucas1p1a2fdc6c35dd27741c18831b34bbed0c8@eucas1p1.samsung.com>
 <0e35a4e1-894a-47c1-9528-fc5ffbafd9e2@samsung.com>
 <aWf4KyTSIocWTmXw@google.com>
 <61e8c93c-d096-4807-b2dd-a22657f2e06a@samsung.com>
 <aWrjhqC_6I2UNXC5@google.com>
 <CAJZ5v0hWt63=0yjFrbTY8zXubh-Uc6ZwAndT73VL7itMkTe81A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hWt63=0yjFrbTY8zXubh-Uc6ZwAndT73VL7itMkTe81A@mail.gmail.com>

Hi Rafael,

Thanks for your thoughts!

On Sun, Jan 18, 2026 at 12:53:21PM +0100, Rafael J. Wysocki wrote:
> On Sat, Jan 17, 2026 at 2:19 AM Brian Norris <briannorris@chromium.org> wrote:
> > I suppose one way to "solve" that is (untested):
> >
> > --- a/drivers/pci/bus.c
> > +++ b/drivers/pci/bus.c
> > @@ -380,8 +380,12 @@ void pci_bus_add_device(struct pci_dev *dev)
> >                 put_device(&pdev->dev);
> >         }
> >
> > +       if (dev->dev.parent)
> > +               pm_runtime_get_sync(dev->dev.parent);
> >         pm_runtime_set_active(&dev->dev);
> >         pm_runtime_enable(&dev->dev);
> > +       if (dev->dev.parent)
> > +               pm_runtime_put(dev->dev.parent);
> >
> >         if (!dn || of_device_is_available(dn))
> >                 pci_dev_allow_binding(dev);
> >
> > Personally, I'm more inclined to go back to v1, since it prepares the
> > runtime PM status when the device is first discovered. That way, its
> > ancestors are still active, avoiding these sorts of problems. I'm
> > frankly not sure of all the reasons Rafael recommended I make the
> > v1->v3->v4 changes, and now that they cause problems, I'm inclined to
> > question them again.
> >
> > Rafael, do you have any thoughts?
> 
> Yeah.
> 
> Move back pm_runtime_set_active(&dev->dev) back to pm_runtime_init()
> because that would prevent the parent from suspending and keep
> pm_runtime_enable() here because that would prevent the device itself
> from suspending between pm_runtime_init() and this place.

I'll admit, I was a little fuzzy on the details of the first part of the
sentence here -- specifically, that an "active" (but still "disabled")
device will prevent suspend of its parent. I suppose I'm more familiar
with the typical "disabled and suspended" device, which essentially has
no effect on its parent.

Anyway, that's basically v3, so I rerolled a v5 that looks similar.

> And I would add comments in both places.

I tried to add a short comment to each. It's an art form to write
exactly the right size of comment to make everyone happy (people
complain about too much commenting, and then others complain about
non-obvious behaviors that could have used more comments), especially
when it comes to something as tricky as runtime PM. At least I tried...

Brian
