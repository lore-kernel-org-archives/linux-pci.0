Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F84247280;
	Thu, 19 Feb 2026 22:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771541604; cv=none; b=msX3+iQmj3EJ3Ppl/prypTR8bKsqto6KVCav5H1UtIofvyQ98XN9X6e7Eaq98CP79sopMSiqOpKyPYo8+CjC749EqhrhVXNRRmEXhx9NPYx66X9DNVFzvu4eWfEIMKC+Fs6Ci76W3GKyR27Mt8UJ9Ml6T5Y7WMyAiDEwJobk1lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771541604; c=relaxed/simple;
	bh=BcdVDXas1f1tZ2Svg0e2enRiHCFMkAutX4j7j/UFx84=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=RT5KjXHjHei9oeytJ3BBhPs/HuX35win3Vuzk2Z4KKNGG947WBqoYCcnTNR6blS2Fv3qP7B6xGoeYcbFp5/DLE8h7NyIXsIJsnqbKT5YCFNMV/BlWNOa9kAP1MpW//jl1Gp0FA1+ORnQBciMBXbel2UcLGReraqyEIWf9Meq62g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=al9X7+8t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="al9X7+8t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F407C4CEF7;
	Thu, 19 Feb 2026 22:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771541603;
	bh=BcdVDXas1f1tZ2Svg0e2enRiHCFMkAutX4j7j/UFx84=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=al9X7+8tyTapEaKc7xpTsZmez0ZOZ/X1mqPIUW64RCGqc5i+QnNdrcvCOpkU/dX/P
	 xLEV/OlEaWBzOqEPAFzjfbFriY1V3CM4xfrhpdUDLaCqlOgQZ0tZLRnAIr2h+dz5dI
	 unZHCEI17wbnq/G8F8/iGyRN+VnrRIW/Z4CAzp57BHX41mlwD1Tp2pzG49SIGH3/Rq
	 aRzXBjaipHGiKWt/xEYAwCRJN0qAXG3cgo4MTkhSMUMmsK3MMEp3ydtCCpcmOIBWat
	 Li0yWu+yD20T0sDeNH7YSWwWw6ldJJexpShSFQU6YKXuRNK5eFooRpim0SkH67T33r
	 tByx9YzrG2eaw==
Date: Thu, 19 Feb 2026 16:53:22 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Matthew W Carlis <mattc@purestorage.com>
Cc: ahuang12@lenovo.com, alok.a.tiwari@oracle.com, ashishk@purestorage.com,
	bhelgaas@google.com, guojinhui.liam@bytedance.com,
	ilpo.jarvinen@linux.intel.com, jiwei.sun.bj@qq.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lukas@wunner.de, macro@orcam.me.uk, msaggi@purestorage.com,
	sconnor@purestorage.com, sunjw10@lenovo.com
Subject: Re: [PATCH] PCI: Always lift 2.5GT/s restriction in PCIe failed link
 retraining
Message-ID: <20260219225322.GA3501275@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219220959.19900-1-mattc@purestorage.com>

On Thu, Feb 19, 2026 at 03:09:59PM -0700, Matthew W Carlis wrote:
> On Thu, 19 Feb 2026, Bjorn Helgaas wrote:
> 
> > Applied to pci/enumeration for v7.1, thanks.  This will be rebased
> > after v7.0-rc1.
> 
> We're heading down a path here where we keep working around the
> work-around & now have decided that the kernel will be meddling with
> the link on potentially all of the PCIe devices in the world. The
> trade off that we're making here to accommodate a device specific
> interaction doesn't seem like the right direction. 
> 
> Can we reconsider my patch that restricts the link retrain mechanism
> to the specific device that created the work-around?
> https://lore.kernel.org/all/20250702052430.13716-1-mattc@purestorage.com/

I think we already at least potentially meddle with the link on every
device, and it definitely makes me nervous.  I would like it much
better if it's possible to limit it to devices with known defects.

I'll defer these for now and we can see if a consensus emerges.
