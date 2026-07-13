Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527C1224F3;
	Mon, 13 Jul 2026 17:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783962665; cv=none; b=oB8b9fcHq3suNkuHoz31ZECAk6LOp9hTZIy+geSL9jgHS7J4PWD7AL/+CqaHfl6SFJWzJK6L3Ohzru83PSUinmPUtxjmMCh4SAv6fkR9Ydow2wTHVV9HCBNtc36Jt7MlfFMFl7WE+ZNv0vj2Qf7Mhxz9JRv8f5s+6kcEvK8n9yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783962665; c=relaxed/simple;
	bh=R4JlLDqzxgeAj3Wxwl80y9vNfNFTHctZRC548npiXLg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ThLpx/ZTmYR9HmctsnZZPqpUqKur06Dn2jSTMNa3P5pE+pRVa1KswAmOTOhKnjcwpKgVWOt90i9a8ZKXPz7k3tjAXU2ly0CiGCTxt/q6Mk3AQfVplHbIhQOGlRR/PaHDwdaknutsaZ6lU4WY9m5DGvDtr8lfB099+Jqjik9Ati8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGq2F+SR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGq2F+SR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C67DE1F000E9;
	Mon, 13 Jul 2026 17:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783962664;
	bh=R4JlLDqzxgeAj3Wxwl80y9vNfNFTHctZRC548npiXLg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CGq2F+SRihrRb1iGY3wp/vm6k3hhKXizz7nBpQs/ECVLkAGonWqmzNq5B7GX9GjOS
	 J0VaAd/44x60+6j2Yn+FrjyzAJKbdokfnneTfcZpiy9X1YEeIhC9AcBtn+yPDnyRvH
	 pRUCusuVo7um/O2041T9RVWxELbdYv4bVpPmPNUpmVLZeLkKubBrTqpZqspZ7e+hhQ
	 q4qbLnPS0NPlxOkfKn4gpY3zh3sXFAS6YEx6It4qXPsXt+UOgVFrB/+eoN2b6uvXR8
	 c81DrPu80fzsWdaldzvxo2WLoX+YyNM8pj+c+gN7j0s6T1tteysMx6QSiA5qp2mR1M
	 lnROTocEtx+1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 03/10] dmaengine: dw-edma: Move ll_region from struct
 dw_edma_chunk to struct dw_edma_chan
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: dmaengine@vger.kernel.org, vkoul@kernel.org, imx@lists.linux.dev, Frank.Li@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260713-edma_ll-v7-3-6fb7498c901e@nxp.com>
References: <20260713-edma_ll-v7-0-6fb7498c901e@nxp.com>
 <20260713-edma_ll-v7-3-6fb7498c901e@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 17:11:03 +0000
Message-Id: <20260713171103.C67DE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Frank Li <Frank.Li@nxp.com>
>=20
> ll_region is identical for all chunks belonging to the same DMA channel,
> so there is no need to copy it into each chunk. Move ll_region to
> struct dw_edma_chan to avoid redundant copies.
>=20
> Tested-by: Koichiro Den <den@valinux.co.jp>
> Tested-By: Devendra Verma <devendra.verma@amd.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713-edma_ll-v7=
-0-6fb7498c901e@nxp.com?part=3D3

