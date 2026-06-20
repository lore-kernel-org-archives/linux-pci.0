Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FCA184540;
	Sat, 20 Jun 2026 22:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781993980; cv=none; b=MvSKEk8VI1z/SrGsdG9rTpB0e3pKmAu2L2O9X7Dm4YhPmRdOfrn3KPm9Rgp/oh6B7idIVXTLVqQRB2G0ZSgJPpQqdhtjJ1QmUGPCFlPOub1WI6H8K7TTBevwr7z9CoE2Su36EeoyA+NWXRDGGfpHF20d85hZyuAQ6T86boOFgmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781993980; c=relaxed/simple;
	bh=iKag8Wbg6apQqw1GVivqk4n/eA834L8fgVW0obFHggg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hi86R6Qe6xuj0OkuWH6BHvl3PRWoHQvx40Ymwc5O1Z5SoFO8LK5vWJFKO3WrAAKvDmJN9tTzCyusrHDK37ZO0cxGX8Nsh+TCpj99ctYCxGlHq8+iybSUo4iTPagpCpeTa3z4/XgV9w+oyufADmwf5EqLQD+sBPBxkMdauJp0ZKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=rwnRc365; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="rwnRc365"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gjTQm4hyzz9tZ3;
	Sun, 21 Jun 2026 00:19:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781993968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iKag8Wbg6apQqw1GVivqk4n/eA834L8fgVW0obFHggg=;
	b=rwnRc365bq46Z3dP2YqTPKuYDQ3aPlrW/0zEn3YxN7fNp7+RTUB8HxSWyiN13WbogkL3dq
	qktnSbYqYRmSIMb9X40sq5F9/sOkfAHPKwaRLSLmpAsZk/yxbwY0Iz1WUGJqoM8BsOOdkT
	Jwin4KdXWaOnfkx12a7mpIjwFQHYGQ0GXs5U5Uw6znF+Z38j3flBpxmdJN5orfQNAggSVJ
	OFbOY2lwyRxNZAlFW/o5uaFOByGQqi7eJQSwgCY86mchP88RV/vyd5XUApHO+518p6EO8S
	xhlIWweEm2ArugEIl2C3moWxv80E90ZgxFaOXP0cRxHjikf6wZKf0Np4Hry0Ng==
Message-ID: <23297c85b12edcf0eafb183827e0db750620e6cb.camel@mailbox.org>
Subject: Re: [PATCH v2 2/4] rust: pci: add managed Device::enable_device()
From: Maurice Hieronymus <mhi@mailbox.org>
To: Onur =?ISO-8859-1?Q?=D6zkan?= <work@onurozkan.dev>
Cc: Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
  Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=	 <kwilczynski@kernel.org>, Miguel
 Ojeda <ojeda@kernel.org>, Boqun Feng	 <boqun@kernel.org>, Gary Guo
 <gary@garyguo.net>, =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg	 <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross	 <tmgross@umich.edu>, Daniel Almeida
 <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>, Lyude Paul <lyude@redhat.com>, 
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Fiona Behrens <me@kloenk.dev>
Date: Sun, 21 Jun 2026 00:19:18 +0200
In-Reply-To: <20260620095401.11939-1-work@onurozkan.dev>
References: <20260620-b4-rust-pci-edu-driver-v2-0-6fd6684f2c14@mailbox.org>
	 <20260620-b4-rust-pci-edu-driver-v2-2-6fd6684f2c14@mailbox.org>
	 <20260620095401.11939-1-work@onurozkan.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 72579dc082773ce3f50
X-MBO-RS-META: ro9rbnhhhgurszza7ydjaa7hkyzgwftq

On Sat, 2026-06-20 at 12:54 +0300, Onur =C3=96zkan wrote:
>=20
> > =C2=A0impl<'a> Device<device::Core<'a>> {
> > =C2=A0=C2=A0=C2=A0=C2=A0 /// Enable memory resources for this device.
> > +=C2=A0=C2=A0=C2=A0 ///
> > +=C2=A0=C2=A0=C2=A0 /// This function is unmanaged and does not perform=
 any
> > cleanup when the device is unbound.
> > +=C2=A0=C2=A0=C2=A0 /// For a managed function take a look at
> > [`Device::enable_device`].
> > +=C2=A0=C2=A0=C2=A0 #[inline]
> > =C2=A0=C2=A0=C2=A0=C2=A0 pub fn enable_device_mem(&self) -> Result {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: `self.as_ra=
w` is guaranteed to be a pointer to
> > a valid `struct pci_dev`.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to_result(unsafe {
> > bindings::pci_enable_device_mem(self.as_raw()) })
> > =C2=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0
> > +=C2=A0=C2=A0=C2=A0 /// Enable I/O and memory resources for this device=
, with
> > automatic cleanup.
> > +=C2=A0=C2=A0=C2=A0 ///
> > +=C2=A0=C2=A0=C2=A0 /// This is the managed version of `pci_enable_devi=
ce()`: it
> > enables the device's I/O and
> > +=C2=A0=C2=A0=C2=A0 /// memory resources and registers a `pci_disable_d=
evice()`
> > call that runs automatically
> > +=C2=A0=C2=A0=C2=A0 /// when the device is unbound from its driver. In =
contrast,
> > [`Device::enable_device_mem`]
> > +=C2=A0=C2=A0=C2=A0 /// is unmanaged and only enables memory resources.
> > +=C2=A0=C2=A0=C2=A0 #[inline]
> > +=C2=A0=C2=A0=C2=A0 pub fn enable_device(&self) -> Result {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: `self.as_raw` is=
 guaranteed to be a pointer to
> > a valid `struct pci_dev`.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to_result(unsafe {
> > bindings::pcim_enable_device(self.as_raw()) })
> > +=C2=A0=C2=A0=C2=A0 }
> > +
>=20
> How about adding `_managed` and `_unmanaged` suffixes to the function
> names?
>=20
In general, I agree with you.

However, both functions differ slightly more than being only managed
and unmanaged. `enable_device` enables I/O and memory resources.
`enable_device_mem` only enables memory resources.

Isn't it confusing when we only have `enable_device_managed` and
`enable_device_mem_unmanaged` but not `enable_device_unmanaged` and
`enable_device_mem_managed`?

What is the general road ahead in the future? Do we want to continue to
have C-Code "magically" clean up our resources or would it be
preferable if we get some handle, which does the clean up when it is
dropped?
> - Onur
>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0 /// Enable bus-mastering for this device.
> > =C2=A0=C2=A0=C2=A0=C2=A0 #[inline]
> > =C2=A0=C2=A0=C2=A0=C2=A0 pub fn set_master(&self) {
> >=20
> > --=20
> > 2.51.2
> >=20
