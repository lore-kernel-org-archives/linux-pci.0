Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40A7470456
	for <linux-pci@vger.kernel.org>; Fri,  2 Oct 2026 09:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932737; cv=none; b=s6iw9TCXGWayZ4O2KcRna2ptgsCv5O0Dguang1rkjVVPXMy/y3Rds7KNdPDtSc17nvXrOxB38wY9wgtKgDGS5yLp7aDRs1ElYBX4SOKXoqFLJ72uTahZdtJGJ38/rxDJhiq8vSjFjgpNg3k/av0NrR8MpDerWPN7VODyqEYdayA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932737; c=relaxed/simple;
	bh=zQL2EPvMfmomBsZEsdKKjBntQy2iyaPiZB2OcBDEMU0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kheZEIfP0+T7ibPXdMMtUv+itXwGXrtV52j3cloKFJiMfXmLx7FH3arLDkWzbxOIs7e/prjIb7SQCU4S8qdA/e1KijOPgUSfHrInchNe+Q3hIHccTRXg3Cl6TVSGwF8FPP4Y/l4fytiS3UYK3jd5AIlUZC0NdAWrbno57VkowxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GiMJsSAj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GiMJsSAj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55CD51F00898;
	Fri,  2 Oct 2026 09:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932736;
	bh=zQL2EPvMfmomBsZEsdKKjBntQy2iyaPiZB2OcBDEMU0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GiMJsSAjsiQHUGrFWLm4Vk3V7Emt1XgpIoaScbyLnGGqy+S6DFBy+AmeJnlIt8vF9
	 sNYMbtcsPFDLO0vKnp2fI6QuTeL5S7AlgEKLvHjMCZyrEa8n8oPtW3Hn9gW9irfvYO
	 H4thFBCyflQeufudnhGhcW+7d6GbSJJAkPFw5E8z65DhwIpwFRuXnjD/pCNQvbwKKL
	 h0ifs09nouoFCcfCG5ae1Dk176ktVXhgsgWIgrSu1lKmmQRloVlaATqb7XDRZR2uem
	 rzZiwQB1EIBgihwFpvwnfEIolzwRZAUX9L6TYOz8KHwTO+de3Jey3QYUX6scjXhW1u
	 7024MDHfVq8QQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] PCI: Set RCB only when the Root Port has it set
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Roese" <stefan.roese@mailbox.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261002091029.2225203-3-stefan.roese@mailbox.org>
References: <20261002091029.2225203-1-stefan.roese@mailbox.org>
 <20261002091029.2225203-3-stefan.roese@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:18:55 +0000
Message-Id: <20261002091856.55CD51F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> pci_configure_rcb() read-modify-writes Link Control of every endpoint
> at enumeration, also when RCB is clear in the Root Port and there is
> nothing to set. Not writing a register that has nothing to change is
> justified on its own, but the write-back of the other Link Control bits
> also has side effects on some devices: the Renesas uPD720201 xHCI
> (1912:0014) comes out of reset with ASPM L0s and L1 enabled and stops
> clearing them itself once Link Control has been written. On a link
> whose Root Port supports no ASPM, the previous patch clears them, but
> it does not run with pcie_aspm=3Doff or CONFIG_PCIEASPM=3Dn. There the
> first access to the xHCI BAR runs into completion timeouts that hang
> the system.
>=20
> RCB may only be set in an endpoint if it is set in the Root Port, so
> there is no need to ever clear it here; an endpoint with RCB set
> below a Root Port without it is a firmware configuration error. Only
> set RCB, and only when the Root Port has it set.
>=20
> Fixes: 1a6845aaa6de ("PCI: Initialize RCB from pci_configure_device()")
> Cc: stable@vger.kernel.org
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Stefan Roese <stefan.roese@mailbox.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002091029.2225=
203-1-stefan.roese@mailbox.org?part=3D2

