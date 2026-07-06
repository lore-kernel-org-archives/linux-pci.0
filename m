Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964FE3E6DC9
	for <linux-pci@vger.kernel.org>; Mon,  6 Jul 2026 20:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783371319; cv=none; b=iRCUFoQ6MuvB6XbjlEHZo0wdhU8aRoiIbSGH2q9zhzcr9c5HQW5Pxllb6Rhz7YOAW20ERWOoGbFvJLIihrAOklLBByUwddt/YyS2gHd/NwviLm+Dthpc/qnNJ9ckd/p5dJQmNNDPubjjGBTGvjka8eMg5SPGCqQAPEgu28uTw4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783371319; c=relaxed/simple;
	bh=IGkv70DP+moeGvr1kGH9U5sSQn3bciZbedCDbRAUTC0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=mwgtbh5TLR11zbhu/TKFATPhbFS8W4zH8EmcP/fWfXZKCxyySgg9Fcu0cYWPzxVoSuDYwZRRsvGuNLiPbbtc37OJgraO5pvCabtJEbXeU7ILi/mS1Pspn3/vvMw3KJjGG6uTcu1BOxeN86EMvUW9Udat9EjQn/0aGm0tFKrxSjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZtdfQY5G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZtdfQY5G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C9AB1F00AC4;
	Mon,  6 Jul 2026 20:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783371316;
	bh=5gLMtL0ehzbI70XdQsW+G0rVSl2OqfF2FvFTuKabiUc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=ZtdfQY5GlZBwo2Dk3+jCkLeXTKb08OnjvZ4/kp5SKUchP8JTLru5fZII+8ZJeeaV5
	 foMGreXVEPCGWSQ7sNu+aXwLgqB3IVI46NtDR6dJ+IUpjIdkOzb6UP7HDovLPX1blI
	 1hRlzNVHEknVZvGuNlQeHyYECqwKAEoIVXSNT8K5SZZsYT2DyYNvIvMsux0bq/I+v5
	 QTNCmdcvX0lpvBXfcDnsQ9wS1UDGUYAdQgCJKueQ6a+WAHdE6xm1S/keuQ/sVIeQ0J
	 2Qjj8EbEiZOplU7dBcTw7W5+Nr9eh0C13V+TamPXoiXAqV9YvLPgdBYAyfzsFVDXBs
	 Cyk3QipC3ctPw==
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 69560F40069;
	Mon,  6 Jul 2026 16:55:14 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 06 Jul 2026 16:55:14 -0400
X-ME-Sender: <xms:MhZMavd9PMWXuwu51MKZq42kWvE0up6_XKQoUBdasI7Ko-7yqY50Nw>
    <xme:MhZMasvjmF0RCwxgTJ7UkFntrLSM4C6GMWJNnhR2Fi5Wi8jUlxiQYr8oz4gL8gJ3k
    lnloddjEp-z5XwBzjAlRv3U1zYrJbSJreRGuJtNUBsyThZfXfBjRxHD>
X-ME-Received: <xmr:MhZMaul1ickysRstuZowGPBF9KhPrqZuMeqBnc4bF-Nwfz-EQ-yEDj2O1SVCJZME1SticJoc4SOx_DeKsx1gc8CxoL8ujPFosLI>
X-ME-Proxy-Cause: dmFkZTEAePvJuEKBGMbOChD/aQmAfYs2XehDYVSZUm2aqSa84m+EtRSpUh6+tYC2p0iMf0
    X+djKkK5BiiP6WWLI5mxHrW2y7cqvDQPlT7+mvCOU6xs60WtZczWG0cJlGnIDzLWINxfIX
    qad7h3IKZk22azgw2gZBYcd1ISKEq2lEOzPM4bpNwsXF1QxcHqoPmQ5G/HlxT2EoYm2332
    J6H3zVybY7tI3rkaAbQoyhlS3SLsnahXAUElwAcoNCyyqOy8wc/Kqw5mDGYFJQ8wL85qft
    vlgYjhUdObKKirqT6J9Jrk5KX8nxGdTguNWWYknZsPiiHmcAhERHX9S98P2x1UZI06LAnR
    W+pevVlbAwvSL+i8KYveIrSf1EUAnAncvUgAvax3frp6lZfAX78qvpB7DmeY+iFL434AeW
    5NYFUFnWXTmnAGVD0zyrmxkGOJGHcUC7poBGLnUKTd9UMk7hoS+seRWvuOeFZ6eQKOBS3C
    AXPGBuCTX7zwTE14EqfS+tadDMdDdXvFJ/CNYm8S0oGaTu0QsON0+dT7+Xz/JjlVSkgIta
    zkNW/ImMKHQLJMsgLSNCT1KiSTfd7LJhem8qzTV5fCptYLJDRt1KYixluHoLzHWacViiAB
    ahMTsy0y2O/xP7WX76v4pTZxayGbIzgpHgZ12wIy248Lkn4SJc0N1GuFOznA
