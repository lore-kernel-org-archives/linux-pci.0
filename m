Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50802175A88
	for <linux-pci@vger.kernel.org>; Thu,  9 Jul 2026 02:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783565114; cv=none; b=Q51LRFXildPA+c5/8wbtfyncjPnchiAsscxuu7370e9j9QvNAeqcRj/55up9QwuS4X5K3GkbqQtDpMDyevqiCTTxMgSOqRq2bKX6JQz9ymi8KaoXEoHv+/z9ACeOFeK0CqnW/Nlog/77sUvO23fnEXFRPeo+/bT6jdKe8KZhA6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783565114; c=relaxed/simple;
	bh=5yogYnG6Dlco/lFZ71lVJUPfGlx8F1VylFaX7l1IeZQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=aOEj6dlWbtT/JPV8sRjh+qhgsaKJ77dp0NkL2EbcBUrmyQfwqtrklWpB3kNtEnjmBHQDUyobMxursF1Iskat/emDztArSHw8daJjBJ2ezerEM2BE6Rf9npLbAaJfuGvfPvNSjCvcXXWrjPKf9E2qXUPRSTEGLpAY45MucRbHK3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eufZ2GUo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eufZ2GUo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B051F00A3D;
	Thu,  9 Jul 2026 02:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783565112;
	bh=wylYEceSROIfSQqRInOTqju8R0pfnz5zMsXN2HHh0qg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=eufZ2GUoN8+BeiuUAqP56kvHirhPhJXHTZlP2atA6uTr37VaFASxzKoqPPw0qJiXS
	 q6PCzpq44xAof2cwKC7H0G1Rq6RzAsbtRUW+H/hZXD9Om7sk3EiHaoCAsyGCjhHPj+
	 OWMc+0EEjzDpbvjlN5IDuaZWJJqCjojKEY8R3rRowCUz9wcbSmU9mVa9ZtiXtPbm22
	 dNGZ8pDzwYIA+BxdpyKy/NHZSmlFUqeHvHYzjq5anvcn4+2gI3q1kT+BAtytsYIgLJ
	 hgnqwNWG3T80rsYcWSDpR8JLsmKbdh1uOrlbrwdRyNIcFFplQL0XUj64aJMro9X5QE
	 Irw6J+4zIWaiA==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5B330F40068;
	Wed,  8 Jul 2026 22:45:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 08 Jul 2026 22:45:11 -0400
X-ME-Sender: <xms:NwtPalJwm70TMKrYaY-bh8D7e0SDhdIfdMqZu9ANTzCAHyHLy_5j9A>
    <xme:NwtPaorWp8GAp3wK46FGWxFmexyVMQoLvTw9MA8OjPzZD6uQ7e6qnwrLQ-NYrSuFG
    Ue_AuEGgAbmAgdWtVOXONYC_GNaS5OqAOZ7VYFiDlV_JiS5amfhDE0>
X-ME-Received: <xmr:NwtPajxrEjy62J6DT43rPW0BpXkFH3Cnyn60w4FHXcL7q8eh-j-JKxEnsy7dV5uUdZi-4tVKeYYsLkodjQCDjU2yEr1_MeJ9vTM>
X-ME-Proxy-Cause: dmFkZTE1C3L7Zr11pLJKwAhuU92xmmLnv4zXE4T/EqOBslopKhtxVbexgJRKkK4ct0SSB1
    2lx+D4BJxiAZyDeVAnsgWjvO1RVgcBM4+MSlw1m0kP5JMx9hTxkoPVOrR4Hx8MaKJOn5im
    2eBpl3TY0TaLHNP7EcUfEX/i1c4Y8W/G8G6vHCtfbWnLa+nTFOaAWJ+bEcLqDY87yO3iZs
    qrcxTDIP+HLRida1YgAhQSQ+w0iSUQV7fEdDe15IQGW1N+qnAOkGPeqUiGzuTO8x84n/mn
    nEhSnk0DaWCayCnZdkXZQ3HPKfNll61w1b5MEAzD2MY5oxOLMDLXsa/sP+6/S+Hc5mhfHl
    +6ZGKzsdOj2Js6qSeB7T7oU6SE6zOBBJpyZ5tEzTLJjYcZXs3rdI56Cc50sP6Xv/yGuGfo
    DZ8INkEVkoNyL+1WwU/mJ9G/e9W/olV5lXe/kKdcMMQLHBGJ2APiE4X3BFZ/Kzy2TvoE4n
    b6eGk6aCu6oP2/uO9kwYd0Fk8oiYvJ7xzHZfh9sBoHHHAuQ5mUjCH1e/gBbhzEIDh42yvh
    ZuJL7v3/OhCwSvDpvTl1nQjqelfwUIgFPS26GDiGsOpeLTHm+hllB/t1uVDcw+VQFWvX/y
    2toWU8WGbkz0DLuB/VHRAZ5E2TA2oWXkqwDkMjw2K4mk4JrapicQIzNt5yKQ
