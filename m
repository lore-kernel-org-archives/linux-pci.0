Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1CA32FA30
	for <linux-pci@vger.kernel.org>; Fri,  2 Oct 2026 09:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932904; cv=none; b=ULDZTzERYuJ3NrctSbYmU1Eur7HMakwf6WNHLWVQ6Rx1hpdXCHyXmh4G4rAtWAsnAIRzQrrq7y53t8ykl0BN0zCkcvw9ZMBFLs30UnVE+vTO9gHXf8p8dEIzxf/GxyGRL3LAlsPxBNNZvn0d8WJwhgRFJ0InHuVeumHH8hl/lTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932904; c=relaxed/simple;
	bh=7wgrfviOTra5JY/U2bhCFFYjxqds7huy86FqWMq8Mbg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sW7rrzqWUyOWikfSgRvl1DAy4e0ybMNtjD6GDaGbu2LHCmFSw++/bepzW3/eEnEMJaNsCuqFYijJdc+Vrm6wD6P2BJN8rnK2nt2+O1Fll2TM+aAGH0CK7Lw8Z+3yZVh+0/OwZu4OV9WZ/sCiy6PdsRbCPECCRiTlv57n93HshII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GmgZOW9V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GmgZOW9V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D05541F000FF;
	Fri,  2 Oct 2026 09:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932902;
	bh=7wgrfviOTra5JY/U2bhCFFYjxqds7huy86FqWMq8Mbg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GmgZOW9VWEiJAGYMuvDugiG8gvD+AtSvsWiPLQMh+QXJIif8DBGoU5X0TRPzrQect
	 q9txJabDlyBVDpckHBjC8a07ZeF/mG2B7w2HTX25EMAS9Xq/gWv5nvG0ntBWk3qJHu
	 81+4nT96g8m/a2tW/A51w7YSAJ7YcN17RamsI07RpAaAISNWKOSj6m3H31wEydBgpD
	 EhTLqGQx3Ai4E8m8seUXCKrD0mVxWl+CMXc/sbGolEd3n4jCmS4ANCi7SuuSBTDizp
	 eD+BYk1wn5WV2twXhPVKPof4ZD6yLAnPj+lRTu82YQ2y4R6bBafx0q+CW5ZecyOCWv
	 AMqF0yhA7O6iQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] PCI/ASPM: Clear ASPM Control on links without
 common ASPM support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Roese" <stefan.roese@mailbox.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261002091029.2225203-2-stefan.roese@mailbox.org>
References: <20261002091029.2225203-1-stefan.roese@mailbox.org>
 <20261002091029.2225203-2-stefan.roese@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:21:42 +0000
Message-Id: <20261002092142.D05541F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> pcie_aspm_cap_init() returns early when the two ends of a link share
> no ASPM state. It then never touches Link Control, so ASPM Control
> keeps whatever the device came out of reset with. Per PCIe r7.0, sec
> 5.4.1.4, the result is undefined when L0s or L1 is enabled although
> the other end of the link does not support it.
>=20
> The Renesas uPD720201 xHCI (1912:0014) resets with LnkCtl 0x0003 (L0s
> and L1 enabled), as the Mini Card CEM and M.2 specs ask for. Behind the
> CPM Root Port of AMD Versal, which supports no ASPM, it only works
> because the chip clears ASPM Control itself during the firmware
> download by xhci-pci-renesas. Once the host has written Link Control,
> even with the unchanged value, it no longer does so. Since commit
> 1a6845aaa6de ("PCI: Initialize RCB from pci_configure_device()")
> pci_configure_rcb() does such a write for every endpoint, ASPM stays
> enabled, and the first access to the xHCI BAR runs into completion
> [ ... ]
>=20
> Fixes: 1a6845aaa6de ("PCI: Initialize RCB from pci_configure_device()")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Stefan Roese <stefan.roese@mailbox.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002091029.2225=
203-1-stefan.roese@mailbox.org?part=3D1

