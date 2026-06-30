Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31F140BCCC;
	Tue, 30 Jun 2026 12:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782823211; cv=none; b=e7Z+Cty6qegdv8efxgvppYKOzb1O4L8rhgmWmuYMUcPdul/ah+8VLw9xjH1QxfY/0M+N8LxE0RUO7+YVgMbF9VK1A4vYf2l5wH2RKY32/k5JgoVLN5wIP6Y4CBWee6pXDJJkyob14z3qocRfjzwCL9cPn7C1YWqFuSkwJ1D8eRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782823211; c=relaxed/simple;
	bh=bl3I/86hqMe/n8cOzb0d1IVOtT9qA2YDZh+SKJBsXcI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uKGsLua4WiL/WwbGoLFOpyP8XeUMTJ/cJnjRooI0qtPgpsw5aPRiNh7zuC2BGLRY34wcSQ0B1vgg8J/YIaGwS/EwRZ6NWC7Sk2qXnvPDAnbXY5QHPPONuiMGdQ95ut7PAPqW4bOXwkcvcFzVfMRHM1mRUs3gpFuPWzqskSxBv6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVdzR3jV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVdzR3jV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BEA91F000E9;
	Tue, 30 Jun 2026 12:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782823210;
	bh=bl3I/86hqMe/n8cOzb0d1IVOtT9qA2YDZh+SKJBsXcI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HVdzR3jVlS3D78eDPTu4X5Fw6VazQOmGQrEwliEqgbduF3GAHfkJCsS7o3zQfNXnT
	 v650+/AY0+PBpi8xLUDShHWg4i/KI8oj8vnbNZOcKuQSNcmkQM+hSpoRG4Z2bS55se
	 LW+MATI0id58rw5+808J9BZhHeM/6O0AGdIkS/WEkByaz2mwCwQow09sYpl1ayQP8o
	 L37l2D4tB11K+Lt3RUyn+/BcX6d3ZWNzOReg+D1P3X00Wqzi8hn8tssyyTP7rz/iYO
	 /1JjXM//R2/hkZ5WaggRBt/+5OzDcsaNNVubLqxkt4T9jwA1vsxYSrHs1FmFW5cikV
	 z1Rh+R0GearSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/11] rust: pci: use `Option<&IdInfo>` for device ID
 info
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, "Alexandre Courbot" <acourbot@nvidia.com>, robh@kernel.org, dri-devel@lists.freedesktop.org, "Danilo
 Krummrich" <dakr@kernel.org>, linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260629-id_info-v2-3-56fccbe9c5ef@garyguo.net>
References: <20260629-id_info-v2-0-56fccbe9c5ef@garyguo.net>
 <20260629-id_info-v2-3-56fccbe9c5ef@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 12:40:09 +0000
Message-Id: <20260630124009.6BEA91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> It is possible that `pci_device_id_any` will be passed to the driver, e.g.
> `driver_override` is used on the device. Therefore, the driver must be ab=
le
> to handle the case where `driver_data` is 0. Thus, update the `probe`
> functions to get `Option`.
>=20
> The current code cannot tell if the info does not exist or is the first
> entry; however this will be achievable once the code is updated to use a
> `&'static IdInfo` pointer instead of indices.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629-id_info-v2=
-0-56fccbe9c5ef@garyguo.net?part=3D3

