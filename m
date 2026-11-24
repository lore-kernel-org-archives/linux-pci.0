Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795510352;
	b=oR3FJr5nxHpOvEmdIghCfRTC/+CNs+3YNixpdz3axssOIs21hXNuPFaN03uJS10YnZwG
	 P/KmH0VtKSZdfPqkaGJ6u2D0SEmVc+jqlMaHPCcYSupwg4UKkCXMY1j7ICd2YNvlK+0XM
	 69P8H/F3DspgfEwCejy+2bD5y4FyE+jzhVkef6a/Q0/YseaKqgVnc/p9JYfulRoP2XtYj
	 mRrqFUpGSWrUtspGE6TksDbYQyb/Otsl6LM55fFgB4ALBHkFr81R06U7A9zSIFZ8QE6/1
	 3CTaNKl/CsvIOlMdJUFCos3+w3Vq/PgTeaV6oufX+APUZMBGc+oFViuv4gjP/G+2YJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795510352;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=13azyXGvHKrknCLGtDbLN0QYujThRUWNhuhFb1eY8ns=;
	b=tAVDHTNBRA/R5EpG8N3G2HjBsEYAqwoUwlQdgBxETaxXBM57qxUc1gtEAQ+ke/p182lj
	 GCTxfH+KZxjbJSPUf3ZsgEu8wESrgoPi9Ynj4trq8JeU9rf9noTTLyaHIcv0BC/TVU2DZ
	 cxi4PpPTsZXgeNEpxnqins5ODGC+Njfu1H2au5BttYt7ZMbujLLNeAwIZjfRIrwVv8JF/
	 IzmyGbxRYOywT1DpAOH2fi1H+pgBaRZle2S5vY28ijFVe2hRi1xsddv78aeVEbbQXPQ43
	 uW5ynllQr/DBzwpDHL3sjxzqVRwSppjqpY+0N/ucFv2LNv1z/ZDxyZr5hUeg1zBPzng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FwqoJqZm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391AE606A334
	for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 08:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FwqoJqZm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 761BA1F000F4;
	Tue, 24 Nov 2026 08:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795510351;
	bh=13azyXGvHKrknCLGtDbLN0QYujThRUWNhuhFb1eY8ns=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=FwqoJqZmeuZ28l9+7Il3lSwSAiaxGgszzeFCcXBJpWAV9oq2uw1auzAKmw4Fk84lA
	 Fpusiih0mU8hAW51Bpo8PmPxoDHeTyunwI0rSguOuPsQW0lmze3RlIKW13ju6R4hpP
	 ZQQfJCYT92xPy9NdEowAN4g2HAi94DGeURNUJXC9NYzhZ30Y/cJckpCiPxmlMR/S7E
	 FJpsLcllrv/7fVhLgtkze0PjEXXU50DIYXg3Sq6cigT9VmWRhIaR5V1f+E6IFzcWts
	 BPRvpcO0CpXkl/FAPRcvDAjA+VceppmU9/UgUNER47MN83JMJK1oXZFRgyCwVZLsoN
	 5T16w7PmVPsSQ==
Message-ID: <sashiko-outbox-230747@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Correct PCIe port type field encoding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gokulkrishna Sekar" <gokulkrishnasr@gmail.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261124084828.15318-1-Gokulkrishna.Sekar@harman.com>
References: <20261124084828.15318-1-Gokulkrishna.Sekar@harman.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 08:52:31 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> set_pcie_port_type() validates PCIe port topology and corrects
> invalid upstream/downstream port type information in the cached
> pcie_flags_reg value.
>=20
> When performing these corrections, the code updates
> PCI_EXP_FLAGS_TYPE using PCI_EXP_TYPE_UPSTREAM or
> PCI_EXP_TYPE_DOWNSTREAM directly. The PCI_EXP_TYPE_* values are
> decoded port type numbers, not values encoded for the
> PCI_EXP_FLAGS_TYPE bitfield, so the corrected type is stored in the
> wrong bit position.
>=20
> As a result, a device whose type has been corrected may subsequently
> be reported as PCI_EXP_TYPE_ENDPOINT instead of the intended
> upstream or downstream port type.
>=20
> Use FIELD_MODIFY() to update PCI_EXP_FLAGS_TYPE so the corrected
> port type is encoded consistently with the format used in the PCI
> Express Capabilities Register.
>=20
> Fixes: ca78410403dd ("PCI: Get rid of dev->has_secondary_link flag")
> Reported-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
> Link: https://lore.kernel.org/all/20241213070241.3334854-1-gthiagarajan@m=
arvell.com/
> Signed-off-by: Gokulkrishna Sekar <Gokulkrishna.Sekar@harman.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124084828.1531=
8-1-Gokulkrishna.Sekar@harman.com?part=3D1