X-ME-Proxy: <xmx:NwtPakeaMFP8EMgeCxanSd71Ck3aPijH7-TUQo3UREFMvh4iv2ozPQ>
    <xmx:NwtPandbb98JOxdn313nLmfR3igg0V7hr1CxjDhP6vETXlO1pIWAkQ>
    <xmx:NwtPauYubu9kU8u2_1JwBDU3AVYXlGwWSSE8A0PVt9Fr4kn21tnntA>
    <xmx:NwtPag-Gz4SogRiBIfOX36H7mfI-u6JQ85kRj9YWUbKSNsFBRM-xlA>
    <xmx:NwtPaiUS7RLWOsc7Gc_JPbUOfy64-Y06glGByCLxqZB9ktsouxsLDXJM>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 22:45:10 -0400 (EDT)
Date: Wed, 08 Jul 2026 19:45:09 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, 
 "Dan Williams (nvidia)" <djbw@kernel.org>
Cc: linux-coco@lists.linux.dev, 
 linux-pci@vger.kernel.org, 
 driver-core@lists.linux.dev, 
 ankita@nvidia.com, 
 Aaron Tomlin <atomlin@atomlin.com>, 
 Alexey Kardashevskiy <aik@amd.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Daniel Gomez <da.gomez@kernel.org>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, 
 Lukas Wunner <lukas@wunner.de>, 
 Petr Pavlu <petr.pavlu@suse.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Sami Tolvanen <samitolvanen@google.com>, 
 Samuel Ortiz <sameo@rivosinc.com>, 
 Saravana Kannan <saravanak@google.com>, 
 Will Deacon <will@kernel.org>, 
 Xu Yilun <yilun.xu@linux.intel.com>
Message-ID: <6a4f0b35683b4_353c8910011@djbw-dev.notmuch>
In-Reply-To: <20260708143153.GH118978@ziepe.ca>
References: <20260705220819.2472765-1-djbw@kernel.org>
 <20260706125140.GB107792@ziepe.ca>
 <6a4c163072c60_174db6100c4@djbw-dev.notmuch>
 <20260707124321.GF118978@ziepe.ca>
 <6a4d95fcc92c2_2f05d5100f7@djbw-dev.notmuch>
 <20260708143153.GH118978@ziepe.ca>
Subject: Re: [PATCH 00/15] Device Evidence and Trust for PCI Security Protocol
 (TDISP)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jason Gunthorpe wrote:
> On Tue, Jul 07, 2026 at 05:12:44PM -0700, Dan Williams (nvidia) wrote:
>  
> > 1/ We previously discussed a use case to operate a device's private MMIO
> > while not allowing access to private memory (software encrypted NVME
> > with private MMIO [1]). Many of the following comments are based on
> > preserving this assumption so you can save some reading if we agree that
> > use case can be abandoned.
> 
> force_dma_unencrypted() does not *prevent* device access to private
> memory and provides no security properties on its own. It's only
> purpose is to inform the DMA API what the HW restrictions are for
> doing DMA.

Right, to be clear, this mode's security properties come from never
asking the TSM to enable private DMA while the device is in RUN.

force_dma_unencrypted() has no security properties.

> The use case I had in mind relied on the vIOMMU to police access to
> the private memory. I think if you do T=1 and ADVERSARY you must have
> a vIOMMU or it is an illogical configuration.

Ok, the software encryption aspect of the suggestion was what threw me.
So we are saying, "no need, outside of defense in depth or data at rest
concerns, to include software encryption on top of an NVME device being
operated adversarially with T=1."

> So, IMHO there is no use case for a T=1 device to only use shared
> memory, I would abandon that combination.
> 
> > 2/ The confirmation of the trust level and the enabling of DMA are
> > separated in time from setting the trust level and entering the RUN
> > state.
> > 
> > All the archs separate the RUN step from the ENABLE DMA step, and the
> > implementation separates those steps in time.
> 
> Yes, until the device is fully accepted the DMA has to be kept off. If
> you have to measure in the RUN state then we must have a second step
> after measurement completes, however we are measuring in LOCKED right?

Yes, measure while in LOCKED, but nothing strictly prevents taking
measurements after RUN.

> > echo tsm0 > $pdev/tsm/lock
> > cat $nonce | device-evidence dump $pdev
> > device-evidence validate $pdev $generation
> 
> So the device is in LOCKED here, DMA remains off both because of
> LOCKED and becuase ENABLE DMA has not been done.
> 
> > echo 1 > $pdev/tsm/accept
> 
> And now it is RUN. So I don't see the issue with enabling DMA at the
> same time as gonig to RUN? (though defering it to driver probe would
> be a very nice touch as well)

It requires "accept" to consider the trust level. E.g. what does it mean
to do something like change requirements after accept?

echo full $pdev/trust
echo 1 > $pdev/tsm/accept
echo adversary > $pdev/trust

In that scenario this now adversary device may have been allowed to
operate without an enforcing vIOMMU, and needs to unlock the device to
correct that.

