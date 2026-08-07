Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EC234751B;
	Fri,  7 Aug 2026 19:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786132287; cv=none; b=Z6uvMKWaJY+SThPKi4z/4mBUSY76C0V5RtncGK9LR5G8M2Jv8LHkPXzT/4rpm5zyNQ2wMN+A6ERTCdf8yUuDcXjmAXwlEuMk86cZ6/8BtLTHNLvV7mDRgLCp4iwRQSpP6cVgHIAmwu6vCCXC7mDqY9SUQNrV44i9L7IB5V3wJaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786132287; c=relaxed/simple;
	bh=Uc59e4uBVwCY07rYJ6TXko4K0Tvri0HNMWqhN7KKqGw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XygfmsC3L4ITXv8aONut02kTPc9HIjEEX/fh7vCUeNruEqiidUAVG99cUXZqX1R+qR5atYGOSIlOl1qwU6lmldsg7IWCwYvlYQFTZPapeayCCGQ8i8xaJWXE+NvgLkM1D7aD3HEvCrhCZMJOQxqA8A78EVMePoPoiDELqIlIcbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETiR3uLD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETiR3uLD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 362651F000E9;
	Fri,  7 Aug 2026 19:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786132286;
	bh=Uc59e4uBVwCY07rYJ6TXko4K0Tvri0HNMWqhN7KKqGw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ETiR3uLD1uRVEx3JR1keV84jngGbzRGikZuop0cFgKzeQmf6sTYLDo7SUc+ajCUlK
	 kKgLIjR4pq99CHHi0vrg8ghR8/30jziRElgCV4/CDAVKAVgelg5/RtTRA8paifobHS
	 aixbP3PdOlkEEMNXONXAwN+uXv926da7zQAv5epUS/gYT1kP18ZtH5RU8idnWzbNea
	 AidTOCzmrmB+Qg7JvFlAOTM8vRYk34tbPoUpPq4Pl93gady5qYufxfaE9J4/PqTj97
	 AH4ha8kaLxosQwF+tvpBb60fhR8h0Y189CaGWk6NKGogVUmNWKnGuDR0y5sIFkKaf8
	 csNaiByo4vbPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] PCI: of: make a flags argument optional
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Elder" <elder@riscstar.com>
Cc: robh@kernel.org, linux-pci@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260807194100.455599-4-elder@riscstar.com>
References: <20260807194100.455599-1-elder@riscstar.com>
 <20260807194100.455599-4-elder@riscstar.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 19:51:25 +0000
Message-Id: <20260807195126.362651F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The address of a u32 object is passed to of_pci_get_addr_flags() so
> it can be filled with the computed flags value.
>=20
> Allow a null pointer to be passed, so that the validity of the
> resource's flags can be checked without filling in the flags value.
>=20
> Signed-off-by: Alex Elder <elder@riscstar.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807194100.4555=
99-1-elder@riscstar.com?part=3D3

