Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848122D3A69;
	Mon, 20 Jul 2026 15:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784561447; cv=none; b=J9it1KiDIR48Q4+nckyxSfOV3oSfiNIwwgjYTNDMYjTIeHfexHmftbROqss8UliBqoZYZfd63vRkrijw1sr03feGgyU5Mr2IKwtRoakJe+epzokRKJJ51gLYW/OAFXSqRGYWdbScjnNW1kooDvcNPsymPsnoNt3j6L7cOKPx9n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784561447; c=relaxed/simple;
	bh=mQbar/d8QGB/uSbQHJ47j+oqs0sNVVWb1ltrpfOdz+E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Jym+FBYFbiqhJbA+ooajTfOsH3QsOrKKomq5fJ85Y87WL6eF43lpyKYUrW1AWH9C4chy8UvHXJ+xwaXHdfMEOGEmu2ORNrZfan8qJoS/HPU24mUUCbat2Kpg6tFWWDoq+CM/ohxLgrIhu7aKjSiAo3FdOFJYiZVEjRXLiB42kXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=menUWW6T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="menUWW6T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13FF01F000E9;
	Mon, 20 Jul 2026 15:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784561445;
	bh=mQbar/d8QGB/uSbQHJ47j+oqs0sNVVWb1ltrpfOdz+E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=menUWW6TR0NQtE9XHTCF1PSlH07STB+kjy8nk5SFGbA9UB4lgTCgShl3FJeiiulmK
	 vQlklLjEzafQrrxjrOtHAGP/mowrcJL6rWPtX67WrmYKSWd4WH60ozChPU2tYqrxvz
	 Vg3OvfR9knYo6roNiSYsVJwojW8kUXUmRL4u562cKPEeBVjoiu5aP5HKiDfQMceeLn
	 m9AejmbYuHCcTs2TCOQQs3N07AP/qNmIFz92Z+8ahmn4My0Yz7hPkaGZ402HKJTYjb
	 3bwBTZ2lGEpDElGuRQtVPFJWK0lYnBu7lLqUBK2xJ9dB2N0lfXoOkQURzDrNTRq6Z2
	 sAcquC/tnZlgA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 15/16] PCI: dwc: tegra194: Use cached PCIe capability
 offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: imx@lists.linux.dev, Frank.Li@kernel.org, neil.armstrong@linaro.org, linux-pci@vger.kernel.org, linux-amlogic@lists.infradead.org
In-Reply-To: <20260720150619.24733-16-18255117159@163.com>
References: <20260720150619.24733-1-18255117159@163.com>
 <20260720150619.24733-16-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 15:30:44 +0000
Message-Id: <20260720153045.13FF01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> In host mode: tegra_pcie_dw_host_init() runs inside .start_link, which is
> called after dw_pcie_host_init() has cached the offset. However, the
> driver's own initialization already enables hardware, so calling
> dw_pcie_get_pcie_cap() is safe and will return the cached value.
>=20
> In endpoint mode: pex_ep_event_pex_rst_deassert() runs after hardware is
> enabled (PERST# deassert). Because the core no longer caches automaticall=
y,
> we call dw_pcie_get_pcie_cap() here to cache the offset for subsequent
> accesses. The helper performs the DBI read only when hardware is ready.
>=20
> Thus, the private pcie_cap_base is always valid and can still be used for
> register accesses.
>=20
> Signed-off-by: Hans Zhang <18255117159@163.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720150619.2473=
3-1-18255117159@163.com?part=3D15

