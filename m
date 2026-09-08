Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B708529402
	for <linux-pci@vger.kernel.org>; Tue,  8 Sep 2026 14:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788879527; cv=none; b=ci2QDUA9qxJEcs2AD2ZKRPYOCJMsztSNRgOP51jCD85mepHo6xMnmGOTmCSC5gmu/MYlmeSdSrwiQClnqeuIgrBgdrwRI+HZYQ0jhoBAYo166CRKIDZOkaCMuv648S8FB1Kn2CQ8A6dAtF/IW9WOASql/ZqYYHsVkkTwWyhHfBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788879527; c=relaxed/simple;
	bh=W6X6dMjstlBgM13gtoik0Ioxdx4OL70s/v0VcbPBydo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=olLV4+fljQatxYrnQoaH7+b6/aTeP2XPSjzNgT5I9rBJ84GcVNHR7buSNuhTIKECN/S40UbCTu9BSDuxjUghQE/FnFVFyYmiI3gXYE8CzU/7dksZvOum5VATBNJa8O4mG37/MZiunVWPQ+LgUo+Irza9i20htf+vNNLr7z5p2ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17DD21F00A3A;
	Tue,  8 Sep 2026 14:58:42 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 08/10] PCI: dw-rockchip: Set broken L1SS resume flag
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260908-rockchip-pcie-system-suspend-v6-8-fbabcca9921b@collabora.com>
References: <20260908-rockchip-pcie-system-suspend-v6-0-fbabcca9921b@collabora.com>
 <20260908-rockchip-pcie-system-suspend-v6-8-fbabcca9921b@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 14:58:11 +0000
Message-Id: <20260908145842.17DD21F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Setup the broken_l1ss_resume flag, so that pci_suspend_retains_context()
> returns false on the Rockchip platform allowing PCIe peripheral device
> drivers to act upon.
>=20
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-rockchip-p=
cie-system-suspend-v6-0-fbabcca9921b@collabora.com?part=3D8

