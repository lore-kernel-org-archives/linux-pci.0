Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACF737D135;
	Sun, 23 Aug 2026 04:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787458320; cv=none; b=JaOUPU3DrQmyTJcgMLMQw0xLZtgZbsCALu1yY1ugY86eDZsqZ9WUaQ/YpbFsDXuTvj/MgK+9fh+LFWMHlcu8Le8jGMkByq0G+m19y1qyKwURYA3u9nRAqRJflYrbRoUcA/63ip6VOLCD+GXfs1YJT0kodsqrMGM7x4wzSIKdB04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787458320; c=relaxed/simple;
	bh=7+iVg6/iiInQ1ravji5LTxu7l7Vx7D8/5If71x5EkJU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CZcQdpZ7NXyy9tS4HsObiibHprwmMzlRkA5hCn81tyqfeI+hmL4tfzoUEIU0YCbWF9DNrvcPs+BNUqPNSnToOerfQWkR/uQ/ymLcUOF4YFctzqQp+766KpyKACueH3y2XdBaI+uIgk0j2lbq52AQTKW5V+z0ckbEMOmir4aOhic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GU5Bi8Io; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GU5Bi8Io"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39EB61F000E9;
	Sun, 23 Aug 2026 04:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787458319;
	bh=7+iVg6/iiInQ1ravji5LTxu7l7Vx7D8/5If71x5EkJU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GU5Bi8IoFVr5un8jeE82cLG3ySCrJXFey6P8AGJcEy1wtADlwgnzbpnM/yLr1JRvQ
	 Nxv2/EMLho32IZ+rsi3pLqfsDG79jayZqpdRyQUvdci5Zvasd0hqPqSskrMJjPXhDv
	 3eMCaHVEFIvi75/AocuSjVpcyZWTSnwIDna79hsvX4KWd7bELCy7JMpMop1RsI84FL
	 cHn3/5R3elGUGj9SJC2hofuBU75hI3/tiEx8fxduGfEdv/NpYiXWqRCFf7mqEzZfP7
	 da2Emp0qfZItChAwdsu7vl/wO8aGtZHfxYX8hPf7TbOEfBEJG+wONu5Db2YPpVcrA+
	 nHI7RS8imgk7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/2] dt-bindings: PCI: amd-mdb: Add CPM6 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sai Krishna Musham" <sai.krishna.musham@amd.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260823040715.204096-2-sai.krishna.musham@amd.com>
References: <20260823040715.204096-1-sai.krishna.musham@amd.com>
 <20260823040715.204096-2-sai.krishna.musham@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 04:11:58 +0000
Message-Id: <20260823041159.39EB61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The AMD CPM6 PCIe controller is based on the Synopsys DesignWare PCIe
> IP and integrates two PCIe host controller instances. Add the
> "amd,versal2-cpm6-host" and "amd,versal2-cpm6-host1" compatible strings
> to describe the HOST0 and HOST1 controller instances.
>=20
> Add "intr" to the vendor-specific reg-names in snps,dw-pcie.yaml for
> the per-controller interrupt register region used by CPM6.
>=20
> Update amd,versal2-mdb-host.yaml with separate register definitions:
> - MDB5: 4 regions (slcr, config, dbi, atu)
> - CPM6: 5 regions (slcr, config, dbi, atu, intr)
>=20
> Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260823040715.2040=
96-1-sai.krishna.musham@amd.com?part=3D1

