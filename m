Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792442109;
	b=BZRMUQTG/foc7bJG8lpbbGZsimNaCI71eH0r+5Iont0cTZs3NKje4MM3hfalwVpN4A1o
	 xhfppQpfqjxm0EsFpdzlcSHglwVo2wIEEGBOWrFcZDoK4aiIijLLkQ2zKvzJ3OtAjOe/+
	 +4d+5/yw1icscanvBRFgtHTDnVY346QCJhFV+L3mJzoafwOhbW8bJR9oiY/AoqSUcizEg
	 iYgvKDUlom/vdAMfKv5j4Q3wJcqgWDnkcRMQ5dEExRdJPabf8NbBmdi0MC1GZ8ruwuIMN
	 vdxnSZACqmsD7kcXZ7BFIDaHww37KFRfR6zcdwD5uHsPUWqUI6JosKbctOz3H/y6lxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792442109;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vBu/TKdp/tecyQelmkibZMI2iTqidDebWzkhUllZ2Z0=;
	b=UjiNgWSR0VLHLH4bCM+NCTVGC3B6wu+m1/SxQYhPDvYpBY23msJiOtTdzj3GlymINltB
	 7gy07lK+8D98PzIxby+UuoT1F9VUs+uEXLELzcV9yDIGatTN9i30Hwr8htLbekbDELhog
	 fv1zhHbERU+xFYuY0HKKPY+WPiASUuJ8A3y258++okWHTF2ysxMCL0UlxrgIOOdXQzsXi
	 yrtZ9PEPktKshoy3GXkczOKu94VBoQ72cRWi8srfvHuZwuf2be7d5ZEz5xQw01Nv0CMrJ
	 w5b94xG8eKEq+tCCAtuyGniN1rIYCKIdqKPZ6CB5aqvDDxKpdJKTcLOUQWh/PYRnzrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Y/trCjmD";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1059606A321;
	Mon, 19 Oct 2026 20:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y/trCjmD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F2F1F000C7;
	Mon, 19 Oct 2026 20:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792442109;
	bh=vBu/TKdp/tecyQelmkibZMI2iTqidDebWzkhUllZ2Z0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y/trCjmDtQQUTBnWhjbBifKN8d7Zd2MAv2L0V6LymZujMUfqK1T7MFhqkPJL4xAQ6
	 4KSUsvq9S5KIJq9ciZD8aygejkeKMXSaR43tiqOTCWxLxPHhuxDDrt2cnjOZdAkn/p
	 KmtspvQBUqT7PWloFa4y8+YktvY+8YwvO5nK8XwyOzfzCuiRwA7ohnnLGTLNXo8bPf
	 dJ65q2S3bn0FwtSmDT6a1njYYcGDFCrmwZK3xaI7e6JtsOxBsjb4bVqxR6RiU4hm2i
	 MGSan3sFu5+bACU8XrwYJSb72OzdgV5W4Y6RBD3bfI7wcHEv9T57ef5h/0/5tttirV
	 fZvvvXPwLEkag==
Message-ID: <sashiko-outbox-178180@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] PCI: Do not mistake an absent device for an
 active link
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RnJhbmNpc2NvIEJlbHRyw6FuIE1pbGxhbMOpbg==?= <fbeltranmillalen@gmail.com>, linux-pci@vger.kernel.org
Cc: linux-usb@vger.kernel.org
In-Reply-To: <20261019202445.38259-3-fbeltranmillalen@gmail.com>
References: <20261019202445.38259-1-fbeltranmillalen@gmail.com>
 <20261019202445.38259-3-fbeltranmillalen@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 20:35:08 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> When an inaccessible bridge's Link Status register reads as 0xffff,
> both PCI_EXP_LNKSTA_DLLLA and PCI_EXP_LNKSTA_LT appear set.  The link
> wait code then takes the inaccessible bridge for an active link:
>=20
>   - pci_bridge_wait_for_secondary_bus(), for ports up to 5 GT/s, decides
>     that the link is up and waits PCIE_RESET_READY_POLL_MS for the device
>     below it;
>=20
>   - pcie_wait_for_link_status(), used for faster ports and by
>     pcie_retrain_link(), reports success at once when waiting for an
>     active link, and times out after PCIE_LINK_RETRAIN_TIMEOUT_MS when
>     waiting for LT to clear.
>=20
> Treat an all-ones read as the device being gone.  All callers of
> pcie_wait_for_link_status() and pcie_retrain_link() treat any non-zero
> return as failure.
>=20
> On a MacBookPro14,3 whose Thunderbolt controller does not come back from
> S3, the downstream ports of the controller are 2.5 GT/s ports that no
> longer answer.  Resume spent about 65 seconds waiting for the xHCI
> controller behind one of them ("not ready 65535ms after resume"); with
> the pci_bridge_wait_for_secondary_bus() change it gives up on that
> controller after about one second.  That machine never reaches
> pcie_wait_for_link_status() in this situation, so that part has not been
> tested.
>=20
> Assisted-by: LLM
> Signed-off-by: Francisco Beltr=C3=A1n Millal=C3=A9n <fbeltranmillalen@gma=
il.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019202445.3825=
9-1-fbeltranmillalen@gmail.com?part=3D2

