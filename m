Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794428240;
	b=PEB5Xeklmg12TCzaA7bbH6WBK/EYw+YXcraI+t3jDZWK0azNKgXYf5xsAmAh034d+6eA
	 Z69GEY2FOioN7sRcVKQid92a5/p9/peZVbtYvyusbGIkS4e6+8VIUClg4DyQMswXWT5OJ
	 tXEuh1e1Unpu76SpLaO/DXM+sfHL1FhVNFeBVHSZA2UzpMoVLw5NXVkyoa8mL2Z/OO+j0
	 TbOIqNNfbSwOAuaZ5+h/O2PmbHmhJr3p0ErNbNZnRBrbe12KSEtUiqRpIlGIaT6xNSTz3
	 y/nVzPap320m3oyQtt5HV9VFQ3TwtoFwWG+gVel6iOnHXSo/aSTTOOyMFF3NRu7SLIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794428240;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vaw7dHhqHsTQbQX1CxVr/PAdx6+Qt5h4ufIK0WsUbg4=;
	b=uIRvYzYfyupe1EgbU+MSGI7YIRIIAD/MBVrt/gIUcXTCOZd32T1JiI7f11amfwIDvCTD
	 eaS3XPhINGLOiL2td9xoOpQbNtF1k6JetvZV//rjvZt/xvaMelwtxnDfC9T6A++AvBjQm
	 srt9g4tAIarT2yXEwcbNpXh50BIOqknTFKB4lyBnHOv9wh3/rAKWVQltuIh7Rl1lnjsfT
	 QASFcxDoQkJPJUzpXtXXd0UeiB94Wq3n1fOfSl+0oSvF9UuLv9Y02dwj5PRgVra2Oux8s
	 TRVR8APvEYpwVL0OCL2rhwl0eq8A3DmS8D/jhaMBwr2WEFCPPzLaLYQhMqJMfl/XJaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aKrzIKn8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14920606A324
	for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2026 20:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aKrzIKn8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDCF91F00A08;
	Wed, 11 Nov 2026 20:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794428239;
	bh=vaw7dHhqHsTQbQX1CxVr/PAdx6+Qt5h4ufIK0WsUbg4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aKrzIKn8DQjMSxb7zMtE3lyiXph5HFSNOLj+Ff+T6Gv52JNnrx9CJWBG0TExwHTdF
	 4zpT9dzYv+O+1E003f0Rbf9Fb8BouKTk20CVltpDrkQ04L8GyZdVHWRwF+GZQwDgkx
	 4z1GdH2Xr6iGzK7/Q7p7j/HZ6u8Y30QDHlY/kVPPagCIsYpu7mimuw74KJgM8uRYS+
	 h1SK9hqkeo65Yv1zd6hRy+U/NTS8MVadgrq8lrk2YLbH61F285KnzyOSiMBHyiXkVw
	 wfl238qzLciEUOy1x1HT2gZVEqviAdp9Ax8oRh6YooI3BVRC4+MMbFv6VaQpK0P5ne
	 u0esR52ZZBQQg==
Message-ID: <sashiko-outbox-209630@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/1] rust: pci: add domain_nr() accessor
Reply-To: sashiko-reviews@lists.linux.dev
To: "John Hubbard" <jhubbard@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261111200549.160806-2-jhubbard@nvidia.com>
References: <20261111200549.160806-1-jhubbard@nvidia.com>
 <20261111200549.160806-2-jhubbard@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 20:17:19 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The nova-core driver has to send the GPU's PCI location to the GPU's
> firmware as one word that holds the domain, the bus and the device
> number.
>=20
> The PCI abstraction has dev_id(), which packs the bus, the device and
> the function into one value. It has no accessor that reports the domain.
>=20
> Add an accessor for the domain number.
>=20
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111200549.1608=
06-1-jhubbard@nvidia.com?part=3D1

