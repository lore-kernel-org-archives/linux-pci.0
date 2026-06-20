Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch [109.224.244.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D0527874F;
	Sat, 20 Jun 2026 09:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781948910; cv=none; b=FofvPJ1HMdENrZtrOBWuEpOPMt4c1Jf2EVoiBOFvVeC4DAy+PVbcm9Ma5Zx7GQJtzuRqLKllxvme/kp6URovaeRTuR04sXKiNzQdabZfYEbBiZVJyKxwfczpuGxV6oD0bDOSvkS5zm/OdKb6UcykHspOHNqSGelcWKlgC/Jk9kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781948910; c=relaxed/simple;
	bh=geWSv/T5XWcGEeo4/XJSgAwYYfXlxKxV7Yr/S+EwjmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yj2lsgDnC/PaTp9d3NXNSyKQYbKrWCkOx+/zT2t78JoX05B/bDl10Xaa/6raMKm5wCN4n4heVoXzMA/ddQ2rf19ftr8xX+dQAn4QJt98o1Yvtlzp3UaLs4AEEw4ciP59qySwgC1BGYzlvLTPDNlrvA7m7EZWUZ3pF9agPSuwFog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=bM8bApB1; arc=none smtp.client-ip=109.224.244.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="bM8bApB1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1781948900; x=1782208100;
	bh=jBSURXFRLbbBTaF4NGy+Yff5wO8oZTfNBtF5SGS66lU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=bM8bApB1mcv3w0ao2Z+Nn1VkXdPYN9qBukpugYQYQf8IrpgHozrP3bkm8GeF62LSs
	 hQWyc3+YzScwZuju09EV3P+Re9oQR/hp4Lt02xee8FJba2UCL8byvr7SNSnyhEUoE1
	 iP2biuerzVz6fbjtXfu84M9h9rh/qKCkqSQvRSHD88/V/go2sUdp4zw1Pyf9oNNlNX
	 twCV2OgQYLuvPlBoNWFNP40zSXqe6cz0wjUQhtOk7GPOqIkp8qwJyP4G9jt8PghC4D
	 kaOPwbt9QyeVygbY+vmdWrzo0HC6NYG3FP5IHn3URBuS2TOxoh3mITIUFA4dtlMpjw
	 lBfZroMdkR12A==
X-Pm-Submission-Id: 4gj8m05jlMz2Scmn
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: Maurice Hieronymus <mhi@mailbox.org>
Cc: Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Lyude Paul <lyude@redhat.com>,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] rust: completion: add complete()
Date: Sat, 20 Jun 2026 12:48:12 +0300
Message-ID: <20260620094815.8347-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260620-b4-rust-pci-edu-driver-v2-3-6fd6684f2c14@mailbox.org>
References: <20260620-b4-rust-pci-edu-driver-v2-0-6fd6684f2c14@mailbox.org> <20260620-b4-rust-pci-edu-driver-v2-3-6fd6684f2c14@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 20 Jun 2026 10:45:47 +0200=0D
Maurice Hieronymus <mhi@mailbox.org> wrote:=0D
=0D
> The initial completion abstraction only added complete_all() and=0D
> wait_for_completion(). complete_all() marks the completion permanently=0D
> done, which makes a single Completion unsuitable for signalling the same=
=0D
> event repeatedly: once complete_all() has run, every subsequent=0D
> wait_for_completion() returns immediately without waiting.=0D
> =0D
> Add complete(), which wakes a single waiter and increments the internal=0D
> counter by one. Paired one-to-one with wait_for_completion(), it allows=0D
> the same completion to be reused across multiple cycles, e.g. to wait for=
=0D
> consecutive DMA transfers to finish.=0D
> =0D
> Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>=0D
> ---=0D
>  rust/kernel/sync/completion.rs | 11 +++++++++++=0D
>  1 file changed, 11 insertions(+)=0D
> =0D
> diff --git a/rust/kernel/sync/completion.rs b/rust/kernel/sync/completion=
.rs=0D
> index 35ff049ff078..a54361b53644 100644=0D
> --- a/rust/kernel/sync/completion.rs=0D
> +++ b/rust/kernel/sync/completion.rs=0D
> @@ -90,6 +90,17 @@ fn as_raw(&self) -> *mut bindings::completion {=0D
>          self.inner.get()=0D
>      }=0D
>  =0D
> +    /// Signal a single task waiting on this completion.=0D
> +    ///=0D
> +    /// This method wakes up a single task waiting on this completion.=0D
> +    /// If no task is currently waiting, the next=0D
> +    /// [`Completion::wait_for_completion`] returns immediately.=0D
> +    #[inline]=0D
> +    pub fn complete(&self) {=0D
> +        // SAFETY: `self.as_raw()` is a pointer to a valid `struct compl=
etion`.=0D
=0D
I think the safety comment is a bit weak here. It would be nice to add why=
=0D
self.as_raw() is guaranteed to be a valid pointer.=0D
=0D
- Onur=0D
=0D
> +        unsafe { bindings::complete(self.as_raw()) };=0D
> +    }=0D
> +=0D
>      /// Signal all tasks waiting on this completion.=0D
>      ///=0D
>      /// This method wakes up all tasks waiting on this completion; after=
 this operation the=0D
> =0D
> -- =0D
> 2.51.2=0D
> =0D
