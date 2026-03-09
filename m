Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4B1395244;
	Mon,  9 Mar 2026 11:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773056390; cv=none; b=lI3wMzrfwsZHSFChTfV+YwWvDKGeiJcOJOdaSapoMgHsqsz+F4+KCldmLxiRNMrjfhuFzBIyyxonD5tkaNmMbUpuyukXT8fzhpleaC9dj4yju6Elvg6qbfNCcOHPrXecaTi89ndL36zm9+5d3ld9Mw6JfMRbL752Tb+bvO4Axyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773056390; c=relaxed/simple;
	bh=55OKdMaij6tI6qvCc02IHRSTa9LXQaT8DGdXB+58iXw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u6/E/Uj9ui9YsfoEOUSdBJITwZ8cK77aSSwFxE0j/2X3qIhJ7I6tPIchnjl3oVBf0TRXcR4bfUV1hMlWYzkqrT90HMYHiNT3d1JKVajGwuRYgFDaU+oGdAz6Lry8sClnRscm2q5Oy71uSmS9EPUbb1xjeQXDINGOns6swz7IDAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fTw5K0qxFzJ46kV;
	Mon,  9 Mar 2026 19:39:01 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id EF36540086;
	Mon,  9 Mar 2026 19:39:43 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 9 Mar
 2026 11:39:42 +0000
Date: Mon, 9 Mar 2026 11:39:41 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <dan.j.williams@intel.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Alistair
 Francis <alistair23@gmail.com>, <bhelgaas@google.com>,
	<rust-for-linux@vger.kernel.org>, <akpm@linux-foundation.org>,
	<linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <alex.gaynor@gmail.com>,
	<benno.lossin@proton.me>, <boqun.feng@gmail.com>, <a.hindborg@kernel.org>,
	<gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <tmgross@umich.edu>,
	<ojeda@kernel.org>, <wilfred.mallawa@wdc.com>, <aliceryhl@google.com>,
	"Alistair Francis" <alistair.francis@wdc.com>, <aneesh.kumar@kernel.org>,
	<yilun.xu@linux.intel.com>, <aik@amd.com>, Mathieu Poirier
	<mathieu.poirier@linaro.org>, Thomas Fossati <thomas.fossati@linaro.org>
Subject: Re: [RFC v3 00/27] lib: Rust implementation of SPDM
Message-ID: <20260309113941.00007258@huawei.com>
In-Reply-To: <69a9de4791667_6423c1006c@dwillia2-mobl4.notmuch>
References: <20260219143129.GF723117@nvidia.com>
	<aZcnTnYJ61Kma0yd@wunner.de>
	<20260219173937.GH723117@nvidia.com>
	<aZgbukYiIxg44_e7@wunner.de>
	<20260220141057.GL723117@nvidia.com>
	<aZn9cfhv0YRxI1mw@wunner.de>
	<699a3ff3f019a_1cc5100e1@dwillia2-mobl4.notmuch>
	<20260223171527.000016ef@huawei.com>
	<699ca65b5ff9b_1cc510019@dwillia2-mobl4.notmuch>
	<69a903d4511e4_6423c1004d@dwillia2-mobl4.notmuch>
	<20260305124837.GS972761@nvidia.com>
	<69a9de4791667_6423c1006c@dwillia2-mobl4.notmuch>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Thu, 5 Mar 2026 11:49:27 -0800
dan.j.williams@intel.com wrote:

> Jason Gunthorpe wrote:
> > On Wed, Mar 04, 2026 at 08:17:24PM -0800, dan.j.williams@intel.com wrote:
> >   
> > > So I ended up dropping this bit of the proposal because there is no need
> > > for the kernel to be involved in any decision about the validity and
> > > sufficiency of device evidence. Userspace has everything it needs to
> > > make that initial determination. "Authenticated" simply means "evidence
> > > ready".  
> > 
> > Right, this caching was only for the automatic device recovery flow.
> > 
> > I think the kernel still probably needs to check the signed nonce
> > against the device's public key as part of the SPDM handshake, but it
> > doesn't need to do any validation of the public key.  
> 
> Yes, and I think this is a subtle detail that I was failing to grok /
> communicate previously. Of course the native SPDM implementation needs
> to be able to perform a challenge response to establish the session. All
> of the platform TSMs also internally carry out that protocol. The
> difference with platform TSMs being that the kernel only sees the
> resulting evidence.

I had a half written email on this but you two already covered much of it
and discussion is heading where I was going anyway :)

For native / CMA:

I agree that the kernel 'should' check the signature in the final
challenge/auth message so as to validate the whole flow was valid.
Fine to leave cert checking to userspace - that was earlier in
the flow anyway.  I'd also like it to do sanity checks on the cert
chain (for internal consistency and the few requirements PCI puts
on the leaf cert), some of which it needs to do to pull the public
key out of the leaf anyway. I think that's all cheap stuff to
detect failures early.

As far as I can tell, the signature check isn't strictly necessary
as userspace has all the info to do that signature check on the
transcript.  Bit of nasty parsing code but not particularly bad and
likely to be in tooling anyway for debug purposes. (I'm assuming that's
why there is a 'probably' above :)

