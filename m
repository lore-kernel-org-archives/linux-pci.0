Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794812557;
	b=0hi9L19afP6F7joI5RXuEM6FJCo50n/1BLFX3RkGRBbDuUK/elsMr98cPX7tor4kulCg
	 5T9d+fNDVxA/mVB459Va1tty+wgRdgTiB/QVljsKfs69k7MhiZiliAaaWPl3MQO+fd+u9
	 OJB+F5Ig2Fk8M8IyEZvmqlkvMGhZKeReVk/I85ff46GzFuFOCsh5a7d5YIW92TQbGGXzm
	 CWZU2N3F1OPrMk1xDlI2Ao0M0bwTMqvy8NkHS9eaqsDYtBKJNaRwrQvzFS5+Zontsc0L/
	 +SOC0vbbDtUvpPOkkABGqVFwDFfXb1nI8btls1boaQtfwo6oZO+xLxeQD4KslTLv2dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794812557;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eY+s9ZRmv60J/swUUUkebV2qhDVC5wILdaT/rmDobNk=;
	b=A1Umtdb4RsDvJBvxV25jKorz+iQqppFRqmTluK6DbMgJRSpgH1TG5tzI3nofYtjCPaQu
	 bBzhnj4Eav49Q/l/7vHKxG8lkcryQkmv5GjXOVK+lL3tXOMplKq8RgrgD9ClevA3xhUib
	 TYfVqi0L6AEZyS+fLPVUZoIBWMl6dEDDUxWIBfft7a5YHCrYh2R3hKCtg0ePZiU/3ob0v
	 4347/IKm/T5WeRpIfgyn/hevVr/ETmfMOYAM2GFU3wg8nyiDNtTX/LreSck81Kkxm2dra
	 v99VrjedZNLyif90rqNK/Fiwv8CEBxI4OiA/mMbjSN0DyE6eFOFvrBTMSTmP1L+gTAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="U0dI/d6w";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8356606A329
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 07:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U0dI/d6w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C1C1F000C5;
	Mon, 16 Nov 2026 07:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794812557;
	bh=eY+s9ZRmv60J/swUUUkebV2qhDVC5wILdaT/rmDobNk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U0dI/d6wUWDYJ0yuapl9SMmmUTZ4HZpvj+IZvhgdsvZNFX0pgcFSHPKyRcL1OMogm
	 Lv55QhGKe5hkFfx2a2m/MtHBKeC5fFJ10SCRl4ANek+C6mj33rdIMiTSIAgMjTHZSq
	 tAhhs//3ndcbmTsbMEBb8iRkFj7Nz08Zh7tRlmEPNO9CH5wUqAz1QfIA1/o9DQa8y9
	 UUJ9Y11xb94+tWz+jTAsg/8gD7z/oydBCTEVjbgjk6LG/QcgIpKVit0UCSrKoTGlD/
	 fKtLZ3oJnm38d9NryZP40r+mmoCyx04goU3dP99Co6u2TglU0QPH0t4TjXwGN0wC2H
	 olw2FJAvcfJsg==
Message-ID: <sashiko-outbox-216363@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] PCI/MSI: Skip MSI/MSI-X restoration when config
 space is inaccessible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Cheng" <icheng@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261116065229.38194-2-icheng@nvidia.com>
References: <20261116065229.38194-1-icheng@nvidia.com>
 <20261116065229.38194-2-icheng@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 07:02:36 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> PCI state restoration runs even when a reset fails. If the device's
> config space remains inaccessible, MSI-X restoration still writes the
> MSI-X table. The table lives in device memory space, and these MMIO
> accesses can trigger additional errors, including DPC.
>=20
> MSI is programmed entirely through config space, so it doesn't issue
> such MMIO accesses. Restoring it is still pointless when config space is
> inaccessible: reads return all ones and the restore path writes back
> values derived from them.
>=20
> Check whether config space of pci device is accessible or not at the
> start of both MSI and MSI-X path, after msi_enabled/msix_enabled test
> and before any config access, and skip the restoration if the device is
> inaccessible.
> Make the helper non-static and declare it in pci.h so the MSI code can
> use it, too.
>=20
> Signed-off-by: Richard Cheng <icheng@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116065229.3819=
4-1-icheng@nvidia.com?part=3D1

