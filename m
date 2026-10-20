Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792509406;
	b=V6g+AkerB0NU+4fhfH7bzay5E/tO4RASE0Cfr73Ppww5od2aBO6qH9zGCJ0tY1e3tn9+
	 41QJWfQCE3E8lmHWAv5wwe6Xgrcc2JJUaPTIqgJYUIctfpI71ykzWsN0yk8nlJR/VRxbe
	 6Jq6X8IvaXCZGoG3UBFN0YyDyU+m0jlulQtE+UP3oabfPAp8l7NMv+RLqQI3LgHJke0NO
	 FrC930J6nCpI47L3w8CPfsvyJL0DGcOwjy9R5tdy3gQxXhEn6HYSSmnSVSFYJWmy89w9E
	 8P9RoqrIq7BX94Jq3/4NSQWuYse7Df9bA01Hfqe3DRyNc/TzrNRBdp77Snp08rQDnZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792509406;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uh7XaHdHWi03OJCBDDcGtQ8EdbuvqWDDoMUQLrWc6VQ=;
	b=YAeHrpuYvUCa/ne0Hn7TaDRvFF4CqExSjXtXHX0tv+huGfnaDk3tiR6bg8+dBXd/02Jx
	 yCHBkuoRIQgSfaLuAn5Bf8/lAtP6Nrke/wjBL2jzIt3Zv4Yy6fFMEmTYnGaWmjPsv4WtO
	 oOeEHQghuZ8KJImZYsdQKbMMmUjMRyh9hBadmrXBoQ51cK3GL+z5qevvb18rYynu4YSci
	 3NDxIcMq5fUf3+jsOG9FI7uJS+MKsBmr+Ho1eu8Rp49aEah9iUV9HjAoyt0qjKiufWbpu
	 dXNcXbqTF8xfJ+JG4d/mNO/jEKpCSgMFkhJ2UP5LXnyawRmeMwWo5xIzH8P/jWdUH4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yzsm5ljW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE8B606A31C;
	Tue, 20 Oct 2026 15:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yzsm5ljW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1117D1F000C5;
	Tue, 20 Oct 2026 15:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792509405;
	bh=uh7XaHdHWi03OJCBDDcGtQ8EdbuvqWDDoMUQLrWc6VQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Yzsm5ljWpkrGr+B/08AQ15cSgSn2XJE2Tpb+OimrnPq8sGkjOjBjHLHIGMjwgREHb
	 p5VBrR2oJsJ0qje+dFEGacD1OcXmNdIqZu5oxLrOo3HKurDjeU2lj78GpQ1SWee6G9
	 1NzMT5aQZtbyVjpuOWPjJA0ugwajZPwlmymJ0OHzXthY9ePYI4Jzmj85ryzppoMp+4
	 C/xG97zD0DkXxA0xOd7CpYdu8xuz6u+drb2s7ejPVycl/bNo3ADtIDX9VWPMKO/7QI
	 u0/yIq1qJyIGZo0fTGCda6eRTQ2wMsaezhiyp/9kkZh7sFTI6f05ddorGIfbjOThJ2
	 ATl7vTWmFOylA==
Message-ID: <sashiko-outbox-179233@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] PCI/P2PDMA: Allow P2PDMA on Intel Xeon server CPUs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pavel Popov" <pavel.e.popov@intel.com>
Cc: virtualization@lists.linux.dev, linux-pci@vger.kernel.org, "Michael S.
 Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261020151305.65218-1-pavel.e.popov@intel.com>
References: <20261020151305.65218-1-pavel.e.popov@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 15:16:15 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Peer-to-Peer DMA (P2PDMA) between two devices requires either a shared
> upstream bridge or a host bridge matching pci_p2pdma_whitelist[]. In
> VMware guests, passthrough devices appear directly on virtual root
> buses without host bridge devices. In Hyper-V guests, each passthrough
> device appears in a PCI domain of its own without a host bridge
> device. Consequently, P2PDMA checks evaluate endpoint Device IDs
> against the host bridge whitelist, causing P2PDMA requests to fail
> regardless of host support.
>=20
> This affects discrete devices such as GPUs, NICs and NVMe drives.
>=20
> Add an explicit list of the Intel Xeon server generations from
> Skylake-SP to Diamond Rapids to cpu_supports_p2pdma(). These are the
> CPUs whose host bridges are in pci_p2pdma_whitelist[] without
> restrictions. AMD Zen and newer are already covered by
> cpu_supports_p2pdma(), so only Intel entries are needed.
>=20
> Tested with the Intel Level Zero P2P benchmark (ze_peer) on Arc Pro B60
> cards in a Linux guest on VMware ESXi 9.0 (Emerald Rapids host).
>=20
> Signed-off-by: Pavel Popov <pavel.e.popov@intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020151305.6521=
8-1-pavel.e.popov@intel.com?part=3D1

