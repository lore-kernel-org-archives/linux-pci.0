Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2E9402BA9
	for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2026 23:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790724604; cv=none; b=MZP1OGlrlfYO3bGOBjWvqhGT2vA2s3qvJX/l1BJJe/uumuPzfRHe+EqCA4hxF09q73rBTBgGlErg7vXa2A/2vWYZ6rpVejVfMe2ee9IoLl24Q7ZQIAxQbr3SBUP2J3jwxO6U8ttJEYCInvhYXV6wevYi/spx3+Qw0vve48GhcPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790724604; c=relaxed/simple;
	bh=2wQyifMNAaHJ+DPeISLgbJw63qtkgb6WhJ8zP634KBQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rBksNBag1M2FV5SSpWz1i/hECiVPkWp7KK4S+rqX8SL95fV5xnYgfpwkgE1spMVfcpncC3n8gCoYsyeLkTfHxHiMTeVrV7SJyedN+4sLkFedTxXJWT4jlpWg+FWc/SKIInBdu+vuY3FkZqrvvAzBFeS0jQj3OPkXsIdf9RRrs0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eTDSS/94; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eTDSS/94"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E4A1F000FF;
	Tue, 29 Sep 2026 23:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790724602;
	bh=2wQyifMNAaHJ+DPeISLgbJw63qtkgb6WhJ8zP634KBQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eTDSS/94H65uOfVBo5ve6LoF7k+whOq8JcPeIgL3hhJJcx8CTGURzPKL0hoMEVcs/
	 +jR1eYd/ni1IZ4hEExmL1EO9PxNdZ4EWtGqI06s4x2OuwU09+eD+vIqkGndvSr6sqx
	 IMPnWhtAGVX09FOgw7pxdKUjf2PAP3kJiXVMK2MW1elcm1sHH/QyUBVD84wh8dxVtW
	 0FEd6ChPZrF6cmJjVG2rAvyPZUL1ersUnYw2hpAfFREladuThRvyAJ+ANHaKGsD6V7
	 0G4l+0xP5FIg0Ou58nxHYGsgVbWQBma/QjPfi94iqiw9U3ZUYHqI+sxUuWIVmP519j
	 sg3Fjf0ERWMjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] coco/tsm: Update maintainership
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jason Gunthorpe" <jgg@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <0-v1-52697321555d+14e66-tsm_maintainer_jgg@nvidia.com>
References: <0-v1-52697321555d+14e66-tsm_maintainer_jgg@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 23:30:01 +0000
Message-Id: <20260929233002.74E4A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> With Dan's passing Aneesh and Jason have volunteered to take this on, with
> the support of their employers.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/0-v1-52697321555d+1=
4e66-tsm_maintainer_jgg@nvidia.com?part=3D1

