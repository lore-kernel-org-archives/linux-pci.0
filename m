Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951AADF6C;
	Wed,  8 Jul 2026 00:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783469570; cv=none; b=TrRHWx6Zn3CnfXaYBG98wRgw1BjK2JxPIpFmDERJjbshUwEGwXMlWBS6+DOE/6tLsqdmJ6htOrtza+P4zO5ECvzFQk+ICZ5+BUVBXg/845ajFBvH7ftlMFMiEDwkTSyj+4fZ0/lVa7tWkb53EDFyb5UH84r6Ezpvb58skjjvjR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783469570; c=relaxed/simple;
	bh=uWbkefmHV8WOrsqMlAMvzHvl5OEe1Rw2ZiJAOe+cRSI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Mj60pr9nd8/g/eiKovgZ7EzwFljRC+bhLQ+N8pqi+ARQ/aL6Jh1qR/mSPJeRMq41eQZYvFyAAznyhruIMGI8jhql5I2ItLfR9mLFUk+WKma3bUX87jl/PkA+5WPObmbP+5a+CD7ZyUfCKm70Q842gME03yXhVmMQekXsjTiDaPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NnbTJfFs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NnbTJfFs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AABE1F000E9;
	Wed,  8 Jul 2026 00:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783469568;
	bh=XygNDL9LJUCyKIdSKNrAz2OLah10cRGyd/1yQENfFnQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=NnbTJfFsfj2zkbkzlWkWgo5CvsIHdc+c4ZXBvv3hogKcEuhFibxIdqHuoJrJ7fa9T
	 aMbi+JusCyEuYXTPLt5J0eY+1ZSsk5rHVNi5Eqweqsref0RdyUAunCGXw+JMppllXV
	 aX5X/LslSj5kzj9xEhI4M3kXs/OybASzU+jy9ueTeH1memSpF9ePt+OsCJ1m1aBsrS
	 4gVmbqxOpZSZnKPkTXI6UZKq9ucVwWSnkxqjfNg2uE7o2W/axfYcV6kPqLSBxLv/PF
	 xYl+pOrvGz9I1aNxmxT/SXB5rFxqMHkITu5raRbqCKboxxZsgnxBcpo+W6POu3SFMP
	 sJW7rHVUMrd+A==
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id A8620F40068;
	Tue,  7 Jul 2026 20:12:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 07 Jul 2026 20:12:46 -0400
X-ME-Sender: <xms:_pVNagkZf3ztUU_zfONuDFS4gzCmKKwdpgNHXrlvBtZwxuXNGtv3Vw>
    <xme:_pVNanUW38wTwp9bZ84mj9_Ht0XJjJSCQt_uOiUVtB7Epc8fA-pKCt1m4_hLAfDNO
    s_x8at0mA9_9wgpzCIXxqJIsqctIhgn3YR9UbjFeZzmr2ZejLQePfI>
X-ME-Received: <xmr:_pVNakvEqVxXeRowHhoRgfgXvXsnCTg5xA3wtie5RjTguTiWXDqXKTcl6e75zD1GlNWJmz1h_lpAi_VAlOTJcz1wR0YAZKOWCHU>
X-ME-Proxy-Cause: dmFkZTEXr+/q7I+RcNXjcV3ObWqWLeEt1fwfx5A4rBgJxQvqhh3hbaJSlC5CUOD6s35Z+T
    fH2v6lBffG/knpi5LGaFbUbuQsLVS53QXlC9rctoUQzl2za5EBO5yEdgkxUNHJKLrTS0Rl
    Swl8bSG2y/zxnEfjbN6QXUvP3BzyrG8/BDHndVq7u/mj9e6yxrSUj/16lrt6ygnUlNGBIL
    9OG75/FpjzBrWvpAPZHkyYMLQFhSzMAklGbNuAXCqeulcDn/1+bT2PLuIcvBzG4OFoOpve
    UP3Fhqw7DQLVERIdQssZThs/Rz00KFXGUug1zftqpNDsGReGWdlvpCXMN4BVxyBnpLv3To
    4QkuQpyVsKM+LnBvLLlWLeEzTPBArlLNHLYKbTGfzyWS0MNhKSDFoyU03XGcKsuXxGOC+A
    rqozYUMuAfjRiiotGV0EczT8p8EX7iPzjEkJdarIYFKP9TSmQKq5xZm+MPgOYUTbleowPG
    vfNO5SPMphDPgNQWibDSxyFAfCcCbQHlohqESdd92NqwzgM9t1aHz8szryKxEno5x0PEVJ
    mLaHxoLU9Ih6BrLgxG6v3VAalaDjvG2Ukm3CbqSfjNmJEvd0Z7PdtubYy1jnEI2tS5j1Hk
    Re0JxDRMx1jChhCNvODyJk57b+IdXA658fZzsFChL+NSXeC1USw7O/4p3ATw
