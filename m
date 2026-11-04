Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793808994;
	b=lWQ6QChL4Ker5eChAXfGT9JvLrYHofc9B8K1dCLCYihRBZGDJoPkJmTTWAEELdtiihqs
	 c6Wqxc4rHJLDyN9u5fissWNnZBgX6QuX29BZiIWAfdeWjy+2YPnnsoJCANxZDXVBV5Ngn
	 1r43itQEFSJQs0IELsiVcHQReMIoq1zq3DtdeUEWe+OerlcZHZguuf28qRvtnujE2mFwM
	 lReO2/z9iJJzfGr7H0oXyA6sKAwOjTWAua0VCtPCRBE7V7tE6fWM9nZWn5SrG+KAHL4oV
	 KYMF48a/RUPQRuumCh+KK7D1fSpc3bUoFjzTob0MT/OSQRuYJoXi3BbBAnuBGfMABdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793808994;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Gy+HkP/8oHSGDtampn/DNgcb1It3ZT5rm1vIL+SZbW0=;
	b=XZR0OdHP7+9uiJ7SW9LPu6aGKreOjxHBlUVMNQnhHP5+VafLeKGHZKEV2aulNWOJaAlm
	 0gTaAGSOr3mzsdNii1ptQ/rhBl9jlgwfC4RnxRhdjnDnnuTPjnoIVeNwvAhyNUQcpcN4Y
	 4T1bcHdg89cUdS0bpSf106GUw8OYdHPWS40O72AffsIlfyiLjHASQ0nMZ7jB560OFLZHg
	 mNi+6GI9pLh2Keb3gL+/Zmtcg6j9W5/BKr4wh1nRgN/WX4rGXeCaA6DYxZfWEOf13PVOA
	 Se/XI8DPVaFiFHbsqTMNEumWAnrVgORhLEL5QTDaUOa5NyUROqqfRrDueptyr2HJGbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aGbj+izM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DC1606A32C
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 16:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aGbj+izM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 666791F000C1;
	Wed,  4 Nov 2026 16:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793808993;
	bh=Gy+HkP/8oHSGDtampn/DNgcb1It3ZT5rm1vIL+SZbW0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aGbj+izMcSccOI1RBEHU9biclno3n35qTK0rvrtl/vBgmEqz35Q17kHQhL8MbVYkx
	 zMohg8w9hTcF6RIm/+h4xFy55MaT54SWKVdy4mtjxJbjvUcqe+lQ2nER+Nw498MwYr
	 52pTkrok5E3RsWVf7OC8Gs24fQ5iaJ6EmK8oFG79WfhQyeSN6B0E5Vsyl8U6Kps6G1
	 hEaxj8VLiOEVP6gEt8Qay7aSPCyI/WqZRnvgqFeC8D8zaRkeRwznpOXQUkmXrAyxI3
	 0meog+BgVfJKEkkb/rAxELwvdZ05KyDlWwZEgTOGuC9c/uWJsSVgh6teXZU0m9bt/t
	 iv8Tjj5R5hTLg==
Message-ID: <sashiko-outbox-197592@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/7] dmaengine: dw-edma: Add a channel transfer size
 operation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261104161227.1742005-2-den@valinux.co.jp>
References: <20261104161227.1742005-1-den@valinux.co.jp>
 <20261104161227.1742005-2-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 16:16:33 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Expose the channel transfer size through a core operation for eDMA and
> HDMA. LL progress handling will use it to check for a stopped channel
> with no payload left to transfer.
>=20
> PCI Express DM Controller Databook 6.10a-lca06, section 7.3.4,
> "Detecting the End of the HDMA Transfer", documents this polling method:
>=20
>   STATUS field of the HDMA Write/Read Channel Status register
>   (HDMA_STATUS_OFF_[WR|RD]CH_i) is Stopped, and the HDMA Transfer Size
>   register is 0x0.
>=20
> The same condition applies to eDMA as well.
>=20
> No functional change on its own.
>=20
> Cc: stable@vger.kernel.org
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104161227.1742=
005-1-den@valinux.co.jp?part=3D1

