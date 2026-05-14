Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4524939E184
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 18:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778783968; cv=none; b=gkI6eNdRu7u6U6XkqdSDxg62pP+Cx+4FiIPpYm4CZrMk535JHGag0iUfWUxYOS40t8xxtn72bneq8pWRBKRCDCAz+zblARk/GhcjvW4S85TLAq+Iz8/4t7WScwYvmPgB8QXwM/l/kJ/SKqMu9QHHH0qUCGg/zbYJVrYqfTqz+KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778783968; c=relaxed/simple;
	bh=IrF0zGrTHmpd++IPJHJubaUM4ePJN6hA/bybSS4Ofz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hCj/py0AZPNuZLok3FcR8bKyQS2AXop12KDQ63aZe3C6pU44s5gEfrpQNbCfd7MmzibOfFIxPvnEI1OQQ0Ji2J9m2ke9cLKnCB29SvbHqjkdof7zAFwcMqnWPcaRMwBwr2ysAqzvd9yxftLyHVXiH9PjGZkvHsStftAjn7ajN3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oktT/2bO; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oktT/2bO"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8379e010b01so3709933b3a.1
        for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 11:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778783966; x=1779388766; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lLOCOr0MLE6BsBE2JUx9eHh9btnIM0Pqg1T53aQwE2M=;
        b=oktT/2bOGngaOZbyc1bGvG6ObOMcAOiXB+hG5FXR0Y0BLqvQb6I9+E+Nuv1w+AiVub
         lX0Od10rC9g26LYFsVI0I3BJhwCcmSQ2jpD1pBYUGenXN+C2i6mw8FvxoGH4jqQllgZ+
         1zQQx+urO4KeHFfkripg6/Hp2VyleHtitu8zeLDbhMmoMP/VkV9wE0j3GH2t6QCHYO9K
         WNPprZqd0E0HAo5ZzY7o8uc8EsVPewjJZKTMBjoGX06l8po35CrS01GxLgW1T4AtDZFy
         fuH443MAUseUwaDCMqW3dy1vdn1lEoEsUkcrKbeR9eg2MY1a2ZleeHj2MaFcCTckj8pH
         aGAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778783966; x=1779388766;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lLOCOr0MLE6BsBE2JUx9eHh9btnIM0Pqg1T53aQwE2M=;
        b=gtu155ePEQ5U8bVf8yegwjChUgBNXlmJEH/dXlMqnICs9XLA4m5jPCiQOXup4Vr+6/
         vsS4Q03hYl1le4JsSGv6iu5tlnjdnr0wZrmlzWYwgS4dTRAfZq7EJ4XSipuLLWF/43tG
         x+EnfahK0LemaDh+G4b1UBD25aMpeJE1Egbfv8OgP7Wd33SbaD0czY08zHD4l/kdaF67
         JbjZVZZ+KV4gLI2CcHhkAlIL5YjC6N1YqJpS+Gse+OjNUfVtkZWcJ2vnNm/YveRzr1tG
         JTaxgYsjg8F2RKVKgI4+mJB0ZCMBkdQihkfW9EU5aDLFhJdx7rGBgVoO0Nq1yKR3zw1f
         AwMw==
X-Gm-Message-State: AOJu0YwVCMMKo78SRa2xEaWmfD30qbOySpBQup3u5C5mTg8b8FFItW7N
	zsPzeRH9TC/JawfawffO9pIvNNi/1bPL8o8bAnOXKP0+odSg3I2uc0LytK+TudeFEQ==
X-Gm-Gg: Acq92OGZcLTdF2hgmAKdoFUnmhTN6BXgDv6q/+qkWiGAsfGNnCP2Gzsy2Jnpwxs1bfx
	3kUuc5UjSrZxGf734+ayKt9u3hcvw1TEPeQObl7vmESeKQYO1XJEe9tqv6oqkPirF6G0+WQZsZO
	dKV+knXpoOeyB4KlSm0y8iCCtXlopMfw8E4vaGV7CIN+08aM97G8OsszzFywKwEl9FSA+mWDsfs
	CBE76bo7rmRdHJQBYFUqYLUJRwTutd0M5wjm+o6kZxDeatFxBGbYtr0ZwJiHAL9ZcepqJU+dPFV
	kN2r6cbIvrjKBCHx/cLVh4M+v93mrIBt0rb/K/NANXCHvMgQeWKSGNJDpsovhNenlbVfl4YsA7Z
	V65bujcirv1rcPBFA/qceX54fLREK88lcgLCBk9iNIzbl4PdSkPqsg3/51Z/fvq/1zae+8I8l3k
	rGQW/O/jCzXZTRGsVUqBXx8SPIlZkB08W6Q6edryyia7NbLkKPwAhh1ymjeYZ0sTzpoW1VlAp51
	oetM2GIdTI=
