Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADBA153BE9;
	Fri, 10 Jul 2026 16:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783702608; cv=none; b=grwYO6JSobCMorL4ik8guFufHLAZ/vNCu/SeEE0Xwc45l88R2lyua5nLvtjDVoX1M4K2LNXT/GSqd+/TVMzh0E+JHLlObCZ9TgXERbJ67wdyYvBzBtoHe06FEncn0rSo6Wx3ypDDEf2nmE22k3T3Ft9Qiyy8iXUemg3XK2fvxnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783702608; c=relaxed/simple;
	bh=2HTfP0sK3d3rKA3xYarhZYjpCPp/waa7ghFixUdcvGs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ugJ6jAATYVWBXg5q4fAGPC6u9r5n1jqa8n0fKee/LQea4a/aMW7nsVqmxy4up/3+MIyhKyyAJ1KxCdYQa2CtXPNXL/bylfqzmI4Ecqz9ntnxRCFibnqz7doZ+iAgMNissy0RahRZL5ac15Oz4llYg8MzJAqgUdsoNzHAswCk3wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmofAJ68; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmofAJ68"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B160F1F000E9;
	Fri, 10 Jul 2026 16:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783702607;
	bh=2HTfP0sK3d3rKA3xYarhZYjpCPp/waa7ghFixUdcvGs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dmofAJ68qW1/S0QwR7HpqKaKJQ2Vp2iu8aSLw+FuoX4+c7UGKcBuixXx7t+aDF9QJ
	 pAWMalXO1Vh5QiCbqgcfq/sfImm2OflHkAolXIk8+5Is7ZQg52TLb3Kd/0N9nIAHix
	 V1Y2CjjH5Z6eg7q0naLPspf1Fhg6dECK+ip8AzHbAVa3blwGFFi8FdK9uW5hkeE0hI
	 9M+fUikPzvMv9uDh6wbiK1j7UEVg+hj3ftQS3bZhOEOrAnN/cu0gDlH0dkj4G7diW4
	 w+KxRDAOw3SzN5pDwCdYs+aJ4LZl6O6chl6qQgJGpWaxQuJAi1xxJhrZqX9L6/1GJG
	 Byw1XCc8k2SUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 02/10] dmaengine: dw-edma: Add xfer_sz field to
 struct dw_edma_chunk
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev
In-Reply-To: <20260710-edma_ll-v6-2-1471d278b73a@nxp.com>
References: <20260710-edma_ll-v6-0-1471d278b73a@nxp.com>
 <20260710-edma_ll-v6-2-1471d278b73a@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 16:56:46 +0000
Message-Id: <20260710165646.B160F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Frank Li <Frank.Li@nxp.com>
>=20
> Reusing ll_region.sz as the transfer size is misleading because
> ll_region.sz represents the memory size of the EDMA link list, not the
> amount of data to be transferred.
>=20
> Add a new xfer_sz field to explicitly indicate the total transfer size
> of a chunk.
>=20
> Tested-by: Koichiro Den <den@valinux.co.jp>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710-edma_ll-v6=
-0-1471d278b73a@nxp.com?part=3D2

