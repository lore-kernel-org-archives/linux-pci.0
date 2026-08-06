Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE2B3D9551
	for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2026 11:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786015769; cv=none; b=j+UnLX6SMRy7YrDpoyWXXY36BDWNkJ153Z8IYwgNRidEHq8vAH0E3hTnYSE/2R5YP7OaRPp1d2aDwfLf0Cyv7dcxbQtbolmD3sPsmuoU5YNJ5mhFQz+/hJWVnq40Liu5+RaYccst/SVy/5KbzhLvCHxr8VZW6g+KBrg7wilgp94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786015769; c=relaxed/simple;
	bh=GbrEKUwUFkkFyYHhRga3ArGkAPSdkj1/Uqgup4yA8qY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WBEe+obg4nm7L3amG4TsOJmGchVtFDh8nMQ6+Q3hCS4+7SdWNtdie57Sz+TCq9KMh8nlfh0QbSER0+sGHgIMF5YRrvonJFRkLo2qDajbNFS9fKcw5I3QoOpxKETGXLm09FgZh8pvalfKE1g8JIX6yhjFG3mIT4E44MMEb9TvH6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KjQOqHZS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KjQOqHZS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61FE51F00A3A;
	Thu,  6 Aug 2026 11:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786015767;
	bh=GbrEKUwUFkkFyYHhRga3ArGkAPSdkj1/Uqgup4yA8qY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KjQOqHZSebXWMl/IHyGluQ9/b6Xy4wOq8dwGC/hCZ6XaSjom3gV64CNgHJIgwFS4b
	 6WdNPxxRA5br0nszFtVtQd6cibx/Mlxiw1xubAgaynhOBwvhhz3qNhls6FMc4qPdkC
	 gXh9CBhykkLo7UIP8w/iWOMeIFGJlnCUO3qrZ20LqTy4x37zXcEr9JnP5pmMtQqgSd
	 NCs9Lx6347t/ofoHrvUlCfDO087jxdGqspoRPVVYDcF6TI1BOypuom6ZcKaiEtdAvC
	 ekV1Zgb50jllHKoyG6Z0scReZBnbo44v+rYEhFDXLE//xZalMqRy5Ti03K1WSwq9Qk
	 fO48oQmXzeXhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/13] PCI/P2PDMA: Document ACS egress control
 handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260806-fix-p2p-acs-v2-9-0cec14812965@nvidia.com>
References: <20260806-fix-p2p-acs-v2-0-0cec14812965@nvidia.com>
 <20260806-fix-p2p-acs-v2-9-0cec14812965@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 11:29:26 +0000
Message-Id: <20260806112927.61FE51F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> Document the ACS P2P Egress Control outcomes used by P2PDMA: a clear
> target vector bit permits direct routing, a set bit with Request Redirect
> enabled sends the request upstream, and a set bit with Request Redirect
> disabled causes an ACS Violation that P2PDMA rejects.
>=20
> Also record that pci=3Ddisable_acs_redir=3D clears P2P Request Redirect,
> Completion Redirect, and Egress Control.
>=20
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806-fix-p2p-ac=
s-v2-0-0cec14812965@nvidia.com?part=3D9

