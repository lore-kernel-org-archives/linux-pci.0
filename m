Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1BD396D25
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 18:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778784394; cv=none; b=cIzjik6k+XNzZZCqi73WPNm2DGhiKNFl89YgFkI1ve60CimYljtjDNoPTvBCRTUyrAPzHgwh9Dmnc6N7iw63G+fmWKnfESkZS5skSn80/OKuPEXHAlxUAdxqVwN1j+On3fB5Uv5bBaZS9g1HHJ0IVwB+XaellXnCYHLadcOL7kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778784394; c=relaxed/simple;
	bh=ZWs/UHYsK84uYEnQZ3cF1K4U4pbiZVAZeP1d+14kwb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=od+DYrRHPFXv7abzqCzE/HG8TB1/vbzIFwi7PaISAX0s9it1jcBMuV8RPGdXF5DtUQyTxvVIRhxwBih+ho4S2UYNIJBrVMYPRu+PsXb4txbkWXOYbt8N5KuNnAwdfkwgOkc/L6eVB9yGuLGwSO4d/hKjrYqq1khDIRMwU2OfDy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ac+yVSvM; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ac+yVSvM"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ba3e3c4f87so77239575ad.3
        for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 11:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778784389; x=1779389189; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mNwkE7l7eZCybJrXfUk9UXry5vm3L6Ks/wwD4RybeTU=;
        b=Ac+yVSvM3cXiztY8VMpNyflv4yW8LLgZrUVeahOSEdrpv+kCN75bO6AjQRekkfiZpM
         wH+VJW6/ILhfggxWLuYp4+gbzp7qcjGh0rnEXXimyGsUJbQ3SLKzFLkERt8C2f820NRg
         o/4YcooNj02HfmQD9/1AQzJsPLjGvfrGqd/Z/Awxh5AXFi57+4X/CLYYV5yRwAhazLka
         LQp2kggyBUgnbpGBWlVgxYvzi8jDPUWZgfpcEBg8IQlt3k9B+nuInR+J+4tldm8+U43c
         dxxPLeTiiZmsZcD4b4bBzILkoR7uivoKk0uW/+UMPYKG2hYXfeTB0aIMOI5lK9mbmc9f
         K24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778784389; x=1779389189;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mNwkE7l7eZCybJrXfUk9UXry5vm3L6Ks/wwD4RybeTU=;
        b=U3NH2k5WKCgxeWfamds+OUHtXicAb+TOqkZhbFeO+3ochkRiht1KcpkcX4//MeO/hm
         ZBWG1xdUxZAXwYlpJ1SjtyTlVxetzXqjYzp3f6BgbEnXhNmM0jbprU6EnowiVuOJOrpw
         iZMOl0H5yGJ4agi3rG9ShCr4gyKKZbiwGqpLTvSuXGIwok1+6BfSv4xlbEzTfVhWnZIU
         eNRV/oyrrRtiK1cyjlP4NqP2DJ5BoLsYys7EMUt39dpJ+GX8Rwu0Xwu+y2L9So7flCcA
         Dt/dm2VAXJ+G+EkAyG5KtZlmE11wdCboTehxfdHr9BE9Aosn3X6bJW2qFu7KRg8AphE3
         Sm1A==
X-Gm-Message-State: AOJu0YxAlJfv8lLRTMrJxixY1+kLCekhOMvClhHpsQ6A77MPyVjgRtP2
	TZv3ia2BaiTa1JNimYJh6j74SGzdHDDXqkr+qNOdND70kFex0Ht1cTq1ewMjwxG4N9p73EhWdre
	bELs1VQ==
X-Gm-Gg: Acq92OGOT3qeis7Lp5JVZc/hNx6R+3evus2xTOYY0gBRMiZvvZh5pUGyAiZnWchXgT8
	qJw1Edph2Am5EHZV8mzWs47LbBAB60nXlYacwN/U/MLvn6iN5owAGrYaJ7ZP/mYJ9DiQRFC0k92
	p/U6Cn5YabAOLXwriUoMIHLV3HJak9i1Wx3EeoLfkcEw51CkeknJA0d2TgVaecPOtaUttoC7ORS
	Sgpwv8NbMFDhoREVMvYAEsW6+WjWeeEI6jz/r74PRHx4aGRmNccS3vM7+BYCCJ6+9KLsueeX97V
	FHFqR3tL7WvIiYjrjiFMu1QzQYFxx2UBCERcaf8bOtpJ3So2EGtzZAPNZtiztzzl60xpzw7VXl8
	wj0Ig4WrYTLf+Ewv1XqcT5MZQGUgDiYX2EBIwFaHJ4rTnM/99x9VS4ns4u2WbSL1T30KmgUBm13
	HufnJZ5DVr98Qp/U51HbjgCI/NaN6bfd3wX2mdpPcv0s0tDBNAe3mGjAfF+8EIOp0xEujVtfTY
