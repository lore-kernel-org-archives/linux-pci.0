Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B6E340281;
	Mon, 13 Jul 2026 17:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783962617; cv=none; b=oMc6LYm7PM4VGIxQt7mcuZi9w5J8922wbUYSrQmOGp2LgEQ0aKTGgUBuesIxD6lXf/p7u/dDx27HrFxWAOP183NVEkY1t/N425UGs12gOrJQFmkrpVBGxxKax4K53cA66tULknr9h3XlB9GCIhZAmdZkZx6nsrIE/bwOY3D0AJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783962617; c=relaxed/simple;
	bh=TVbMNwW7iJfNjR9gOJQk5nDFVvJswloSv+iZEN9uFtE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ju/uhlUYgpm2rlS0/ltpAMHUdlwOATn4BDsqXH3z3SfLZcKiEQhmgWJu8eOmprFFFUdODRLgDNxI15wBXLzORQ4fdetm7mi2AhCpMXWQGoDuMFzEzKuG9qk5u/oQ0Zq/tHb3BlsjuTLoqbjxa7Rf525VGEtjUZ3SNo4YPyqknN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IwtdO9Bs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwtdO9Bs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7FB31F000E9;
	Mon, 13 Jul 2026 17:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783962616;
	bh=TVbMNwW7iJfNjR9gOJQk5nDFVvJswloSv+iZEN9uFtE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IwtdO9Bs2PsJ+JUf9nvmqcigP90Qk68oQUsacn2i3Lp4UpJB6/yd+P0TeIl4/ocA3
	 dE1p381UKkiKbin+t4AjzSKhbtv/rDV2qgPsl3SAgztZykL1ZNVv3JLOclZNqNr2p5
	 J9YAlwDoLywkYDuoRZUvrtLEoyCCtQmojXvTiamFEEv9Z+vPBoLDIEq6EtWqkrvUt/
	 usUpx0oiIgYiGOEXS9P7ST20K7l/bkfYNus5cIhy2Rc7S8UILWc5g4CGvzssHGQHhs
	 4Bcevg0sTRLZo4d+uKEptRwhzAB9X4fFoQiKkNuIFJDDFWoUGICfJspPiMzek4purj
	 dLhBOuN4NdNwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 04/10] dmaengine: dw-edma: Pass down dw_edma_chan to
 reduce one level of indirection
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: Frank.Li@kernel.org, imx@lists.linux.dev, linux-pci@vger.kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260713-edma_ll-v7-4-6fb7498c901e@nxp.com>
References: <20260713-edma_ll-v7-0-6fb7498c901e@nxp.com>
 <20260713-edma_ll-v7-4-6fb7498c901e@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 17:10:15 +0000
Message-Id: <20260713171015.C7FB31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Frank Li <Frank.Li@nxp.com>
>=20
> Some helper functions do not use any information from dw_edma_chunk, so
> passing a dw_edma_chan pointer directly avoids an unnecessary level of
> pointer dereferencing and simplifies data access.
>=20
> Tested-by: Koichiro Den <den@valinux.co.jp>
> Tested-By: Devendra Verma <devendra.verma@amd.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713-edma_ll-v7=
-0-6fb7498c901e@nxp.com?part=3D4

