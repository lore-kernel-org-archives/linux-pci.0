Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC754285CB9;
	Mon,  9 Mar 2026 18:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773079263; cv=none; b=cggt6cBbeiqMxarHiujZsPda91lejUa93YnLSsyan0sjh1XZjQ0K0jMionRdfjfS+NIh1j1sQ88ufCLmP25ZqBrJTU8JQt9MfzYTik9qWZNE75EX2F40BtiqUEaXWasUDY+HhIjvCT0PLaKla+hixH43vaQSUBZcublHNZORtRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773079263; c=relaxed/simple;
	bh=BgJQRqhGjraeZq1/E3D8YOpgm/h7Z0Fd8RnoHaYLJng=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QahyCi/+iG5ZAGG18YI+lnYlMvwTtiYM3/MvpDj3jIgU4kdt09PXZx2nmyOVFdltDST8inspo2uVmlIJpEvxPLCbhk1PBA8dY/kBjsgTzBqD+F2zscMCMW0Req3a+DDwBQLpOvNzry9HE+Ty28a5nTY8UAonvjnvuUjX7AC+6q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fV4Yw4Q9CzHnGck;
	Tue, 10 Mar 2026 02:00:52 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id C1EA54056B;
	Tue, 10 Mar 2026 02:00:56 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 9 Mar
 2026 18:00:55 +0000
Date: Mon, 9 Mar 2026 18:00:54 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <dan.j.williams@intel.com>, Lukas Wunner <lukas@wunner.de>, "Alistair
 Francis" <alistair23@gmail.com>, <bhelgaas@google.com>,
	<rust-for-linux@vger.kernel.org>, <akpm@linux-foundation.org>,
	<linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <alex.gaynor@gmail.com>,
	<benno.lossin@proton.me>, <boqun.feng@gmail.com>, <a.hindborg@kernel.org>,
	<gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <tmgross@umich.edu>,
	<ojeda@kernel.org>, <wilfred.mallawa@wdc.com>, <aliceryhl@google.com>,
	Alistair Francis <alistair.francis@wdc.com>, <aneesh.kumar@kernel.org>,
	<yilun.xu@linux.intel.com>, <aik@amd.com>, Mathieu Poirier
	<mathieu.poirier@linaro.org>, Thomas Fossati <thomas.fossati@linaro.org>
Subject: Re: [RFC v3 00/27] lib: Rust implementation of SPDM
Message-ID: <20260309180054.00000933@huawei.com>
In-Reply-To: <20260309155909.GG3717316@nvidia.com>
References: <aZn9cfhv0YRxI1mw@wunner.de>
	<699a3ff3f019a_1cc5100e1@dwillia2-mobl4.notmuch>
	<20260223171527.000016ef@huawei.com>
	<699ca65b5ff9b_1cc510019@dwillia2-mobl4.notmuch>
	<69a903d4511e4_6423c1004d@dwillia2-mobl4.notmuch>
	<20260305124837.GS972761@nvidia.com>
	<69a9de4791667_6423c1006c@dwillia2-mobl4.notmuch>
	<20260309113941.00007258@huawei.com>
	<20260309123148.GC3717316@nvidia.com>
	<20260309153339.00007b29@huawei.com>
	<20260309155909.GG3717316@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Mon, 9 Mar 2026 12:59:09 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, Mar 09, 2026 at 03:33:39PM +0000, Jonathan Cameron wrote:
> 
> > I'm not sure exactly what our security model is in the native CMA case,
> > so what software we can trust on the host. I.e. does the DH session actually
> > need to be between the kernel and the peer?  
> 
> Yes, absolutely a DH session is required in all cases, it is the only
> way to generate a PCI encryption shared secret and exclude a MIM.

Ah. I was missing what you wanted with the DH part. For some reason wasn't
thinking about IDE (maybe because this patch set doesn't get you there for
native). Though as I understand it some of the native usecases for CMA aren't
using link encryption (different security model from CoCo).

