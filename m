Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9417E306B1B;
	Thu,  2 Jul 2026 14:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783003370; cv=none; b=aAnKYM4LnbGfAO/IKR6coIgL4lqriZOrWolpJkKmsfgTRMRGl0uxTRfNNPxhXO+rmtID3h0/NSRnRdNBvBprFabOm6rIiQ/0dG4yIhyBdne1Eyx2IMdUbn7vdNkGZ1gBt/rupp+2APSAsIgqw8+4029BG28GbxY3oTxWZXS+tZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783003370; c=relaxed/simple;
	bh=G57ERqTS6s/8aEDOS+5CjHuorxFgbpD8CwwGUsDCQU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mo9Jw7XNGm/SVtSt+Y9r8EIyUE2HcMbRcQR3qgdBway9BitqPicpePIVSI+QVLiicmBsk7JVFx83dGRCTgEtsqQLZCGHg4Cz4leUEhzdlGDPZhRGHLgEgZ2uRIdoTgb9w2ERBTm7T6H2HVBQMaR4fqwqJH+UOmzSOwuCQSBQaqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id AE3F010EF1;
	Thu, 02 Jul 2026 16:42:43 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 9C347602E7C0; Thu,  2 Jul 2026 16:42:43 +0200 (CEST)
Date: Thu, 2 Jul 2026 16:42:43 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Max Lee <max.lee@canonical.com>
Cc: bhelgaas@google.com, Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, acelan.kao@canonical.com,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Victor Shih <victorshihgli@gmail.com>,
	Jon Pan-Doh <pandoh@google.com>
Subject: Re: [PATCH v2] PCI: Mask Replay Timer Timeout for Realtek RTS525A
Message-ID: <akZ448o-YMGfEEOP@wunner.de>
References: <oc3i3yn4c22s5c3gtqgs7a4wrpqiywwvboxstdf7josxddqmpd@y43m75ovby2t>
 <20260701204201.GA302478@bhelgaas>
 <akXy1gsijpfslOJm@wunner.de>
 <CA+YcyLx3XS3LEeVzPEfD+OdktsLFyLuN4mQGk9EyEgQUmKPLBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+YcyLx3XS3LEeVzPEfD+OdktsLFyLuN4mQGk9EyEgQUmKPLBA@mail.gmail.com>

On Thu, Jul 02, 2026 at 03:06:29PM +0800, Max Lee wrote:
> Both the endpoint and the immediate upstream port expose AER capability.
> On this unpatched boot, Replay Timer Timeout is not masked on either side.
> 
> Endpoint 0000:58:00.0:
> 
>   Capabilities: [100 v2] Advanced Error Reporting
>       CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
>       CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
> 
> Root Port 0000:00:1c.6:
> 
>   Capabilities: [100 v1] Advanced Error Reporting
>       CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
>       CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
>       RootCmd: CERptEn+ NFERptEn+ FERptEn+
>       ErrorSrc: ERR_COR: 5800 ERR_FATAL/NONFATAL: 0000

There were Advisory Non-Fatal Errors on both ends of the links.
The upstream kernel does not support ANFE so far, but this
development branch contains three tentative patches to add it:

https://github.com/l1k/linux/commits/anfe_v1/

So far this is compile-tested only.  You may want to give these
patches a spin to see which Non-Fatal Errors are signaled.  The
kernel should also dump the TLP Prefix Log for those errors and
you can use this tool to decode it:

https://github.com/mmpg-x86/tlp-tool

See the example usage in:  Documentation/PCI/pcieaer-howto.rst

The TLP Prefix Log might give a hint as to the root cause.

Your commit message mentions a "transient link training instability",
but I think if that were the case, you'd see Surprise Link Down Errors
(which are Fatal Errors).  Except if the Root Port was hotplug-capable,
in which case Surprise Link Down Error generation is blocked per
PCIe r7.0 sec 3.2.1.  Another exception would be if the Root Port is
not Surprise Down Error Reporting Capable (bit 19 in the Link
Capabilities Register).

Bjorn mentioned commit eeee3b5e6d0b, which states that the Replay Timer
Timeout errors (only) occur when ASPM is enabled.  That may be the
actual root cause, so you may want to play with ASPM settings (disable
L1 substates etc) to see if it makes the issue go away.  Disabling
non-working ASPM settings in a quirk would be better than silencing
the ensuing errors.

Thanks,

Lukas
