Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4441F6AD4
	for <linux-pci@vger.kernel.org>; Wed, 14 Oct 2026 06:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791958919; cv=none; b=tBUx2zly8B0zvePaCAgheelseuaL+leRj5aLdNsP9mjzMW/DcERCjK28unT4cuLNeXLJgg8ufUlSY8euvypTB3EUIPwxYJEz6U9d6JA8x8qWm3gKMgk9Ohe8XRz/hLJOFgh+Mc94ap4I3Bl3feTYVRngQK3R2C2Fn26VbkuPbIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791958919; c=relaxed/simple;
	bh=b+lnC8CF23mRbE7EiAz/AWNUgjzXEoQCd1PXF3OjB3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tel/hW8hcBu4hJpBWSrnVvTXdMwM7r+KHA6CtyAk2PYISS+8k1xJ/mHWwhQDY4xSpEpujwpjQkejoiqk+EnTsYnazjkUGnFj59Fu0796UlYVDWtABsTIkeEa/ez42inUBSOw4wZQj5u2M+n7tMpyVCGlMt0zm3cHtfbGoroELtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQCY+NN1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQCY+NN1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815E71F000FF;
	Wed, 14 Oct 2026 06:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791958917;
	bh=RpD9UrzTg2yn9JZAZl72vnNutpVGunoo7kphLUU8T1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NQCY+NN1UctbmfviEydJTggBelrPSLsiianQW1tCYJDAqoFB35f1eMXXHRKt6orsH
	 I9WjhnmRUvuFgy6Ok9gb/r3cTluIOSJ3ud3ZqFXR9H8XTqN13yejJYWsp8qZ3J4R4f
	 sdE72JogYbIQdndihiQys8Bssx+olcaswYQIaPnNKK9BMsUXZ9qkxaFn6rJGb4Q6jZ
	 Kuvbb+lXxhrovT9mzvXYnOp3NJp2bEDmQjCEnfUTJuTyfYtYa2yoGU1U5MAM4RaI92
	 +u5LJ4PQS/uSPBZjOfkTzeYjtI19QkBWcv9JNkoD0mlzJRFy3CWa09q8HwDb+A8msv
	 22AwP8zmI4SIw==
Date: Wed, 14 Oct 2026 15:21:55 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Bjorn Helgaas <helgaas@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Kees Cook <kees@kernel.org>, 
	Matthew Garrett <mjg59@srcf.ucam.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/sysfs: Add lockdown checks to legacy I/O and memory
 handlers
Message-ID: <20261014061710.GA1638248@rocinante>
References: <20260720211541.1509744-1-kwilczynski@kernel.org>
 <8a8fc5b8-cccf-4849-a0f4-b7878f1de511@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a8fc5b8-cccf-4849-a0f4-b7878f1de511@kernel.org>

Hello,

> > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > index 5ec0b245a69b..c24d9270a7a5 100644
> > --- a/drivers/pci/pci-sysfs.c
> > +++ b/drivers/pci/pci-sysfs.c
> > @@ -913,6 +913,11 @@ static ssize_t pci_write_legacy_io(struct file *filp, struct kobject *kobj,
> >   				   char *buf, loff_t off, size_t count)
> >   {
> >   	struct pci_bus *bus = to_pci_bus(kobj_to_dev(kobj));
> > +	int ret;
> > +
> > +	ret = security_locked_down(LOCKDOWN_PCI_ACCESS);
> > +	if (ret)
> > +		return ret;
> >   	/* Only support 1, 2 or 4 byte accesses */
> >   	if (count != 1 && count != 2 && count != 4)
> 
> This hunk was misapplied AFAICT. The commit 747b9bbbbdfd ("PCI/sysfs: Add
> lockdown checks to legacy I/O and memory handlers") applies the hunk to
> __pci_legacy_is_visible() instead.

Yes, sadly it was misapplied.  We found out recently, too.  I will sent
a patch to correct this a later today.

Thank you for letting us know, Jiri.  Appreciated.

All the best,

	Krzysztof
