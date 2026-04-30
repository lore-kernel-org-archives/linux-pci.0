Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBBE383C96
	for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2026 09:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777540482; cv=none; b=kdnQwfGEPd7M0WiD+y6uV0xIT9WMKoxnBCLqEmvqUAJt7x0CCph7hDfCRu3jWZtXDK3bEmy8te47xR/CNTNVLJq3GUbrcMCf6z7Mtds/lIMBW259UVV+x6VoqSl+6ZPQvXBMa8R/VDV5ekLA56Ft2lqN+czszmmLC2lSdgquQ/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777540482; c=relaxed/simple;
	bh=sVifEoF/oe2xdwrFV3e2F++qf+hnysQw0CLe/H5O8ts=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CgI33NTnV2GGEq4Lsb81n/YS9RLTo+eioDTL2tdcArhCxkbO2p8XZhYUkB5LT8DtmLH9t+Kg4LX1D03SWY7jol83x8Q/Ec1/qQM432wSBzZtYFrPr3XaMLOQ0VdBGwtDqXP9BN1EBnX926+Z5bj4cr2zXYthWPo10dMec5eCxXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oyv8AkPs; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oyv8AkPs"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b844098869cso52801766b.2
        for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2026 02:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777540479; x=1778145279; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9iVxD0Q/b/KabKpN0s2yCS+iq2LiFZxDqstnJNGVdg=;
        b=oyv8AkPsHabnMIV2gaNFnlzQc7xrQlMZgaZRZv4GDJQcYvMUaXHM/RO9yJ2bc2jj4T
         4vyP02r61SvFmNzPaqqQB5zp4wJ4Jn9GBtoLghe2AeP1rMjKW0mVVLZbVWJaAN1D+YIV
         SRrLurtvNg71bHVocgvwQ638x4pJwSZKEXv4qFJ2ujy8HcyqXKoVZ5n6kC8ZmJ8KqvBf
         i50jTzeHoSSzljxzAMYyN5bDx1uhA7CRLdB4hCJn3XGebZIPGC3wPfJQ6cFj7CQpV092
         GzD2MfH9q63Tn/rCtUJ4JYJbEgu8C6jWe58jefapJp+YktIaJ1zNTjijJi+JpCCw0tUx
         kcPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777540479; x=1778145279;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9iVxD0Q/b/KabKpN0s2yCS+iq2LiFZxDqstnJNGVdg=;
        b=mLilJi2d5cP/sYYx8tgPvmnxSK2ENMP1CXwWe7EKRM8/lFRg064yoDOptEZ5Vdz8Lf
         Isnwf15VpqVimPg5tREBjjQctI8tNa57OshR97qABzRT/6ZcdF7tvwxkufz1s52b89nV
         rRQcBkt4+lvILkVq8rC1AqRqiByVGoG/bNr0TFip9CA0RkTaxzpQOmXbaNpWPkPTPhYi
         b8GeJndqVorxlxUV0y9J77zEHRpWVaC2rkF+0g5DdiBfs3moxKTMPcdcFT9TSQdYHgoX
         bDtp/einYm1Q8fQxiAEskgO2KwUTWKm26qQTWZr/EkQrJ74RA3uIIp46c1/ywFcKKq1a
         qBnw==
X-Forwarded-Encrypted: i=1; AFNElJ8mIRIucHSketBfwqeKILHuJywqQBPxT35D0MkgA6LKZpaokQxsXBgYes/5CxCtsAwHK5kHCjASQe4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMRIsilOZ1NP3yJ3GTvDAcrwfu6aX6prdGySrSdU4dFNgTAwiw
	XprFMYLnDnDUnfhTHUZEJKmeV77Y6wyy9hfDdSaUL9+7T1bXzcT1XpJObQmLqhbKaPwbu2aWpJT
	wDX9ylbX1x4TmWzv7Xw==
X-Received: from ejcqw42.prod.google.com ([2002:a17:906:6a2a:b0:ba5:8db:d6f4])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:7b98:b0:baa:2d37:cbf9 with SMTP id a640c23a62f3a-bbac5abfee4mr145636666b.1.1777540479322;
 Thu, 30 Apr 2026 02:14:39 -0700 (PDT)
Date: Thu, 30 Apr 2026 09:14:38 +0000
In-Reply-To: <20260427221155.2144848-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260427221155.2144848-1-dakr@kernel.org>
Message-ID: <afMdfs0segrRBx34@google.com>
Subject: Re: [PATCH 00/24] rust: device: Higher-Ranked Lifetime Types for
 device drivers
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, acourbot@nvidia.com, 
	david.m.ertman@intel.com, ira.weiny@intel.com, leon@kernel.org, 
	viresh.kumar@linaro.org, m.wilczynski@samsung.com, ukleinek@kernel.org, 
	bhelgaas@google.com, kwilczynski@kernel.org, abdiel.janulgue@gmail.com, 
	robin.murphy@arm.com, markus.probst@posteo.de, ojeda@kernel.org, 
	boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

Super cool to see this!

On Tue, Apr 28, 2026 at 12:10:58AM +0200, Danilo Krummrich wrote:
> Before:
> 
> 	struct MyDriver {
> 	    pdev: ARef<pci::Device>,
> 	    bar: Devres<pci::Bar<BAR_SIZE>>,
> 	}
> 
> 	let io = self.bar.access(dev)?;
> 	io.read32(OFFSET);
> 
> After:
> 
> 	struct MyDriver<'a> {
> 	    pdev: &'a pci::Device,
> 	    bar: pci::Bar<'a, BAR_SIZE>,
> 	}
> 
> 	self.bar.read32(OFFSET);

I think we should establish a convention for how to name the lifetime
early. Using just the generic name 'a is probably not ideal.

How about using 'dev for lifetimes that correspond to the lifetime of
the device being bound?

Alice