X-ME-Proxy: <xmx:_pVNaqr_eEn0kTIs2bj-Qb6uyWqSO_BQXI0rxi1DcFbm1icCe8iazA>
    <xmx:_pVNap54nRjrQ0Dw4dwrTu7xvWnvYPWhkbHXoPW5I29oohqiG5hmlQ>
    <xmx:_pVNaoGiNWgX5H5YLHltNtj39JeS4tjx6MJ2SDPR4CsLVJiqpwVYmw>
    <xmx:_pVNag4BfSDnV7x2YcuqEx5CzLSI2HG4QbKQiPPzkrnXIxLf1C4bDQ>
    <xmx:_pVNariKX72MEAoKAzBhvD2vRF5kxgcxsOyL4RLKoP-hl2WRmMGpsHV3>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 20:12:45 -0400 (EDT)
Date: Tue, 07 Jul 2026 17:12:44 -0700
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
Message-ID: <6a4d95fcc92c2_2f05d5100f7@djbw-dev.notmuch>
In-Reply-To: <20260707124321.GF118978@ziepe.ca>
References: <20260705220819.2472765-1-djbw@kernel.org>
 <20260706125140.GB107792@ziepe.ca>
 <6a4c163072c60_174db6100c4@djbw-dev.notmuch>
 <20260707124321.GF118978@ziepe.ca>
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
> On Mon, Jul 06, 2026 at 01:55:12PM -0700, Dan Williams (nvidia) wrote:
> > Jason Gunthorpe wrote:
> > > On Sun, Jul 05, 2026 at 03:08:04PM -0700, Dan Williams wrote:
> > > > * NONE: no usage of the device unless the trust is explicitly overridden
> > > >   by user policy specified via a driver flag, module flag, or uapi (TBD).
> > > > 
> > > > * ADVERSARY: needs acknowledgement from the bus and IOMMU / DMA layers
> > > >   that the device is limited to strict IOMMU translation behavior. Drivers
> > > >   can use this as a signal to limit functionality. This designation
> > > >   implies follow-on IOMMU and bus enabling work for features like
> > > >   arranging for the device to attach to a blocked IOMMU domain when
> > > >   detached from a driver.
> > > > 
> > > > * AUTO: typical / historical Linux driver model.
> > > > 
> > > > * TCB: a trust level that only exists in Confidential Computing
> > > >   environments. When acked by the IOMMU / DMA layer it enables the device
> > > >   to issue direct-DMA to private/encrypted addresses or otherwise attach to
> > > >   a secure vIOMMU within the TCB.
> > > 
> > > I'm not sure I entirely like this one, certainly it needs to be
> > > possible to have both T=1 and ADVERSARY together.
> > 
> > T=1 and ADVERSARY are independent for link encryption and private MMIO.
> > In other words the device is placed into the TDISP RUN state independent
> > of its trust level. 
> 
> That's the right thing
> 
> > Downstream accesses to the device must have T=1, and
> > its upstream accesses will have T=1, but with force_dma_unencrypted() ==
> > true.
> 
> That should never happen. Once in RUN force_dma_unencrypyted() ==
> false, it has nothing to do with the trust level.

2 concerns:

1/ We previously discussed a use case to operate a device's private MMIO
while not allowing access to private memory (software encrypted NVME
with private MMIO [1]). Many of the following comments are based on
preserving this assumption so you can save some reading if we agree that
use case can be abandoned.

[1]: https://lore.kernel.org/all/20260326120046.GG67624@nvidia.com/

