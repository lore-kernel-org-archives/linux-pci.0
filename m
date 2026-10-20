Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792521418;
	b=zZeEw2BvlfSiF1qE+7svufozb6duL8EwyqrKVcjh0OJ5jfIWigYA6MttGgOQTQ/Bt7Y3
	 BWxr1FINVbMNVuQspbmyZdEyU3/Zz8LbMQ8lVo3DCPzMXrK3cqNjypr1taxj5rBHcAMj2
	 f0UYYLVKWeIhluGGJRti5woK+5BBUjNaefLkMALwQRIE/sIdevvNMOSPYn9c3q8/PXARD
	 KXI2oAQbGdSDTJ7pAm0qGAVEJRJn6EQpSCdvNJRaT5z/RgTsiSAIeDALgCWpqxOvuu5Hy
	 jzkNMsjvl/XcAtomX1GLXBnNEUM13SJFM25qn5jk+KcL7ok6R4bidDi+OSuYlnGPwAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792521418;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=K1Q4Aq9iCD15hk/qBj0oqzIMTgoJkVnmRluHnpiwfXI=;
	b=AllUdSqPR7cNLjUhFSxUdSXM9syjOQdUJWaGc813HLeW4zTFbtzYzhGIE61bN8pqyXUk
	 drrkezfRVhcJRlqGKKcJVpve665GnFcN3BTM7p4oB2x2byUS0LZdQgw5H8dv5iumzk+2E
	 vcNODir5N0oFbsgTSX8rkSRi3ktf686H6PQ1I0OoY8gf32pjzU46l/Cxi6aVqqJ3JCtQW
	 o9nei2BfjweXv9es0T8ioiWpY/26fc07zKW70AT06Csegl+UcO6czte1a4tmaE+ZOOgsL
	 /IMrs1hYV85Blhn/DzgvYP3tMD2LiT4vJajHy/A//2c4zRTo4HoHBONX3ol/yb7rsMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ldpciNF1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50329606A31A
	for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 18:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ldpciNF1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71501F000C9;
	Tue, 20 Oct 2026 18:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792521418;
	bh=K1Q4Aq9iCD15hk/qBj0oqzIMTgoJkVnmRluHnpiwfXI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ldpciNF1Bw0cJEMS+1Fcja/ENJzjAkzE7bBRIWTXWtoLKDf2nnxpTk259QKqZns2L
	 00gfPmil66KIfF9FL6BQsEfsoJgZH2YdC48ei7GjRs3orAnD5lEqKf/+fHxdnHPr5/
	 KUmeZYuJ4p64+SC6fcpgeuw7g8G9najk41oyK1OXMUYU3MqjYc5/Ts/kwlU20+ioQK
	 43VV1aQcO4vqlCi16FCuoNcpb4Y9YYKj6KB62fSJtqh15GnOwA03/3TYrU1lAzJb1A
	 WsJ/m7fNpZ2+/iFUVyz6tR5UFDy7p22VpZSjl99UKas0eE+FpAd2t+am2Sql97nI/P
	 w5gRXz2suzCbg==
Message-ID: <sashiko-outbox-179490@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/6] PCI/portdrv: Bind DPC service based on
 host_bridge->native_dpc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuppuswamy Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261020181924.3003553-7-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20261020181924.3003553-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20261020181924.3003553-7-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 18:36:57 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> get_port_device_capability() binds the DPC service if the port has a DPC
> capability and either "pcie_ports=3Ddpc-native" was given or the OS
> controls AER.  This repeats decisions that are already made elsewhere.
> It also ignores host_bridge->native_dpc, which is meant to say whether
> the OS owns DPC.
>=20
> Make host_bridge->native_dpc the single decider:
>=20
>   - In acpi_pci_root_create(), assume DPC control whenever _OSC grants
>     AER control.  PCI Firmware r3.3, sec 4.5.2.4, requires platforms to
>     retain AER if they retain DPC.  Put the other way, firmware that
>     grants AER does not keep DPC.  PCIe r7.0 sec 6.2.11 recommends that
>     the OS link control of DPC to control of AER.  Commit 97ca178c899d
>     ("PCI/DPC: Allow DPC on all Downstream Ports when OS controls AER")
>     relied on this link.  Keeping it means DPC still works with firmware
> [ ... ]
> this.  The OS now uses DPC there because firmware granted it.  Since
> "PCI/DPC: Reinstate support for AER-incapable ports", dpc_probe() no
> longer requires AER control.
>=20
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@lin=
ux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020181924.3003=
553-1-sathyanarayanan.kuppuswamy@linux.intel.com?part=3D6

