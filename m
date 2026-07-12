Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF24374183
	for <linux-pci@vger.kernel.org>; Sun, 12 Jul 2026 22:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783894890; cv=none; b=sx1VZC6dvsQX0hRGwliEiONk4tkWDoeHyFor5afXNftj9BPeJJUkznxZW1QlfmxgWxvUPD+NTaHTgJ7XPL57+EbxRRHSrUcfLkRUB+aqVFMNzjdQxLxzKW1BcAjLwTcxYs+Pvz7yxGJNUq0PbfTaOquGY7bPrf1kuVXPWl8oaVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783894890; c=relaxed/simple;
	bh=yXFkHL5kLy0YmcSeIBWJ/pJv7FWST/0rD1sn/vpnnlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+c/fnzh2OhYubO5jDISMNt/almudaFcm+0oIo4octF6lEZS2uL2Z8cU1VJeJkmOnpvdoMdhDZaRsORVOgVKKsWPJimJJ91JUu3V2AvtpXNQGSowzjgF7XOxRiJHMAPoYuLRN1X36YOkdBUY6QVpV7gzXCB3yvbbAAvR26FOseI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=es9ZEdAx; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="es9ZEdAx"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so17879865e9.1
        for <linux-pci@vger.kernel.org>; Sun, 12 Jul 2026 15:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783894887; x=1784499687; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yXFkHL5kLy0YmcSeIBWJ/pJv7FWST/0rD1sn/vpnnlo=;
        b=es9ZEdAxIcbFw1bX0rbFbs/J+Hem6iEGnVb3ZzpzC6RcVxDjUV+idFAKIpsFC46Bym
         A/NJGC+TpeGR9uTk1yl0cZhka+XaPP+4x/WdCcJiokP/wRe4i2mas4FhcRYPtdH8QVJs
         V7GDZ0OS1F8cBp81RmUxJEsc6UpLwZQSLvhpd8E6dy5KxXeOLZdyAJolQRvZNyEKSW1w
         RUbJsV7SWWKR71oOuu7yIRX91gqaRGW3imRr91cViZbhhGPRcJgN1gZRoli/a8HMzAwq
         AeDHppeB6kJ4VXUsBKiopTipGR5RjYeWx6PPQPAXjR4DpMD4kr80exOPMvKiY3ehJRdP
         Y6/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783894887; x=1784499687;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yXFkHL5kLy0YmcSeIBWJ/pJv7FWST/0rD1sn/vpnnlo=;
        b=ZBKfGx2649yFG+0d2V4G/MNivl4Q8mRxku5VFw1jOuC9ri/ZuFd7dUCt8AMcfMwzgX
         6xYYPQtEEvgVBXwohmZCMukTUJNg0QXCZRRHuWimNu8qP27jXeK1l0ZPwE67c4roedAN
         q26hM2K3pYQsuqYD+yhWD1ixzUj+BnJ7ZMGOvN3W/QZ2RDqsp3Krm80uQAGCt/J+XX7u
         Ys/ExDJZZBb+R2yATfp+Epue5HjIVV2MfQ3qgIE1IMk7G+ZKhMlmvVn3umF81GEspXkm
         Mfl7Q9N57i4bVeJ3m9C+70syFljCxR76SBTggUE3joDEV9RtsorMm5LHe61+h2fq0Iar
         yl1w==
X-Forwarded-Encrypted: i=1; AHgh+RqxetXoJLg707j+vpxF/n9o095iQJSRPAXJE9XGkA4LW/2dguvKQsceKDIOUcAnFC30RbgbMUiNZKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcaCCK9tOEHd4PXDNDfEmLvXpF/VuTcKNVO0o1TH7K0dIHNeIg
	uKswzfWzkoQz+N8Jl33BRomb9qobTsoZWR9eAOTCCdG5hyWBGDpXt6a4iEBtwQB7hTg=
X-Gm-Gg: AfdE7clhP7yYyRvKaELH21aAAmP1Tdi2lF6R22xYsJICuDapHRG6wiMlJSUkBPys0Xh
	PBW1K/RBXoFiRONJ76dqJWtv/5o4J/nOSdOPZ8hTrIwKG/8mZ2ya6z4WZPv5mZ3/rK64JUMt4cA
	tWRirnxbclfjLHJaEsBsVlRF9dsyQSNLHtFGqUmDKcCH0R3WhZ+P5qMU4k3RKAUT/iPWIUQ6dMk
	Gst8c7Ys+OrdXyau/MJr/YvBQpZa5pFg604lb+5GDBVh8zTPcYiXsK+iZz49woIRomrxLHCTyZH
	7LHG4Dr2rgN03L+b0j1XU62mfXEJqk7P8T1KhkxizjcQReprznhGHXjWO7w4mn5tbNN1mZ6WFdf
	hN3lJMz3/q+gZiGY6FSThP8wxep3ta9qr4olYg0vVdxMlrBtPehlxxGiihTQjAwtPl8R2h5tfl9
	xhclOx4xJ+TQGfIoDjxg==
X-Received: by 2002:a05:600c:3543:b0:493:f6c1:2f09 with SMTP id 5b1f17b1804b1-493f87dc753mr64927015e9.6.1783894886966;
        Sun, 12 Jul 2026 15:21:26 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-493eb742a49sm296924145e9.12.2026.07.12.15.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 15:21:26 -0700 (PDT)
Date: Mon, 13 Jul 2026 00:21:24 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Ahmed Tiba <ahmed.tiba@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
	Hanjun Guo <guohanjun@huawei.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, 
	Saket Dumbre <saket.dumbre@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, 
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-edac@vger.kernel.org, linux-doc@vger.kernel.org, 
	Dmitry.Lamerov@arm.com
Subject: Re: [PATCH v7 10/10] RAS: add firmware-first CPER provider
Message-ID: <alQTUuwze5ZjGabk@monoceros>
References: <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-0-8b3a85216cef@arm.com>
 <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-10-8b3a85216cef@arm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o63zw6szpf3k5nqs"
Content-Disposition: inline
In-Reply-To: <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-10-8b3a85216cef@arm.com>


--o63zw6szpf3k5nqs
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v7 10/10] RAS: add firmware-first CPER provider
MIME-Version: 1.0

Hello Ahmed,

On Wed, Jul 08, 2026 at 02:59:09PM +0100, Ahmed Tiba wrote:
> +#include <linux/mod_devicetable.h>

Please don't add new users for this header file. Only use those
<linux/device-id/*.h> that you actually need (if any).

Thanks
Uwe

--o63zw6szpf3k5nqs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpUE2IACgkQj4D7WH0S
/k5Aagf+IcCM3MbiQFXq44EFdGthF9zwEU47GU8P9/gSXah2GXOz59WKWZqRlJgo
j4mZ9uRbJqwLqZ7OtPIZj1IyEY9Bmeix2uL7sJuVUBcZ2qRaX3OxW/xi8zEaH0fi
1DgPWPB5MHOhvc5d5JJAeoqaV3TCXNxNEF8uvyiaGJWFIr7oGvWZVJCPTmjbqVt8
vzyFYzCac+qNGAzM6F6FhjNsegEgpsSAP2XIIruYv2+iPpHWzMbx+LpknKOq8Rws
N/Cmj3SBH5ULfApKqkL4QqeHk6RnfAclAjr/EdYS7nE6L5Bdot9DOOil56IDxCps
pX4u0VGI9OqUoeIeIDXaS9GJsG261A==
=Eag/
-----END PGP SIGNATURE-----

--o63zw6szpf3k5nqs--
