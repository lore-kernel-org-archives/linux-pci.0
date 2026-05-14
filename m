Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B283B3939B5
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 19:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778786556; cv=none; b=Og5JNXZN1/CLHE7vHoSZVOTRH8gRbZqdnt46Fx/b2/Vz4llusVqwWR6wgCrulPezhP4+NhIMibIitEiRHPBXTyEANbkHJUYMxaXyGlDFer4P84k5oa9O/pjNn6o+rNClqlSaAOoIlBKv7vC9Gw++oF16wbtNxJJJFjRstxhxl/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778786556; c=relaxed/simple;
	bh=tGxOYv9Nyd6eZG66QUGsC8xf8ANNtJniWajQdhHgGys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ck6MAV6W50O1Awgs5Lwe2HU4+AoNfYxxF6BCxxGjjCbVOIIUYatTBksj1LPbdh4zwMBBKzoar/N4AIwelox9BAVlN0yRnSWUQ4tqwxfJeHkpVOz3z2mfdyUMMg7YtmZbo0apoW2syW7HayTGSiPv4Zq38boOufFvm8M8ThXSkwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iOIBXAtU; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOIBXAtU"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2f03d6cf77bso9528150eec.0
        for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 12:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778786554; x=1779391354; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=swoWvHLtJzwRweupdjBAQi7lnJXOta8L1pMLFBh8CXc=;
        b=iOIBXAtURNcntTYXfsayZk9wB7D1KVMBypj9MvTVqPpCVvPdUThdDtl+8V+PqQriY9
         wySBJEqE0B7Bwdwz+IEFhFDgsq3fyxlTiThlEgq50z9CW3c1n04YI9K+Vk/Y4TYSRIcC
         /qVLSX/7ySRtXofUW+6ERWaybQ4tCrm0HVdHvUqVjZmdkgfHudIY05mkcJyCoN3QWDr0
         HmBN92lvLPHu90i0RjeeTpBe8XPVlij9a5nqylQ/tiAlfSJkz/ob0mizAhwbN0hyNVky
         wIXyyjupiTKCQylCCSaWKiBPfsW38uca2Qjvm71O5N9aD2wTmx9KaLJ3UukV2nvXg8bK
         1+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778786554; x=1779391354;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=swoWvHLtJzwRweupdjBAQi7lnJXOta8L1pMLFBh8CXc=;
        b=i6Ie8QeYKaa/8XIcAabteJQ1Y3WO2l5xckt1akvdqaefIjNHB+cuLjgeLeeugCErox
         JJzCUCQzJQXWMnvYHIqhLCo/Cx4dae84ghVj5KxCFcqHq+C+R+CzdeKhtLnhTYJ1x2No
         bLZOtBeeka46OFN8gzuCOOM7nMbxLhkFKwZ77twncH4WSqrO0aEpXgrQSvUYJcUWY/KV
         cc/yXRRXUxcVQu+abKW5sE7m52OWZi71Y6o/Xblx8jiXgrng7DCjVShbDcrB8A6W3rnK
         f+VkD7a2Fded0PjVPcMSyTwInPYrv05Kpznt8SklKhk4ds9K14+Bkiwto8zoy0CUp5b8
         GE/w==
X-Forwarded-Encrypted: i=1; AFNElJ/O13W5nmWRRauhBwM2XQbG906q07j8D5kEwu0e3IVv0R8tdvzeCkJBg/GjiQbJtkfFl1/FbrP5xog=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdJHrBsYFysgKxF1m0S+pkxUvkgi2sL7TxFOZqcX6Z0VvezGOw
	9Tl81cLauBG+QWmXrkcafXvo7NHH616Thr0fIGZL8zdppLYfmkmIwRNn
