Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7F13438B1
	for <linux-pci@vger.kernel.org>; Tue, 23 Jun 2026 09:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782205865; cv=none; b=t7MpfhaTzNLLhvFyBaxOPrFQgTrIf1D55Nov3ft74cCU0CUcEV0kFr12T3BqUH0hShMqQ/C6rQhRd88gJqZog+/Cs+uq9MpZF1TIDqdhxX8Ivdwq6TTS6oNwt3Aj1J9F3svXt0rce7wAcK95mlRnWO8rQZYsWklIfK9xcxUnIdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782205865; c=relaxed/simple;
	bh=c4Nd3zK2O/q+UcEsQ5yFUirF2W3qVqjo57TX40NJvEE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=grXBhl1ATdUssCjYnkX+QU4gkNEW8+B+ts8z/9ufF9EeVir8pMIfZNG+JbpznewQsH0CPBkFD9QMs2z5dnNq5tp6reCDvLGCP42dcGYfN+5wrO7P+NoDvCvLPjh89+W7YI+AbB6FHDoKuEbrBbR+/FK5fA3SQQ5FZktf3SJ2KoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMk5JBN6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMk5JBN6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E011F00A3A;
	Tue, 23 Jun 2026 09:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782205864;
	bh=c4Nd3zK2O/q+UcEsQ5yFUirF2W3qVqjo57TX40NJvEE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NMk5JBN64J04Ml32oa0ewX78jiKHKBnCpq5Pgv+ifQP9cNVnX7FPdI3aqHFDbHCY1
	 7/nYX3h5z3hJHTw8oetMN0rrMa69RCUzwYyAwSzr//5/2dWTvxl9Ije/6NIob4V2QL
	 3bI0lkEJyNXtw3FBojq8rnRx9IwkRUAEAvfxy6lwKf2y4BJWEWZHsWoLNVLc67z3jb
	 yHmskmV0/dvRM32sNnlAqM6ffhrdrWDBnIokIYOwjzuvj68qkVo1qZaBwqjKR/zQRn
	 /mRr7a3v8K9kJ08lsUTw57PWH9qYMabiqwUfbK+IKzycDSTIfc4yLnpm8ntwTE/hme
	 BnBkcAtmJVRrA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/4] Documentation: PCI: Add documentation for DOE
 endpoint support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aksh Garg" <a-garg7@ti.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260623090737.711656-5-a-garg7@ti.com>
References: <20260623090737.711656-1-a-garg7@ti.com>
 <20260623090737.711656-5-a-garg7@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 09:11:03 +0000
Message-Id: <20260623091104.22E011F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Document the architecture and implementation details for the Data Object
> Exchange (DOE) framework for PCIe Endpoint devices.
>=20
> Co-developed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Aksh Garg <a-garg7@ti.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623090737.7116=
56-1-a-garg7@ti.com?part=3D4

