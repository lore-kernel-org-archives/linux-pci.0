Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE45481FB9;
	Thu,  2 Jul 2026 14:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783001524; cv=none; b=a1cy+agOODG/Kl4gKHi0zsfqI9qeukFmOcmdgYJooP1hgSfoP3KDBdpw8OCCyutnJtj9N8V7GiaRp33C6zcMJS8QOXv8SqWYZSLrWC2lfz4LVZ1GhzcIE4b5MqB8ovFC27JqDUZqAczs2KEH8pGwfk6actUDYvjBOG/j4hFiP/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783001524; c=relaxed/simple;
	bh=5YVkEUk1VvUE0uXIpeGk+VtjVa60Z+1R9iJdsXWka3I=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=gzj0pC4ADf22dRnwBuONji2XVciLEEbCC9pmiZ1qagIkhoDiGb3JqYtVOM09se6Dr7G6Io5+qvtLpvfI6gPceLYemp4+Ea5jQrU80qUvAkhkfmOaNSbxhiP5sne8XMws12IWso3v3U1nODmqAyXmThc/JjyAT+kN5C/JJpUtXgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=aQgaI6oW; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=KNJbvCnp; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="aQgaI6oW";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="KNJbvCnp"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4grf2l5KrLz9ttk;
	Thu,  2 Jul 2026 16:11:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783001519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ksmXwi8tu9mdEBoQBPl2d3d/fhMwsJx5kxAdif4Y6g=;
	b=aQgaI6oWhIKPz3dg0vYxRxQuc7SwR4FFjOMaAhv/FhCINgbQXS7qrPM/mkStomucYq2M1H
	UWpUc57w3JZFNgNi2evX6cRw5IFOcugZupdOf8ilwoTBcQm1yuDTuw/iY0EfLCUZgveX/2
	tZiwiEbQDFFSr1wN84e2/2d2ZQSuVW4bwdQvR6fG1I3kcub9dFzCgkHaz3r6LCrYSpFkYx
	9ljVv0qY0FFcghxo0I+5jO9Oz4sEeumf3stPVusPJ6CbNeet9BIprmXWs7ILDLXeImyVco
	rT77im2jj2E0sOcpMN+r9QLSLzbJuN7coddoTqXls2NJYXTVTIuHifndEPSkKQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=KNJbvCnp;
	spf=pass (outgoing_mbo_mout: domain of mhi@mailbox.org designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=mhi@mailbox.org
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783001518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ksmXwi8tu9mdEBoQBPl2d3d/fhMwsJx5kxAdif4Y6g=;
	b=KNJbvCnpHxJVm1bPSBkoGrOQ+DQGVVo+E93WiJNaWcvpO/x5GJNB4Hoht6xJBN2CWwfaX8
	N8PPEXDXmKDbxakSXIFZ/StPL8Hx8bvd40yDrM0z3nH6B8f8vxaBElTgQ586GA3Dk/yr/p
	HzR+xCqjH1DxRO3pDjIDaGP8LhhJcDZ2EnJnMAQxNti9cWFoT/BESZZxG3UlgSRsc/x/bx
	hWg+tvWUj6MINcG1dBze1Xb7Phacxhj94MLXV79FokCWV7USTKXDf9GxbMsDxD8kQfogmv
	pDSLULW81A8wK7nqez9y8tPpa5tm7uyQPcVvKBAV5FuxAsSiTdC1spV8axfBCA==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Jul 2026 16:11:47 +0200
Message-Id: <DJO5A8OJXRJJ.3CVUFZA73QYOC@mailbox.org>
From: "Maurice Hieronymus" <mhi@mailbox.org>
To: =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Maurice Hieronymus"
 <mhi@mailbox.org>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>, "Lyude
 Paul" <lyude@redhat.com>, <linux-pci@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] rust: completion: add complete()
References: <20260620-b4-rust-pci-edu-driver-v2-0-6fd6684f2c14@mailbox.org>
 <20260620-b4-rust-pci-edu-driver-v2-3-6fd6684f2c14@mailbox.org>
 <20260620094815.8347-1-work@onurozkan.dev>
In-Reply-To: <20260620094815.8347-1-work@onurozkan.dev>
X-MBO-RS-META: xzkct7h9d7ar1mwnaqcqwt8mkdakhnky
X-MBO-RS-ID: f64b412c6e2ff9a57cd
X-Rspamd-Queue-Id: 4grf2l5KrLz9ttk

On Sat Jun 20, 2026 at 11:48 AM CEST, Onur =C3=96zkan wrote:
>> =20
>> +    /// Signal a single task waiting on this completion.
>> +    ///
>> +    /// This method wakes up a single task waiting on this completion.
>> +    /// If no task is currently waiting, the next
>> +    /// [`Completion::wait_for_completion`] returns immediately.
>> +    #[inline]
>> +    pub fn complete(&self) {
>> +        // SAFETY: `self.as_raw()` is a pointer to a valid `struct comp=
letion`.
>
> I think the safety comment is a bit weak here. It would be nice to add wh=
y
> self.as_raw() is guaranteed to be a valid pointer.
>
I agree with you. However, I just copied the safety comment from the other =
functions.
That being said, should I also change the saftey comments of all the other =
functions then?

I thought something along those lines:
// SAFETY: `self.as_raw()` points to `self.inner`, a `struct completion` in=
itialized by
// `Completion::new()` (the only constructor) and kept alive by the `&self`=
 borrow.

Best,

Maurice
> - Onur
>
>> +        unsafe { bindings::complete(self.as_raw()) };
>> +    }
>> +
>>      /// Signal all tasks waiting on this completion.
>>      ///
>>      /// This method wakes up all tasks waiting on this completion; afte=
r this operation the
>>=20
>> --=20
>> 2.51.2
>>=20

