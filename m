Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9368456DE8;
	Wed, 12 Aug 2026 17:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786556257; cv=none; b=B0p7elJzdFeHIiqiVBdfs5v8Qp42/d6SPCJK1TEvz4cnK8oIx+rWiehNqfkjh5aBV4yzX9pkDLiZHzaylhAZZ2JJFHtl9X1NsrcMED9AewShhYTYnruF62FngP6SlEx90M5836szCi7m6rLqzy13UyYoDGuvvs8qrARABfORXq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786556257; c=relaxed/simple;
	bh=SoUPwDXMmUhcR7Jzq39eSaKiYlp1y6GoPF67qoZMcqM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=r4FQgwlEepqQ85Qu69cGIK0yh73MEIch2cIUDns7gcfWw/6quyUstPASV7TXXRVtugEC1CaCmRhW2hliqQjXe9vKfloVGxQGglwFw3WVRnHTvL91d4YfgxfB3jRMxycsq+vNwoF3NUOybTQVv0+fioRCO1HbmcW/ZiwhOiHtc9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gz0c+abm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gz0c+abm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E18B41F000E9;
	Wed, 12 Aug 2026 17:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786556256;
	bh=FRjvxmjv+QwDQeHa7piNraUS+xJH87P/jJlyp8e/qA8=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=Gz0c+abm2Gzoh9aC4cnYAv1EVnbq3Ksk2BzHFzWMU3ZVvcEbzcbMGiSDKzgh6+5c2
	 wXCxkUzaBUqszDJdFerbV03JdUw0nVD3t1sFxmKII+VSnZU5SpQ9DDYnmVjuQDhZel
	 N6piaSd9/0J7q7vlA6ddp46Qxj6fSXj4Q8bp+9Yf/LU7WAgBrHRJyVfhMd+oDCUH/6
	 MhCDfwDxv2JEzOIB0vxzyMkFbj4tPyKWk5BgSX/0WXHEZOsEOCDsionhrmxGjBWFcY
	 GQCOvumgxNaS7sKcPKbSshYrOFJMhgVjjYOvSd07JSu/ScJlTN97nTFrLcx/FW2baZ
	 0SgUDt/zIYA+g==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Aug 2026 19:37:30 +0200
Message-Id: <DKN5C359PZP3.2BPH5HLM9H0HY@kernel.org>
Subject: Re: [PATCH v2 1/5] rust: pci: convert IrqVectorRegistration to a
 lifetime-managed owning type
Cc: <bhelgaas@google.com>, <kwilczynski@kernel.org>, <aliceryhl@google.com>,
 <daniel.almeida@collabora.com>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <tamird@kernel.org>, <acourbot@nvidia.com>,
 <work@onurozkan.dev>, <jhubbard@nvidia.com>, <ttabi@nvidia.com>,
 <apopple@nvidia.com>, <ecourtney@nvidia.com>, <shashanks@nvidia.com>,
 <zhiw@nvidia.com>, <driver-core@lists.linux.dev>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260811233952.3000968-1-dakr@kernel.org>
 <20260811233952.3000968-2-dakr@kernel.org>
 <DKN3U000UGRL.2MOXT25O11UE0@garyguo.net>
In-Reply-To: <DKN3U000UGRL.2MOXT25O11UE0@garyguo.net>

On Wed Aug 12, 2026 at 6:26 PM CEST, Gary Guo wrote:
>>  /// IRQ type flags for PCI interrupt allocation.
>>  #[derive(Debug, Clone, Copy)]
>> @@ -78,6 +75,7 @@ const fn as_raw(self) -> u32 {
>>  #[derive(Clone, Copy)]
>>  pub struct IrqVector<'a> {
>>      dev: &'a Device<Bound>,
>> +    reg: &'a IrqVectorRegistration<'a>,
>
> The registration has a refence to the device so we don't need to keep bot=
h reg
> and dev?

In this patch dev is still needed for the TryInto impl, but a subsquent pat=
ch
does remove it in favor of IrqRequest.

>> +pub struct IrqVectorRegistration<'a> {
>> +    dev: &'a Device<Bound>,
>> +    count: NonZero<usize>,
>
> I wonder if it should be called "len" as I view this as a collection of I=
RQ
> vectors.

Either sounds good to me.

>> +    #[inline]
>> +    pub fn vector(&self, index: usize) -> Result<IrqVector<'_>> {
>> +        if index >=3D self.count.get() {
>> +            return Err(EINVAL);
>> +        }
>
> Given that the error is for out-of-bound access only, perhaps return `Opt=
ion`
> like `get()` function of various containers?

It's not really a case a driver would handle other than just follow it up w=
ith
.ok_or(EINVAL)? anyways, so I'd like to keep that.

(Further consideration on a subsequent patch.)

>> @@ -256,7 +249,21 @@ pub fn alloc_irq_vectors(
>>          min_vecs: u32,
>>          max_vecs: u32,
>>          irq_types: IrqTypes,
>> -    ) -> Result<RangeInclusive<IrqVector<'_>>> {
>> -        IrqVectorRegistration::register(self, min_vecs, max_vecs, irq_t=
ypes)
>> +    ) -> Result<IrqVectorRegistration<'_>> {
>> +        // SAFETY:
>> +        // - `self.as_raw()` is guaranteed to be a valid pointer to a `=
struct pci_dev`
>> +        //   by the type invariant of `Device`.
>> +        // - `pci_alloc_irq_vectors` internally validates all other par=
ameters
>> +        //   and returns error codes.
>> +        let ret =3D unsafe {
>> +            bindings::pci_alloc_irq_vectors(self.as_raw(), min_vecs, ma=
x_vecs, irq_types.as_raw())
>> +        };
>> +
>> +        to_result(ret)?;
>> +
>> +        let count =3D NonZero::new(ret as usize).ok_or(EINVAL)?;
>
> I don't think `ret` can ever be zero. `expect` or `new_unchecked()` perha=
ps?

Correct, but I don't see a reason to BUG_ON() for this. A WARN_ON() makes s=
ense,
but I see this to be the job of the C API making the promise.

We could use new_unchecked(), but since this method is fallible already and=
 not
a hot path, I don't think it's worth.