X-ME-Proxy: <xmx:MhZMavCT819ysApqsVIoRfOeH9K0t4F3sdA02UR1UQ-_4j5E0cJlcg>
    <xmx:MhZMamx-jTDnTW4zHLnGxnJD7IhD8L70gJFuGh-p9tmRokUnEmot0g>
    <xmx:MhZMajcvhzx_dBXzlJE2Ll2Iejggf4KbTLpsQQmLsMcU9hYwJO3L1Q>
    <xmx:MhZMaoxuaVdcGrSwuVBI8Fx5GZFqA4OvClj04qMRzjj8VVCXisjjkg>
    <xmx:MhZMal5dkb4wP8wdAx5cYB-p_Zq2EPjIa2MDRiefUJgPeL9TfKgRUuZ0>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 16:55:13 -0400 (EDT)
Date: Mon, 06 Jul 2026 13:55:12 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, 
 Dan Williams <djbw@kernel.org>
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
Message-ID: <6a4c163072c60_174db6100c4@djbw-dev.notmuch>
In-Reply-To: <20260706125140.GB107792@ziepe.ca>
References: <20260705220819.2472765-1-djbw@kernel.org>
 <20260706125140.GB107792@ziepe.ca>
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
> On Sun, Jul 05, 2026 at 03:08:04PM -0700, Dan Williams wrote:
> > * NONE: no usage of the device unless the trust is explicitly overridden
> >   by user policy specified via a driver flag, module flag, or uapi (TBD).
> > 
> > * ADVERSARY: needs acknowledgement from the bus and IOMMU / DMA layers
> >   that the device is limited to strict IOMMU translation behavior. Drivers
> >   can use this as a signal to limit functionality. This designation
> >   implies follow-on IOMMU and bus enabling work for features like
> >   arranging for the device to attach to a blocked IOMMU domain when
> >   detached from a driver.
> > 
> > * AUTO: typical / historical Linux driver model.
> > 
> > * TCB: a trust level that only exists in Confidential Computing
> >   environments. When acked by the IOMMU / DMA layer it enables the device
> >   to issue direct-DMA to private/encrypted addresses or otherwise attach to
> >   a secure vIOMMU within the TCB.
> 
> I'm not sure I entirely like this one, certainly it needs to be
> possible to have both T=1 and ADVERSARY together.

T=1 and ADVERSARY are independent for link encryption and private MMIO.
In other words the device is placed into the TDISP RUN state independent
of its trust level. Downstream accesses to the device must have T=1, and
its upstream accesses will have T=1, but with force_dma_unencrypted() ==
true.

The only combination missing is T=1 with force_dma_unencrypted() == false &&
VIOMMU enforcing IOMMU_DOMAIN_DMA.

> Arguably the T=0/1 decision is much more like link encryption, it
> effects the transport of the DMA into the CPU. That it also impacts
> how the VIOMMU works is the only thing that make it sort of
> trust-like in this model.
> 
> I'd also argue this list is missing "FULL" trust, which is the
> historical Linux behavior for a normal device. AUTO should be
> selecting between FULL/ADVERSARY based on things like the ACPI/etc as
> it does today.

Two notes,

1/ that is effectively how the UNSET level behaves. If the
bus has not set ADVERSARY before device_add() then the default behavior
is the AUTO level. Where AUTO means all of the automatic privileges a
device can be offered without needing any other coordination.

