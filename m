Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3CA13D891;
	Fri, 14 Aug 2026 15:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786722405; cv=none; b=rGyf6wuqCLSGZNaiCz7R/27DnrxWcLgoVN+iqW3JQPcbMDb9d3CoiAKj2S4ryq/eaE0DkI1Omm4MXhZkeKWKXNDNPyHYTVbvhesgbI4r0fcDjXTqg59LHA9eNY4izmhCaWSs3JjwxOI7onUIVPgT4VINR88fZo9LGwl/3huqffY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786722405; c=relaxed/simple;
	bh=6b9g8pzlAgIUA/7x85zUm2vIyPH+1WAKZELVg4wjrBg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A0c8XWhaq/yDNSOaE//BZ/TT0pFYvmIfKTRXy9qBTgxe6FOYXEboIbzRs9/cItjrHANrpFQ8ShDprlqFNbbUboR3jTQBtFIVG9yyyUwzliDJ9zSceOjAWmwoY8EEBO2HgYdRJvdaMeCQZJu7imsG+5kydP0njZ5cJjkt69zyXjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZsQMWY8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZsQMWY8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE8571F000E9;
	Fri, 14 Aug 2026 15:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786722404;
	bh=6b9g8pzlAgIUA/7x85zUm2vIyPH+1WAKZELVg4wjrBg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UZsQMWY8SbafWJnSZi1m6BUcGaldFn04fAWb/OVxl9WIRTIUdE6fASkA2fRtF/38p
	 Wjtvq5ZnOLFmvvOimZ7yF1ZjDc97NBrpfSSPo2QKRvez0ZIk+B124WorKrL8ZE+ue/
	 1zdXPQED1VZEYG23IrCadv3fFReUkyCNbfoe8VjftMDl1wsGrXKIXedWS96jhKg8eP
	 V17M8xi+kobNth+gfm95hFkLwJO161uFD92ResNfTiJ8wbw+LrBO+kT+n6qSot0cxw
	 W+83CSt2EdMxnppRZGZ0aL/ipzdR2OuFrDzX5iXbnBYcVBU6lTUGHDyM322TfxWkN/
	 3sOZQQ7pHcN3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 1/5] dt-bindings: pci: tegra264: Strictly
 distinguish C0 from C1-C5
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260814-tegra264-pcie-v10-1-05d08c592b05@nvidia.com>
References: <20260814-tegra264-pcie-v10-0-05d08c592b05@nvidia.com>
 <20260814-tegra264-pcie-v10-1-05d08c592b05@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 15:46:43 +0000
Message-Id: <20260814154643.EE8571F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Thierry Reding <treding@nvidia.com>
>=20
> Instead of using the ECAM registers as the first entry, strictly make a
> distinction between C0 and C1-C5. This is needed because otherwise the
> unit address doesn't match the first "reg" entry. We also cannot change
> the ordering of these nodes to follow the ECAM addresses because that
> would put them outside of their "control bus" hierarchy since the ECAM
> address space is a global one outside of any of the control busses.
>=20
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-tegra264-p=
cie-v10-0-05d08c592b05@nvidia.com?part=3D1

