Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699712C026C;
	Mon, 11 May 2026 07:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778483662; cv=none; b=Fnr3gOlfqcsBSqyDpP8kkWCXjvON0rPSCBH8sB5RYbDT1oCFzNmjwhkrhauxxIIf1ufMhnxoROEng+wBAMfCo6a8w6kc9+bwz77vd7nTQW0sTX82NlCRuVGH5sb17iZD2lbCK3cOQ/5ixg/Tiiy4MsbTA9PvrwXEug8B+bydlvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778483662; c=relaxed/simple;
	bh=nVVd4eNs/EGRFbVXonkvZ+pnEBN7gnthyVBbs1lyC2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q94jtKs7MbQvgZun6tZEG0gdRhmY3MhV9565woitQ3CCLETrHWXCDCrB4GJwOnNTtPXqp/dbjVL0gtB4LVte9pI5ls0p6tuabTBV9jvJxp0iryam87HyyQKRJokDc7gjzN54NB9cNBHqChLW9kO1RHCVqH6iLgl6QoXoTP3EeEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7yq/Y3O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7yq/Y3O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1222C2BCB0;
	Mon, 11 May 2026 07:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778483662;
	bh=nVVd4eNs/EGRFbVXonkvZ+pnEBN7gnthyVBbs1lyC2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B7yq/Y3OQs7NGjxxtvNO117vgssJrT30Yq2CLYOr1KWbXKk0rh2YKiR+hFc76l3zr
	 x0uaV5KPrbD2553PAZDn4zn/z4Sdc96rvZvIWpQ+oUtZlCIFcwbgqPPB4vYj2W1gyy
	 wRYbmNBE3dPCDWPUYXwmKjNCUDTRWQ1GUYMPa3zyq75Ztp+cC3g+9UFcaxzh/NCxtD
	 zLuWXz3dqi9vqAaSm80IMvjYN94wSiS+KH2r+OKDIGrk1KBIoofQyPTV8FbFS8zMdf
	 GSi3HXZ2EbH4r8x2BlSbDqgtbR3YwDxHE+xAGBo6LYXbAppInK7dT4zq0KRrXfc4aa
	 ciIN0ecj2u2Zw==
Date: Mon, 11 May 2026 16:14:20 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: sashiko@lists.linux.dev, linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 15/24] alpha/PCI: Remove WARN from __pci_mmap_fits()
 and __legacy_mmap_fits()
Message-ID: <20260511071346.GC1096586@rocinante>
References: <20260508045824.GA3160093@rocinante>
 <20260508230758.GA30814@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508230758.GA30814@bhelgaas>

Hello,

> > > >  static int __legacy_mmap_fits(struct pci_controller *hose,
> > > >  			      struct vm_area_struct *vma,
> > > > -			      unsigned long res_size, int sparse)
> > > > +			      unsigned long res_size)
> > > 
> > > This isn't a bug, but since the WARN() statement that used hose->index was
> > > removed below, is the hose parameter still needed? It appears to be completely
> > > unused in the function body now.
> > 
> > Ah, yes, darn.  Forgot to remove this one, too.  A quick fix:
> 
> I squashed this in, but you should double-check it because it didn't
> apply cleanly.

Looks good!  Thank you!

	Krzysztof
