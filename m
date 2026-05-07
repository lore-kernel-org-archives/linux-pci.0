Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025CC391844
	for <linux-pci@vger.kernel.org>; Thu,  7 May 2026 09:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778144913; cv=none; b=nYKGt0UR8GSwt1ZJnVLpJ8JKq1Ote9nBkuRkrGjimRswxwdeZgN04tZUfzyo/G2jxYs60LdCxCkpLl4kqPypEh6b3S8gZrOIZre146e7j0On2IX8u69OqdJea8M2Nj6t0sJVQnvfWXDzRSn8Xq85ciF6nNYym347zpRPOVVMSFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778144913; c=relaxed/simple;
	bh=6KNYU1WpeWbZtLaI95Q3FSHorYk7ZzRQOvKRN7EcI9c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mN3cGjUztT9RezuDwAQabt6jH+wGtdte+uEpgsv6o8n2XTWLXH93B/rUVLyG51JnFBISnmiQcgOpzeVSujX8LIJ9l+sQiczRg1bNAHv6nDqAJgqEofsqaULMSveOEIRhB8UCBFHMDE77YiawgAJj9D+NW4F8bjW3Hf906p/jhn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NxheRe1i; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NxheRe1i"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso5583085e9.3
        for <linux-pci@vger.kernel.org>; Thu, 07 May 2026 02:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778144906; x=1778749706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8AqCHUecRdMHaTSiwSFKRzA+aPKBe0J8V8U1pAN7qQ=;
        b=NxheRe1i9m2sCCP55ucTBUdx1urWhohFrPkwD4vBI2HOdw4eg+P8II9CkHEe5txdp+
         XkWbVrqMHS9rPml5LOR0L3FaQjhmpZEhUeQfEx4NsC3t8B6rGdmoct7VFHNnGwyc3+WP
         Xz6dpU6+9WtBf8Bgr8My5FX4rDZ24MAf7s3xSqFe3Ldy+Ux15aKtB39mxZrKPrblNitE
         trusfVBCNaTesfP2fz48nJ2DxZ76xtU0aQejmDchHmxbdKEqu2W/NuqNsHO15cLPkscf
         J5/YSXNnjqCUBeOjOTXnJGncT3ANWGG5fRBrOOgWpb3jtQ7LnyzyhLFSf3qZVD45eUmf
         119g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778144906; x=1778749706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h8AqCHUecRdMHaTSiwSFKRzA+aPKBe0J8V8U1pAN7qQ=;
        b=k2JaHnvmuMU7C66tE5QcTRJ3e/UUd5/ZCaUWM2yytKhmLx46tjKVeJnt2ifh15Fanu
         j6LDKVcwnEPG0CJvwx6/OxHhcBFf3gbImRCQn1ZblMmuirmhE4cCnI+A5YHHCTfUAbZo
         UphX5EVfaFdPnMCi5xHCpGx4IdWYDgQDWBd9JwJn+pmxDvM+iG4BUWT8U1Lxz/2u+oum
         ellhzdeq8i2w+JBO6TV0cBTpA6wGmDEDGahaJNtNGfkPlqlifZtf5X9vPKGnYRioE3r3
         QeUdoywhMlOJeNqSpbGgK/x2cKEnA8B7TtCj4f58UrLEXdNhFta/2+/8/llYEw1O4f71
         jxcA==
X-Forwarded-Encrypted: i=1; AFNElJ+lQQBNJ1xqfTr6RC374PCAfAqJ7MleaCxZitkWu0Em+BTgreqkqh66ul9peHpGlXFKEqfiyYGKRTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM34hPDuLc9HARH2yGQK8p7zNZsJtfMqeLu1g1DoIW1doHt3oo
	4XbIk1DnwhG/cg4TLKMMUbq4sVq5oB7Kcun67T04Elt803IW89plxAvn
