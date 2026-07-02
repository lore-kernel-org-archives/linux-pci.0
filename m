Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD35139A4CF
	for <linux-pci@vger.kernel.org>; Thu,  2 Jul 2026 12:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782995732; cv=none; b=DhEpatoW5moMx+pCwaRJnoReVuPm+dSUIpFxOM6FffFrpbk7VX8YpaThvAqu2oWh2X9UB0cxpqhta4/LfynMxmX5H070Q6II46p2dE50hR+ZVTp+xqQBEQd0yEe4ayYeSPkM88z4U+M1gZd7MPx3fpMFc+H2sWjGjJai2+I67Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782995732; c=relaxed/simple;
	bh=A75cH9vDUcSuqqIcjcDggDuojYWt7a6anlsiMWIVqb4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a4z0HVZZL9R4nnlAXqcjoTHUMxgKyqPkZeDtdh6fJMpg+ydghBrTkP2/JuaVwR4S72gI+SZORV+cL2XxuHZ7zbGDl7w1utEt5s7IDFQ/NCkRtUOG1LnR/F2z8tpTKA+AcHDfVco1seElCIoVPbv4xTZsjd3NPbI+aow0D9bLm0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JIvBQkQT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIvBQkQT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC7B1F000E9;
	Thu,  2 Jul 2026 12:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782995731;
	bh=b/sJt11Ayl+djgh4REyt391Nu3np/UCqGpQ9OJ8jYBQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JIvBQkQTQqDr3gFNL8Knt3JcZMQbHYiiuq25thcq4N6QywWoTpy3dYwra0tNyyZPx
	 w4+ifIVOn4REu2OdPHDEUScC6Dy6XS7GrOboSPd9nQgWZ+19+cg5eoa97u6YxRozE1
	 0JmzrB0ZeqOEXN2+mIfDaGg6K5rHIBCGICCr218fSHoLjZRho1O+f8tejf2+SyM6Ek
	 kU8r7qCFUKGD08l0TsU3S6nZMRi42NUBN3HtKt1aVQNRb3O4jJeZSXgej//xEXaqAn
	 sxLvgWSG8ugJIqnNMLIuH52PThm1Swbew1eEyFqo6joKHcuXxsqZH3W66diy4SbRRa
	 +lNCBIuJjlWwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rust: device_id: rename IdTable::as_ptr to
 as_raw_id_table()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alice Ryhl" <aliceryhl@google.com>
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260702-idtable-rename-asptr-v1-1-e0927273c71a@google.com>
References: <20260702-idtable-rename-asptr-v1-1-e0927273c71a@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 12:35:29 +0000
Message-Id: <20260702123530.ACC7B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The current name of `as_ptr` is very generic, and if you attempt to
> invoke `foo.as_ptr()` on a type for which this method is missing, then
> an error along these lines will be printed:
>=20
> 	error[E0599]: no method named `as_ptr` found for reference `&DmaBuf` in =
the current scope
> 	   --> linux/rust/kernel/dma_buf/buf.rs:54:38
> 	    |
> 	 54 |         ptr::eq(self.as_ptr(), other.as_ptr())
> 	    |                                      ^^^^^^ method not found in `&=
DmaBuf`
> 	    |
> 	    =3D help: items from traits can only be used if the trait is impleme=
nted and in scope
> 	note: `device_id::IdTable` defines an item `as_ptr`, perhaps you need to=
 implement it
> 	   --> linux/rust/kernel/device_id.rs:165:1
> 	    |
> 	165 | pub trait IdTable<T: RawDeviceId, U> {
> 	    | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>=20
> Suggesting the IdTable trait when an as_ptr() method is missing is not
> useful. Renaming it to `as_raw_id_table` makes the method name unique to
> this trait and avoids these bad suggestions.
>=20
> Assisted-by: Antigravity:Gemini
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-idtable-re=
name-asptr-v1-1-e0927273c71a@google.com?part=3D1

