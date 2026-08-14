Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5D74483A3
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 10:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786702948; cv=none; b=qnFcDQqzezOsT3Xwvq23nOSshndppGqf82gfngOUHXoEqBpkB0ete4Ac5uw1QOEzIrngKCJPU8uJY8P8DGluHYV4Mrg6R8CNIVwmQjwVuhcAj3uCX5ZAjMdmiyprnzJILbeR7DDBsaV/UQV9/dR5aUv12VoSIdOsRm2WxSRE7mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786702948; c=relaxed/simple;
	bh=6zcqGzOmVvXfMut1/MsXaZAjl1RoRIAsk2o4Qo9C10U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RqL6fUJnIj8RoCAwsZXiybcC0cA8OFWhuOADqYdBNsFVgvMUTtwF6sAm1eRvFNyk+oxZet9BwdUHC5DdyL4GKfdlcUyoUKMtSH1cinMR1dfiw5aLTJfZafjwzemzQV5+LaaGYZUf/DMIjz5PK5wvql83FzOjwxpMKr6Roy3sEK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKEfGkYH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKEfGkYH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F41661F000E9;
	Fri, 14 Aug 2026 10:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786702941;
	bh=7DiXxKu6Aa4oo4cVPqlBccyG50dgWTMBXPPNfDbcRqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dKEfGkYHH2OAwuorIiAGpIHiOlrvXZetRzHz+Kdgmmp1t/f/rEsU4WQt2g2cet8cf
	 N2+6RVKoeB+TPbjlQds1gfU3OLph2bwHcnf5M8UcQEde/2L3tHVIsXHe5Ng0WpSWfC
	 /DLkzuuWu73tbThZ8JNRw741U9xpQ7l5f84VynKcxWKClDTY71Vel0KBFCWdF/qkS5
	 vezg7f7ZpUzoP+9kAF2e9EedgW4jN0tH5WScMzQOaHKf8zDIAKsrKUrqbpWyNqWAG2
	 MEgysCY3Oeqfun96GuTtSD7109Ly+6r0uyYeZOeEOJZRNXoeJPXSEwdcZw2x6mMHX5
	 sXZqTBcWMuMGg==
Date: Fri, 14 Aug 2026 19:22:19 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Narendra K <Narendra_K@dell.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 4/4] PCI/sysfs: Pass the device name length in UTF-16
 code units
Message-ID: <20260814101153.GA93086@rocinante>
References: <20260814070522.2327975-1-kwilczynski@kernel.org>
 <20260814070522.2327975-5-kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814070522.2327975-5-kwilczynski@kernel.org>

Hello Rafael,

> Currently, dsm_label_utf16s_to_utf8s() passes the ACPI buffer
> length to utf16s_to_utf8s() unchanged.  The Device Name _DSM may
> return the device name as a buffer holding a UTF-16 string, and
> the ACPI length counts bytes while the converter counts wchar_t
> elements.  The converter therefore receives a count twice the
> number of code units the buffer holds, and that count is its only
> bound on the input.
> 
> A NUL code unit ends the conversion early, so a name that carries
> one is converted correctly and the error stays hidden.  ACPICA
> zeroes the entire result allocation, and the padding placed after
> the buffer supplies that NUL for most lengths.  Lengths that leave
> no padding, or a single byte of it, do not, and the conversion
> then runs up to its own length in bytes past the end of the
> allocation.  The bytes beyond the allocation are decoded into the
> "label" attribute, which is world readable.
> 
> Thus, divide the buffer length by the size of wchar_t so that the
> converter receives a count of code units.  The division truncates,
> so the converter is never told to read more bytes than the buffer
> holds, including for an odd length.
> 
> Reaching the out of bounds read needs firmware that returns the
> name as a buffer and omits the terminator.

[...]
>  	len = utf16s_to_utf8s((const wchar_t *)obj->buffer.pointer,
> -			      obj->buffer.length,
> +			      obj->buffer.length / sizeof(wchar_t),
>  			      UTF16_LITTLE_ENDIAN,
>  			      buf, PAGE_SIZE - 1);


While looking at this from PCI perspective, I also noticed something with
ACPI code base that we could also fix.

File drivers/acpi/device_sysfs.c, where the description_show() is adding
/sys/bus/acpi/devices/.../description sysfs attribute to each device where
this is supported/available using data from the ACPI _STR method, has the
following:

  result = utf16s_to_utf8s(
          (wchar_t *)str_obj->buffer.pointer,
          str_obj->buffer.length,
          UTF16_LITTLE_ENDIAN, buf,
          PAGE_SIZE - 1);

I believe, the above code has potentially the same issue as the one PCI
has, and which we are fixing here.  I can send a small patch to fix the
this, too, if you want.

Thank you!

        Krzysztof
