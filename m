Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795630058;
	b=nS7jdPy5ZoUdUwoUMFdFzWBxPT5448g++5sSAsERJkJhNJ3QA9AGaFBmsh0YB7MosMWT
	 SyqF497s2KufvKItQmWBtZ9HBdbU1BMPbzhpeSQEPSnNEg3FQFn7NKJkFheLIe5b8nbVf
	 R04xstuNHazUZo1260UrZbJClIKYO5gphdmMM+0OwF1EpS3QolzNGLdJSOlIbCYMaiMvP
	 +1CTnr0ozqLymz7cF5a/1xlQCN2vicemlSPTyw06jivQdr5DYdOWZuioRmP90FFDHTRQL
	 i6+8emIpJ68VGmwO+Yz3e1nAOkmC7orlqZaN+O+pUOAj9DGWSQH2UPBd+4C0Rr+j/Wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795630058;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=7S9L2bVkaRL0hV4UwLogPIAmhUfhkxStMxKaA9DQzpM=;
	b=T4cFaxLacMoNBe/13QavLkaOe9agOYj1AOqdICm+vXfHFNhgwjtIT4QErRUEFy+s8I1n
	 XW6g3IwFfTPTd6GRXfzn7+oN9xJumFaeICUg2xmsMnjgvysXJojhtbEB2bVgENRmrOnAW
	 y0h0i+OgloAgUjpiVI3rTGIfXuhY1VWIM8d4UXEWiJ+F6I1ltDh1zneKe+JDNtEpZ+dkF
	 wYYRNPnspmhUoFdeYpSYs7QaZX3BGvZO+fSR5Qw8yK6KD8x4fqX0Ovnpo2HwETfvm3or7
	 iEiUobsWm/0MhYKUtPNCv91mnhTHKdyD/omJzV5Re3uu3s3ngavDbWkHailMycLGIWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GU2faQD0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF787606A31E;
	Wed, 25 Nov 2026 18:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GU2faQD0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6F71F000D0;
	Wed, 25 Nov 2026 18:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795630058;
	bh=7S9L2bVkaRL0hV4UwLogPIAmhUfhkxStMxKaA9DQzpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GU2faQD0C3C3QHmZvfIZn6uGYgk/K2DzEGXeZnGJRKWYKEZFgx4lDFYq1U1YnIMFm
	 mJSeky3yhAM0AM3lPh3HAZEKZYKk73gQI06V084q3VYZeO4wMQwu/dvS+884t7TDWg
	 kICFYd6g0yNMvxwAdhljLowinJr2fjAsxdNe0504a35BXFxF4MkEklnymmuuo6dZLL
	 v0umaGv32j5CcFNpREGmeOvfyEn0G1vGR+0bpKY8p522I8chm0GkKbrMFqgueKQwX0
	 iNYZ7VwvCStdnpFW+yvf58G+dYK3FcjbcFl1/UBpyz6fqZVLw5R8U0+ESzbA3PTmaA
	 Tj1AoRSlWJCNQ==
Date: Wed, 25 Nov 2026 20:07:34 +0200
From: Leon Romanovsky <leon@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-sound@vger.kernel.org,
	dmitry.torokhov@gmail.com
Subject: Re: [PATCH v4 28/33] PCI: Use device trust for platform restrictions
Message-ID: <20261125180734.GG14811@unreal>
References: <20261124-device-trust-core-v4-0-037eb0d17b1f@nvidia.com>
 <20261124-device-trust-core-v4-28-037eb0d17b1f@nvidia.com>
 <sashiko-outbox-233065@kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-233065@kernel.org>

On Wed, Nov 25, 2026 at 09:46:45AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] PCI: of_create_pci_dev() runs pci_ats_init() before
>   device_trust_init()
> --
> 
> commit a65ec3ba4c9db1ced18be2126bf20a6e9f67645c
> Author: Leon Romanovsky <leon@kernel.org>
> 
> PCI: Use device trust for platform restrictions
> 
> This commit maps PCI topology untrusted device classification into the
> device trust policy and checks pci_dev_default_is_restricted() when
> configuring ATS and ACS translation blocking at discovery time.
> 
> > diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> > index 9cb23780093dd..c8c96acc26343 100644
> > --- a/drivers/pci/ats.c
> > +++ b/drivers/pci/ats.c
> > @@ -21,7 +21,7 @@ void pci_ats_init(struct pci_dev *dev)
> >  {
> >  	int pos;
> >  
> > -	if (pci_ats_disabled())
> > +	if (pci_ats_disabled() || pci_dev_default_is_restricted(dev))
> >  		return;
> >  
> >  	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ATS);
> > @@ -40,7 +40,7 @@ void pci_ats_init(struct pci_dev *dev)
> >   */
> >  bool pci_ats_supported(struct pci_dev *dev)
> >  {
> > -	if (!dev->ats_cap || dev->untrusted)
> > +	if (!dev->ats_cap)
> >  		return false;
> >  
> >  	if (dev->is_virtfn)
> 
> [Severity: Medium]
> Can pci_ats_init() run before device_trust_init() populates
> dev->dev.trust_policy on OpenFirmware PCI enumeration paths?

Changes to IOMMU/ATS will be sent in a follow-up series, as this series is
already large enough.

Thanks
