Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00963AB285;
	Thu,  1 Oct 2026 14:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790865250; cv=none; b=Rt4FgXms0DkrVd+F7+gvgJWJKP45uwG6aM3PiTFd0cIbba7M2HddI02Uz1ip+HdDKELHSs+MMgKp1tn9N6R4U7lHj5K/gO+FL1GAEF6cAGA8JpSjKThm/wj2y2Lrt7knybzlcl/YbqLt+zMwg/qXB6UbLNFujdaIgS8stZrDXN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790865250; c=relaxed/simple;
	bh=QWWBe2OCxkIJeZ7Tj1wApfXFQwzVg81Rrvvic2te2WQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WG8Ggv+srU0EyUBBR/oYAc6qRRMibR/r0tWbUzBUWuJ5qDMuBxjFIsin90E1JysA8dqZf1+ksXiGVYL0QmqEA5my8nr9Xh+fvN7hb6PjDeOGts7BAQ6DUbIVBnJZ27J4DlvY5cf87nOVYY/DthaQ1xHaiZBwnlx5lHF0gkUDOws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6jS/BEt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6jS/BEt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997591F000FF;
	Thu,  1 Oct 2026 14:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790865243;
	bh=QWWBe2OCxkIJeZ7Tj1wApfXFQwzVg81Rrvvic2te2WQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f6jS/BEt8SySkeje8zG/MXW36J0BP/0z7Y5Y2TtGX+/bZkb9jSb0p3Yu7zCzlZqr6
	 kgM5ZlEQJ4KPstTuHLyp55rnW8RCbyiYqkWkBsH0VemZxaqCUtA/Ksno7kqRAbd3t2
	 9Bq+RpBAoqerxcZs/XHpIzPRXWaFl8oWUyJNV7nZvrpuviZdDNtDIySC36wPDuHEBc
	 o9mq7eTf5Xl7UzUGUSqxZO+frsxZtDCF1hk+nT2NYpuQQ+WURhUP5riOuDAHK5HUfi
	 oPxLuASHs6IGTto0HagFUOwrVgeafZRTl0BBTeZXmre+NwbcEGL153hqaSqwdrClfm
	 gr0hx6He6mhuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 02/10] drivers: core: Use fw_devlink_set_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261001142815.277550-3-herve.codina@bootlin.com>
References: <20261001142815.277550-1-herve.codina@bootlin.com>
 <20261001142815.277550-3-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 14:34:03 +0000
Message-Id: <20261001143403.997591F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The code set directly fwnode->dev field.
>=20
> Use the dedicated fw_devlink_set_device() helper to perform this
> operation.
>=20
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001142815.2775=
50-1-herve.codina@bootlin.com?part=3D2

