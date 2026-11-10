Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323420;
	b=R2/aNZnySekxejhZYGdqkdyr0kpwx76r2ao8ts2fubZp8kSWRlN56gwW8iS65Quu1a8k
	 AmY0Xu3F72f1xMaODe5TSLui4HEhpujPaQfU2nNhIhd48fKDfgDXxvyI87egHhJ9QHc7P
	 X04zsBnByIbYDTyrZ9DvofReO+9iOj92V3ub1+mcw+kfta6Ld4pNdwCU06FMsXT4f2eRk
	 OtB11RU1P8EaMwwb4U22F+ttg3O/eurYL31USig2wtaDy+VYdlUWsuPGFyIYXCo4CYC1W
	 dv918fn+tGqM7LSmjsF1AGHucZtZO8H6hjpVHLBzz4knoQtohH6bepueNgLf5CmE8cA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323420;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=taz6BwAWKKMv9ZUckVUjYzboBlzZDozVZGV/yZriAoo=;
	b=iqDVOn5pw/oikwtYWeTkc/u6kdeGs/0Unq1lRjs4sNE1Ag0/jhIUJZuT9pzXm+tCl+9M
	 Z+ac4exf+GP+KK16yg+KO5KBHADofJM5k5rcL+W9b2zUkCLhe9J9wPQZUs8W5nXeUSKnK
	 f0tAJGmpfbwAtp3CKPInm3gkCIA8VU73l38F5pb17VOIHv+fclaDgkzf+kWjjN/N6XI2E
	 pE2dClHm3MBi9W9ofmZn3nPaeDetVfdaptXgsVCQA1uX+jHcyhfu/sou+xw5E5KEJhr+4
	 ZZkAU0BsA1cj6luAjpm6GLLh9sOgHd4nABD7kVcsTOxa68d5coxHtSeIcE4picXvKyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xz71NOXU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC96C606A320
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 15:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xz71NOXU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65EB21F008A2;
	Tue, 10 Nov 2026 15:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794323419;
	bh=taz6BwAWKKMv9ZUckVUjYzboBlzZDozVZGV/yZriAoo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xz71NOXUHYoUpqwf/0aN29iN8mZAW0sN6Sw0mn4ucUJ6yMmhpn0K53MouyQHqTYy1
	 mXEeC07wkD0oaQAtsD1W/hvMpmvfZXeDW6DnEMlchQsB4JBoMneh6iEHArNMLtoKKE
	 O3Y352xP1bs/gPY2HOTZ0wXTDCfUgy0XhN9ZfrTkCRslrOS6LfOPPY86CW1120h6jT
	 fuZ/nxnZTBiWhfxxahxZGSDV09mALLk3L9bz4X2y+dVyDkyh9u4xEy0ZmPKzBBgtDx
	 5FIAz31WDMffa75nSwYvdmW5vwGKPEp5L7r/hIab42Dt/nqxCCbdlsIWBSYvw8keCr
	 R63/hRHBU5WBw==
Message-ID: <sashiko-outbox-207234@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] riscv: pci: allow write-combining mmap of PCI BARs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Troy Mitchell" <troy@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261110-riscv-pci-mmap-wc-v1-1-1d16fb8c74b4@kernel.org>
References: <20261110-riscv-pci-mmap-wc-v1-1-1d16fb8c74b4@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 15:10:18 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Define arch_can_pci_mmap_wc() for RISC-V, so that the PCI core can
> create resourceN_wc in sysfs for prefetchable BARs. Without it, the only
> sysfs mapping of such a BAR is resourceN, which uses pgprot_device():
> with Svpbmt or XTheadMae that is the IO memory type, where every access
> is strongly ordered and nothing is merged.
>=20
> resourceN_wc is mapped with pgprot_writecombine(), which selects the NC
> memory type when the kernel uses Svpbmt or XTheadMae. Without either,
> _PAGE_NOCACHE is 0 and pgprot_writecombine() changes nothing, so
> resourceN_wc would get the same PMA-defined attributes as resourceN and
> no write-combining at all. Make arch_can_pci_mmap_wc() true only when
> _PAGE_NOCACHE is non-zero. On 64-bit this is a runtime check, as
> _PAGE_NOCACHE is chosen at boot from the CPU extensions; on 32-bit it is
> always 0, so nothing changes there.
>=20
> Signed-off-by: Troy Mitchell <troy@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-riscv-pci-=
mmap-wc-v1-1-1d16fb8c74b4@kernel.org?part=3D1