We only _need_ the kernel to check the signature (in challenge/auth)
for the (future) recovery flow.

As Alastair's rust demonstrates though it's low cost in terms
of complexity to ensure internal consistency. I'm assuming
the various TSMs are doing similar?

Anyhow, all that really says is I'd like the internal consistency of
the SPDM session checking in now.  Leave checking we actually trust
the cert + measurements to user space (and all the stuff below
on recovery comes later).
> 
> So when / if the PCI/TSM evidence implementation grows kernel-internal
> revalidate support it will be growing something like pdev->tsm->pubkey
> that is installed / cached "after the fact" for platform TSMs. For the
> native SPDM driver, pdev->tsm->pubkey can be installed at 'struct
> pci_tsm_ops::connect()' time because it already has it parsed for its
> own internal purposes.

Agreed it'll be something along those lines.

> 
> > > Automatic device recovery into the TCB is a separate concern that needs
> > > to be prepared to handle more than just "is this device able to generate
> > > a fresh signature with the same cert chain that userspace saw before".
> > > Yes, that is a minimal requirement but not sufficient for many cases.
> > > For example cases that want to validate measurements, interface reports,
> > > or opt-out of recovery because SPDM session loss is fatal.  
> > 
> > Yeah, but it is a pretty good starting point :)
> >   
> > > Authenticate a device
> > > =====================
> > > Look in /sys/class/tsm to find a tsmN device which will be either an
> > > instance associated with native kernel PCI CMA/SPDM or a platform tsm
> > > like the one provided by AMD SEV-TIO, ARM CCA, Intel TDX, etc...
> > > 
> > > echo tsmN > /sys/bus/pci/devices/$device/tsm/connect
> > > 
> > > Once that succeeds the PCI/TSM evidence netlink interface is available
> > > to dump any signatures created during that session establishment.
> > > 
> > > After userspace is happy with that evidence it can bind a driver.
> > > 
> > > If running in a confidential VM where the TSM driver is capable of
> > > securing more than just an SPDM session the interface is:
> > > 
> > > echo tsmN > /sys/bus/pci/devices/$device/tsm/lock
> > > 
> > > Similar evidence can be collected, and when userspace is happy with it
> > > it can accept the device:
> > > 
> > > echo 1 > /sys/bus/pci/devices/$device/tsm/accept
> > > 
> > > ...and bind a driver.  
> > 
> > Makes sense to me, userspace can figure out what flow to use.
> >   
> > > Auto-recover device (future work)
> > > =================================
> > > By default, devices fall out of the TCB on recovery events for the TDISP
> > > case and need userspace to rerun the lock and accept flow. For the
> > > native SPDM CMA case the default is that the kernel continues to operate
> > > the device post recovery and only userspace polling could detect device
> > > replacement.  
> > 
> > Even with SPDM the kernel should know if the SPDM session has to be
> > restarted right? It could squirt out a netlink multicast message, or a
> > uevent on these events, so the polling is not baked into the
> > architecture?  
> 
> Right, "SPDM session lost" is a reasonable notification to put into the
> interface and "future work" bucket. The polling comment was with respect
> to the near term limitation of this minimally viable first step.
> 
> > > To go beyond those defaults the kernel needs userpsace to tell it how to
> > > re-validate the device. I think that can be as simple as a netlink
> > > message to store hashes of cert chains or measurements and then use
> > > those in a new challenge / response with the device with a kernel
> > > decided nonce.  
> > 
> > Yeah, I see several reasonable options:  
> 
> +1 to these.
> 
> > 1) Above, kernel is informed of hashes and does an exact content
> >    compare
> > 
> > 2) The driver operating the device has a built in same-device policy
> >    and deep parses the evidence for equivilance after the private key
> >    is validated, carefully avoiding volatile evidence bytes.  
> 
> Yes, Lukas was also pointing out that the existing driver reset/resume
> handlers could signal "revalidated" as well if the PCI layer had no
> opinion.
> 
> ...but the point is that it is a menu of options, not a static policy.
> 
> > 3) User provides a BPF program and it runs on the evidence
> > 
> > 4) Standards bodies define a generic "same device check" algorithm for
> >    the evidence and core kernel just does this for compatible devices
> >   
> > > The equivalent behavior to what is present in this SPDM proposal is
> > > extend drivers/pci/tsm/evidence.c to add a netlink operation that tells
> > > the kernel to cache the public-key and challenge the device regenerate a
> > > valid signature. Then plumb all the recovery paths to call a new
> > > 'struct pci_tsm_ops::revalidate()' operation in all the same places
> > > where this patch set wants to reauthenticate. Later when something more
> > > sophisticated than "challenge the device to create a signature" comes
> > > along it can reuse those revalidate() hooks.  
> > 
> > That's a nice simple starting point.  
> 
> Appreciate it. Still want to close the loop with Lukas to make sure
> everything he wants to do for native SPDM can fit in this scheme, but I
> am feeling increasingly confident.

So far all sounds good to me.

Jonathan


