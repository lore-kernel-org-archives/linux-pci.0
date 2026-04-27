Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C3A366567
	for <linux-pci@vger.kernel.org>; Mon, 27 Apr 2026 20:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777322169; cv=none; b=ohYEYhMyim1chT76LUKJ6w5AEJw0+rDkhLptxGo4fI5GPQhNODbQJpuhvT8qKxSn2n9cly0SoftK2xfcg1Z9nFBe/VrZWCzZJnF8xZ6KFlZdx4UAbqQDiugIyDWwv5+Gg45UzA3ebHRoEw9hCxkta2jr23mA26dx/ARuzsL4HRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777322169; c=relaxed/simple;
	bh=KeprCv7MW+Ce6GRs821xRLB6lzgXnDlvJi4UuP93Z0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ARqahjsywEfwes7gaPCv21K2/c0CORKYBnAfjwaj0bFmF9pc6aSLztIlHmoCWgU1+NnR8FPCdZDcV9naJ80guEKq6vvQbIdydFsZvgZfm6W0QFLGOWjKAYVKQE41TCnoAUBEF+Xn3RO+ayoD1jOumbANb8h9yxBLg6bltTVUTYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bmrLkWIV; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bmrLkWIV"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b46da8c48eso25205ad.1
        for <linux-pci@vger.kernel.org>; Mon, 27 Apr 2026 13:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777322167; x=1777926967; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5kLJiYyLuMrCMUKzFtT9+iIyaNr1wOEkpYjAcEB5YGU=;
        b=bmrLkWIVSxk+L9G8lTDVFmbvafcTq8CDnHR2x/I4EEXR066PnMtIctudoC5XyxLYUj
         4mjjxtGLo0z3xMlFfhtT5r4amgxpPB3XpiEOhgB1KdoLK56fltUxFIoVgHooAfrJbN/8
         wskUCJ2Jl/TgbDaP+GWsjasyXxxj/HlhZOV1symkcEvzmjDtM+FMxP/mf8Sg9rbZpBoE
         P1StnUXj8MHXW89CZZn5F2iybiffEdb9nPSwdpvIWemI1mUZnkoqITpzfGGwev7DnJTH
         3ECRU5OfiNJs96/Kk0NeGtHtdBrlrkqUmTlSCWMgZ8Tf7De/mxEa5cI0f9QWkaAQwaJz
         fqgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777322167; x=1777926967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5kLJiYyLuMrCMUKzFtT9+iIyaNr1wOEkpYjAcEB5YGU=;
        b=U8NoelTXmmg9Vl5bxcIAJtYKAYNlFe44vzSGxsWYA5zX8Sh9UNAFLwGuiT/imM6BrC
         R9mQFac+VH97KaQwvTVFUyfSls8W31AXxPJ1/rJqqaEAIeOvb7BEurdx0hmU/8rmt0aP
         zihApWfpGsfYToKrlOHPomRR+e0ioegtpPqHGXtqUVDT+NODMJZhsKYV5mvXVNiTThAN
         5OYVSyfz1Pg7a89awjA8Tp3x4phGtt3tqLwzIRePuKD1v6poF1Ri5Ktc6pLnCN/4Jen0
         HLuF2Zyh7uMp2l99qD1D4wMgm6f0lY3uBWyVkBgQutKUBgpWHBhryqd/QeTXOCDSNOKB
         bwHg==
X-Forwarded-Encrypted: i=1; AFNElJ+ubC8SUZvUa7G1t5BKt/M1hr8Fqp4UPVvHRy0SJnT7LJyRGudxWbbhjBGcN1qy21La7ifPpxDI6Eg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6aQonR/X3MeY4VQ2LQkrJWvazhiQOxojXTJ3pRGXUZbdqRFgw
	gSOwj9c+9g0+udbH6b8R8SBpKdgodyZONDBxBTfMvu+wZkCC636foerL+NnqPSN3NS2lNmMT2hI
	8CAk64g==
