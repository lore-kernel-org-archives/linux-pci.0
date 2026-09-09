Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E697E1397;
	Wed,  9 Sep 2026 08:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788941746; cv=none; b=Xz97RQjwP4P3BbZGO1ZBCWdEmS68sZLdM1nVOiMUesMXpRNlC/90qK71f6mqlpakKjytPDmWB3QFCqzsdB/N/4yLDlzBDz6vtLfKKnQPq4bPZ/9MGqYMQrahNIPGzhQVOnWCRANEdZGqW6cf/bX+SC0OwhPiNmrD3OQIKiMpMbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788941746; c=relaxed/simple;
	bh=a1lhgt9CISj5Ul6rBE1QU6mQFvRhbKT8F3/qagXqNvI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J3ofdKV4lujIAXG908NY1lT7M0RSU9fs2am1ptcQ3Mm4WNsnkBzc+lHrkgCN+5Y5UjbTe5PTii9TiW3mMoB7wOJgDGXXhBORlMI1qCwtvO11jrkfwkOn6duo3oEXgPPNFzeKyRWbD/3e2qQF0cfjYOpHx9UtI/Zw5J5c4LSz73E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KvZ5CODe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KvZ5CODe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E8E31F00A3D;
	Wed,  9 Sep 2026 08:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788941744;
	bh=xPvH5rJOmjE4p401wK4Cw3yq/Drn/8Elzs7NVYwlfC4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KvZ5CODe8JS8Lm6J0CyQ23mzAElSw2KMfTADWMdCEsAIUvV2r+fwYEdhMvystWGx1
	 0uBnUwgDlHd6aymNk0QhDm7dauyARm3sf8N/8/wiO0A72kkMeeSeqwnFpC2axYAFJ9
	 EqH9PJd13MvyT3evTi+KOLp9vV9YWLTzHVU/TlAqqIFJPnCfS7tn3wVHFyWgEAD+v2
	 P98023JMBNunCwwxmw6mGVuY1g5z6D0WQPNG5iyiBTYgk6vMISctHsna9Tx6SekAtS
	 Tura4Kq2Ak175/fkuARaKC/Yl9JlW/0KDd9KlD5QqXmmFcTdbCmJC7teXw3IKtv/yN
	 aRfTJdCfD21xA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 09/10] PCI: of: Remove fwnode_dev_initialized() call
 for a PCI root bridge node
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260909080114.591938-10-herve.codina@bootlin.com>
References: <20260909080114.591938-1-herve.codina@bootlin.com>
 <20260909080114.591938-10-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 08:15:44 +0000
Message-Id: <20260909081544.7E8E31F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> During the instantiation of devices described by a device-tree overlay
> applied on a PCI device, devlink displays the following kind of debug
> messages instead of creating the expected links:
>    'Not linking xxxx - might never become dev'
>=20
> Without those expected links, the device removal order cannot be
> correct.
>=20
> Those debug traces are printed by fw_devlink_create_devlink(). In our
> use case, they are all printed because the supplier of the link has at
> least one of its ancestor with its fwnode flag FWNODE_FLAG_INITIALIZED
> set.
>=20
> The culprit ancestor is the PCI root bridge.
>=20
> [ ... ]
> are correctly created.
>=20
> Fixes: 1f340724419e ("PCI: of: Create device tree PCI host bridge node")
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909080114.5919=
38-1-herve.codina@bootlin.com?part=3D9

