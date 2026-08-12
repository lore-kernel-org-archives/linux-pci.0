Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA043353A9E;
	Wed, 12 Aug 2026 17:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786556680; cv=none; b=kXtk5U0e7kBTI969UW7ZUZBYIf6rIfLsJWMxwhDrkN402iBSzxz+YC/Z7lXMkhc8ejK021S9MB+zWLzDIKzqRr3jVHu3vl8agrZ/HW5ylAYA5lfFSo8W2WSJ96X4RFc+EimkPjDCYHDxENHUA2uiLs1mIKgnqg5eVy9BPncG6SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786556680; c=relaxed/simple;
	bh=LZRjpjfbx4VkXwM0b0rleUV5TktAp2M5ZEJCN21vAws=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=st5C/p5a4qjkImZ4WyiNeHwGeybwKPph8K6H3xO9PGguT3BXr2IlyERoVsMNTIPNIdSy+PW27dLBlzPZFSk7KHLqAW9xxwFo/PoM7xj3Dmuyrf/LcL+OdBbRls05DbjLJSFK3kCtBMwOwzf26QjsPDX+wzIfxDQgA2yQ5pIbis0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNYr4ZKO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNYr4ZKO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE07B1F000E9;
	Wed, 12 Aug 2026 17:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786556677;
	bh=Ui4p9VCUM8Q4wdJp9wjMixzYl4Ap2DGvNZ7i2Z80Lb8=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To;
	b=XNYr4ZKOiXkiTFl9Jo/xWrwytrThNFh9+DpJou5jp1lKbuilow4sUiGHUqE4J5ILr
	 5aqnJOu72gRBWCu0rDicQJvD2l2FkSC/tnUBByZ5WucP5DCWe5Lr/v3R891PpfmKe7
	 YV0tdnT1KHJdB9AmCFODi614reeByNoHCNw+wI/EKaSADtIo+Bt3cvsZ9qW9NEnplR
	 883FlSZCzSb1teesRQGNF26qJUsd45kzDjVBovb4JDuAZIxztbiRp30sxB0e1PJ+j+
	 oBClKfF83zQHQ/yPBuzYNgAg9MGOLCGtr+SZbTZWQykZ401nm0E2GVVIgwoUyp6l7T
	 3CjLVav6B6vXA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Aug 2026 19:44:32 +0200
Message-Id: <DKN5HGXO6M7E.1SL8IATHZFUK1@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 2/5] rust: pci: resolve IRQ in vector() and embed
 IrqRequest in IrqVector
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
References: <20260811233952.3000968-1-dakr@kernel.org>
 <20260811233952.3000968-3-dakr@kernel.org>
 <DKN432T77NWT.1HRUZU9DJ9ABH@garyguo.net>
In-Reply-To: <DKN432T77NWT.1HRUZU9DJ9ABH@garyguo.net>

On Wed Aug 12, 2026 at 6:38 PM CEST, Gary Guo wrote:
> On Wed Aug 12, 2026 at 12:39 AM BST, Danilo Krummrich wrote:
>>      pub fn vector(&self, index: usize) -> Result<IrqVector<'_>> {
>>          if index >=3D self.count.get() {
>>              return Err(EINVAL);
>>          }
>> =20
>> -        // SAFETY: `index` is within bounds of this registration's allo=
cation, and `self.dev` is
>> -        // the device it was allocated from.
>> -        Ok(unsafe { IrqVector::new(self.dev, self, index as u32) })
>> +        // SAFETY: `self.dev.as_raw()` is a valid pointer to a `struct =
pci_dev`.
>> +        let irq =3D unsafe { bindings::pci_irq_vector(self.dev.as_raw()=
, index as u32) };
>> +        if irq < 0 {
>> +            return Err(Error::from_errno(irq));
>> +        }
>
> Correct me if I'm wrong, but I believe that it's impossible for `pci_irq_=
vector`
> once we have allocated vector and the index is in bounds. (If that's not =
the
> case, we should ideally fix that instead.)

You are correct, as of now it is unreachable with the index check above.

> So I think we should just `.expect()` on the error in `Into`.

I don't agree with the conclusion; I don't want this code to rely on an
implementation detail of pci_irq_vector(), which (even though unlikely) cou=
ld
theoretically change.

If we want to remove the redundancy, then we could maybe drop the index che=
ck
above.

(I also prefer IrqVector to be a new type over IrqRequest, as it also guara=
ntees
type wise that a valid IrqVector will always transform into a valid IrqRequ=
est.)
