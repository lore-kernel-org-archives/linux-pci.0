Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071E3332EC8;
	Tue, 18 Aug 2026 15:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787068242; cv=none; b=sMchmcAgqRQV4GlJ2F17kBfXmy7s/uGvNM7nqD6OxlsYfdnQCkI8pZhmwhFWs/9pbcsdCF95ikFSN/Qd6XMTtEEEfKzaPQoZ6ov2W5HnxRopz9RtYxT87ZTxTPqGi+/tdlbgKFsnAdSQP8tOWR3LWAxeS5clILA0rGF+hWtMTro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787068242; c=relaxed/simple;
	bh=5VeukePej8RwsJpOpSfhS8lzksj1LUcEyQuqFP8SLkk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DH9zFrDwvBoKEkbDXT6Nx8xh3rHZpaEp39fIN5cD2Ob/h0h2DFzyDfTAtwaqt+8Uv7cVUYXCTOJjlnCtZMlzeExQTkFWRQ4DEPkY5xm8bVLTeKvrP7+kn5OUNnhuwXSvqh9hVNt3k5g1t/pbu1lqR1/wGS+Ox0NAxsnrrJ4ScP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZF9JNaQL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZF9JNaQL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30261F000E9;
	Tue, 18 Aug 2026 15:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787068240;
	bh=5VeukePej8RwsJpOpSfhS8lzksj1LUcEyQuqFP8SLkk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZF9JNaQLJXzg85k3WFwAC6Uctfso14eTt1XOOxhqBvCYtfA6XWPs7JkuSCz29foPq
	 wQJxSeUEagS9d89P/lyHPbdxsexDNGpP4o7BaxeBR7pspkT1/0DwQ702H9LmfOIPbl
	 ENygOJ6kK+exeu53IUs03V4Jw2eVQ3XIRtO6P6styJ3tVNWVj+8b9b+3LOH/0BIGLD
	 yDrLbrjkJja0y1msvykxuvSXyaxy36gd4LFlTVWez8wBp/WYaXvDfZG93NDcSv+aZ/
	 WMTEO2YXynqL13t/16w2P7/NKAoRGgfhN1f9JeAIdsjsoN4hwEBHJ3SsqdxEfdN7rv
	 kJk/W4fzFArTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 2/2] PCI: xilinx-cpm: Add support for PCIe RP PERST#
 signal
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sai Krishna Musham" <sai.krishna.musham@amd.com>
Cc: conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260818153755.3801111-3-sai.krishna.musham@amd.com>
References: <20260818153755.3801111-1-sai.krishna.musham@amd.com>
 <20260818153755.3801111-3-sai.krishna.musham@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 15:50:40 +0000
Message-Id: <20260818155040.B30261F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add support for the PCIe Root Port PERST# signal using the GPIO
> framework, along with the PCIe IP reset. This reset is managed
> by the driver and occurs after the Initial Power Up sequence
> (PCIe CEM r6.0, 2.2.1) is handled in hardware before the driver's
> probe function is called.
>=20
> This is useful in warm reset scenarios where the power rails stay stable
> and only PERST# is toggled. Applying both the IP reset and PERST# resets
> the Root Port controller and Endpoint synchronously, improving
> reliability and avoiding lane errors.
>=20
> Both the reset GPIO and the reset controller are optional to keep
> backward compatibility with existing DTBs. Also add a PCIE_T_PERST_US
> (100 us) macro in pci.h for the PERST# active time (PCIe CEM r6.0,
> sec 2.11.2, "T_PERST").
>=20
> As part of this, update the interrupt controller node parsing to use
> of_get_child_by_name() instead of of_get_next_child(), since the PCIe
> host bridge node now has multiple children. This ensures the correct
> node is selected during initialization.
>=20
> Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818153755.3801=
111-1-sai.krishna.musham@amd.com?part=3D2

