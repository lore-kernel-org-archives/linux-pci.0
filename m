Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09383E764C
	for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2026 04:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790656311; cv=none; b=OHkTI/H2K+FoAGlBKk0TnnfvSSg2IdmJBYQhILr1YUFcAtfg/RXmVQvTf83Tyfe8LSRCnliSbb6tBx2ov3p3zimUYFbh1d7A2npv6UXIC3oK6tOhjRqb7U0mj/BWMbpiXK2hXpZQ62nUsAuZR4o8R0EDYgBEgBelK0WPGbow0CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790656311; c=relaxed/simple;
	bh=JBqCEy912ESQwoBLiD8WO335b6Dn5FR6W1kXjAGR04c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lCJtv/LYGhd2J/4Zwh1g0Ehubij1L9ha89iHnzrIjrPimn3y5APrAoQpAvwEdoOlHLf/lzSaK6Ng8qsxg5Ys1GiB78oZwsyfiQb+3d/nobeGsDY/RzAwFewpDwwfILGqA6/gZQPitKLlEtVX0rcHUyuld/gqs/qm1KCZo3cRJ/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ev+qesOQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ev+qesOQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 568541F000FF;
	Tue, 29 Sep 2026 04:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790656309;
	bh=JBqCEy912ESQwoBLiD8WO335b6Dn5FR6W1kXjAGR04c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ev+qesOQAv9ScWH7APqHIBuOtXOxSfGBym7xm/mccX0T3n/lvPk4j5K7swJWK2ZAr
	 0AS+lZdWMYmv+mY/bDDxoMtuhFuYFPwvt950AqRFTpl4Ii+hEPveOIOl5ej4G574u1
	 6wyqQd88KZB/ge5y914s4qFZho2nC5pYIMt3Ty0VrBKp6gzwAQrPJNkeOWODpIEST/
	 ayQHSy5dlE8EsMTX3AIWXn+6eraegwU3JZZ6qcZVoTKxYEc6mJZZdKJpibKLni5UUQ
	 082BfbXelO1osp5xt1QgoQLaxDgDv5Sz8f9g++fWqtIlRNoYzApJGEPyhkIK2HgSv5
	 j289EAkNJdm7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 05/16] iommu/arm-smmu-v3: Add a helper to drain cmd
 queues
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260929034510.2023173-6-praan@google.com>
References: <20260929034510.2023173-1-praan@google.com>
 <20260929034510.2023173-6-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 04:31:48 +0000
Message-Id: <20260929043149.568541F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Before we suspend SMMU, we want to ensure that all commands (especially
> ATC_INV) have been flushed by the CMDQ, i.e. the CMDQs are empty.
> Add arm_smmu_drain_cmdqs() that drains the command queue using the
> arm_smmu_drain_queue() helper.
>=20
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929034510.2023=
173-1-praan@google.com?part=3D5

