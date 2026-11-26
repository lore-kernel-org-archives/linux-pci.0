Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795734736;
	b=f64lCHxg118gMXwcyStQtRbjXTkAiykxdGS7CdCwZ76kdjPaX1iG7QioBsAetwpGk8t9
	 Jndfl3AaSqjvkNHOKOqNTtSWMUgN4lf8dot8C3+GiretL//5DPsON9/fpTvR/bqo+4/wt
	 89fAWrPOp12v4kOsq4YN1npYRKDizB/ZY+iMojpkKQfUV80PH/GEchCV3OUmZHLfxPIKD
	 X/OFX0yfw/LD5gkM4Ve7oCRP/QnGBUSvn0NtRx921K+KlBey6VQTOA21923wnaIo9nPHB
	 9+ATlPJNd7V4aQu2PZxy2A72K3z0LMNkQhVvMq5WstYlIZzV8qwX78Mk5Il86TbORjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795734736;
	h=Received:DKIM-Signature:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To;
	bh=yCg6GFs8aIIt9H7EV8TqGTZ5EaU2Zu9rrP42YjkHPnk=;
	b=Hjv4/RPNsyjhFSNFXAHvRgDoKmFWUGQmM3OBLkUYxgUrLchk23jz2DwDe3xPSP2p8hDw
	 L+W8BvyJDiYcjQIRU+3kdCsIkdQHGbTHXEZG+ESry+rYqueMLFyvXSCd62P8ENsOR4UXk
	 IWHEbnux6XD3s5yjfrOqxFO+D3kNc/nQEnNamCuGUHOmNbt2d6fGjlOOLLHvjcuPzmLSY
	 tuDCJ2kRf8rF2NmTtzNbc4Ap+5E6RDy6pg9yX09Alzg4xNt4hmIX1Lu+x3aHBUoZGTNWx
	 XGOoYhPM6lzAs9sE7a+0X6tVAJ7o44PNc17V1mTNSZ1arjfAq+qPSK+EAq3xTaF9UiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="OLE/5HdM";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB58606A31C;
	Thu, 26 Nov 2026 23:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OLE/5HdM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93CEB1F000C1;
	Thu, 26 Nov 2026 23:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795734736;
	bh=yCg6GFs8aIIt9H7EV8TqGTZ5EaU2Zu9rrP42YjkHPnk=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=OLE/5HdMOrzqMoVMzpMOMOMHiwFOsx9zxrVlr3wkAc/3r3feA4bo/4U8T+dquucT7
	 GoxqIb3GA2Qzhx23dBRIcv/B7pXI/l0P5FqcBZ2JkRB8dKNWtcDk83NE+tFGgfmsDy
	 Y2+X8Sk3RBM8g/QKSroJurZNSvZCfBzHReXtUL4ZFWqJTFXeExgVVyxjuXWjrWU54x
	 wRLwe8ecIV18WWvO6CCa3mCpILwAESGiq3BoKYoO7R0FnuW3Fs9WKfUegeovFJCzNe
	 Wn9z/hNWXG4yDF+b45eJhwRrzPajMgbisyeckxW0kPcFQ8utWEGo0CiWDlzqk7vx7W
	 dVWYVqxyMLVnw==
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Nov 2026 00:12:07 +0100
Message-Id: <DN5IU15U2LO1.1NCRHBKWBJG5B@kernel.org>
Subject: Re: [PATCH v3 7/9] rust: vfio: add PCI variant driver abstractions
Cc: <acourbot@nvidia.com>, <kvm@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <linux-pci@vger.kernel.org>, <jgg@nvidia.com>, <yishaih@nvidia.com>,
 <skolothumtho@nvidia.com>, <kevin.tian@intel.com>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <jhubbard@nvidia.com>, <ecourtney@nvidia.com>,
 <cjia@nvidia.com>, <smitra@nvidia.com>, <kjaju@nvidia.com>,
 <alkumar@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <zhiw@nvidia.com>,
 <boqun@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
 <work@onurozkan.dev>, <jgg@ziepe.ca>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <peter@colberg.org>
To: "Simon Song" <xinmengs@nvidia.com>, <rafael@kernel.org>,
 <alex@shazbot.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261119215046.2892839-1-xinmengs@nvidia.com>
 <20261119215046.2892839-8-xinmengs@nvidia.com>
 <DN4P1UAAVP8G.2TUW0Q8UEQVCG@kernel.org>
 <03b5355c-e8c9-4190-95b8-fb847756ad7f@nvidia.com>
In-Reply-To: <03b5355c-e8c9-4190-95b8-fb847756ad7f@nvidia.com>

(Cc: Rafael)

On Thu Nov 26, 2026 at 4:01 PM CET, Simon Song wrote:
> On 11/25/2026 3:51 PM, Danilo Krummrich wrote:
>
>>> +impl RuntimeActive {
>>> +    fn new(dev: &device::Device<device::Bound>) -> Result<Self> {
>>> +        // SAFETY: `dev` is a valid device. This is `pm_runtime_get_sy=
nc()`, which takes a usage
>>> +        // reference even if it fails.
>>> +        #[cfg(CONFIG_PM)]
>>> +        let ret =3D
>>> +            unsafe { bindings::__pm_runtime_resume(dev.as_raw(), bindi=
ngs::RPM_GET_PUT as c_int) };
>>> +        #[cfg(not(CONFIG_PM))]
>>> +        let ret =3D 0;
>>> +        // INVARIANT: `this` owns the usage reference, and drops it if=
 the resume failed.
>>> +        let this =3D Self(dev.into());
>>> +        to_result(ret)?;
>>> +        Ok(this)
>>> +    }
>>> +}
>>> +
>>> +impl Drop for RuntimeActive {
>>> +    fn drop(&mut self) {
>>> +        // SAFETY: `self.0` is a valid device, and `new()` took the us=
age reference dropped
>>> +        // here. This is `pm_runtime_put()`.
>>> +        #[cfg(CONFIG_PM)]
>>> +        unsafe {
>>> +            bindings::__pm_runtime_idle(
>>> +                self.0.as_raw(),
>>> +                (bindings::RPM_GET_PUT | bindings::RPM_ASYNC) as c_int=
,
>>> +            )
>>> +        };
>>> +    }
>>> +}
>>=20
>> This seems reasonable, but doesn't belong into VFIO core code. This shou=
ld e.g.
>> go under rust/kernel/device/pm.rs.
>>=20
>> However, it would become dead code once we land the runtime PM stuff and=
 enable
>> it for PCI, right? I think an alternative could be to just make nova-vgp=
u depend
>> on !PM.
>>=20
>
> Right, this goes away once driver has runtime PM callbacks, I tried !PM a=
nd it
> works, but CONFIG_PM is set in x86_64_defconfig and allmodconfig, so driv=
er
> won't be built there with default option for x86, would you rather keep
> RuntimeActive and moved it to pm.rs or prefer to depend on the CONFIG_PM =
until
> the runtime PM for PCI lands?

Right, in this case I'd just inline the call to __pm_runtime_resume() into
Registration::new() and the call to __pm_runtime_idle() into
Registration::drop() to keep it as local as possible.

We can then replace it with the proper bus PM handling once the core PM cod=
e
lands; I will send the corresponding PCI changes soon.

Rafael, please let me know if you have any concerns.

Thanks,
Danilo