If the private-MMIO-no-private-DMA case exists then ->dma_configure()
needs a "trusted to access private-DMA" signal not a "required to access
private-DMA" signal to determine how to set force_dma_unencrypyted()
while the device is in the RUN state. I am ok to reconsider that use
case, but that was part of what lead to the proposal for
force_dma_unencrypyted() to use the trust level.

2/ The confirmation of the trust level and the enabling of DMA are
separated in time from setting the trust level and entering the RUN
state.

All the archs separate the RUN step from the ENABLE DMA step, and the
implementation separates those steps in time.

echo tsm0 > $pdev/tsm/lock
cat $nonce | device-evidence dump $pdev
device-evidence validate $pdev $generation
echo full > $pdev/trust
echo 1 > $pdev/tsm/accept
<--- T=1 and force_dma_unencrypted() remains true in this window
echo $pdev > $driver/bind

The configuration window where $pdev/trust and $pdev/accept can be
dynamically changing should not be changing the force_dma_unencrypyted()
result if only because that value will mismatch the hardware state until
the next ->dma_configure() event.


Another factor that lead to the assumption that "operational trust level
configures force_dma_unencrypted()" is taken from a comment from Greg
[2].

There are also buses and paravisors that may know that private-DMA is
enabled for a device by construction. In that case it is also a "trusted
to access" signal, and not a "required to access" signal.

My answer, given the concerns of drivers dangerously flipping the
force_dma_unencrypted() result at runtime was to place it in 'struct
device_private' and make private memory access a result of the trust
level. Otherwise it is confusing when 2 devices are at FULL trust, but
one has private memory access and the other does not. One is FULL the
other is FULL+.

[2]: http://lore.kernel.org/2026031230-mastiff-create-7593@gregkh

> Even if you set ADVERSARY it should still be bouncing partial page
> DMAs into private memory. The point of running something like this is
> to remove the shared memory attack surface - ie the hypervisor SW. The
> attack surface is reduced to the device itself by remaining in shared
> memory.

Yes.

> 
> > > I'd also argue this list is missing "FULL" trust, which is the
> > > historical Linux behavior for a normal device. AUTO should be
> > > selecting between FULL/ADVERSARY based on things like the ACPI/etc as
> > > it does today.
> > 
> > 1/ that is effectively how the UNSET level behaves. If the
> > bus has not set ADVERSARY before device_add() then the default behavior
> > is the AUTO level. Where AUTO means all of the automatic privileges a
> > device can be offered without needing any other coordination.
> 
> I think my other remark about two enums is some of the issue, the
> policy can have things like UNSET or AUTO, but once the driver starts
> to probe an in-effect mode should be computed and be concrete. Having
> a driver run with a trust mode of AUTO or UNSET is just confusing.

UNSET never escapes to something a driver would see, but yes, appears
AUTO is too confusing a term compared to FULL.

> > 2/ The ambiguity and conflict occurs at ->dma_configure() time when the
> > bus and IOMMU layer want to reject the device's access to some privilege
> > by failing. When FULL is defined as !ADVERSARY then it is difficult to
> > describe the semantics when FULL trust honors rejections to private DMA
> > and when it falls back to shared operation.
> 
> Given that the trust level shouldn't impact force_dma_unencrypted(),
> the only thing left is to setup the IOMMU differently, and maybe
> operate a driver in a hardened mode or something like that.
> 
> I don't see what the TCB is supposed to be changing here.
> 
> That leaves it just as a policy gate to check that T=1, I'm not sure
> if that is worthwhile enough for dedicated UAPI?

If we ditch the private-MMIO-no-private-DMA case then yes I can
see T=1 being a uniform requirement. 

> > The above more points to a need to have an explicit trust level for
> > adversarial private memory access. The address spaces are distinct
> > assets with different levels of trust.
> > 
> > UNSET: bus picks initial level, or leaves it to the device_core().
> > NONE:
> > ADVERSARY: Device can be in T=0, or T=1 mode (UNLOCKED, or RUN).
> > AUTO: Could rename this to be FULL or ALL or DEFAULT, I still keep
> >       coming back to the "AUTO" name because the privileges are not
> >       uniform based on the IOMMU / DMA topology and device capability.
> >       Again, the TDISP state is independent. The TSM driver does
> >       not get called to gatekeep and verify access in this mode.
> > TCB_ADVERSARY: or PRIVATE_ADVERSARY. Device can access private platform
> > 	       resources iff an enforcing IOMMU is present.
> > TCB: or PRIVATE_FULL, automatically enable all access privileges
> >      including private memory access.
> 
> Yeah, we can keep adding more modes to make a big cross product, but
> I do wonder if this is going to get too big..

