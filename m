Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7877275AFB;
	Mon, 23 Feb 2026 17:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771866936; cv=none; b=lR2/d1HVDKths0SDDmQ/4/DQvgpIdio2AXc7SkkyUinlf5IM0LeM8GuqBkNAX1D2r9D9QzwBhJfAzQVasc184Dzi2bIO3kFUj1grJsVmzDE7/1skQw3mtM8kWz0zo8/3MEb9d1tih8eKaHJh4OvqyBg6NpSWvtXvucmzfFfXgGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771866936; c=relaxed/simple;
	bh=5WCDUqqUaCC/EdbQ/WC19N68G8OmPJbTU90snkSfaFg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IvlPvWqpUabEHFCGZav+gl/u6JBg3CXGeDPzALO+hmpxy1P8pt+EAyI5iVgUvcSkMmHkZ3kkfbiKtLL6FVp28eLqlYAEXG58L6LhOSho0M0tely+r7HTPIQbq6aA/6wyqHoEm0bgYHCyeDoj/Nb++MezIeNKlcwtuGxemi+YVFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fKSCH3FJBzHnGgl;
	Tue, 24 Feb 2026 01:14:51 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id C117240539;
	Tue, 24 Feb 2026 01:15:29 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 23 Feb
 2026 17:15:28 +0000
Date: Mon, 23 Feb 2026 17:15:27 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <dan.j.williams@intel.com>
CC: Lukas Wunner <lukas@wunner.de>, Jason Gunthorpe <jgg@nvidia.com>, Alistair
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
Message-ID: <20260223171527.000016ef@huawei.com>
In-Reply-To: <699a3ff3f019a_1cc5100e1@dwillia2-mobl4.notmuch>
References: <20260219124313.GE723117@nvidia.com>
	<20260219124119.GD723117@nvidia.com>
	<aZcbBt7OmNeH3oA0@wunner.de>
	<20260219143129.GF723117@nvidia.com>
	<aZcnTnYJ61Kma0yd@wunner.de>
	<20260219173937.GH723117@nvidia.com>
	<aZgbukYiIxg44_e7@wunner.de>
	<20260220141057.GL723117@nvidia.com>
	<aZn9cfhv0YRxI1mw@wunner.de>
	<699a3ff3f019a_1cc5100e1@dwillia2-mobl4.notmuch>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Sat, 21 Feb 2026 15:29:55 -0800
dan.j.williams@intel.com wrote:

> Lukas Wunner wrote:
> > On Fri, Feb 20, 2026 at 10:10:57AM -0400, Jason Gunthorpe wrote: =20
> > > IOW the resume/RAS acceptance criteria is that the second nonce was
> > > signed with the same private key(s) that the first nonce was signed
> > > with. =20
> [..]
> > > Linux will have its own sw model, the spec is just the protocol
> > > definition. In the CC world everyone just knows the verifier needs to
> > > be external.. How else could it even work? =20
> >=20
> > There are products out there which support CMA but not TDISP.
> > In other words, the CC world isn't everything.  The modest goal
> > of this series is to allow authentication of devices in compliance
> > with PCIe r7.0 sec 6.31 and the SPDM spec.  I understand there are
> > features and authentication modes which are important for the
> > Confidential Computing world, but CoCo needs to fit into the
> > spec-defined mechanisms. =20
>=20
> The TDISP proposal from Jason and I bears repeating because it is a
> superset of what a CMA-only solution needs, and security guarantees it
> provides. I also submit that "identity revalidation over reset/resume"
> is not a *primary* concern. It is certainly *a* concern that needs to be
> part of the ongoing discussion to avoid painting ourselves into a
> corner, but certainly a complexity that is incremental to the base
> enabling. Recall CMA is only a building block to trusting the rest of
> the device interface outside of the SPDM session.
>=20
> Userspace is in charge of all trust and verification decisions. A TSM
> driver, whether that driver is in-kernel-SPDM-library, or platform TSM,
> establishes a session with a device with a given certificate slot. The
> session establishment makes cert-chain+transcript available to userspace
> and caches the public-key. If userspace does not like that result, it
> opts to not bind a driver to that device, or retries with a different
> cert slot.
>=20
> If later we want to support a "same device" capability in scenarios
> where a userspace round trip is infeasible then that is incremental ABI.
> That ABI would allow userspace to cache golden cert-chain+measurements.
> The resume path can revalidate that identity description with a fresh
> nonce and the cached public key.

=46rom a simple case of 'what is here' in this set, the only bit I'm seeing
change in order to implement what I think you and Jason are describing is we
don't bother checking the cert chain in kernel for the first time: We
provide that to userspace to decide if it's good. If I understand
correctly, this will be at the end of the full sequence once we've pushed
through a nonce and gotten signatures + measurements.  Same as checking a
TSM provided transcript. That was sort of happening anyway if we consider
the .cma keyring as just providing a short cut filter if we didn't trust
the device provided root cert.
User space got the transcripts before it had to make any decision on
binding and could do anything it liked with them.

For that caching the public key bit, I'm not clear on whether you intend
to do that from kernel side (which I think I'd prefer) or have user space
squirt that key back in again?  If we are doing it in kernel we can
at least always verify the transcript is self consistent and refuse to
give anything to user space if it's not consistent (other than debug materi=
al).
By self consistent I mean we verify the signature against the device provid=
ed
cert (might as well verify whole chain as that's trivial given we have to p=
artly
parse them anyway to find the cert).  I don't think it maters hugely if
we do this in kernel beyond advantage of removing a few foot guns and
simplifying the userpace interface to "I'm fine with the provided transcript
for use when I'm not here next time" write. Disadvantage is we use the
cert parsing code (which is there anyway) and parse it all twice - once
in kernel and probably again in userspace or at some remote verifier.

Measurement verification (in kernel) is potentially a trickier bit of ABI
design as the space of what might be in there and what matters for a given
device is complex to say the least.  Only a small part of that is spec
defined.

I can see there may be some use cases where we relax things beyond this
(potentially including .cma keyring and root cert only)

Jonathan


>=20
> For TDISP the violence of dropping the device out of the TCB likely
> needs more sophistication than golden measurement revalidation. For CMA
> mere trust in the root cert is not sufficient for many of the
> adversarial device threat models, so the kernel need not carry that
> responsibility.
>=20
> Aneesh and I are putting together some POC patches along these lines.
>=20
>=20

