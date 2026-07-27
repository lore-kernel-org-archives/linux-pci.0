Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385F12D249B
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 14:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785161501; cv=none; b=A5sQPL7aqbaha/MlUt2J/YmGPtHouZqg7BtTq0bka2fHnp63TW+JBaN60YpOWOHaI4EzqRoMLE5YMo55P+zW9cRrN0w7gfaWAieKtVQ9y7cRwumJdYjNQ/jY0KZSCHBy0ocyVeTATRbqpxA2/88CkSZiFXXvNsRaJutMsehRRSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785161501; c=relaxed/simple;
	bh=bURpuSEE7OZbsLc0bXT0LbC+r6+yoseyESUr3+tIEPA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nzgoQjOqACxRkHhH9nvOrSa4W03j0Ikv8+0IRDMFawviLvKwkias32EzYWwrRQtTKLLr779XGi7MQNKqoafk8INdilnUSWwXU4JZsRnnCt0/WbDr073gpVxJ6BrSKs4VCcE728/WUR8zKajAT0v5vpKjuPp4vTXDdBZKUIDSA4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jv4awYso; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jv4awYso"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B01E41F00A3A;
	Mon, 27 Jul 2026 14:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785161499;
	bh=bURpuSEE7OZbsLc0bXT0LbC+r6+yoseyESUr3+tIEPA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Jv4awYsoRKWzvzDoXdBBzBIVr3kLzF7b3m7aH18Q+iHmW1Dgj5rua+KnDdq6PqHom
	 3UwzMKGrChvJwe+Rx3f5E1jwmjL52Kx4R+jty1wxBjKyHLk5r+gms6d7+F2UI4gS6x
	 Famg5R9jnoSyNyQwgnW9hWGX8kfQTmGNCkHE73wmM93KzMbxrvyfE+bKou/ft026LG
	 HX669fus44fOtYqwinNi2DPrHfV5ghIGYcCZ73MH5EeN3xz8s2wv/uPt71mY72lJUg
	 xJC3BNG1J5PNm6KUpSpv7pKh3EOvLgj8SH0upWoNSyXMWV4IeYq+5g7EfwzA3o8/cD
	 yOfBYiCxgKt7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/3] PCI/ASPM: Use
 pcie_capability_clear_and_set_word() for ASPM disable/restore
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260727-aspm-v6-1-2ebb3ee7ef71@oss.qualcomm.com>
References: <20260727-aspm-v6-0-2ebb3ee7ef71@oss.qualcomm.com>
 <20260727-aspm-v6-1-2ebb3ee7ef71@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 14:11:39 +0000
Message-Id: <20260727141139.B01E41F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> pcie_aspm_cap_init() disables ASPM L0s/L1 on both ends of the Link
> before touching L1SS config, then later restores the LNKCTL state
> that was in effect beforehand. Both steps use raw
> pcie_capability_write_word() calls: the disable step computes the
> new value by hand from a snapshot taken earlier in the function, and
> the restore step writes that same snapshot straight back.
>=20
> Switch both steps to pcie_capability_clear_and_set_word(), masked to
> PCI_EXP_LNKCTL_ASPMC, matching the accessor pcie_config_aspm_dev()
> already uses elsewhere in this file for the exact same register. This
> does a live read-modify-write of just the ASPM Control bits instead of
> relying on a stale snapshot for the rest of the word, and is
> consistent with how the rest of the file already touches this
> register. No functional change.
>=20
> Fixes: 7447990137bf ("PCI/ASPM: Disable L1 before disabling L1 PM Substat=
es")
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727-aspm-v6-0-=
2ebb3ee7ef71@oss.qualcomm.com?part=3D1

