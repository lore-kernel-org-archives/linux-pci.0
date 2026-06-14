Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB0323AE62;
	Sun, 14 Jun 2026 19:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781464010; cv=none; b=c+CtOosuZH9whXiVcVC9QptjSNren6yT1J7yA+jtfAe2rAtDwhX0UVZfjC7spiyLpNs7tJ30nlFRJdvcEZrFt583KcAl1IOu8wn9h35pmqGkjuShZovKOXQt8NVdMMFhIB9uQZxRhpN8rpPGo8Fjml8BfJkQqWEbKIIdGeTkKJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781464010; c=relaxed/simple;
	bh=k3QCqmw1T6l7mUtgKb3hT+9TRaPBaNJwqi0SKsqgOrk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kOwq44y0bKyKALjZpeAoR9wrbdBjake5AB4yHW4ZBNQE6BhP8dkrHcU97DvJWoVSF4TAanC9LMPjQYED1SlDuTQzpuZqnjO8qVoIpb33CBLfBFXDJYfHPK13NQ+0UUXiWSEojlRn5NSdXI4dYXGm62W6fNjCygz56W1MF23eSgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=xoYJSMrW; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="xoYJSMrW"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gdjR840Zqz9tWv;
	Sun, 14 Jun 2026 21:06:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781464004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k3QCqmw1T6l7mUtgKb3hT+9TRaPBaNJwqi0SKsqgOrk=;
	b=xoYJSMrW8WgPW1v+tD/rJE5UuB8uDttHf833RHajcy6A7Nkk0JfooYqYoorNuRBEv45Rdj
	SZqoQCNOQc8QUSqufLVroz3LJGYhunRLg20T/EKlef5ZP9ij0blIaX83Duen2iMKVOLt5N
	6tfEEsnmI5dhMbwQHJNNjF7yklFxJ+dvI6imW76Ho6Gr3eNyu4LOQMWH4qaePqFomhclF7
	C3ELr56j2/YWrYvvEtD+WweJ/LlmLK6PUNDPwpj7E16tgCvrD8YO8aJzoszLbBukHvb/x7
	LzP4ApFyCiW4op3Ptur3yIxov5khpb/y+C9q11eK3VclLqidCMTId77wFjj0xA==
Message-ID: <a9f96dfd400dccbbdfcd191e448a962cab8c1dab.camel@mailbox.org>
Subject: Re: [PATCH 2/4] rust: pci: add managed Device::enable_device()
From: Maurice Hieronymus <mhi@mailbox.org>
To: Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
  Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=	 <kwilczynski@kernel.org>, Miguel
 Ojeda <ojeda@kernel.org>, Boqun Feng	 <boqun@kernel.org>, Gary Guo
 <gary@garyguo.net>, =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg	 <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross	 <tmgross@umich.edu>, Daniel Almeida
 <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>, Onur =?ISO-8859-1?Q?=D6zkan?=	
 <work@onurozkan.dev>
Cc: linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Sun, 14 Jun 2026 21:06:38 +0200
In-Reply-To: <20260614-b4-rust-pci-edu-driver-v1-2-e3f2471b595c@mailbox.org>
References: <20260614-b4-rust-pci-edu-driver-v1-0-e3f2471b595c@mailbox.org>
	 <20260614-b4-rust-pci-edu-driver-v1-2-e3f2471b595c@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: jgzqm4jqnyb1iahiwcy6t5ge8iepn7b4
X-MBO-RS-ID: b88d3be925106cc4d9a

On Sun, 2026-06-14 at 17:59 +0200, Maurice Hieronymus wrote:
> Add a managed counterpart to Device::enable_device_mem() that wraps
> pcim_enable_device(). In addition to enabling the device, it
> registers a
> pci_disable_device() cleanup that runs automatically when the device
> is
> unbound from its driver, keeping the device's enable count balanced
> across unbind/rebind cycles.
>=20
> The existing enable_device_mem() wraps the unmanaged
> pci_enable_device_mem() and has no disable counterpart, so the enable
> count is leaked on unbind. On the next probe
> pci_enable_device_flags()
> sees a non-zero enable count and returns early, skipping the power-
> state
> transition back to D0. For a device without a PCI power management
> capability the power state cannot be re-read from hardware and stays
> PCI_UNKNOWN, which makes __pci_enable_msi_range() reject the
> subsequent
> MSI allocation with -EINVAL.
>=20
> Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
> ---
> =C2=A0rust/kernel/pci.rs | 16 ++++++++++++++++
> =C2=A01 file changed, 16 insertions(+)
>=20
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index af74ddff6114..ca04548c82c3 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -452,6 +452,22 @@ pub fn enable_device_mem(&self) -> Result {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to_result(unsafe {
> bindings::pci_enable_device_mem(self.as_raw()) })
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> +=C2=A0=C2=A0=C2=A0 /// Enable I/O and memory resources for this device, =
with
> automatic cleanup.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// This is the managed version of `pci_enable_device=
()`: it
> enables the device's I/O and
> +=C2=A0=C2=A0=C2=A0 /// memory resources and registers a `pci_disable_dev=
ice()` call
> that runs automatically
> +=C2=A0=C2=A0=C2=A0 /// when the device is unbound from its driver. In co=
ntrast,
> [`Device::enable_device_mem`]
> +=C2=A0=C2=A0=C2=A0 /// is unmanaged and only enables memory resources.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// The automatic cleanup keeps the device's enable c=
ount
> balanced across driver
> +=C2=A0=C2=A0=C2=A0 /// unbind/rebind cycles. With an unbalanced (leaked)=
 enable
> count, a re-probe skips the
> +=C2=A0=C2=A0=C2=A0 /// power-state transition back to `D0`, which makes =
subsequent
> MSI allocation fail with
> +=C2=A0=C2=A0=C2=A0 /// `EINVAL`.
Will add #[inline] in V2.
> +=C2=A0=C2=A0=C2=A0 pub fn enable_device(&self) -> Result {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: `self.as_raw` is g=
uaranteed to be a pointer to a
> valid `struct pci_dev`.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to_result(unsafe {
> bindings::pcim_enable_device(self.as_raw()) })
> +=C2=A0=C2=A0=C2=A0 }
> +
> =C2=A0=C2=A0=C2=A0=C2=A0 /// Enable bus-mastering for this device.
> =C2=A0=C2=A0=C2=A0=C2=A0 #[inline]
> =C2=A0=C2=A0=C2=A0=C2=A0 pub fn set_master(&self) {