X-Received: by 2002:a05:6a00:ad5:b0:823:cbb:a484 with SMTP id d2e1a72fcca58-83f33cbf6abmr694029b3a.14.1778783965954;
        Thu, 14 May 2026 11:39:25 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c78844sm3268209b3a.47.2026.05.14.11.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 11:39:25 -0700 (PDT)
Date: Thu, 14 May 2026 18:39:22 +0000
From: David Matlack <dmatlack@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 05/11] PCI: liveupdate: Keep bus numbers constant
 during Live Update
Message-ID: <agYW2pLTsjwuNBg2@google.com>
References: <20260512184846.119396-6-dmatlack@google.com>
 <20260514013646.C4F8BC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260514013646.C4F8BC19425@smtp.kernel.org>

On 2026-05-14 01:36 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Bridge bus numbers are inadvertently cleared for 'broken' topologies during Live Update, modifying the hardware fabric and disrupting active memory transactions.
> --
> 
> commit 0f468978660735d49ff81fb445992a21db06f9ce
> Author: David Matlack <dmatlack@google.com>
> 
> PCI: liveupdate: Keep bus numbers constant during Live Update
> 
> During Live Update, preserved devices must be allowed to continue performing
> memory transactions. This commit modifies the PCI core to always inherit
> bridge bus numbers when any devices are preserved, avoiding topology
> changes that could disrupt ongoing operations.
> 
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index b5fdc5017f921..08ea9324647ba 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> 
> [ ... ]
> 
> > @@ -1497,8 +1505,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
> >  		 * do in the second pass.
> >  		 */
> >  		if (!pass) {
> > -			if (pcibios_assign_all_busses() || broken)
> > -
> > +			if (assign_new_buses || broken)
> >  				/*
> >  				 * Temporarily disable forwarding of the
> >  				 * configuration cycles on all bridges in
> > @@ -1512,6 +1519,12 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
> >  			goto out;
> >  		}
> 
> Does this code accidentally clear the secondary and subordinate bus numbers
> for bridges with a "broken" configuration during a Live Update?
> 
> In the first pass (!pass), if the bridge topology is invalid (broken == 1),
> the code enters the if (assign_new_buses || broken) branch and executes a
> pci_write_config_dword() that disables configuration cycles.
> 
> Since the pci_liveupdate_inherit_buses() safety check happens after this
> block, the hardware fabric gets modified before the early return. Can this
> disrupt ongoing memory transactions for preserved downstream devices?

No, it is on purpose, not accidental.

If the bridges bus secondary and/or subordinate bus numbers are
misconfigured during a Live Update then the options are:

 1. Proceed with enumeration with the misconfigured
    secondary/subordinate numbers.
 2. Clear the misconfigured numbers and refuse to enumerate further.
 3. Clear the misconfigured numbers and then assign new bus numbers.

(1) seems like a bad idea to try to proceed with a misconfigured bridge.
(3) could lead to the bus numbers assigned to preserved endpoints
changing, which could lead to corruption (e.g. memory transactions being
routed to the wrong devices). (2) seems like the only sane option.

> 
> > +		if (pci_liveupdate_inherit_buses()) {
> > +			pci_err(dev, "Cannot reconfigure bridge during Live Update!\n");
> > +			pci_err(dev, "Downstream devices will not be enumerated!\n");
> > +			goto out;
> > +		}
> > +
> >  		/* Clear errors */
> >  		pci_write_config_word(dev, PCI_STATUS, 0xffff);
> >
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260512184846.119396-1-dmatlack@google.com?part=5
