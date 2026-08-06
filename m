Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC20D385D8F;
	Thu,  6 Aug 2026 17:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786037208; cv=none; b=ibh/wWJVbK6yLgaEGCFigVWLgYpDyWo+s1e6X/AE1GJc/cjkfA0fC2A0HsRoxyjLDIF7EKJMrLMYktKmIP1Et0LFaC5fmc1biq/j2/B3KTEbbORYbPgBHeJwWIGr+ortozuppJrrLNnKvFUFNg8EGThXakcPrF5QXyvklGyXMtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786037208; c=relaxed/simple;
	bh=km7uuaYM9ECNN/ZLwjBNnjj5509onM+/fQSWz61cVKg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kEyCrgbo6NOM6h5fuBoMpiUl0jfy/a1FwgG22CZs69MoZque/IKv1VaIcFjrtFvoIRBtSwDb9VJYfoTNWVl/agnAo9nB6BwpPZ5bd3hoxzI3VfMQKnYqEauG9CB5YdRmdlypa+j/Ui5WOMITCUe/Sj93STpUlFRTZ6Uq5KfYRLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAu+e5m3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAu+e5m3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B6A1F000E9;
	Thu,  6 Aug 2026 17:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786037207;
	bh=Jci8ZAL9PyOMSQK1X2/Nm9dIvNlLs9xH8yoq61Ao1fo=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=mAu+e5m3FLm6/8yBI7k6dVfFIDmhihUusYSQS9clkDK4h5gVbNS2rQeK0vkgTdoRZ
	 ptqe6UgI9ux6HwBW8bW8ntGLTyXo4qkGQKGcqmc7SLsf1pYbgsXeComCaPV8/dBoDn
	 kKomEKOtSrJT/8Ii38fvJMkVYUWfOKnlk8Y6BhkYjOOjP9veIC2cav3rNQv5DJ4t+v
	 Ga8kNKmRQp2trBXbytciThaJY+qcfmoyezbvtfbyU+4kc2TBaXC1dk4Udu2sd5QMfA
	 /nRsWpkoDYAHlzAXd07inDNhBfI0UMSV/NSkiB1ygmoFruTJO/GK4RNcHxarm5dpJL
	 ccfzj9omKeASw==
Date: Thu, 6 Aug 2026 12:26:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: Avinash Roy <avinash@linux.ibm.com>, maddy@linux.ibm.com,
	mpe@ellerman.id.au, bhelgaas@google.com, npiggin@gmail.com,
	chleroy@kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Avinash Roy <avinash.roy1@linux.ibm.com>
Subject: Re: [PATCH] PCI: quirks: Add warm reset quirk for IBM Spyre
 accelerator
Message-ID: <20260806172645.GA2192955@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72ce5fa7-d12b-40e5-a4a2-f2de414088d1@linux.ibm.com>

On Thu, Aug 06, 2026 at 10:20:02PM +0530, Shivaprasad G Bhat wrote:
> On 8/5/26 10:48 PM, Bjorn Helgaas wrote:
> > On Wed, Aug 05, 2026 at 06:21:32PM +0530, Avinash Roy wrote:
> > > From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> > > 
> > > The IBM Spyre accelerator (PCI ID 1014:06a7) requires a dedicated warm
> > > reset method for reliable EEH recovery on pSeries/ppc64 platforms.
> > > 
> > > FLR alone is insufficient because it does not re-initialize the Spyre
> > > firmware state machine. On ppc64 with EEH enabled,
> > > pcibios_set_pcie_reset_state() is overridden in
> > > arch/powerpc/kernel/eeh.c to drive the platform-level PERST# signal via
> > > EEH PE operations, which is the correct mechanism for full device
> > > recovery after an EEH event.
> > 
> > This makes it sound like this mechanism is needed for EEH recovery for
> > *all* devices, not just Spyre.  If that's the case it sounds like we
> > need more than just a Spyre-specific quirk.
> 
> Now I re-read it, The second statement needs to be re-worded. It does sound
> like its true for all devices. Quirk is only for the Spyre card.

So I guess this is related to some Spyre erratum?  Per spec, FLR is
supposed to "set all Function-specific state machines to their
initialization values" (PCIe r7.0, sec 6.6.2).