The bus specific requirements like private MMIO + link encryption are
pushed out to the TSM driver. Userspace policy that wants to require
that the TSM driver is consulted on enable private DMA events needs to
arrange for it to be loaded otherwise ->dma_configure() can just proceed
with what the bus pre-configured.

> IDK, maybe it should be a bitmap instead of a level?

...not sure

> bit 0 = Force Disable
> bit 1 = Device is adversarial:
>            - Enable strong IOMMU protections
>            - Enable driver protections
> bit 2 = Require T=1
> bit 3 = Require IOMMU
> bit 4 = Require DMA/MMIO security (eg Link IDE)
>
> Where value 0 means the current level of full trust.
> 
> It is a little easier to explain what each thing is doing and easier
> to add new things

The question is whether these requirements belong on a central device
trust mechanism bitmap or should be pushed out to other ABI. For
example, if the presence of the secure IOMMU is enumerated
after the device is in the LOCKED state then userspace policy can know
what it is getting into without needing to tell the kernel. If T=1 is
required then either a TSM driver is present to validate it can enable
DMA, or the bus/paravisor arranges for that T=1 capability to be
pre-enabled.

Perhaps the levels are indeed:
DISABLED
ADVERSARY
FULL

...with a T=1 flag on the side that leaf drivers can not set on their
own.

> Then from a sysfs perpsective the policy would have special string
> values like 'use bus default'
> 
> > > If the trust level is reduced to just be a command to the kernel how
> > > it should operate the device then it would be up to userspace to
> > > confirm things like T=1 before setting the trust.
> > 
> > This discussion gets strained for me when T=1 is used to mean both
> > "device is in TDISP RUN (with link encryption and private MMIO)" and
> > "device is in TDISP RUN + force_dma_unencrypted() == false".
> 
> It means both things though, we really must not run with
> force_dma_unencrypted() = true when T=1, that's pointless and harmful.

Like I said above, I am ok to ditch the consideration of the
private-MMIO-no-private-DMA case.

> > Otherwise, full bi-directional T=1 before setting the trust would
> > require an IOMMU to be blocking the device until that final confirmation
> > point. Given that is not always available the proposal is to defer
> > acknowledging the trust level with the TSM until ->dma_configure().
> 
> ?? If you have no iommu the instance you set T=1 and do the platform
> step to activate DMA the device has 100% acess to all
> memory. force_dma_unencrypted() does nothing to constrain device
> access, it is all about accommodating an addressing limitation.

Right, this is my point above about why "echo 1 > $pdev/accept" does not
immediately set force_dma_unencrypted to false nor enable private DMA.

> ARM at least has a dedicated call to enable DMA. It would be nice to
> place that call right before the driver probes so DMA remains off
> until we commit to using the device. Maybe other platforms have the
> same - but I'm not sure it is *essential* as the point of setting RUN
> can reasonably be the acceptance point.

Not essential, but it is useful to have the "operate device" intent,
IOMMU default domain configuration, trust level, and private DMA enable
all in the same bus operation (->dma_configure). Which is why "accept"
was demoted to just set RUN state and leave the rest to be finalized
later.

> > NONE: Device core rejects device operation
> > ADVERSARY: reject device operation if an IOMMU to set IOMMU_DOMAIN_DMA
> >            not available (not in current patches)
> > AUTO: no rejections, but no private memory access either
> > TCB_ADVERSARY: reject device operation if IOMMU_DOMAIN_DMA not
> > 	       available, or TSM rejects the evidence used to enable
> >                private memory access.
> > TCB: reject device operation if TSM rejects chosen evidence
> 
> What does "TSM rejectes chosen evidence" mean? Kernel isn't supposed
> to be evaluating evidence?

The host / platform TSM is protecting the VM against evidence that has
changed since the last time the VM asked. I.e. the TSM is tracking if
the untrusted VMM relocked the device without the VM having re-read the
evidence.
