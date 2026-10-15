Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D220E5226AA
	for <linux-pci@vger.kernel.org>; Thu, 15 Oct 2026 12:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068439; cv=none; b=DtPUES5k/aj2Q9uX9HVDEXJjJS/jQjweFDkP+ZWEIevSb1ObO5TCN6VS1x/dIOO06VD6UlNTGX5ZHQyz4C1xXSNZ6Q+TfIG6yl3QZKNHGoak8ZR5DHKTP5eqqPa41LcQpPu/vTyC/whrsP8zO8kxtpjbQrqiMEIJd4hGYZsSffI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068439; c=relaxed/simple;
	bh=GihJuuzfs9CWo5T00mkS7UVfvXangNKwl6Ju+JR44vc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=MFPairpEEyhYIszqsNv+YxGW5p4+ugNm5ral9jnAclNBmPFJ5giVMivkDiMF7yZVAYF2KvEsBqxt7n12ijCYR6uZgAXRoG8MX9lXaglFKfLUn3WEsp5+jnCniV/MUAbeIc6GA2eT+rNVR9Ql5u72dUWKAHJvu2/d8XzRRf37MNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVnCLKRf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVnCLKRf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE0E1F000C4;
	Thu, 15 Oct 2026 12:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792068438;
	bh=GihJuuzfs9CWo5T00mkS7UVfvXangNKwl6Ju+JR44vc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OVnCLKRfhvxuFeUj+dKNW27d43TlmSfPqd64709+UYnwDAsj7alao5RAEkI+EoaS5
	 VT2NnKoSbeJpD3VXZO7nE21xyAIk76Pnx4LM4yeQNbP0GA8GddYBiznuPHeApGFws7
	 0kFKWSbwN2s1WLikBpCx6cpr2fg9oL19pW0SJvbKEMJ3ZpErB7UDsCx4f63oItG5+B
	 0jvST9Z3MACmgBLtxICNz6CnTGpyJOXWnBUf1bLdf/tYzRibODK1kS5DH3fgmYwa0S
	 5XIdxp7jziAoGJ0FGpk30PoO8gGGdjxL6/Yz9FPqTnSIWsH2YYbr4DrtV19deX5Y0S
	 ao/7zrg9xiKPA==
Message-ID: <sashiko-outbox-172862@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/7] rust: io: register: add `#[ro]` and `#[wo]`
 attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Almeida" <daniel.almeida@collabora.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261015-io-access-modes-v1-6-93611b84b5e3@collabora.com>
References: <20261015-io-access-modes-v1-0-93611b84b5e3@collabora.com>
 <20261015-io-access-modes-v1-6-93611b84b5e3@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 12:47:18 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> `register!` gives every register a location with the `ReadWrite` access
> mode, so any register can be read, written and updated, including the
> ones the hardware defines as read-only or write-only.
>=20
> Add the `#[ro]` and `#[wo]` attributes, which make the macro use the
> `ReadOnly` or `WriteOnly` mode instead: in the register's `OffsetLoc`
> for fixed registers, and as `RegisterArray::Access` for arrays. Reading
> a write-only register, or writing or updating a read-only one, then does
> not compile. An alias does not inherit the mode of the register it
> aliases. Add an example to the `register!` documentation.
>=20
> The tyr driver uses the attributes in a following patch.
>=20
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-io-access-=
modes-v1-0-93611b84b5e3@collabora.com?part=3D6