X-Received: by 2002:a17:902:c948:b0:2b2:4f43:b48c with SMTP id d9443c01a7336-2bd7e8423a7mr7937695ad.14.1778784388674;
        Thu, 14 May 2026 11:46:28 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe49a4sm29394575ad.38.2026.05.14.11.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 11:46:28 -0700 (PDT)
Date: Thu, 14 May 2026 18:46:25 +0000
From: David Matlack <dmatlack@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 07/11] PCI: liveupdate: Inherit ACS flags in incoming
 preserved devices
Message-ID: <agYYgQc-gjs7-III@google.com>
References: <20260512184846.119396-8-dmatlack@google.com>
 <20260514023718.1A7A4C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260514023718.1A7A4C19425@smtp.kernel.org>

On 2026-05-14 02:37 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Modifying pci_dev state while holding only a read lock in pci_liveupdate_init_acs().
> - [High] Intel SPT PCH root ports bypass the ACS quirk rejection check, causing their custom ACS control registers to be permanently lost on the new kernel.
> --
> 
> commit 9befbb904977419650ee202e0854fc1452e0a9de
> Author: David Matlack <dmatlack@google.com>
> 
> PCI: liveupdate: Inherit ACS flags in incoming preserved devices
> 
> This commit updates the live update process to inherit Access Control
> Services (ACS) flags on incoming preserved devices. It caches the
> inherited ACS controls established by the previous kernel so they do
> not change after a reset.
> 
> > diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> > index d8e06afde2c76..e3cd6d76636c3 100644
> > --- a/drivers/pci/liveupdate.c
> > +++ b/drivers/pci/liveupdate.c
> [ ... ]
> > @@ -361,6 +373,16 @@ static int pci_liveupdate_preserve_device_new(struct pci_ser *ser, struct pci_de
> >  {
> >  	int i;
> >  
> > +	/*
> > +	 * Do not preserve a devices that rely on device-specific ACS
> > +	 * equivalents (for now) since that would complicate keeping ACS
> > +	 * flags constant across Live Update.
> > +	 */
> > +	if (dev->dev_flags & PCI_DEV_FLAGS_ACS_ENABLED_QUIRK) {
> > +		pci_warn(dev, "Refusing to preserve device that relies on ACS quirks\n");
> > +		return -EINVAL;
> > +	}
> 
> Can Intel SPT PCH root ports bypass this check?
> 
> Looking at pci_quirk_enable_intel_spt_pch_acs(), it does not appear to set
> the PCI_DEV_FLAGS_ACS_ENABLED_QUIRK flag.
> 
> If these ports bypass the check and are preserved, pci_liveupdate_init_acs()
> will only cache the standard PCI_ACS_CTRL register, ignoring the
> device-specific INTEL_SPT_ACS_CTRL register.
> 
> When the new kernel calls pci_enable_acs(), pci_liveupdate_inherit_acs()
> will restore the standard register and return true, skipping the
> pci_dev_specific_enable_acs() path entirely.
> 
> Will this cause a regression where the custom ACS configuration is lost?

Yes looks like it, I will account for Intel SPT PCH root ports in v6.

> 
> [ ... ]
> > @@ -671,6 +694,32 @@ void pci_liveupdate_finish(struct pci_dev *dev)
> >  }
> >  EXPORT_SYMBOL_GPL(pci_liveupdate_finish);
> >  
> > +void pci_liveupdate_init_acs(struct pci_dev *dev)
> > +{
> > +	guard(read_lock)(&dev->liveupdate.lock);
> > +
> > +	if (!dev->acs_cap || !dev->liveupdate.incoming)
> > +		return;
> > +
> > +	pci_read_config_word(dev, dev->acs_cap + PCI_ACS_CTRL, &dev->liveupdate.acs_ctrl);
> > +}
> 
> Does this mutate dev->liveupdate.acs_ctrl while holding a read lock?
> 
> Since pci_read_config_word() writes the read value into the acs_ctrl
> pointer, should this use write_lock to avoid a data race regression?

Yes, will fix.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260512184846.119396-1-dmatlack@google.com?part=7
