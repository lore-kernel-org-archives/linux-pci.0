Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A751B42981C;
	Tue, 16 Jun 2026 10:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781607335; cv=none; b=Zu3m3Ka7kjaL/WfPgUgdomvm0uG+2YqeWa++DqgdkjNdTpaYnLsarSdX4d+4rEiWFV7Qw4Nv0TyAHn9OXUcWALMn2AuFiaC7uLJnNwAL1yYPFQNid58KkdgbEHtr2Ttqa3VyN/SYjLNgAQUtY3DerLosnTB96DJVWca2NNGZB0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781607335; c=relaxed/simple;
	bh=4Shem+W3Thu+0U62YYv7MMF6HIE/0YWwj7GLTsPRCIE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZaEsf5VnvZUF0atKPYan4WyLp9g1Hmi/gVL7LJMBCJvfDuHQEhYr+gnDQ4tF7P79sQB17wmE8+3iC264w6efptZmrociHxdO+uk97sIzeK79BCLtq9hEEMnoz8g+mbFtoJICbq014PvIUMYMttYvOxyA6rNuR0PQFiE+vAbocX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DzjEhMbC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzjEhMbC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 241301F000E9;
	Tue, 16 Jun 2026 10:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781607334;
	bh=4Shem+W3Thu+0U62YYv7MMF6HIE/0YWwj7GLTsPRCIE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DzjEhMbC2O50NUUi3vMLldN59k5yqYPB1VeqZqBti1YyTZuOLQBLEV+QktDjZcZPh
	 iMwO2vjgkPQsHW5up7QOGaDNqiauJgQBnKz0w0Y086gIUm16MTqLua0SUqXKk16iXy
	 L3KdbYHVEubGBhy4Eotuz+TVnNpSuuURqvrhjIU8k0rfE+Y8uy7arpnZaZfHSEAlMx
	 qwfqMh5g+/WELv0HW5usHSqn7fVPajAH/DGtTklLatSEQC6icygJ3b3m8rYNKr6wz7
	 O0YG/G54az4/XWJw0F2JSYoFcoGctg/Iu3LLixAMK9Ht28jAcNIUcDhxtVqaOhykyG
	 UwjWvVMxcfWeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 02/12] PCI/TPH: Fix tph_enabled concurrent update
 race by bitfield packing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260616104621.41915-3-fengchengwen@huawei.com>
References: <20260616104621.41915-3-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 10:55:33 +0000
Message-Id: <20260616105534.241301F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Split tph_enabled from shared pci_dev bitfield into spare bit of tph_cap's
> u16: tph_cap is immutable post-enumeration (15 bits for offset), remaining
> 1 bit stores tph_enabled. Removes cross-bitfield concurrent write hazards
> highlighted by Sashiko after VFIO TPH exposure. No functional changes.
>=20
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616104621.4191=
5-1-fengchengwen@huawei.com?part=3D2

