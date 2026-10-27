Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793104453;
	b=iIQTwaB3kI6dv3eJFg+claU+l3jMIBg2lUJW+xdEXyO/qCgFfKSzmvHuFkDzDWt8kyba
	 meX147Opb245Tvi4j0WRRcuesY3jJolJ0LsrX2hr39LvQHc7jzubAVh+Ti64IiBb3t0M/
	 ebJiosoo2m6SW1ITuV1PLlltymMuMuI7w0qyIQaSrkh18umBH+RB6xqPlNYZxS0Bjre8J
	 2xTBbKCRqSHXDA5zPMwS8jK+mO6DfvxbiOKbumjoluYLs9nucKMOZYqfCpfEVEYs7qdsC
	 V+ijjJ0+pHLKyOb98BWoiYXg3g5i5NJp9CzfLaziB5KmdqKC09rzA4BTQ9WB0V4QZyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793104453;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YLhngKM+PJuyCYagda4g1OjNaEbBjpafXL8ZRgC0cqU=;
	b=sFBVSWPHFuUUn0Y31ZquvNF9HuNXH/aeUvXRa5ryHeIcixPsQPZvn7ies+4lvvMQKVvX
	 W6VrqZF2n/gdg0yh4S62VYsIR+PaRAyBg+d1KgIRQqg3lxnDpf0eXCXe8uXIun7AWtEW6
	 ti0LTpV1LQLc1A6T/qEg17JPxMZmXFOr6x5tGMeOBrs/MW+ad5I9F1SrpFupi/EpPhb+l
	 v3pOoP5C4+TYMZtUb3jNSVGsLLbkpRNrWjhWcnDBKHqXpHbtZJV2VvLJ6ipob5qXLWHC1
	 9b2XrlU+9it6axT8w3zvPriGn1MXhJvjKeuDxLiDTHXtvzbNaMAGjS3LwB9fgO6vvtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C392606A31B
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 12:34:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E0191F01828;
	Tue, 27 Oct 2026 12:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793104447;
	bh=YLhngKM+PJuyCYagda4g1OjNaEbBjpafXL8ZRgC0cqU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FmvBFEFV2lyH5uLX3PliV0IQg3+MKj+4xrf/HmmyohraeGJT0SmagsIi4pBzZFjMG
	 B0wcbg2HWK/zraPSi10Ha5Ohvbsb6IWZbomc0efz/YREe5Xj3mNF0idE5QiNXVcsGG
	 JvhrFyZrK/kzoi08SROBR76/ZXBKRAGIvhan43qbhJTOlVhTeFAJfREpjM2fOz5qFl
	 NQDXR/PEkN5YN/9+pcQm4cZdVXSws7Pv7IgKVSZl0gJVAyyYFJ2c+UvAVrsxADQolM
	 DiBdE9xX1mztg3mu9cCg+6EAvNan43+jV9ppe392YkEhdo32ySFuMd/hwoxDdjIy//
	 NGkHFTPdllO7A==
Message-ID: <sashiko-outbox-186564@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 15/16] PCI: dwc: tegra194: Use cached PCIe capability
 offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261027122827.2725643-16-18255117159@163.com>
References: <20261027122827.2725643-1-18255117159@163.com>
 <20261027122827.2725643-16-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 12:34:06 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Replace the two dw_pcie_find_capability(&pcie->pci, PCI_CAP_ID_EXP)
> calls in tegra_pcie_dw_host_init() and pex_ep_event_pex_rst_deassert()
> with dw_pcie_get_pcie_cap() so that the driver-private pcie_cap_base is
> filled from the same cached value.
>=20
> tegra_pcie_dw_host_init() is called from .start_link, i.e. after the
> controller has been initialized, and the PERST# deassert handler runs
> after the endpoint has been brought out of reset with its clocks and
> power enabled. The helper therefore performs its single DBI read at the
> same point as the open coded search, and the private copy keeps working
> unchanged.
>=20
> Signed-off-by: Hans Zhang <18255117159@163.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027122827.2725=
643-1-18255117159@163.com?part=3D15

