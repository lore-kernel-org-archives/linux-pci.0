Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794822876;
	b=qPmTfjJ6QQ9meTmZMdDOnb2WOj+VKrF5ot7ZpUgJ5tLB0N8CAsaqzQ38RhMRKQw5lFAA
	 DPRZqBCxU6kQpg+kBpXf5vMlyvRQAOl3fPYiGGxIU0meFfa/kMMwJ8u8O/sfcO3OCzBM3
	 +o997Gy9fbqyNihzT5ZIuIv2i5+sG2jR8VhK1SlQbK2CHOOWUnRreO1WCHokuFTYPedBs
	 deT0anEiAwXrpJ7dWqgAnSiLiUxH547ZxRnRyfs4qOW9H/SrBAQgNIJB5uvIYdNNXlc4D
	 vISGjdgzqh9sTClX9ZFqV13XpOcdteJ2cAR0tB/kg+IqzVNSiNx9ZxL5U7FNji/zUOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794822876;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Ff7oPpQqrqOl1r2yeNmCCGb8saJtTlT4dJFK6TRdHTo=;
	b=IaCWLwzP64BrRAT5dkIILKpG/4MbUU33JUMg0pE+CybWr9wliuxXwn7C7Pmmwapqa3fp
	 eACHfT3bDMlZcYAYm0AMDORxG8dersDD3MHhbgkZZ0ihcBa+XnPLUpHDU4xHfG9j0vHoG
	 l9OvBoXCn9H6NjwcD2yJUnQvImCHaZzAOlNGUDPsN6bggfO+Vd4Hxe6CmiQXlzLcRqTKh
	 MI8rhAlJHGViIrTsHEZXpTEOLonAK4ZypNgaADsKDCrDe8ZEi46UOK9tmLKIl/OsHaHY3
	 CkHKk8TAYmFDjK8rJsymLBmsF8cMOgc2zl5zIJBAfOBGs0GW6IBAWAwNeS3LkVd0v7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HtBdTie7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A1E606A31C
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 09:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HtBdTie7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F7D1F000C4;
	Mon, 16 Nov 2026 09:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794822876;
	bh=Ff7oPpQqrqOl1r2yeNmCCGb8saJtTlT4dJFK6TRdHTo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HtBdTie7NVSaT5Yv4M43N1i12PtdGmK/tc1LPePjwjsRnNPqrzdkrZR4sy2nPVo3r
	 9GavaFRvioh5gVm8K9RawZmOU6iYflXIdezbaonvm0h1KnwOS8/bXpJ+dmKZ/lBOYy
	 7wshGlppKDVdlDEXJ5uqZpst7bRW31p+V/5dVVvAuDTiVJC5/UtDn5kxiWXhfMCI6p
	 4JP7X9HI866GjOexC9bTRDYPH+xcZ6Jw7q/KTZ/hxnNj5AniqPnxq7jQfbgvYniDP5
	 6VzAdkq9IMi3+/6vGLqtHIKXuUHtK+XDkH+n7JgW5enDC5eqWL9E2C5rZJnQk+Aw5K
	 3nRu5f21LZHKA==
Message-ID: <sashiko-outbox-216666@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 6/6] PCI: rockchip-host: Mask the client
 correctable error interrupt
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Thompson" <matt@boondocker.io>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261116-rfc-b4-v3-6-0bf052b68f2a@boondocker.io>
References: <20261116-rfc-b4-v3-0-0bf052b68f2a@boondocker.io>
 <20261116-rfc-b4-v3-6-0bf052b68f2a@boondocker.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 09:54:35 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] PCI: rockchip-host: missing Fixes trailer on bug-fix commit
--

commit f0d8b30ebd346074d58b3aee793327c70a8878bd
Author: Matt Thompson <matt@boondocker.io>

> PCI: rockchip-host: Mask the client correctable error interrupt
>
> On RockPro64 the PCIe client correctable-error bit stayed asserted
> during link bring-up despite acknowledgment. Its level interrupt
> fired at roughly one million interrupts per second on CPU 0 and
> starved RCU.
>
> Mask the controller-local notification, which the driver only uses
> for a debug message. Standard PCIe AER uses root port status and its
> separate interrupt.
>
> Signed-off-by: Matt Thompson <matt@boondocker.io>

[Severity: Low]
This fixes an interrupt storm when unmasking client interrupts in
rockchip_pcie_enable_interrupts(). Should this include:

  Fixes: e77f847df54c ("PCI: rockchip: Add Rockchip PCIe controller support=
")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-rfc-b4-v3-=
0-0bf052b68f2a@boondocker.io?part=3D6
