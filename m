Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F3746A5FB;
	Mon,  7 Sep 2026 10:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788778657; cv=none; b=QPLvvtUQhKiXqxEV//HDDjWp3xlHMzD3uEbzua+/HkoNI7bvsL+nwRyBTVSxhhDG41C7y6T8PO9U3WH9D9O3a9xtxK2q8KPQl3eG7hJygSTCPSgTlx9Ym7w7Fnr+XOuC/OWbSemos8DG5RVopCAeYF4ZcCcFqTLQQOXDOsZdW+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788778657; c=relaxed/simple;
	bh=8Qkqdm0pwq4JI5CAHELlBVj2Ysrh6qiYppILxVJCXF8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ChoOo+Xj3xTlWSzaY61lQc9GYnXS4a3ImGBK8J/qJ/8oxpY+X514baGNNAFMka7HREfG1uQuZTfYjwPynzoMdzjTBjWV5/136XOugrNiyEpu0kpK/lBRG62Wvt2oaEfMTnzj4/xXNtyTIMPRhSPA5702lD1jDw0LWJTkjIIB8iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m84s5pF5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m84s5pF5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E0F71F00A3A;
	Mon,  7 Sep 2026 10:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788778656;
	bh=8Qkqdm0pwq4JI5CAHELlBVj2Ysrh6qiYppILxVJCXF8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m84s5pF5AJTah6snRyv073I7J8FZ4r0LfGSVkNkD6tgrH2Pl1g+fLXIUYHA7hbece
	 TAcIbeofMbx3YN5mSpzEHgDbb8szYxmO3UAwH9wHbOBlpvUeCpieosxUsGcLBxlHCZ
	 O52oiOAQeMOOgP33hx9sKLPjeJZigVMb6ubr8ouB08qWMHWmujyedAD+0SE+toXNoL
	 5b1mCbg2E6KYbVD+cLBCUqp70/TwrT7nktQ78dV0VfoFbkGpfk2Jo6Voe2L2vztCIr
	 3F5Y6p3d5LWgEakAOw0CV7xNJ4cmkQ6jlmrmX/MowAL/48mbAEOFj0SSGjVEJ/6TDd
	 iFaLQNQJfT8AA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/2] dmaengine: dw-edma: IP name corrected under its
 struct
Reply-To: sashiko-reviews@lists.linux.dev
To: "Devendra K Verma" <devverma@amd.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260907105453.1940646-3-devverma@amd.com>
References: <20260907105453.1940646-1-devverma@amd.com>
 <20260907105453.1940646-3-devverma@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 10:57:34 +0000
Message-Id: <20260907105735.8E0F71F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> For 'xilinx_cpm6_dma_data' struct which is CPM6 IP, the comment
> under this struct has typo and mentiones 'MDB' registers when
> it shall be 'CPM6' regisers.
>=20
> Signed-off-by: Devendra K Verma <devverma@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907105453.1940=
646-1-devverma@amd.com?part=3D2

