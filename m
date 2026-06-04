Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E39C3CA487;
	Thu,  4 Jun 2026 20:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780606021; cv=none; b=jzTrRpgiQDGhPCpIxGeOawInl46aEDFM45xLqqOoMBkrXRttoyGxIYPtaPaH/w/kJELsLrmQy2qhfwXeJMbELimZ/mweB9YAYN2DlMHJ89Xt5FSgENFPZuPyU4o0Nh4kQ8SsFXPtT5CW3QXKxPRs/kNn+HD9gXH9D9Jn/3lnZj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780606021; c=relaxed/simple;
	bh=2rvcSjl7CKGamsUv3lxfXDFYPjx3jjJ258AlHxAaMBI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EvXWfMy5eeDeIUy5R+fr2ABMFd/MjOxlhc4c+PKsx5STNcpRP9HHZcgfpK2ceIWHr2UwlT0BpX2Nv2CZss2v6WtyxfO9q4beCf6LQ6FmfANWD8/5lQ8Cc/pi4gnJDcgEXGsqNn9DtaFBOzR+lIEoH+adXsI8zrshrzF+bPHkgRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=cycoymbH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZDbmZtLw; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="cycoymbH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZDbmZtLw"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C95E714000BB;
	Thu,  4 Jun 2026 16:46:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 04 Jun 2026 16:46:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1780606017;
	 x=1780692417; bh=9L+CUePTap8dqHQfJyhsNM+v+VQPkUCuJ7Sobe05wSo=; b=
	cycoymbHQ0mvMDETgFLN7fwYWbstGU7QaRpNMmdB5FeweKLk38u10vtZYkwaesZ5
	dEIUFtXJs70Qd6g3JoQIQDVPhlCli/V8x14irxrTlqQmxP7JsqiraUcIkLsnwUDj
	bOfHwIx3q38d+n7fnGhF9zR7w4ogGlFwxgBUqGWN8ClbL0u0wIF6eBggWf72AIex
	xwRD8pZaTDWaDrcqxvBaclWaQxT3tSkriWqMmAoeMNLHwrihSeBvG4W1oWm/co4x
	xAuih3H8UZA4wOiqmt2Mc6CUDIwb39Fgkd6PlQ+jL8NNY++kwZHby8YsMfh4h8MG
	KqN4Q6+HrHeAHhPSr27u0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780606017; x=
	1780692417; bh=9L+CUePTap8dqHQfJyhsNM+v+VQPkUCuJ7Sobe05wSo=; b=Z
	DbmZtLwyav1uImySw86uEkXGln3Yl0k+5VFBI9mEmwOgdjljefVkfUc6zYowIqt8
	t8KoOSGY6qe7VdhBkhAyHFJgFkO+kKK/6vu1icUWiuS0ZlE8R+XGMNmv+3NRyJ/c
	P6jmuJwjtFwdM0VnRDa3QpOPDBRtFvBzFGIO55JBBjHb89aBqwKgCC4bgpnPWOwf
	cRFRAR8/oMzEVLhgjRVAc1a9K9szg5Fd5At8jkKm97kWRAVsAS6i4/ldmnPDYWJ+
	eTP2Na0vLm9lfJ2F5/0KzXHmoYmtE9q1UtjNzzFJVt39ff4V4q/nBXFtbw22l+9b
	bIr10wyo8upg2PBRMqRWw==
X-ME-Sender: <xms:QOQhanSTNSEtvKgWsyBJ9DZePOqO9d6qDajPmFEuUJwShkcTDDLFog>
    <xme:QOQhaqU96P8cfrvKSIrfYWtSW9Rz58GidUGWmlKzNN0rOv2_x9zLFJBD9LUi_RbGZ
    lAZDiidiT7C-w7Wa_eF2zIeTNBUPDV375UsLvV5C0q83YN0vqRCZ-U>