X-Gm-Gg: AeBDiesi/c7RQ/vzHjvEECB6tPtuv55d5ujKI6EJNgLyDdjGluGP/mtTZ1usE5qSpNj
	BSA4kqOSQuIwrjHGOkmO5Fn/288nQSD8X2+aCKIIn2aWkQuiBY8MKCYf1u15dxvG0MiKAfvI3G0
	I5Nld80wAZJuIdYyeU7b2M5lbSYPopEoBGmEMmarIrPLFdXuiiqerJ04nBEvxF5v6s5vcT4aAC0
	NAmsHAD8oHVWLjXredKR0mfvnpVwSL75rzRoh98S8X9bWqfvqepR2y2rH7LVa38Og+8lD/BDIPI
	Bk4BUIDUcHDPPAyMwq+QPbeTIUzPDH+X0af0wg3f9XG9MmLDXA0sH2Y/3IieyzAlvCF9WQ9/vRp
	NdFj7cFtIpqq4tETH4t72gtKGkixMxYLKaw+Iibb5Ii7lM2s+KRXDze+4UsvU3dXd2kC+ShM1cR
	ufHlDufzlTML2fT9fDEuGHMXy1BrWf7qgk2XC/B4XSmZphldsldK9WvKopmUJ3TIh6AoB6VOox3
	JBhraYNQqA=
X-Received: by 2002:a17:902:c40e:b0:2b0:b925:da98 with SMTP id d9443c01a7336-2b97c25051bmr274785ad.19.1777322167052;
        Mon, 27 Apr 2026 13:36:07 -0700 (PDT)
Received: from google.com (195.236.83.34.bc.googleusercontent.com. [34.83.236.195])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b97ac8d439sm2960695ad.66.2026.04.27.13.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 13:36:06 -0700 (PDT)
Date: Mon, 27 Apr 2026 20:36:02 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Gui-Dong Han <hanguidong02@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Alex Williamson <alex@shazbot.org>, "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, dmatlack@google.com
Subject: Re: [PATCH] PCI: Init driver override spinlock in new_id_store()
Message-ID: <ae-_EmuuoQTqD6wg@google.com>
References: <20260427193139.2109938-1-skhawaja@google.com>
 <DI472FJ8UOG4.1JGTQK7W1RAX@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <DI472FJ8UOG4.1JGTQK7W1RAX@kernel.org>

On Mon, Apr 27, 2026 at 09:46:20PM +0200, Danilo Krummrich wrote:
>On Mon Apr 27, 2026 at 9:31 PM CEST, Samiullah Khawaja wrote:
>> Fixes: cb3d1049f4ea ("driver core: generalize driver_override in struct device")
>
>I don't think anything is wrong with this commit, and it seems unrelated.

I will remove this one.
>
>> Fixes: 10a4206a2401 ("PCI: use generic driver_override infrastructure")
>
>I'm also not sure that this one contains the root cause, despite revealing the
>actual issue, more below.

I see your point. I understand the actual issue is that the temporary
pci_dev struct was not init and that was added in 2014. I added this
since this is where the regression happened.
>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> ---
>>  drivers/pci/pci-driver.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
>> index d10ece0889f0..5f453213b8c5 100644
>> --- a/drivers/pci/pci-driver.c
>> +++ b/drivers/pci/pci-driver.c
>> @@ -215,6 +215,11 @@ static ssize_t new_id_store(struct device_driver *driver, const char *buf,
>>  		pdev->subsystem_device = subdevice;
>>  		pdev->class = class;
>>
>> +		/*
>> +		 * Initialize the embedded struct device driver_override lock to
>> +		 * avoid the lockdep errors.
>> +		 */
>> +		spin_lock_init(&pdev->dev.driver_override.lock);
>
>Can't we just call device_initialize() and set pdev->dev.release to a new
>function that just calls kfree()?
>
>This way nothing of that kind can ever happen again; it is hard to predict that
>a device is used without ever being initialized.

Agreed.

yes we can set the release function and call device_initialize().

Should I send v2 with something like following:

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index d10ece0889f0..634b4311bf5d 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -179,6 +179,11 @@ static const struct pci_device_id *pci_match_device(struct pci_driver *drv,
         return NULL;
  }

+static void _release_temp_device(struct device *dev)
+{
+       kfree(to_pci_dev(dev));
+}
+
  /**
   * new_id_store - sysfs frontend to pci_add_dynid()
   * @driver: target device driver
@@ -214,11 +219,14 @@ static ssize_t new_id_store(struct device_driver *driver, const char *buf,
                 pdev->subsystem_vendor = subvendor;
                 pdev->subsystem_device = subdevice;
                 pdev->class = class;
+               pdev->dev.release = _release_temp_device;

+               /* Initialize the embedded struct device. */
+               device_initialize(&pdev->dev);
                 if (pci_match_device(pdrv, pdev))
                         retval = -EEXIST;

-               kfree(pdev);
+               put_device(&pdev->dev);

                 if (retval)
                         return retval;
>
>>  		if (pci_match_device(pdrv, pdev))
>>  			retval = -EEXIST;
>>
>>
>> base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
>> --
>> 2.54.0.545.g6539524ca2-goog