Yes, if you want to avoid MIM you need to bring up IDE etc - the basic fact
that both ends can still talk to each other after enabling it given they have
to have the same keys and those went over the secure channel, is part of the
security around that. I think you can attest before that point and rely on
the link 'failing' if there was a man in the middle. The verifier would
want the evidence IDE was up before giving you any secrets.

Whether anyone actually implements root ports via standard DOE flows or
everyone does this a custom way at the host is an open question.
There are various mix and match situations where the Coco / TSM flows
mean we have an encrypted channel, but we are doing our own native
attestation (to a different DOE, say on a VF).  Anyhow, others on this thread
have more info (I think) on the corner cases of how this is going to be
used than I do.

The secure channel establishment and key exchange comes later in the SPDM
flow than this patch set currently covers. This bit just gets you to the
point where you know you are ultimately talking to right device - you don't
know there isn't a MIM at this point.

Next up is KEY_EXCHANGE / KEY_EXCHANGE_RSP / FINISH / FINISH_RSP that will
exchange the public ephemeral keys and ultimately get us a secure channel.
Then we then switch to secured-CMA which is the PCIe spec and is basically the
format for wrapping up the session IDs etc + the encrypted channel.
Lukas' github has the next few bits required, but not sure he's all the
way there yet?

That then gets used for key exchange messages related to IDE via the PCI
spec defined IDE_KM protocol. (which is fairly simple compared to the other
steps - only about 8 pages :)).

So we may need to get a bit further before we can do the attestation
flow that would be equivalent to what CoCo needs.  I'm thinking
we may need one more set of measurements to verify both ends think
IDE is up.

For now the host will know it didn't bring up IDE.

> 
> For native the verifer should be able to measure the running kernel
> using the TPM, and then confirm the measured kernel and the peer have
> established a MIM free PCIe encryption, and finally measure the peer
> device.
> 
> For instance, imagine an enhanced version of "Network-Bound Disk
> Encryption" where the storage key is not released unless the server
> also validates PCI properties (physically encrypted with no MIM, right
> devices, etc)
> 
> > > I suppose the flow is the usual crypto something
> > > like
> > >  - Kernel negotiates a DH session/CSPRNG with the peer, generates
> > >    symmetric keys from the CSPRNG 
> > >  - Kernel forwards a nonce challenge and peer signs it, somehow mixing in
> > >    CSPRNG data to bind to the DH session  
> > 
> > We have a small amount of context (8 bytes) that we can put anything as
> > part of challenge/auth (alongside the nonce) It will part of the signed
> > response. Would that work for something from with the CSPRNG,
> > mixed so that you can't go from that context to the CSPRNG value?  
> 
> I assume SPDM is doing this already somehow otherwise there is no way
> to setup the PCI encryption keys. The fundamental purpose of the
> signature is to exclude a MIM by signing something that proves there
> is no MIM, and that is usually a value that both sides independently
> pull out of the CSPRNG. If they derive the same value then they have
> the same CSPRNG and DH tells us nobody else can have it. But there are
> other approaches too..

For SPDM it's this or pre shared key stuff which requires some out of
band way path. So probably ignore that.

> 
> > > Of course all of this should try to align with the way TSMs are
> > > working so we have as uniform as possible uAPI for evidence transfer.
> > > Though obviously a kernel SPDM has to be distinguisable from any other
> > > TSM from a verifier POV.  
> > 
> > Agreed. Very interesting to know what exactly is going in the TSM
> > SPDM exchanges as hopefully that will reflect best practice. If we
> > are really lucky they won't all do different things ;)  
> 
> Yeah, and I don't really know the details, just have some general idea
> how attestation and PCI link encryption should work in broad strokes.
> 
> But I know people who do, so if we can get a series that clearly lays
> out the proposed kernel flow I can possibly get someone to compare
> it..
> 
> The baseline I expect is a merkle tree signed by the root of trust
> (TPM or platform TSM) that encompases everything down to the required
> bits of the SPDM negotiation to prove no MIM.

Agreed, that's my basic undestanding as well and likewise, can get
some appropriate folk to check it out once we have the full thing described.

Jonathan

> 
> Jason
> 

