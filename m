Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2E2384CD6
	for <linux-pci@vger.kernel.org>; Fri, 12 Jun 2026 14:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781275314; cv=none; b=OwVW/0M0O38NHHcrfxZRQGW5N+rPdX5ericrW29Rq73gL/AF4YyJ4z7Ozl6QmT91+pURnGKpdyzp/2pT4H1mbXZymOsGtUAer4lbht8JZrzAkbQRa9ZnFlZzuQqSmEuogIeI+OgnnCbbmvuydGIEUtV++jVgGGn7hcco6rDO2dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781275314; c=relaxed/simple;
	bh=6iZkZgESgMQX/QZFVJDemaFY12GIEqJSn/lpeUYNKnc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IbWAxg0X+G/tEBeKp+lbwZMVWmllLMQwgGmrD7+kjz/pcYvWjUQu+9G3VXmnM4Z0jrZb0Zq1/e9mm3GKzIxkTkbilEeTxHyW8V70clqv4qHxo8297UmMhn7LWQs253V4qY2VdcD2hIipiz1+k14v88y6eKB0L7loHLEhdydmON4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+IrCART; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+IrCART"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4907E1F000E9;
	Fri, 12 Jun 2026 14:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781275313;
	bh=IRPrI3yBAc/IgtOws2/bqKrXNJ/HJeBHmVWeQD6ll3s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M+IrCARTi3AxanZ0ACZm8WFEVcXCO33sgCa9oIpMzmogSjtZBz2Sq1njOHk6kVNFA
	 cb+MMERu1Dw3bsbWfm8r0PxEdgZChmPEqwcPJ58RynFroIlQpvXlKxcHJXi8fo7s4t
	 VkrRpuaXZ9GxEr3OfP1ArRkNBKOdqMB1L3fNA4t87sRFsdlwhSBEDF3CM08BdZG/BG
	 DMTwHhv2SDl2u1Xcw8NZD++Q5Ur7vxRIZLlVEPe/0TaZR0KupnAmnqRSmriPnqXrJC
	 9uhHLr85ea4CGBkMcf7I7bQJ6mEGBKOjcDIakBNiLrIBUIMBGUz10TYkWVT4uM8TGU
	 9ACV1Yd6VHTJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9] PCI: Add device-specific reset for Qualcomm devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jose Ignacio Tornos Martinez" <jtornosm@redhat.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260612142638.1243895-1-jtornosm@redhat.com>
References: <20260612142638.1243895-1-jtornosm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 14:41:52 +0000
Message-Id: <20260612144153.4907E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Some Qualcomm PCIe devices (WCN6855/WCN7850 WiFi cards, SDX62/SDX65 modem=
s)
> lack working reset methods for VFIO passthrough scenarios. These devices
> have no FLR capability, advertise NoSoftRst+ (blocking PM reset), and have
> broken bus reset.
>=20
> The problem manifests in VFIO passthrough scenarios:
>=20
> - WCN6855 WiFi card (17cb:1103): Normal VM operation works fine, including
>   clean shutdown/reboot. However, when the VM terminates uncleanly
>   (crash, force-off), VFIO attempts to reset the device before it can
>   be assigned to another VM. Without a working reset method, the device
>   remains in an undefined state, preventing reuse.
>=20
> - WCN7850 WiFi card (17cb:1107): Same behavior as WCN6855.
>=20
> - SDX62/SDX65 5G modems (17cb:0308): Never successfully initialize even
>   on first VM assignment without proper reset capability.
>=20
> Add device-specific reset entries for these Qualcomm devices using D3hot
> power cycling. Testing shows that despite advertising NoSoftRst+, D3hot
> transition provides sufficient reset for VFIO reuse, particularly after
> unexpected VM termination. While not a complete reset (BARs preserved),
> it provides the only viable reset mechanism for these devices.
>=20
> Testing was performed on desktop platforms with M.2 WiFi and modem cards
> using M.2-to-PCIe adapters, including extensive force-reset cycling to
> verify stability.
>=20
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612142638.1243=
895-1-jtornosm@redhat.com?part=3D1