X-Gm-Gg: AeBDievloHlHiXkHPkqOKRwXQvDsMWgtc/6TNgL1j5hJyCv5aZc4UiPQsYdwUIdEgTn
	92Lq7pSPWzXL4MkIw1VzNu36blSUdFK653E/GKvqWDPls7T8nYIRP0f5UpxlVwSv0wId1/AKUJN
	TWqR80PrxxddQiD6LHrst7whyHrEQpz6oWnqsLJF2xs+N2NNMwsOk6KgQiSGdE/mMqIYYnpOJQp
	f3wGZpJmhMZawr7FxdibdVgcVGyi8eYfOJ4rxT/q/DVxxrvv75PXAPMK4uLwLa2vZbgSLvielfD
	bB53OI5ia/O6gENwlR7fyLViDPSWfqGf6G9wOlpGIV/q1iunJ3+ky6s6/3m5igkcoa6CZVn9/3Q
	YlCim6dQftotEKh7g2udOwxANer0MjpXdqaE6B7gvoBwsb5bI9YAnd2qROYEeHSkEgn2B6yOBjx
	46tR4ei7D2Odd0yRmediMUCaggfJ23Q5GQjwxhWUpcOeOarg==
X-Received: by 2002:a05:600c:46d2:b0:488:b187:3c with SMTP id 5b1f17b1804b1-48e51f32c65mr113284595e9.14.1778144905786;
        Thu, 07 May 2026 02:08:25 -0700 (PDT)
Received: from foxbook (bgt227.neoplus.adsl.tpnet.pl. [83.28.83.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e53895cb5sm102053505e9.1.2026.05.07.02.08.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 07 May 2026 02:08:25 -0700 (PDT)
Date: Thu, 7 May 2026 11:08:21 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Jihong Min <hurryman2212@gmail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Mathias Nyman <mathias.nyman@intel.com>,
 Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Basavaraj Natikar
 <Basavaraj.Natikar@amd.com>, linux-usb@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] hwmon: add initial support for AMD PROM21 xHCI
 temperature sensor
Message-ID: <20260507110821.07480da8.michal.pecio@gmail.com>
In-Reply-To: <424c4dc4-1810-4ffb-ae93-7ec9f880ec1e@amd.com>
References: <20260506032939.92351-1-hurryman2212@gmail.com>
	<cover.1778099627.git.hurryman2212@gmail.com>
	<2e2ea249b30168a2eab62fc110c226a511f21bf2.1778099627.git.hurryman2212@gmail.com>
	<20260506233332.664f220c.michal.pecio@gmail.com>
	<424c4dc4-1810-4ffb-ae93-7ec9f880ec1e@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 May 2026 16:36:49 -0500, Mario Limonciello wrote:
> > > The temperature register did not return a valid value while the
> > > xHCI PCI function was suspended in testing. Keep the existing
> > > behavior by default and allow temperature reads to wake the xHCI
> > > PCI device. Add an allow_pm_switch module parameter so users can
> > > disable that behavior; when disabled, reads do not wake the
> > > device and return -EAGAIN if it is suspended.  
> > 
> > Is such behavior useful?
> > 
> > Maybe the driver could just disable runtime PM while it's loaded.  
> 
> I'd encourage what we do in amdgpu for dGPUs. The hwmon files will 
> return an error code (I forget which code) when the device is in
> runtime PM when called.  Don't explicitly wake it otherwise.
> 
> This prevents someone installing a sensor monitoring application and 
> that application "being the only thing" keeping the dGPU awake.  If
> it's awake already for other reasons (like being used) then return
> valid data to the applications

Well, that's not a dGPU but an xHCI controller embedded in the chipset,
which chipset is more or less active all the time (includes bridges to
PCIe ports, some SATA controllers and mabe other things I forgot).
Is the saving from disabling xHCI significant for a desktop system?

Users may be interested in monitoring chipset temperature even while
not actively using USB.

I don't know what are the conditions to put GPUs into runtime suspend,
but a USB HC will be going in and out quite randomly, depending on
connected devices and their workload. You may end up needing to answer
people why their sensor only works when they turn on a webcam :)

Alternatively, would it be possible to bring a suspendend HC into D0,
read the temperature register and then put it back into D3hot without
bothering the USB layer to fully resume and suspend xHCI logic?

Regards,
Michal