X-ME-Received: <xmr:QOQhasET6815wmpxLrk4HKSsDniXDSfSTnokOrsWL3v3N57ny1eexb-yJ9w>
X-ME-Proxy-Cause: dmFkZTFZ6J8tDMhYhalbhDFhFy5P0MOWL5fEkD41Gyq8P/S1S5YG3KJQhbaqOY2/blU/9O
    QFxnL6w2zNKLJs+y5K4MeGGXqwdob634Z9BOJYkIf/dO/gNEL2i/OVIJId8cKIpxtgPW0Y
    ZLQ4WeQLqZ34ImxBL73jJkhuvk9ZyLU4O9SeF1iPhEaqhv8Oc/1NaQQDFXBtMR5ifJREyv
    gdDGsG2DUdP0Ju4N6X5/EwNHLwVsB2lOB5XE/lSGehvkcb5Ib+XfO2rqOJ2Wb77z6Ts57l
    QF6PJA9wavxJguGyuSGO407ga/2/wd2O+t6Y4flmXkt0aI7Eb2iENDDHGp0wt3x0+F/hgw
    x7Rwalf+2tjTwK/q05AlOEf6Dif1MZ58bUFFxF99OA5RwSnhnH4I3tSuE7EJXqixHH4EV2
    0oTtpuZRzG9/TRoxeMEy+1hvd7FpVfoGHkDyt7zYTDfmpVhkQpqptwgo1k1ajRQkiiy/DG
    CH2+r903BH9gCc3NcWGyyfGuY11WPxsGQ/AmVBhLUpLyA5NdV4ReeVB8x0EE+p6QOvOJ8D
    nvMQzSPeQXS0ghLx0g1lSUCvSHjM7ZP5gvNRQVdN755ZRlQny8lfOkLUuQGJmwpWLLbnmQ
    tuonSoxFx/3HATi/Ls8RDdei2l+r8F6tE6BkJy/DxKKNu7hrvF+PkBawC3Tw
X-ME-Proxy: <xmx:QOQhategwZ_Gj3HzAixRYjzCRNt9Bxl5IQ_s4yZhrUYZy06gJliKQw>
    <xmx:QOQhalqzv32kTeJDaShjxDwtIY4B0_cOID0-ygAUFzWnG7gz8AjyJw>
    <xmx:QOQhauC3JHsD60LdRPwkEQgP3pba9ExsOTjWLMGPFVqqpR2Seohv1w>
    <xmx:QOQhauerRavESKcFlp_fKCm5N4kCTOws6l8zRoEawjhG-H5mFPsdGQ>
    <xmx:QeQhautjRf2QcmHlIrWbpzRkHQ3SahioGa_oMmSWjLy8h7hRjBwN2V4j>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jun 2026 16:46:55 -0400 (EDT)
Date: Thu, 4 Jun 2026 14:46:48 -0600
From: Alex Williamson <alex@shazbot.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: fengchengwen <fengchengwen@huawei.com>, wathsala.vithanage@arm.com,
 helgaas@kernel.org, wei.huang2@amd.com, zhipingz@meta.com,
 wangzhou1@hisilicon.com, wangyushan12@huawei.com, liuyonglong@huawei.com,
 kvm@vger.kernel.org, linux-pci@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH v14 0/8] vfio/pci: Add PCIe TPH support
Message-ID: <20260604144648.7427b0ac@shazbot.org>
In-Reply-To: <20260604183302.GD2487554@ziepe.ca>
References: <20260528124649.14732-1-fengchengwen@huawei.com>
	<20260601095840.3aaaa508@shazbot.org>
	<59c82855-59a7-4f0e-b534-d35535d04b93@huawei.com>
	<20260602170847.75bd159d@shazbot.org>
	<3f8d1722-6749-4f3a-b630-c96303cec284@huawei.com>
	<20260603004524.GL2487554@ziepe.ca>
	<20260603125308.0116aa14@shazbot.org>
	<20260604183302.GD2487554@ziepe.ca>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Jun 2026 15:33:02 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Wed, Jun 03, 2026 at 12:53:08PM -0600, Alex Williamson wrote:
> > On Tue, 2 Jun 2026 21:45:24 -0300
> > Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >   
> > > On Wed, Jun 03, 2026 at 08:34:53AM +0800, fengchengwen wrote:
> > >   
> > > > This translation helper is required to handle varied TPH configurations,
> > > > including cases where ST entries live inside device private registers
> > > > instead of MSI-X or TPH capability space.    
> > > 
> > > I thought we agreed vfio had to block that feature in config space due
> > > to security concerns? That's what enable_unsafe_tph is about, right?  
> > 
> > Steering tags can effectively live in one of three places.  The
> > architected locations are the TPH capability itself and the MSI-X
> > table, where support is mutually exclusive.  However the device can
> > support either of these and still enable DS mode, thus essentially
> > a third location.
> > 
> > None of these are particularly more or less unsafe than another.  It's
> > inadvisable for drivers to write to the MSI-X vector table, versus
> > using the SET_IRQS uAPI, but it's not prevented anymore via mmap.   
> 
> We'd have to go back to preventing it..

Disabling mmaps across vector tables obviously re-introduces the
performance issues on devices that don't account for a 64K exclusion
zone around the MSI-X vector table.
 
> > We don't provide direct write access to the TPH capability, but
> > backdoors to config space are not uncommon.    
> 
> I think we can discount this, if a device exposes TPH through config
> then it should keep it secure.

We have plenty of other caveats for userspace drivers that demand
"well behaved devices", so I agree we might be able to ignore the
backdoor vector.  That still means we can't control STs in DS mode, and
IV mode requires an opt-in to protect the vector table, at a potential
performance penalty, depending on the host and device.
 
> > I'm actually still wrestling with the question whether any of this
> > is really unsafe beyond the scope of ownership of the device at
> > all.  
> 
> Well there is certainly some kind of DOS argument for calling it
> unsafe, and we don't actually know what effects the TPH value even
> has.
> 
> I'd be much more worried about some "smart" accelerator device doing
> something impactful based on TPH than insecure config space for
> example.

Is that just a general sense of FUD to add weight to push the whole
thing behind an opt-in?

We could spin the effective storage locations a few different ways,
allowing TPH without an opt-in if we could limit it to the capability
location, requiring MSI-X mmap exclusion to enable devices that support
IV, and unblocking DS with another opt-in.  But if we have a general
sense that this is scary in all cases, then we might as well just have
one global opt-in.

> > > I agree in general that the presence of enable_unsafe_tph VFIO has to
> > > report the per-device steering tags to userspace so it can program the
> > > device specific registers, nothing else can do this.  
> > 
> > What's the scope of "nothing else" here?  The raw ST value for a CPU is
> > derived from an ACPI _DSM associated to a root port.  So if the scope
> > is that the kernel needs to provide that translation, I agree, but
> > where in the kernel it's provided may still require some thought.  
> 
> The APIs accept a PCI device:
> 
> int pcie_tph_get_cpu_st(struct pci_dev *pdev, enum tph_mem_type mem_type,
> 			unsigned int cpu, u16 *tag)
> 
> 
> IIRC the ACPI allows it to vary based on the source. Nothing else
> could provide the PCI device owned by VFIO to these functions..

The function immediately translates the endpoint function to a root
bridge, so I could certainly imagine some pcie port driver that creates
an interface to provide ST translations.  It could really be exposed
through sysfs too, except the entries are a multiple of NR_CPUS, so the
attribute count would explode if we adhere to a single value per
attribute.  Regardless, it's an ACPI lookup, so it doesn't rely on
device ownership, only using the device to lookup the ACPI companion to
invoke the DSM.

> > We also need to consider how this incorporates Zhiping's series, where
> > TPH values can be associated to a dmabuf.  Would userspace get access
> > to those raw TPH values to program the initiator?  It must for DS
> > support.  Therefore the interface became one of the user handling raw
> > ST values and the CPU ID to ST translation became this ill-fitting
> > sidecar.  
> 
> Arguably yes, likely iommufd would need an API to return the ST of the
> dmabuf when it maps it.

Right, so hosting a CPU ID to ST translation interface in the vfio-pci
device feature interface feels pretty shortsighted.  I don't know what
it should look like though.  Thanks,

Alex
