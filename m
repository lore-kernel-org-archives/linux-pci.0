Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BCE320CBE;
	Wed, 12 Aug 2026 19:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786563076; cv=none; b=PSGX3ScYh7f1HhM5R6ZG9VmNzporuWbgcPDT/voymwGoRFPqNyLbiCCvBoG/ADjKlkrhqhX896O20fZpU1k6D2dnupy4nF/QLoG+leR+xyqW5M1DHpBvdoLBTM8tYk8gY5unF0F2jU6BHbwdY5goeHUhYfkpVDuFP+WWna4DnF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786563076; c=relaxed/simple;
	bh=IUOP6NKnlTpSSSf5P55+u+N72940Fvh/R4Z5F17uc/c=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=H0wUnRmTQtAQixJYRzrqj70gcK18PbG0/b4AzIDfN2DdOBOTmsbM+LWZhqlUin0UtpUTd4fPu28E6mS5Q54cHOlNFS/q+J3NfV93TH18kt5LQ7IFV5VB2EBI9SQDH13XIH4MZSEtzc2sBNhO0D4SgEFINJYc+HZY/jMmljS54ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hS78QHXi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hS78QHXi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E711F000E9;
	Wed, 12 Aug 2026 19:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786563075;
	bh=xw4G7/B/uTxPa+kXrkmzXVxEeqlT3GP1kOyNFWPfXm4=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To;
	b=hS78QHXidl4w6xf+BEILFE/0TLRCqkMXlDW6U+c2GmrnvPRrx7y8Z4aUaFazIzBzu
	 KqFvUiPez2/CVhCr+fMgM7KN03U0Gavpkj+9RMfPiiqmATkoiGlM4xVymgAxKhaLo5
	 a8BiXngd5FxI5VjfXFKC1ucDRf4vx64e/hrn9tPi+wcH/wN+1r+F314yGjPy4hWPxv
	 TtkzvS5aZrFkDgRrEc1HcohGqZvMYj8bTAnQ2wefZwuE4RGBv3ib4maF+WQNCpzAUM
	 W/G50YSVl4O3SjWdeSmIV9ywbehntxQ6fWcqi97Jrh1LH2qlSHa7Gm2Y7wwrkGn7vS
	 6T8YRZ5ZEL/+w==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Aug 2026 21:31:09 +0200
Message-Id: <DKN7R3LFHP8S.20RYZQSO8TMZC@kernel.org>
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
Subject: Re: [PATCH v2 2/5] rust: pci: resolve IRQ in vector() and embed
 IrqRequest in IrqVector
References: <20260811233952.3000968-1-dakr@kernel.org>
 <20260811233952.3000968-3-dakr@kernel.org>
 <DKN432T77NWT.1HRUZU9DJ9ABH@garyguo.net>
 <DKN5HGXO6M7E.1SL8IATHZFUK1@kernel.org>
 <DKN60QB0522T.1IRNS63F2RMXG@garyguo.net>
In-Reply-To: <DKN60QB0522T.1IRNS63F2RMXG@garyguo.net>

On Wed Aug 12, 2026 at 8:09 PM CEST, Gary Guo wrote:
> On Wed Aug 12, 2026 at 6:44 PM BST, Danilo Krummrich wrote:
>> On Wed Aug 12, 2026 at 6:38 PM CEST, Gary Guo wrote:
>>> On Wed Aug 12, 2026 at 12:39 AM BST, Danilo Krummrich wrote:
>>>>      pub fn vector(&self, index: usize) -> Result<IrqVector<'_>> {
>>>>          if index >=3D self.count.get() {
>>>>              return Err(EINVAL);
>>>>          }
>>>> =20
>>>> -        // SAFETY: `index` is within bounds of this registration's al=
location, and `self.dev` is
>>>> -        // the device it was allocated from.
>>>> -        Ok(unsafe { IrqVector::new(self.dev, self, index as u32) })
>>>> +        // SAFETY: `self.dev.as_raw()` is a valid pointer to a `struc=
t pci_dev`.
>>>> +        let irq =3D unsafe { bindings::pci_irq_vector(self.dev.as_raw=
(), index as u32) };
>>>> +        if irq < 0 {
>>>> +            return Err(Error::from_errno(irq));
>>>> +        }
>>>
>>> Correct me if I'm wrong, but I believe that it's impossible for `pci_ir=
q_vector`
>>> once we have allocated vector and the index is in bounds. (If that's no=
t the
>>> case, we should ideally fix that instead.)
>>
>> You are correct, as of now it is unreachable with the index check above.
>>
>>> So I think we should just `.expect()` on the error in `Into`.
>>
>> I don't agree with the conclusion; I don't want this code to rely on an
>> implementation detail of pci_irq_vector(), which (even though unlikely) =
could
>> theoretically change.
>
> I think this is expected use pattern of `pci_irq_vector`. Many C code don=
't
> check the return code at all. If we want to mirror what C code do, we can=
 also
> just drop this error code check and rely on `irq as u32` below doing the =
correct
> thing.
>
> For both this and the EINVAL case for patch 1, my reasoning is that if th=
e error
> is never going to happen, then the code shouldn't be written as if it doe=
s, as
> it will only add confusion to people reading the code.
>
> I view these essentially as invariants, just not spelled out because it's
> written in another language. In this case, basically you can say that
> `pci_irq_vector(dev, index)` being successful is an invariant of
> `IrqVectorRegistration` type.

All this only checks out if we keep open-coding the range check and therefo=
re
rely on implementation details of pci_irq_vector().

>>
>> If we want to remove the redundancy, then we could maybe drop the index =
check
>> above.
>
> I think the index check should stay.

Again, this seems backwards, why would we want to open-code a check that
pci_irq_vector() already does and subsequently rely on this implementation
detail?

>>
>> (I also prefer IrqVector to be a new type over IrqRequest, as it also gu=
arantees
>> type wise that a valid IrqVector will always transform into a valid IrqR=
equest.)

