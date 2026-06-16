Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7987321B9F6
	for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2026 02:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781578714; cv=none; b=aQXizN2QV2uum23pw4CjsxEbkhdlk+gjOy5o2bh00NK9yDUYm0G5EbcNsJ7lxIqK/7Il97aehAdvsjuHoqSeJMQVU6AT5bx+d1CrcKSnuI5RKIW1OAaDmZfwy85OQwLWe5vJ9TmVsczyOhTKRUHnBfL+Z9cbIDiYaA87PB2KYO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781578714; c=relaxed/simple;
	bh=PNgwt5VDIItDCUh/M+Jgr+P4tXkinMbEbebVZPRudx8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qSy8WGj9GVnyKEBRM9rT2zml4anwx74jgoa+j5DibCwMXKuYBtBx6cylJ785t7tWASugBcpcavLzMQiGeWf0EhS67lKCCzWBfZ6N8LGP61Y7Sew2/b0I/4SvQCgQDnKqBLpbapoOJgrqfnF7spwtkTJFuSnLgRjVfGw9vEM2v+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NiGcBlwi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NiGcBlwi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D0C91F000E9;
	Tue, 16 Jun 2026 02:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781578713;
	bh=PNgwt5VDIItDCUh/M+Jgr+P4tXkinMbEbebVZPRudx8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NiGcBlwieCPv0jxaDFQ6EJUDwZFRqgRv9tz8a4E4pPOU8s40rzI3S+OQ0iKHgvFL/
	 zfpiROac8vjoGVrNw0vhFn5qafYubT5qeII1vRYvcAlMmt+P7vz7xID2uck/eU0Ay6
	 W19TED+GSmFCsLfyatfJRvDBpa6MABw0u75w4HCfr8iFIS9lnLzZTFqFaUCi6lKpbJ
	 qXbAiaN1PIE3f7GdGX1v9d4o4R6/dS6g1y1p58l6kimWZRUkdV+Z0NLx80QjjJbMvb
	 tCd2Od7wt0gdce7Vtt+Eir/EdlOU0Efv8ncs8HLbYLc7t5UdDjLSCt8I1JLBtsPIRj
	 fy0yN8JWm92aQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] power: sequencing: pcie-m2: Sort PCI device IDs in
 ascending order
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Deng" <wei.deng@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260616025632.3697863-1-wei.deng@oss.qualcomm.com>
References: <20260616025632.3697863-1-wei.deng@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 02:58:32 +0000
Message-Id: <20260616025833.0D0C91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Sort the entries in pwrseq_m2_pci_ids[] by device ID in ascending order:
> 0x1103 (WCN6855) before 0x1107 (WCN7850).
>=20
> Fixes: 2abcfdd91e6a ("power: sequencing: pcie-m2: Add PCI ID 0x1103 for W=
CN6855 Bluetooth")
> Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616025632.3697=
863-1-wei.deng@oss.qualcomm.com?part=3D1

