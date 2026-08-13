Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5132E22B5;
	Thu, 13 Aug 2026 06:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786603810; cv=none; b=jwIAGFSiO55iBe/EBojmwSXb0ccz1xsavAn+yBnhQA3agG9h2SHlstdghha/hSrmtb9sQue1zDOJ9m8b/MEWumDEZoTx2mhuHQeTuqKsnzV9X+jlR9UFXVR8iftvCQIpXjqE+kWXpea2mgHbg9xq5BCD2nCq4IZqEgfv1brpAI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786603810; c=relaxed/simple;
	bh=pT2OFUTiV5i/GOAwO93UnDGyzFqzHVnyehDYVVndaZg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VUw2ZTRDsIIcdMO0iukocjR81/rgt1Cq+sfPBp0P4xX1Wsr5lysJxbaCuReeG1FyepS82a6TkToz5R2khNNDUiRl5s3R7aPZ75jKrrmouWTLWmz23bUfTvsppdP88TNaoM8NjP64BQFbUYkyA61L6ELnqMMbLCK+gBXgwHTl/XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jvw/2mmU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jvw/2mmU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28BB11F000E9;
	Thu, 13 Aug 2026 06:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786603809;
	bh=pT2OFUTiV5i/GOAwO93UnDGyzFqzHVnyehDYVVndaZg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Jvw/2mmUvt3R6dg3//43rIe9Do1sNlY7J/CGNwfgFroLSJX6I2rmsUZDJG826Ov76
	 PVTIuZo1n7BDLSP7cl2B/55HZNOLgLIARTY15HMaiwPRnabJ6n0L1ra2pSUl7lrCjh
	 M8KKj/NRHs+p4RA4XqA0NiMv1DdFZCSQAsZO6UiRJORZWsASo4ulxEwC9z4ZhVDZRU
	 PrmgPO74rDw1+gfMoAXQnfIaZyHloKSYvO8VZ9/kkjriFYHlVDhpuglQB8VotL3BHL
	 Da6WuWlGdje/Dx07PLFRdGjWd6+8JOApwn9/Mo7f8UtbErG7014hg/foB6FGFORnmb
	 PG/T3Zn2foyJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 08/10] dmaengine: dw-edma-pcie: Discover endpoint DMA
 metadata
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: Frank.Li@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260813063757.3131865-9-den@valinux.co.jp>
References: <20260813063757.3131865-1-den@valinux.co.jp>
 <20260813063757.3131865-9-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 06:50:08 +0000
Message-Id: <20260813065009.28BB11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Teach dw-edma-pcie to discover a PCI endpoint DMA function from
> BAR-resident metadata. The metadata supplies the DMA register window,
> channel counts, descriptor windows, optional auxiliary windows, and
> endpoint-local descriptor and auxiliary addresses. Accept DesignWare
> eDMA unroll, HDMA compatible, and HDMA native linked-list layouts.
>=20
> Endpoint-provided DMA channels use raw slave addresses because the host
> programs transfers against endpoint physical addresses, not PCI BAR
> addresses. The host-side dw-edma-pcie instance is remote-routed by
> default, so delegated channels report completions through IMWr/MSI.
>=20
> Endpoint DMA metadata currently has no static PCI ID. Let an explicit
> driver_override bind use the generic endpoint DMA metadata parser, but
> do not treat arbitrary dynamic IDs without driver data as endpoint DMA
> devices.
>=20
> The endpoint polls HOST_REQ at a low idle rate before programming DMA
> window submaps and setting READY. Let the host wait for several endpoint
> poll periods before treating the READY handshake as timed out.
>=20
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813063757.3131=
865-1-den@valinux.co.jp?part=3D8