Delaying enable DMA means the implementation can say, "all trust and
security privileges are reconciled at device driver bind, and revoked at
unbind".

> With this API you can't set the devices to RUN and *then* collect the
> evidence, is that restriction OK?

The Enable DMA step requires evidence in the end. So it is more
implementation ergonomics driving whether "accept" includes Enable DMA
or defers to driver bind.

> > echo full > $pdev/trust
> > echo $pdev > $driver/bind
> 
> Then we can set the trust and bind the driver, knowing that the T=1
> security property is in place.

Or, "accept" success tells you the full T=1 property is required for
"bind" to succeed.

> > The configuration window where $pdev/trust and $pdev/accept can be
> > dynamically changing should not be changing the force_dma_unencrypyted()
> > result if only because that value will mismatch the hardware state until
> > the next ->dma_configure() event.
> 
> T=x cannot be changed while a driver is bound, we need to block
> that. Changing it will mess up all DMA and the DMA API won't work
> anymore.
> 
> Thus force_dma_unencrypted() can only change when a driver is
> unbound.
> 
> If a driver is unbound nothing ever reads force_dma_unencrypted() so
> it is safe to change it, thus we can just synchronize T=1 and
> force_dma_unencrypted() whenever T changes.
> 
> The error case has to wait for the driver to unbind if userspace wants
> to go from ERROR->UNLOCKED. IMHO for RAS we are going to need a flow
> to logically go from ERROR->RUN, probably with the 'same device
> acceptance' I suggested earlier. In this case the DMAs will be halted,
> the devices gets back to T=1 and RUN, then the DMAs are turned on
> again. The driver remains in T=1 and force_dma_unencrypted() is always
> false.

Ideally this recovery does not need userspace round trips, but for that
the kernel needs SPDM transcript parsing. The measurement digest that
CCA provides is over the full previous transcript. A fresh nonce to
validate same device leads to the kernel need to validate the signature
with a cached key and compare the extracted measurement payload from the
previous transcript.

> > There are also buses and paravisors that may know that private-DMA is
> > enabled for a device by construction. In that case it is also a "trusted
> > to access" signal, and not a "required to access" signal.
> 
> In this case they wire force_dma_unencrypted()=false.

Yeah, I just need a scheme where modular bus providers do not end up
compromising the private / unexported method of changing the flag that
force_dma_unencrypted() consumes.

> > My answer, given the concerns of drivers dangerously flipping the
> > force_dma_unencrypted() result at runtime was to place it in 'struct
> > device_private' 
> 
> Yes, this seems good idea in general
> 
> > Otherwise it is confusing when 2 devices are at FULL trust, but
> > one has private memory access and the other does not. One is FULL the
> > other is FULL+.
> 
> It is confusing when phrased like this, but this is also why I was
> suggesting below that a pure trust level may not be sufficient as we
> have quite a cross product of scenarios.
> 
> If the user wants to operate a device without T=1 and without
> ADVERSARY then that's goofy, but technically the kernel doesn't really
> need to care? It can do it.
> 
> IMHO a big question is how much do we want the kernel to nanny
> userspace by having options to double check its work?
> 
> Either we trust the user to have checked all the policy conditions
> before writing /sys/trust, or we encode some policy conditions and
> tell the kernel so it can double-check prior to probe.
> 
> At least if we omit the double check it can be fairly easy to add in
> later if it really was needed for some time of use reason.

As long as IOMMU presence can be enumerated prior to acceptance, T=1
always includes private DMA, and the T=1 status is tracked independent
of the trust level then yes, the cross product can be avoided.

> > The question is whether these requirements belong on a central device
> > trust mechanism bitmap or should be pushed out to other ABI.
> 
> Yes, for sure, I don't have a good sense what is better.
> 
> > For
> > example, if the presence of the secure IOMMU is enumerated
> > after the device is in the LOCKED state then userspace policy can know
> > what it is getting into without needing to tell the kernel. 
> 
> Yes, I think for almost all of this we could push it out to userspace
> and have knobs all over. Like IOMMU already has a knob to switch to
> DMA mode, we could add an IOMMU specific trust level to set ADVERSARY
> also if we go in this direction.
> 
> But, I also do really like the idea of a central knob that was fairly
> general and simple DISABLE/ADVERSARY/FULL which all sorts of things
> can hang off. Including IOMMU and the drivers themselves that may
> change operation in ADVERSARY mode.

Yes, even if some of the ancillary requirements move to other ABI the
central question of DISABLE/ADVERSARY/FULL stays common.

> That means they need simple general definitions for what they are, and
> I really like this ADVERSARY naming vs trust as it makes it very clear
> what the device disposition intention is.

I will do the "device_adversarial()" conversion throughout.

'struct device' grows some "request" policy for trust and T=1 that can
be changed by modules etc. 'struct device_private' grows the operational
trust level stable under device_lock() and a new flag to reflect T=1.
