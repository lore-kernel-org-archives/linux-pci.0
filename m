Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1133B95E9;
	Tue,  6 Oct 2026 08:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791276704; cv=none; b=XC7FYlVumWj14ibZpahe5AaudVCg7b7NPVXfaJH05G0kG2gUwV1yHJEMNKgjimdCrEyCnKLE2L9OCwC+P9v5thvYAGlwHNpScIVewGV9RDjL8HoVZQ8ZHdz0T4lQokAO7jCi6Whhwt+uSngXQZXgalWy+Auh4iluEFDHVYsw2xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791276704; c=relaxed/simple;
	bh=IFDKnsWlG+XfAYkYS0nAuSfFvadl1+DCHmHla16qX3g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SvZsZY5ohPA3uNG7SA7+CZU5nN5Hnq/iD/7RPv3F/CfF7QzsZ3MASWySnLG1OWFrUOjWEE11KijSMVw6TtFsscKPUTzetFanfuXZvahbZZyHgsxuIUas5YMvgTXfjXhu/FEyY8Z9+SynWvY1sIUu9IXpE2dJkmmiih86UV9kAE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5DqauCE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5DqauCE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DF671F000FF;
	Tue,  6 Oct 2026 08:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791276702;
	bh=IFDKnsWlG+XfAYkYS0nAuSfFvadl1+DCHmHla16qX3g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D5DqauCE4gVDdKCtyvp+/2WdmlWBGrRXaXvGjmFD58YGuDYwqUl4CPcIV0hePybAx
	 UPte8PsNqA/fueSXbr52wSJoz00yRL5vadEqAuMWbLJOBcKvRXzmRUoFHu7WyegAP+
	 IYE3IPljg9wsc0pokF2/TeE+v35PGeHiCpkUCYBVvBIKVPcnlFQoV2igznrwpIIk2q
	 gANJMmq6jADQ9p6sX4e4KjFf2UIaN+x+4czR81WjmjtIATGWvxHI/sf/BxwsjdkuRx
	 nHjhshxV/FIEMyfpkMytrVgEstw4v/+7iZuhmi7LIclul5pL1DxzYTFDw7XMl4vDVY
	 lFz8kJnzoyDxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 13/18] PCI: dwc: Let glue drivers hide the Root Port
 MSI capabilities
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20261006084638.3821710-14-den@valinux.co.jp>
References: <20261006084638.3821710-1-den@valinux.co.jp>
 <20261006084638.3821710-14-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 08:51:41 +0000
Message-Id: <20261006085142.0DF671F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Commit f5cd8a929c82 ("PCI: dwc: Remove MSI/MSIX capability for Root Port
> if iMSI-RX is used as MSI controller") hides the Root Port MSI/MSI-X
> capabilities when iMSI-RX is the MSI controller, as it cannot receive
> the Root Port's own MSIs.
>=20
> Some platforms cannot deliver them with an external MSI controller
> either. The DesignWare core signals Root Port interrupts (AER, PME,
> bandwidth, hotplug) as sideband signals on its SII interface and only
> turns them into MSI writes with the optional SII2MSI feature. Otherwise
> it is up to the vendor wrapper. The controller on R-Car Gen4 SoCs
> (DWC 5.20a) appears to lack SII2MSI, and its APP block merely latches
> the signals into status registers wired to platform IRQs, so an MSI
> targeted at the GIC ITS is never sent.
>=20
> Add a no_rp_msi flag so glue drivers can request the same INTx fallback
> regardless of the MSI controller in use. It is the counterpart of
> 'keep_rp_msi_en' from commit 3a4e8302e72f ("PCI: imx6: Keep Root Port
> MSI capability with iMSI-RX to work around hardware bug"), which keeps
> precedence: that one is needed for endpoint MSIs to work at all, whereas
> hiding the capability only moves the Root Port services to INTx. The
> removal stays in dw_pcie_setup_rc(), which also runs after a Root Port
> reset.
>=20
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006084638.3821=
710-1-den@valinux.co.jp?part=3D13

