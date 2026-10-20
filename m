Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792483965;
	b=T0i0JJSD2/AKBvWuKpVzkPC0Qs8CRVJjXjWSjh2NLyDZnZHAw02VY4w6frva4uK1pqz+
	 rBHXCGL4iazbuDFe9NnFv4eax9AifiAVFYpYxz5ACdAXYtUhvjp2JBZy4Pbc91JZsJoVt
	 psyARwyX91FQLmh3ZA/2aQROxZyqGLYjakgUJTr5KLCWoi/iSsp6Jvh890CFUsQEVshWM
	 uw7oAvCHm7m+BHDAgchYOYmZLfgob34mN+XYQ0+Ltox9HyK7/sGNqUCcSE2s1B209Zbt5
	 YRoCwnxRWXcZDdN860tGS8oj0DxEm40692jHyfg8O5ePVAeW3i3iAfbrx/SjhLefkhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792483965;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=10r0if6Nr9WKwfaQ9LB/CcTAReFShrgbCt395Lsmo+4=;
	b=oO3yFCiWyBt8TRrWGkc/cQys0UT8khUe169XCgFxaBqcXo9U9ndwSxfiibItn5obG90n
	 n92Y805r/W5i3a3/kXPRg/EPTkInww1v4LgfSv8jkfcAqasR02Tc+GrQcFtE0yqd7y7mH
	 77rKifmGz/PiCY1sXmu5WopuFBCUb+kDbq3rFyz0kagye1+I9I+gz2q5LzQ1G8ScBhuUD
	 trPdHkdbrYa4kNqUXQjgT6Nnw1nxMrGT3O4ZXMHUhcmBRZug/dHWUCAnKhQpcncULF3eR
	 A09jD+TtzvYWdYOftjODoPs9n6muIzUia+77tzP2vnZLOsBvxbvq5zJnpjQq1K9EV6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jHHY9KgZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B7F606A31C
	for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 08:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jHHY9KgZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4563C1F000C6;
	Tue, 20 Oct 2026 08:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792483964;
	bh=10r0if6Nr9WKwfaQ9LB/CcTAReFShrgbCt395Lsmo+4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jHHY9KgZbaCUGaKUbzQKypW6kpIMdZf+6oy2Qk6q1atfyEtkuRG9KXoLf5kIIBUzr
	 U2GpsvnUMmGlcN40BKQv2jr3Z9b+8nTOy5NMy1wEBD287Ll/QnuNV9eRKZNlBpjCSY
	 XgCSYEUy5RyqJ2RLv4vaj52rOLaO+Z7rH6H4OsvRaMXIVH+/ro6UW8G6AeQ6X2EXpS
	 A4GFucMT/4tSC6L2QYCblZ1U/jveMK/bAVKgVEUESVlM2KYv1VrZpzsPsDOXHKOe8v
	 i/dxTI5emg1wHVNWq0kv9Cchhcxkdpt9qo9ms9H4plFuZ46W3osQZBPji9lrwB/MLt
	 0TQnbF1vvq56A==
Message-ID: <sashiko-outbox-178493@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 03/17] PCI: rcar-gen4: Check live link status in
 link_up()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261020031049.969895-4-den@valinux.co.jp>
References: <20261020031049.969895-1-den@valinux.co.jp>
 <20261020031049.969895-4-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 08:12:43 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> rcar_gen4_pcie_link_up() checks link state using SMLH_LINK_UP and
> RDLH_LINK_UP in PCIEINTSTS0. However, these bits do not reflect the live
> link state. On an R-Car S4, after taking down the endpoint, a link-down
> interrupt saw PCIEINTSTS0 =3D 0x20a000c5 with both bits still set. Even
> after resetting the controller with the LTSSM back in Polling, they read
> 0xa000c5, still set.
>=20
> As a result, dw_pcie_link_up() keeps reporting the link as up after it
> has gone down. That defeats the check in dw_pcie_other_conf_map_bus(),
> which is supposed to stop config accesses to downstream devices while
> the link is down, so such accesses go out on the dead link and stall the
> host. It also makes the callback useless for the link-down recovery
> added later, which has to wait for the link to actually come back after
> resetting the controller.
>=20
> Keep the APP link-up event check from Figure 104.5 of the R-Car S4
> reference manual, but also require PORT_LINK_DEBUG1 to report the link
> up and not in training, through dw_pcie_link_up_debug_check(). The
> callback then rejects a downed link even if the APP link-up events
> remain latched.
>=20
> Clear the APP latches before enabling LTSSM to discard events from a
> previous start, and only read them in .link_up(). RC startup uses
> dw_pcie_wait_for_link() to poll the combined condition.
>=20
> Fixes: 0d0c551011df ("PCI: rcar-gen4: Add R-Car Gen4 PCIe controller supp=
ort for host mode")
> Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Tested-by: Marek Vasut <marek.vasut+renesas@mailbox.org> # R-Car V4H
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020031049.9698=
95-1-den@valinux.co.jp?part=3D3

