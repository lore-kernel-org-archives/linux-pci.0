Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F5345D5F3
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 06:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792392898; cv=none; b=MLBZC97rJWATuIIwvjyFVvG6Vxmmgn0HDnvzLcHEVsNaDpsM99M/NbGfDH50bsc/9x+Trg90fR8aF1q3UPWhQjRleZqYYbCytzOPfNWtE7fVSusZ8dtvgeMQHW82i48RX3PLNgHl7FRKEcogNcksX6e7H/voAZwTeFU3rFQqyho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792392898; c=relaxed/simple;
	bh=bimLOHIfCo0i9w75zCHBGqtQVV4gSoACOMJ3PGtFAPg=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=JuCu98ySFipp1fH9mfE1H5y8fvv0SO5TLKnZwBBwsXlE78sSuSos+zlxivNS2BnVKtTbdy4TpRghH3kubU9nEzyiwdFCFWPIhJMclFF153xGWUMtwJlZ1tUNsdrOqw52Ad08ASBKsR4jBD5ezxOpkzicW0R5yV+8opegmB3IKzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9qr87UU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9qr87UU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F211F000C4;
	Mon, 19 Oct 2026 06:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792392896;
	bh=bimLOHIfCo0i9w75zCHBGqtQVV4gSoACOMJ3PGtFAPg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d9qr87UUKUmQmivt8Mi7dgNfit2kOFyUJfGXusw/OzQ0AZ2peV61ROjUbIBj9XrZL
	 iR2Uae5092yb0RazgH4bUX9PfmD0X5Qcd1uFPaYIRSVX9rSCzXYxW+c4rljoOxJu42
	 avOt9J+ROSPF9M7LEPD0NybBQQe0RDA3lT7IzNrTa5X3PmAl7S3OK/AhAJddPm7tN/
	 V5kPM150LM3Uh6CmJJ6yqFaBEwBnUvfXO3h12sR316SRkBC8/4c+EtNyuuU1OQ84tG
	 JYUJ7iVAcCfybsEyq9Zq6ljb+OHMG+PRGFRqJO018ee1Od+8XqjnMk+Ytw43PHqxYi
	 8maKR7ezaYqHA==
Message-ID: <sashiko-outbox-176711@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 03/14] PCI: rzg3s-host: Don't mix goto-based
 unwinding and cleanup helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261019065025.2146539-4-claudiu.beznea@kernel.org>
References: <20261019065025.2146539-1-claudiu.beznea@kernel.org>
 <20261019065025.2146539-4-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 06:54:56 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> rzg3s_pcie_probe() releases the sysc_np OF node through the
> __free(device_node) annotation, while the rest of the function uses
> goto-based unwinding. According to cleanup.h, the two styles should
> not be mixed within a function, as this makes the ownership semantics
> hard to follow. Drop the annotation and call of_node_put() explicitly
> on the exit paths instead.
>=20
> Fixes: 7ef502fb35b2 ("PCI: Add Renesas RZ/G3S host controller driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019065025.2146=
539-1-claudiu.beznea@kernel.org?part=3D3

