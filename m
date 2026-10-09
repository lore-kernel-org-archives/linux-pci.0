Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D2E1C84DC;
	Fri,  9 Oct 2026 05:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791522205; cv=none; b=DmEHKYOpxsOnTThhMefn7Jbm5ftaHVnHeiS5hwH0nRF2J/DWdv9DArvuxezKGKiZf1gYQt7RQqcjWvUTjw/MRiA/WrBmWC++tgTu/7jZLz83s7Zh01kkWBV5UATRr1TSGfRBucrxEjvnGMpDpPwx1A/sknE2+yzE7PTLpkF4iTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791522205; c=relaxed/simple;
	bh=N7jGmzWNicgquS70Odu1ng8pPs2eUPAzmHI1qdFo5jU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=q6heSYhes8BrTyGnH8IMUAxvVgNZzUiPLzlLRU+YnsnkJBF9zHaoalO6l1m4LHWhg6//T3mQluJg/vlgtsEel2aJEs3Kg/nt+nRlgHCDVVEww110li641V5Ij0fSZ7DYbuFv0NGTvW4HGKCt6GStOR09EshbnKn44np5o5PibXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gEN9I7Cw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEN9I7Cw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78241F000FF;
	Fri,  9 Oct 2026 05:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791522204;
	bh=N7jGmzWNicgquS70Odu1ng8pPs2eUPAzmHI1qdFo5jU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gEN9I7CwhKdku1+DYY565egKv4ZQ5v0xD0W0QobiQK4wuqCb3vXojFU6pESD+wLet
	 S8zbvERvjPVjVCJ1ROeiz+vtRn6+BWc+VptO1nmq5KytOAReHb96c1FoDJvEW3Bu0X
	 FujKS5MTpqQfyaNFz/2w62ClVzU4Qe00Iab9I8D9Wui5E+FgCFHbUwKokrWyMcjM0x
	 1KHbr5yAw/e6T2Ii3gteJEonzWWpN7LkcjiPkJsOLLKYHSFE8YMUPxy2NP4fpgbq8m
	 HJPB84El5bZPhIRtRnU2fnQNZTNA7kC2f42vWd3IsVzv8Tg2Vaj/YD4x8lv/ByjG/+
	 um56APsqKPD1Q==
Message-ID: <sashiko-outbox-164866@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/7] PCI: endpoint: Add DMA auxiliary resource
 metadata
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, ntb@lists.linux.dev
In-Reply-To: <20261009045949.1109871-2-den@valinux.co.jp>
References: <20261009045949.1109871-1-den@valinux.co.jp>
 <20261009045949.1109871-2-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 05:03:23 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Endpoint functions that export controller-local DMA channels need the
> controller register and descriptor-memory layout.
>=20
> Add DMA control and descriptor-memory resource types. The control resource
> carries the register layout and channel counts. Each descriptor region is
> associated with the static channel ID assigned by the local DMA driver.
>=20
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009045949.1109=
871-1-den@valinux.co.jp?part=3D1

