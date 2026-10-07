Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4491633BBD7;
	Wed,  7 Oct 2026 10:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791368407; cv=none; b=t8ZbYISI0C/Q0yKiz/SWJFCR92tu9JVNxl9Eyr8c2fNupkbH/IGN5U7bIU23xxFtjet5dPYYwsjYYZwN56SFCqwisxesO+gKKv5oveuFaMxtjbtwfHXhHEyNRQD6vleyaDcekXgqCP7/ZbJg6UdakP6QKkInLUXqGSi/rrTpzlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791368407; c=relaxed/simple;
	bh=q1QNEwtMMu5UASEeylutS74HPJlVmsPfnQjM6izEUgU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Vpxav4V82GjGipFx3QRFAAwVIh3MaXd17dbL+cShrVmP07UqD2D/5seyviQxdclu8gJ8jaWE9pYm9J751WOabgEdpWvMzSixij0WiOFEB4xuXmZ+1keF3C57fEKrcpuMNSyJLqcAn9W27Zjfo16S2g8IdAo4Qk/mnHGkIPlQ24I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Smh+OEQv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Smh+OEQv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43A211F0089B;
	Wed,  7 Oct 2026 10:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791368398;
	bh=q1QNEwtMMu5UASEeylutS74HPJlVmsPfnQjM6izEUgU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Smh+OEQvZpYIROMYuxPvitWOyAR/U+A/CNknFMnxRqsv7QptEjLZkByXOuRWRHbcD
	 h7dhbR1QaSaiH8CgW+kWmG3KJM/SlZ/tf1uryJko5uIdOa7Git9lzmpswakQ51ib35
	 KiOEuo/+KzSKeeXaHyxLLuXTs8jogwNS0x7SSuP1ryPYhruDYk/+0bqbl3/WYihZt8
	 6K9XixkyOh78wi1tPEjs45C82MygzZ+XzBRnDGT5xQYUYQ1UCexa4sawp0NhTHeZmt
	 ET02uAnawgEKOLmUWke2uYOr91m8eMO3rkGU8tZ3Bo2PnJtQKhA7tfdbCGQ/MhDeXr
	 W8oMCsf/2BXbA==
Message-ID: <sashiko-outbox-162852@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 2/2] dmaengine: dw-edma: correct IP name in
 xilinx_cpm6_dma_data comment
Reply-To: sashiko-reviews@lists.linux.dev
To: "Devendra K Verma" <devverma@amd.com>
Cc: vkoul@kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20261007100336.4009004-3-devverma@amd.com>
References: <20261007100336.4009004-1-devverma@amd.com>
 <20261007100336.4009004-3-devverma@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 10:19:57 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Replace 'MDB' with 'CPM6' in the xilinx_cpm6_dma_data comment to
> fix the IP name typo.
> No functional change.
>=20
> Signed-off-by: Devendra K Verma <devverma@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007100336.4009=
004-2-devverma@amd.com?part=3D2

