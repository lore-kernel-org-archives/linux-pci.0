Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AD83D7D7F;
	Mon,  9 Mar 2026 15:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773070428; cv=none; b=GpUEM/uyAfsyQHpciZvfcXsBAj0VVTTVkSIkbu1lq+XniBUVMzBml2lto1TnJs5eT358UDDapo6ypU6us7lRkyZ5Z3FJQE3m2ILBeFO5fS7c0wZEjVTRdk6hkKDTk6xMjwJ4PH4hNeqlNlseIyeF3RNMadaB+RjRDzPcft3Svu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773070428; c=relaxed/simple;
	bh=zd5csxTmLV63uTDB4HZp/LW6Fb1KME3A1fCKxT6m+jM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pzdLoptpMnR0B+i8lkiUZfvJlT0IQeasDlJItcEffZ073LyaMknGvy2y+2QcDit4sED52VrAcqEko6j8Co3XZPBn+gStm6rZ3n9ZZP21Acka5kYWdXUH8VYWpMIHFsT24tufL6zVfVdpzziuhANUGWhCKA2OeBgRaBmoxTtvju8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fV1HH57JtzJ46dp;
	Mon,  9 Mar 2026 23:32:59 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id CF7ED40589;
	Mon,  9 Mar 2026 23:33:42 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 9 Mar
 2026 15:33:41 +0000
Date: Mon, 9 Mar 2026 15:33:39 +0000
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
Message-ID: <20260309153339.00007b29@huawei.com>
In-Reply-To: <20260309123148.GC3717316@nvidia.com>
References: <aZgbukYiIxg44_e7@wunner.de>
	<20260220141057.GL723117@nvidia.com>
	<aZn9cfhv0YRxI1mw@wunner.de>
	<699a3ff3f019a_1cc5100e1@dwillia2-mobl4.notmuch>
	<20260223171527.000016ef@huawei.com>
	<699ca65b5ff9b_1cc510019@dwillia2-mobl4.notmuch>
	<69a903d4511e4_6423c1004d@dwillia2-mobl4.notmuch>
	<20260305124837.GS972761@nvidia.com>
	<69a9de4791667_6423c1006c@dwillia2-mobl4.notmuch>
	<20260309113941.00007258@huawei.com>
	<20260309123148.GC3717316@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Mon, 9 Mar 2026 09:31:48 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, Mar 09, 2026 at 11:39:41AM +0000, Jonathan Cameron wrote:
> 
> > Anyhow, all that really says is I'd like the internal consistency of
> > the SPDM session checking in now.  Leave checking we actually trust
> > the cert + measurements to user space (and all the stuff below
> > on recovery comes later).  
> 
> I think kernel doing internal consistency (non policy) checks is fine
> 
> We just need to be careful to construct things so it is compatible
> with an external verifier. Even in this bare SPDM mode we still want
> to hook it into external verification.
> 
> I don't know alot, but I understand this requires the nonce (?) to
> come from userspace? 

Going out of my area of expertise... So take the following with a pinch
of salt.

Yes to userspace provided nonce. My understanding is that can come
from the verifier that wants to ensure freshness.

I'm not sure exactly what our security model is in the native CMA case,
so what software we can trust on the host. I.e. does the DH session actually
need to be between the kernel and the peer?

> I suppose the flow is the usual crypto something
> like
>  - Kernel negotiates a DH session/CSPRNG with the peer, generates
>    symmetric keys from the CSPRNG 
>  - Kernel forwards a nonce challenge and peer signs it, somehow mixing in
>    CSPRNG data to bind to the DH session

We have a small amount of context (8 bytes) that we can put anything as
part of challenge/auth (alongside the nonce) It will part of the signed
response. Would that work for something from with the CSPRNG,
mixed so that you can't go from that context to the CSPRNG value?

>  - Kernel checks the signature against the public key and confirms the
>    CSPRNG and nonce are correct (only kernel can do this since the
>    CSPRNG must not leak out of the kernel)
>  - Kernel forwards the signature from the peer to userspace and
>    userspace re-checks the signature against the public key and
>    validates the nonce is the one it issued, and checks that the
>    public key is acceptable. Ignores the CSPRNG data.
>  - Presumably in a real TSM there will be a merkle tree signed by the
>    TSM's platform key that binds together all the TVM measurements and
>    the SPDM activity so the verifier can see a complete picture?
> 
>    ie that the verifier pushed nonce A authenticated SPDM session B
>    which is part of PCI device C that is part of TVM D.
> 
>    Should kernel be extending TPM PCRs or something in this bare SPDM
>    mode to provide something similar using the TPM to produce
>    platform evidence?
> 
> Of course all of this should try to align with the way TSMs are
> working so we have as uniform as possible uAPI for evidence transfer.
> Though obviously a kernel SPDM has to be distinguisable from any other
> TSM from a verifier POV.

Agreed. Very interesting to know what exactly is going in the TSM
SPDM exchanges as hopefully that will reflect best practice. If we
are really lucky they won't all do different things ;)

Jonathan



> 
> Jason

