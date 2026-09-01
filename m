Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692672F3C18;
	Tue,  1 Sep 2026 13:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788269824; cv=none; b=nswLYYMIVBZgzN7gkbK+y4IhjPxm43It6ne/VfEDd7Q8xRYtltmbtEHXoBdMdMvgtMdQE9rBadNdoog6ekzmXbMmexwk6t8uXM7uPyidtkbeeYk8G7PWFcMx+pO/93N/jxVB398QSk6ZdyqnlaAyNaLWtg+p8ZimYH8XjcE439Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788269824; c=relaxed/simple;
	bh=kRGES7TqWRylTv32H4Tu85p6FSUS1bAPxHsMr3HCaWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DrbhzNjgS77VU5k6alk3Th1S+LXTNUEFnSwwt1g9/mPdGFPAxcM3ve+ltgxtKUjfvlXf8GmUdiEZOp1Thb5KGA+yiSEckqjhZc85JDyhhveAhl1gJeey9uxDDIHllx2cIBQBQiJwef5HtkzSpc7ZEHEJulI+j2oj5EqeSsEj/Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UBHhtj5z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UBHhtj5z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 637071F00A3D;
	Tue,  1 Sep 2026 13:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788269823;
	bh=TmJ0D6THwXSlKazd/+sm2hmq8WhHNqX9gHKbDkCivrU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=UBHhtj5zVHN/QyGSVCTr2I1jvC6gEoa1X7Z6gK99peLAU9kcllSvdsachMsnbxfi2
	 JevoZf7OerOse4NMEXYM/0FxqB9JBoPzCoJZUVKJZvxETemWI+sGevydriQVKY7zwU
	 d6RV9ihRib8Kx4OdEPvExnZbXbiGGtAmtSjh6HjOpqwCk7+FHkY4zNBPq+5hYFCrIQ
	 sMOzWWnzGpcqDz50by1vmfsT6j2HSNSu+M4yMlCP2aBH2B0Dro62QRikYe1BaiuUoZ
	 6XYCY4YmKGFp/IbHx7iO71bwcXVfUFjtbeidsYGePl0SFUYKaoIG8UQFInApMhIDeD
	 m/n88RuUi00xA==
Message-ID: <f1930f04-a09b-4425-8ce3-a9229e52acfd@kernel.org>
Date: Tue, 1 Sep 2026 15:36:57 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] rust: pci: reject IRQ vector indices that do not fit
 in u32
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Sophon Zhang via B4 Relay <devnull+aiqubits.hotmail.com@kernel.org>,
 aiqubits@hotmail.com, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, =?UTF-8?Q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, linux-pci@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260901-fix-pci-irq-vector-index-truncation-v4-1-f94aa6932fd9@hotmail.com>
 <DL3XDBBHXKKV.G9P6KRSSX1DN@nvidia.com> <DL3XLHXS647M.1LMHQUVX5RTI@kernel.org>
 <DL40NH1AX8WN.2ZPY7GDL0FSEW@nvidia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <DL40NH1AX8WN.2ZPY7GDL0FSEW@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/1/26 3:32 PM, Alexandre Courbot wrote:
> On Tue Sep 1, 2026 at 8:08 PM JST, Danilo Krummrich wrote:
>> On Tue Sep 1, 2026 at 12:58 PM CEST, Alexandre Courbot wrote:
>>> That makes me wonder, shouldn't we make `index` take a `u32` directly?
>>> If that's what the C API expects, it does make sense to align to it
>>> instead of forcing users to make a potential unneeded conversion if they
>>> already have a u32.
>>
>> I intentionally did not do this, as the common type for an index is usize. Thus,
>> I do not expect anyone to already have a u32, but to already have a usize, e.g.
>> from some iterator.
>>
>> The fact that the C API did pick unsigned int as index type is an implementation
>> detail the abstraction should bother with.
> 
> Thanks for the clarification (and Miguel for elaborating - I wasn't
> completely aware of it!). In that case this patch looks correct to me.
> 
> Note that there is another `as` right after, in the same method:
> 
>   if irq < 0 {
>       return Err(Error::from_errno(irq));
>   }
> 
>   // SAFETY: `irq` is a valid IRQ number for `self.dev`, resolved from this registration.
>   Ok(unsafe { IrqVector::new(IrqRequest::new(self.dev.as_ref(), irq as u32), self) })
> 
> 
> We could get rid of it by replacing the `if irq < 0` test with:
> 
>   let irq = u32::try_from(irq).map_err(|_| Error::from_errno(irq))?;

That's a good suggestion!

> Sophon, if you feel like doing it I think this could improve the patch
> further.

Let's please do that as a separate patch though.

Thanks,
Danilo
