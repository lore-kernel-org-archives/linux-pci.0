Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794285721;
	b=Bcbj2gVuUq2lSnlT9acjGZN9ULsAWtF0uJ7CaPwdLlmgTVnkJr0iV0zxGbQxXy03xoCp
	 W9LZH1UDyXHLF84KSn+XovCaLrwYsVBdFl0q3UK8ZZYPDBOgD8RbUAiDfTWulrF5EnA/H
	 MdpHy+2ss0YW80xWsnlNJ9adpWbnMXbjl2rhL+EhqlBKesOye2TvvN6P9dvgDpYE5e0hQ
	 2lEu5mx9s8VJDttZyiwgy0G3EaLKJ8om80mwbEhb7YsPoIR6zFK28N+WZ7MbiNcwFsAju
	 TgRLZiJtAJj4fLSeoh7Vq8dVZZPYWnGu3tdrWAhvRXR0s+P15WOLkZovAOiyBbWuP3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794285721;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0AmIbMuSisAdz7Uxnf7qNyfu6u6Pp7KwLHJ8kdrLnZM=;
	b=eZOZH43wt/dhkgGOWSUssDWwZBX57k8qclXDMgmP0EwdlLVRKxPhrf0YJQZb6RcG1B88
	 JQxsWBnOrIQDbG6AOWhl+eMcQ5hD85vWLLTkmx46eQT9CiFpKM1Pp4CUBTOL28ZpvocXa
	 TIZobqVoO9AnWNfbXbZhgE7CpW8RXnQknRldA+8wuJk1ea/+jP6texPzEUGX5hVBRjSfR
	 zlzV/Z3axgtFGX3mjIJEj00JtpSMVKK2RIccPD8MvXFe0T5bDOWyZpHCPl1ffQd97MNbc
	 mFjBbXDSyPtxpd677Q0rWEj1YKmUpaxOuKrJN12POQeFXArxoPd2QoKPmvp54TVS2Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lNgFl6d1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F341B606A33B
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 04:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lNgFl6d1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C421F008A4;
	Tue, 10 Nov 2026 04:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794285720;
	bh=0AmIbMuSisAdz7Uxnf7qNyfu6u6Pp7KwLHJ8kdrLnZM=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=lNgFl6d1T2iVvJQ3824eHDCDIcFvKjtURLpVXUVENqTq0QcS6+SUt/YpDJrnWaOyH
	 BpyZdLsHe78LJ1a7UbglaiiSBHejFFPEoBIc7qOia4ZwCStdzc9kQP5Qf09jgx68tD
	 N02P8H6xOz/OFxkVNNEQMXwzOUXo9r7oUTuemxz69V92BrZgnn8fDTLrhOBZwSquCG
	 XE3PG5hRhB9rGbYDC0ow+9lu/CI8DGe4PcBfzpuo67tMNY/3UQ/Z7RFqf+EUNaRWxt
	 jhT1eY36zpUXum9qAieFCqFaE8RY7pgWYRqJh/2VJ/NZqkpIRiPFRN0yacUHy8SQH5
	 vkGtL5TKreClA==
Message-ID: <sashiko-outbox-206230@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 18/25] lib: rspdm: Support SPDM get_digests
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com, linux-pci@vger.kernel.org
In-Reply-To: <20261110041832.1730924-19-alistair.francis@wdc.com>
References: <20261110041832.1730924-1-alistair.francis@wdc.com>
 <20261110041832.1730924-19-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 04:42:00 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Alistair Francis <alistair.francis@wdc.com>
>=20
> Support the GET_DIGESTS SPDM command.
>=20
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110041832.1730=
924-1-alistair.francis@wdc.com?part=3D18