X-Gm-Gg: Acq92OEGjij8s98tfOxxdZ8wxDJyXLIjBnV2loyA4xb4+fnyjOtwXA8xTPReRs0sieY
	v5W/86TVz/wY67NJSDVsyXQZUHm0oipCRSXgNv2bbPX4CGN70x6/4MgwxkNDBm3SL90vCfX8zyR
	Y4Ce34/sF2bqwD1DvJOIFDZ//DnpqpqGvjTw4Z5GOuDzy5DpgnsyjtH/zHEFhcFfxJ4fWshWNMC
	DV5ec5kFq2Q4OLHY42zTHQUwXnPb2T62Mf2DFOr7owY7S2UQYMlsNJRM9CwEJHw6ZhiIRMrR2Mr
	gYj3Bptyl13q5soiQa2Q609JcDh4riijf6iBE+fiuHcwpiFqqY8OEBKXh7FZZJmAeBiIRjixD68
	y2/dY8YFHn04m55R0DoABXvcOrxx/TDRXvezyC88LlqHE2lky7iTdlMzSJbRdvfIchJ+MFBewTm
	lPyoSywxEkTP9h717R4ufW45hNZZfvAiUyPju6gMvYKm8hjbM=
X-Received: by 2002:a05:7301:3d1a:b0:2da:1a81:588 with SMTP id 5a478bee46e88-303983c6515mr406657eec.14.1778786553638;
        Thu, 14 May 2026 12:22:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30296dcb6adsm4623993eec.15.2026.05.14.12.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 12:22:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 14 May 2026 12:22:31 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jihong Min <hurryman2212@icloud.com>
Cc: sashiko-reviews@lists.linux.dev, Jihong Min <hurryman2212@gmail.com>,
	linux-hwmon@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 1/2] usb: xhci-pci: add AMD Promontory 21 PCI glue
Message-ID: <8cbf1ac3-bba5-4223-8425-62aa49508c63@roeck-us.net>
References: <20260512213910.871859-2-hurryman2212@gmail.com>
 <20260514004055.1BBCAC19425@smtp.kernel.org>
 <110e9a0d-bc91-4959-8a7b-1a055d0b49f7@roeck-us.net>
 <1173f5c5-a740-4458-8e08-2c427a704207@icloud.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1173f5c5-a740-4458-8e08-2c427a704207@icloud.com>

On Thu, May 14, 2026 at 11:29:36PM +0900, Jihong Min wrote:
> 
> On 5/14/26 10:20, Guenter Roeck wrote:
> > > > +    prom21_auxdev->auxdev =
> > > > +        auxiliary_device_create(&pdev->dev, KBUILD_MODNAME, "hwmon",
> > > > +                    &prom21_auxdev->pdata,
> > > > +                    (pci_domain_nr(pdev->bus) << 16) |
> > > > +                        pci_dev_id(pdev));
> > > 
> > > Does left-shifting pci_domain_nr() introduce a signed integer overflow
> > > regression?
> > > 
> > > The function pci_domain_nr() returns a signed int, which can be up
> > > to 0xFFFF
> > > on ACPI systems. Left-shifting a value of 0x8000 or greater by 16 bits
> > > alters the sign bit of a 32-bit int, resulting in undefined behavior
> > > in C.
> > > 
> > > Would casting the return value to an unsigned integer, such as
> > > (u32)pci_domain_nr(pdev->bus) << 16, avoid this overflow?
> > > 
> > FWIW, I don't think that is a real problem. auxiliary_device_create()
> > takes an int as id parameter, so the result would be converted back to
> > int
> > anyway. Maybe use "(pci_domain_nr(pdev->bus) & 0x7fff) << 16" instead,
> > but I don't know if that adds any practical value.
> > 
> > Thanks,
> > Guenter
> > 
> For the auxiliary device id issue, after thinking about it a bit more, I
> think
> a simpler approach is to avoid encoding the PCI domain/BDF into the
> auxiliary
> id. The auxiliary id only needs to make the auxiliary device name unique;
> userspace identification is already tied to the parent PCI function.
> 
> So instead of:
> 
>   (pci_domain_nr(pdev->bus) << 16) | pci_dev_id(pdev)
> 
> I plan to use an IDA-allocated id:
> 
>   id = ida_alloc(&prom21_xhci_auxdev_ida, GFP_KERNEL);
>   auxiliary_device_create(..., id);
>   ida_free(&prom21_xhci_auxdev_ida, id);

Other drivers only call ida_free after the auxiliary device has been released.

Guenter

> 
> This avoids both the signed shift concern and PCI domain truncation/masking.
