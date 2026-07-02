Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD422C0268;
	Thu,  2 Jul 2026 15:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783007567; cv=none; b=reW4K5uDHQ5dpwtOiEEGLgxpVecSi/iHgUJrcgrMxY8YCDN3ZsVT9Y8ac7wwEG9ctCZ9D0+peGpmoSCj/gH31e9Jjjmuc3UpdabPboN54zCBs5eUWNRJr+j5LXIDbcUqxzvEVV2OFaogDIEWP5RjH9h9BlGQlJAqAg2/4IytA5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783007567; c=relaxed/simple;
	bh=Pq04jR7r5xIm4PQlrwNdhdQS36HbHfIAAI9OOBmdFtQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=et0gTPBOKIG99hQLweYVlBeAJLkYCWuKNWg0BOHE9/UiIvn/THjboTyp43fazlh7llyo4vJB3CD4OhkjLJQj5YfWjXGz9QoXfdStibkCegHWMwhYvC85nno0YPR0nklLakvGZICXILSs8G9wAiYyIWxJWIId9tZT8hDJQU2h6d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N37lXu9x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N37lXu9x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 248051F000E9;
	Thu,  2 Jul 2026 15:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783007566;
	bh=Pq04jR7r5xIm4PQlrwNdhdQS36HbHfIAAI9OOBmdFtQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N37lXu9xu6CZ1LUGdjWK/6bD+pRuDTv+8tv8+SFyraXT0xAfogP2KYOJOv9vtFsmh
	 l22rlUYILQe4i3sGdtRPfER8NiCC+7NiMDIoTGAhAU9DVzmGQ/U4QNJAR+mfCDVvgC
	 ZDCZ3ez67Rdz04FQaZ/brNmr6AjSbnR4a/ffWbubO431NHhEfklcofJMLeQuw+kqYw
	 CNyFIJMJOZ86A6U0joxCRyUsKkGQvavxA6+1mtxc7fJFXmh1ApBb4eo1WL1DWwJLg7
	 YxMmiW6RfFBOIUJqSHIj1FweyhBIOGXJGw+rDAjyUDuwAcZbYdAkaXEZAXgqlZgvLZ
	 fNKWiOdsKRn5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/11] hwtracing: hisi_ptt: Use sysfs_emit() for
 cpumask show
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yury Norov" <ynorov@nvidia.com>
Cc: linux-perf-users@vger.kernel.org, imx@lists.linux.dev, neil.armstrong@linaro.org, linux-cxl@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260702154725.185376-8-ynorov@nvidia.com>
References: <20260702154725.185376-1-ynorov@nvidia.com>
 <20260702154725.185376-8-ynorov@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 15:52:45 +0000
Message-Id: <20260702155246.248051F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> cpumask_show() is a sysfs show callback. Use sysfs_emit() and
> cpumask_pr_args() to emit the mask.
>=20
> This prepares for removing cpumap_print_to_pagebuf().
>=20
> Signed-off-by: Yury Norov <ynorov@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702154725.1853=
76-1-ynorov@nvidia.com?part=3D7

