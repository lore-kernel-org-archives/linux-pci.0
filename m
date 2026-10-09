Received: from mail-yw1-f226.google.com (mail-yw1-f226.google.com [209.85.128.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C943264EA
	for <linux-pci@vger.kernel.org>; Fri,  9 Oct 2026 08:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791534193; cv=none; b=rz4JGDpV/nYYjZnRGux41WP1RHgf/EXZIfkplPvr3NTQbJSv83FDwG55tN8FL0nbJLs5loZifPaV/h1ENxYL+R1LtWTws+y2pHBxyNwb6GKgx6xWO5tpSWtEtmOEqxJeQiWGhm+5azXxeN4/5aenUgyg6qwYKbWPOB0r3QyNQCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791534193; c=relaxed/simple;
	bh=mHjuxP8No/svkLEibCC62pe0HCMEBgSlND5KAB66MxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWruuo6drkDK8FRBzFiQbuAqqiXS7upfdEmv5s89K9389R4YvlZ3pV3nRL9PCSye0eyrGRuFGRITRu3ioWkMRgc0hGKP5uIWFzVPdIOaYHn9aD959DN0nmlILRw0rAolwrGlJdK9ut7I9oSg5NWg35fBE5OaHJBO7H7FF5ok+fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org; spf=pass smtp.mailfrom=cavan.codon.org.uk; arc=none smtp.client-ip=209.85.128.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cavan.codon.org.uk
Received: by mail-yw1-f226.google.com with SMTP id 00721157ae682-8ac4806e210so37097257b3.1
        for <linux-pci@vger.kernel.org>; Fri, 09 Oct 2026 01:23:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791534191; x=1792138991;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=U8iFS6pM3tthaseRuGrSd+8pptlyySe0KSW3rDNx01Y=;
        b=yDs/fdpUvLBY9h6IpERvk8qP0LRKdti4FuSxfyitrX3hOUq6yOEQLMSnWeopicnuPS
         iXQQBJfo1B7mTyvjjSw185mI8Tx4QsWVTIIAOH8OKi/IOqPlO5yhsSIVozB9aBdoSEuE
         +tixQxcboQwwoyQujLhG40yVyelogZFqFmsBEEmlwceWyFALpdkYJ1lST0sH3TZ7Yz2l
         UM0LMZPu+EbbVKswhN1cQyxD8NpZzF2hkX82Yem2sN6TpogfofV8Bjzr6wvByW0NqpkV
         iW0XRKfvRiyA3lLuqi1SUMKj0CmlF+3w361uhljheTy5ohXyztu3rMyZeNW+wKbuxwWh
         07aQ==
X-Forwarded-Encrypted: i=1; AKwUvByzUL607DbeO6sgp4/3CjdHI08S3WZ5XsTLt7O0PF1AWeZ+mdG8qrLQPCQB2+EHZ/qQHRNPMIC+Eg4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ4NF2So8liCZ1Ncp0zBMKoO+2RLE3WU0P8QIpc4mgOuU4aZaGn
	jmZJnUj7kivijH63BbdNKJY72M1JqJNQhtq6WyRL1loA3n7rPUuOewJg1yVEXjWV7MVCOSzaIR0
	6aWtmyqSntfg5yJYbGhsQbg2Yg563/j0X3wlQCGQcXh5XyhAUJaaC
X-Gm-Gg: AYBFou05AOCjKEUCMPlVrEjwxf8QhGBFNiTi/QoStiuC13wvY9HAUFjEDJeHjY8sA12
	CRxnx0bHFnaMZ2rCubk7wHDsGO12z+pT/U6YI7K9ddHLypRKSiwPaXFlTUcblStEbBOqW77ErXt
	4UlRohQVIGGqHo1F9LFTwfbvsyllwWObyeYRRiCrGzRun1I1RMg6x3VjsR7o8VM86HcXS4z58PV
	dYEvpAnOKGgkjGqNaXx+d6qBKXWYcP+5OMFKWh2moyRszgFZSp7qrdylCBv05UK0tHdfdcYdb3l
	YwtwtqzTl3XSL/Q5DkRzM62r1pmfJWVVccf5WT7NDl5mKBbP4hgwgOHONjRTFdpbh0jAo2NyPTA
	MkFs=
X-Received: by 2002:a05:690c:4142:b0:8ae:6740:99a with SMTP id 00721157ae682-8b07ed4e93amr3514097b3.30.1791534189243;
        Fri, 09 Oct 2026 01:23:09 -0700 (PDT)
Received: from cavan.codon.org.uk ([2607:f598:b99a:160:8a88:88ff:fe88:8788])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-8b07f329510sm59467b3.43.2026.10.09.01.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 01:23:09 -0700 (PDT)
X-Relaying-Domain: codon.org.uk
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
	id 27EC31286282; Fri, 09 Oct 2026 01:23:08 -0700 (PDT)
Date: Fri, 9 Oct 2026 01:23:08 -0700
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Francisco =?iso-8859-1?Q?Beltr=E1n_Millal=E9n?= <fbeltranmillalen@gmail.com>,
	rafael@kernel.org, bhelgaas@google.com, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, lenb@kernel.org,
	linux-kernel@vger.kernel.org, Darrell Gum <d@rrell.co>,
	Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Lukas Wunner <lukas@wunner.de>, linux-usb@vger.kernel.org
Subject: Re: [PATCH] ACPI: PCI: take native PME control on Apple machines
Message-ID: <asikbIuZUZsgmU52@srcf.ucam.org>
References: <20260924132859.24751-1-fbeltranmillalen@gmail.com>
 <20261008232912.GA940274@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261008232912.GA940274@bhelgaas>

On Thu, Oct 08, 2026 at 06:29:12PM -0500, Bjorn Helgaas wrote:
> [+cc Matthew (author of 7bc5a2bad0b8), Darrell, Andreas, Mika,
> Yehezkel, Lukas, linux-usb]
> 
> On Thu, Sep 24, 2026 at 10:28:59AM -0300, Francisco Beltrán Millalén wrote:
> > Since commit 7bc5a2bad0b8 ("ACPI: Support _OSI("Darwin") correctly")
> > negotiate_os_control() skips the _OSC handshake on Apple machines and
> > hardcodes the set of features the OS takes over, because those firmwares
> > return failure once _OSI("Darwin") has been acknowledged.  The hardcoded
> > set is ~OSC_PCI_EXPRESS_PME_CONTROL, i.e. everything except PME.  No
> > reason was given for leaving PME out.
> 
> It's clear there *was* a reason, but I don't know either.  Maybe
> Matthew will remember?

I /think/ this was the set of parameters that my machine would hand over 
via _OSC if we hadn't called _OSI("Darwin") - but it was over a decade 
ago so I can't promise that's the case. I think this probably needs to 
be tested on some older machines as well just to ensure there's no weird 
breakage as a result, but if PME is actually hooked up and there's no 
SMM managing it instead I think that's fine.