2/ The ambiguity and conflict occurs at ->dma_configure() time when the
bus and IOMMU layer want to reject the device's access to some privilege
by failing. When FULL is defined as !ADVERSARY then it is difficult to
describe the semantics when FULL trust honors rejections to private DMA
and when it falls back to shared operation.

The above more points to a need to have an explicit trust level for
adversarial private memory access. The address spaces are distinct
assets with different levels of trust.

UNSET: bus picks initial level, or leaves it to the device_core().
NONE:
ADVERSARY: Device can be in T=0, or T=1 mode (UNLOCKED, or RUN).
AUTO: Could rename this to be FULL or ALL or DEFAULT, I still keep
      coming back to the "AUTO" name because the privileges are not
      uniform based on the IOMMU / DMA topology and device capability.
      Again, the TDISP state is independent. The TSM driver does
      not get called to gatekeep and verify access in this mode.
TCB_ADVERSARY: or PRIVATE_ADVERSARY. Device can access private platform
	       resources iff an enforcing IOMMU is present.
TCB: or PRIVATE_FULL, automatically enable all access privileges
     including private memory access.

Direct-dma to private memory without a Secure VIOMMU present
requires "TCB".

> In a CC VM if we have a T=0 device we probably want to operate it with
> ADVERSARY (there is no T=0 VIOMMU so this is equivilent to FULL)
> 
> For a T=1 device we need to have the choice of FULL or ADVERSARY. When
> a VIOMMU is present ADVERSARY will further restrict the T=1 traffic as
> a defense in depth.

Yes, a mode that can setup IOMMU_DOMAIN_DMA for private memory
makes sense. It needs a new trust level to distinguish if the
device is trusted to access one or both address spaces.

> So, it is really necessary to have "TCB" here?

I think it is important to distinguish that the CC case adds another
class of memory to the trust decision.

> If the trust level is reduced to just be a command to the kernel how
> it should operate the device then it would be up to userspace to
> confirm things like T=1 before setting the trust.

This discussion gets strained for me when T=1 is used to mean both
"device is in TDISP RUN (with link encryption and private MMIO)" and
"device is in TDISP RUN + force_dma_unencrypted() == false".

As implemented, userspace can confirm the former before setting the
trust. The latter only gets confirmed / denied at ->dma_configure()
time, because that is the point at which driver policy has been applied
to set the operational trust level.

Otherwise, full bi-directional T=1 before setting the trust would
require an IOMMU to be blocking the device until that final confirmation
point. Given that is not always available the proposal is to defer
acknowledging the trust level with the TSM until ->dma_configure().

As far as userspace is concerned it has enabled T=1 at the device and
validated device evidence. Any failures to operate the device from that
point are either the TSM finding fault with the evidence the CC VM is
relying upon, or, in the new TCB_ADVERSARY case, the IOMMU layer says,
"no IOMMU present to enforce IOMMU_DOMAIN_DMA".

> The kernel would have to set the trust to NONE when security sensitive
> changes are detected.
> 
> If we still want a kernel-side policy gate, eg kernel will not
> progress unless T=1 is met, then I think that would be better as an
> independent pair'd policy field, ie
>    trust=FULL when policy=T=1, LINK_ENCRYPTION=1, etc
> 
> As bundling the two into "TCB" is probably going to turn problematic
> as we have more and more combinations of policy conditions.

Agree that "TCB" alone is insufficient per above. However, a new
"trust when/if" ABI does not appear to scale.

Userspace policy simply needs to contend with the mechanisms that
"Device Core, BUS, IOMMU or TSM driver may fail to enable a device at a
given trust level".

NONE: Device core rejects device operation
ADVERSARY: reject device operation if an IOMMU to set IOMMU_DOMAIN_DMA
           not available (not in current patches)
AUTO: no rejections, but no private memory access either
TCB_ADVERSARY: reject device operation if IOMMU_DOMAIN_DMA not
	       available, or TSM rejects the evidence used to enable
               private memory access.
TCB: reject device operation if TSM rejects chosen evidence

Overrides and bypasses for those rejection decisions belong with
their respective drivers. For example, if a paravisor is handling
TDISP then there is no TSM driver to reject TCB operation.
Similarly ->dma_configure() when no IOMMU is present is a nop
today. New enabling could turn to enforcing, or userspace policy
otherwise understands the risks.
