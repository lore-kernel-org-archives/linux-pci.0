Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD17032B99E;
	Sat, 27 Jun 2026 12:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782562865; cv=none; b=MF2034YOQiaAO0NHqOA5BDeQyvF8v0uHaljpbTh0MM3C4SL8wnGE5Hu88vUVqR2SBOmgZy9gqrM6C8TaGv6rDRfdUd7nHLEIpbXxEaMztFLCjbDsIdX9JALWIqwP1eGU6oTOrgfAj6DdXZbTxbdt6wp083DKnR/LVteUIy3X17o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782562865; c=relaxed/simple;
	bh=KFIx2AFZiyI2r3T4lqAhFm7Upb8SELASR8MR+gwoP5w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nifRXULlM6HVmyufR+ARgRJ+/ibCaI3GEFguveV61IiLJOvBC2DdGpSZAnk7Dh/DaFM5SrpaaF5w1PxVwVbC/vdL4NzeJgewV0lUdRooz3M74rxRt1/S/VgXnVg0hWqcBsi/Lp7fXB7g4bOJ78GPIWuevMeaZhcqq8D7gMu/tzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RtGOFbz/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtGOFbz/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 130191F000E9;
	Sat, 27 Jun 2026 12:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782562864;
	bh=KFIx2AFZiyI2r3T4lqAhFm7Upb8SELASR8MR+gwoP5w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RtGOFbz/byLs7OfhVFW3cV0WKsm+1hQKS7mbFewzBpZovj3a8uIY5KOLwfo8S/GHq
	 W6xLrz/hATWZUGXgTgzXM0YjD4ut+C/cPMpomTtfIw2U06MwuiT7R/uDE9HvRRXxWs
	 qiH2pmGWsCJv0KBpZT0lh0ztYqWY6xY7IrgEzoHD0HPLuKQyXUKaSv5KilnVZgR7z3
	 EURPQQp4o12Rrodh4HdmaHjmUWaIbFWnxw9tzeV2VxL4PWBzgUfJddlpOZQcm3fTgf
	 V6ahRYdZEQ1NmntK2Al8VvhTlRsW0ctx+NrGT+t1OIm2BC2U0zlY3/J3EovN3FWTpF
	 /humIpEO2E0AQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] dt-bindings: PCI: mediatek-gen3: Split Airoha
 schema and document 2-lanes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Marangi" <ansuelsmth@gmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260627121450.3529133-4-ansuelsmth@gmail.com>
References: <20260627121450.3529133-1-ansuelsmth@gmail.com>
 <20260627121450.3529133-4-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 12:21:03 +0000
Message-Id: <20260627122104.130191F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> To permit proper documentation of required property to support PCIe
> configured for 2-lanes mode, split the Airoha schema part from the
> mediatek-gen3 schema to a dedicated schema.
>=20
> A PCIe configured for 2-lanes mode require an additional reg for the
> secondary PCIe to be configured and the airoha,scu phandle to correctly
> configure the PCIe MUX.
>=20
> Rework the mediatek-gen3 schema to drop any redundant constraint previsou=
ly
> introduced for Airoha PCIe properties.
>=20
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260627121450.3529=
133-1-ansuelsmth@gmail.com?part=3D3

