Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793833765;
	b=U/OWwmMWCglj9f0kut82N/o46COvryF4P3lDtcvN7vHPmqqYOMVa1S6QTQ8CmqtEaBx6
	 /5IbZX0YIr+31RnFL0PPQgdNzz/RkSn3hYcnR76q9br0Eor3N+snshLaCnUI0fF4QlyoJ
	 1SgZEdgNNyXCiHHBa35M2TGU06mtOYTZhaZgU+eH/j4OJj3wpOz+4lVyqIEbOBevZUzXJ
	 ITXLq7pkiqQVNs4TLuvb6wz/EK5qYrjKvgf79NlHJYlkTnP7KgBXz33eS//z8YUsfcIK7
	 f9OV38u1w4CSOaLOlru0o52mKW1p1BLKTEZR9hsEzWyuguSLQpcmDU8xOqJFPB5gViQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793833765;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hsTflurMnOL1xe0rgJ6VI3Mw7eG70p/iqwczxfRU330=;
	b=K6h49w+F0FtYUYlTKC9/H2P6Ph4z3gKSeYUTcDu1ewwFqP1b+w07qr4533+DsW4yk7jN
	 oo1ExMPUOaBRG+87Qa4cP47NrB3L4clw9LDSpbQjFOiNw0iQM2gc8CuqE4yR1sGv/zdLQ
	 Dhy6r/+pGTTmhBFH56Jwa4JlqolYececX82WUgNGqdHwA7a6XYHru6TGRNIwT9v4nZy2+
	 x0U9ho9ztzC7guovVtrFbViJu8m3kLCLP6gAHBpY0bItLQX1En5jUheYzpbOhM5r6b1Cg
	 IgCee2EgHs1KOwcyIzGrkWBPLmQ751KJwqDXmIoiwULfGEa8tWs4CEx3F9kn+KYxvFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="SW4P/3Nj";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323BF606A31B
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 23:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SW4P/3Nj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 880C81F000C1;
	Wed,  4 Nov 2026 23:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793833764;
	bh=hsTflurMnOL1xe0rgJ6VI3Mw7eG70p/iqwczxfRU330=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SW4P/3NjqNiftXJC3dfqECzpai5jxIvYloX8hFxQl/RUcCtoXcvwRj2BZ9Xes91wc
	 /eGCl5vS1DAX5dIHISI5r0HoeEVTg1UeAaMJ1ZIARLUj49njsgp+VEjorebfvF84yA
	 DpPz1qoF/cR2Ev1W87dV9RJdDRs4G3xHntijFZpBMk+TVgRHeh15VXUX0miH7Z4EAg
	 5rVAy3mWBFL6zC8UgQ6p+wnqZX/GcBB2DsEW3OK71bCHL+JdFjuLA/QsYMnS4vRoHK
	 LCldzfwWtDr6nFCr3FXo586WwDT6SttspcBOw/eiRbbPpeTOlcTCU1EnXd/peWs4uZ
	 x9zd0UwcGbzkw==
Message-ID: <sashiko-outbox-198266@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/7] rust: pci: add Vendor::QEMU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maurice Hieronymus" <mhi@mailbox.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261105-b4-rust-pci-edu-driver-v4-5-20ef027bb707@mailbox.org>
References: <20261105-b4-rust-pci-edu-driver-v4-0-20ef027bb707@mailbox.org>
 <20261105-b4-rust-pci-edu-driver-v4-5-20ef027bb707@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 23:09:24 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Expose `PCI_VENDOR_ID_QEMU` as `Vendor::QEMU`, so Rust drivers can match
> QEMU's 0x1234 devices without constructing a `Vendor` from a raw ID.
>=20
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Suggested-by: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-b4-rust-pc=
i-edu-driver-v4-0-20ef027bb707@mailbox.org?part=3D5

