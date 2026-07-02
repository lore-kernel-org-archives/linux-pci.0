Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B6B37A84C;
	Thu,  2 Jul 2026 15:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783005918; cv=none; b=Cw9V2jB9f8OhoZrXkdLGDZI44MwvHilF9GKhmc2oknDd88p4mNRLpQdou5pPcMLbGwJUh+7T5Juxhr5yeJbRgUh8R9O0B9tgZiH5QF0VbJm3YgWCbiXgNC4HDSD68dSZhB4uys+hHhEtDD4SSfohtHxIOfPz+HR4Gm9up3h5WlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783005918; c=relaxed/simple;
	bh=Iv+CS4zGcjpl9dgtplypLGqInhjimWb21gAdLeCVf4M=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=tG90HPjfFl9GsIb3V7lj8m+1upIBaTuUCFqUIuUAIFgUvBBvGIibnJjs/MAm7A8kBj8WGwThbFWJXzAhtnv9+ZzMYxJkgfGUMwy3KrHypSBsLOtEyRnZmgTz0h0KxMgv0zhSkLRp6uSRfM5y8ChG0e6+UTo1pQeAkUiel4rr/ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=fSdJ6pdC; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=SxPG9jDE; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="fSdJ6pdC";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="SxPG9jDE"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4grggD5gkMz8v0C;
	Thu, 02 Jul 2026 17:25:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783005912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RjnMPXnF/dhQHuvEZSYY5RMLgAVlSQUXztQWCWzRLSE=;
	b=fSdJ6pdCsE+UwBNL3kddRWXjArXh+JsA1hvkBKghwikAB6sApHqwBjXxDZe7VKzquNzx3k
	SEWOF3ePWraXigEQAIFdJbBhkbZkkrwoAKHBhLxHD44ISpCnBXy7hhahGcXxI0z1B80t4b
	1QWs+TGuqaRJdlpN4UkLb23I6kc6sgih+OyMNF2KHQjUZkpev8lwUSZ8o/U4R3prNSLgYh
	Htej4zElQI9y73jeuWmwPqKlTcCzKLWx9f+Wve5UTdCh0K1/B7D4sOH4fIBWt1RobWDgXm
	Flc0ZlL6fcdBG+Qyee5U2hCwf19LFmBjiYI56W52kwV+KT4v9CTXjbR1jfgS+A==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=SxPG9jDE;
	spf=pass (outgoing_mbo_mout: domain of mhi@mailbox.org designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=mhi@mailbox.org
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783005911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RjnMPXnF/dhQHuvEZSYY5RMLgAVlSQUXztQWCWzRLSE=;
	b=SxPG9jDEPtWML8dI4s59JRRZvazT9Ro4WIw8Z739R7ZmytWC00soHClKuI+/QOMMxClGRE
	2zZRp4gHooBR0Z1mylbRh74qQX0A+/T44GI+rSNxHqoN45x0sahAVKLe25JbLG9X5AIla5
	mgBBcqjlNlp8tbk2UMycYdrvVD/+PADLX/0KHIQopQrsK/ETrk1AfWV4QNcA30BfG7EKgx
	tx5IDB0p7XTgUe+An2OLQUF2+i+aOw6SECAOWg3Q/cLIr0w7TpqxPIGSMSpf3dVIpOdA+b
	7TxSnxTA6QXvlaFUVaUhETlbHmGGskEqi1va/C+GpEmnF9lEdk5SeSKwXTsspg==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Jul 2026 17:24:59 +0200
Message-Id: <DJO6UALV8NXX.CQL2772AEKFE@mailbox.org>
From: "Maurice Hieronymus" <mhi@mailbox.org>
To: "Danilo Krummrich" <dakr@kernel.org>, "Maurice Hieronymus"
 <mhi@mailbox.org>
Cc: "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "Lyude Paul" <lyude@redhat.com>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] rust: samples: add EDU PCI driver sample
References: <20260620-b4-rust-pci-edu-driver-v2-0-6fd6684f2c14@mailbox.org>
 <20260620-b4-rust-pci-edu-driver-v2-4-6fd6684f2c14@mailbox.org>
 <DJEQ64V8HE19.2DMBHY4XRPMG6@kernel.org>
In-Reply-To: <DJEQ64V8HE19.2DMBHY4XRPMG6@kernel.org>
X-MBO-RS-META: urjtyqjub15b67qxzrh8edtqqum1ehkb
X-MBO-RS-ID: fa0b7829f2d618b5ef4
X-Rspamd-Queue-Id: 4grggD5gkMz8v0C

On Sun Jun 21, 2026 at 2:27 PM CEST, Danilo Krummrich wrote:
>> +impl pci::Driver for EduDriver {
>> +    type IdInfo =3D ();
>> +    type Data<'bound> =3D Self;
>
> Please make this a new type and take advantage of Rust native lifetimes f=
or
> device resources, just like the existing sample driver and nova-core does=
.
>
> I understand that the existing IRQ infrastructure is a bit in the way and=
 you
> have to work around it.
>
> I'm going to send a patch to make the irq::Registration compatible with t=
he
> device driver lifetime rework soon. Please rebase onto that once it's sen=
t, so
> this sample can land as idiomatic as possible.

If you haven't started on the irq::Registration rework yet, I'd be happy to=
 take a
try at it myself. I saw the DevresLt/ForLt work on your driver-lifetime bra=
nch;
is stacking on the I/O generalization series the direction you have in mind=
 for the
handler data?

Thanks and best,

Maurice

