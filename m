Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FB53502A7
	for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 19:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790537021; cv=none; b=jEsTs/rFtZO+N9GlC/3ldWR5y7aiiB2OncTV3tmgbbQLwhvLTrg5O4C/yzJvCbmqhqcpPdkCZG7vzhhTmonFxUiEQMUBwQdQ1i0on4W61PWYzVEZxsqAwZHPAKttvrJfZUju53iMrtVWS1M+ZC8V2p86lMVedy6T9jTZDCfbLZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790537021; c=relaxed/simple;
	bh=zABX1+4Cs7ctBNzJDwB2riz0rGmqRhkqb/LME9uAtjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQiAfN5/EN7nfwdrzlH2XlUoOtmSVdvuf8k7mnwV9kXXgG6VnrGOkce9E21oRfXqPHcefcXFnmSCV0gx9nzSFBDrT+7srBIfUPwWrKAQrOmwcDk2kITPHpKLXyZb0oiUpe5vhbyAfwIrYyISJvU6b37XWZkhTh1cw+Vo9h340lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 01216709F;
	Sun, 27 Sep 2026 21:23:37 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id D16CC6252950; Sun, 27 Sep 2026 21:23:36 +0200 (CEST)
Date: Sun, 27 Sep 2026 21:23:36 +0200
From: Lukas Wunner <lukas@wunner.de>
To: sashiko-reviews@lists.linux.dev, Tony Luck <tony.luck@intel.com>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH 6/7] PCI/AER: Renumber severity constants
Message-ID: <arltOHrdHdokyfC9@wunner.de>
References: <cover.1790531238.git.lukas@wunner.de>
 <244713dea3786099e9ad4eb10ff9f2f430cd7ad3.1790531238.git.lukas@wunner.de>
 <20260927182946.224981F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927182946.224981F000FF@smtp.kernel.org>

[cc += Tony Luck, Steven Rostedt, start of thread is here:
https://lore.kernel.org/r/244713dea3786099e9ad4eb10ff9f2f430cd7ad3.1790531238.git.lukas@wunner.de
]

On Sun, Sep 27, 2026 at 06:29:45PM +0000, sashiko-bot@kernel.org wrote:
> PCI/AER: Renumber severity constants
> 
> This commit modifies the AER severity constants to align with the Device Status
> Register bit numbers defined in the PCIe specification. It updates the severity
> strings and the ras_event documentation to reflect the new constant values.
> 
> > +++ b/include/linux/aer.h
> > @@ -11,10 +11,10 @@
> >  #include <linux/errno.h>
> >  #include <linux/types.h>
> >  
> > -#define AER_NONFATAL			0
> > -#define AER_FATAL			1
> > -#define AER_CORRECTABLE			2
> > -#define DPC_FATAL			3
> > +/* Must match bit number in Device Status Register (PCIe r7.1, sec 7.5.3.5) */
> > +#define AER_CORRECTABLE			0
> > +#define AER_NONFATAL			1
> > +#define AER_FATAL			2
> 
> [ ... ]
> 
> > +++ b/include/ras/ras_event.h
> > @@ -302,7 +302,7 @@ TRACE_EVENT(non_standard_event,
> >   *			([domain:]bus:device.function).
> >   * u32 status -		Either the correctable or uncorrectable register
> >   *			indicating what error or errors have been seen
> > - * u8 severity -	error severity 0:NONFATAL 1:FATAL 2:CORRECTED
> > + * u8 severity -	error severity 0:CORRECTED 1:NONFATAL 2:FATAL
> >   */
> 
> [Severity: Critical]
> Does this change unintentionally break the userspace ABI for the aer_event
> tracepoint?
> 
> The tracepoint exports the severity field as a raw u8 integer in the binary
> trace ring buffer. By renumbering the underlying AER constants in
> include/linux/aer.h, the tracepoint now emits different integers for hardware
> error events without an ABI translation layer.
> 
> Userspace tools like rasdaemon that rely on the historical raw integer values
> will now misclassify hardware error severities. For example, a correctable
> error (now 0) would be incorrectly interpreted as non-fatal by older tools
> expecting the previous ABI layout.

Hm, my understanding was that the TP_PROTO() arguments to a TRACE_EVENT()
do not constitute ABI, but rather (only) the string emitted by
TP_printk().

My patch changes the value of a TP_PROTO() argument but not the
TP_printk() output.

However, looking at rasdaemon source code, it's defining constants with
values identical to the kernel:

https://github.com/mchehab/rasdaemon/blob/master/core/ras-events.h#L248

So it looks like this is uAPI without being marked as such and we're stuck
with it. And so apparently patch [6/7] is not applicable and patch [7/7]
needs a fixup. :(

Thanks,

Lukas
