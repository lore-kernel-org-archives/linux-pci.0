Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2384DDB38;
	Thu,  1 Oct 2026 09:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790846712; cv=none; b=rknJY9XcAco5s93LnkVXE02i79nFBg9F7zJke9ubAR7vX5G7bkDcvy/IjOZEmfq/uOgeKHFmJCH5ybYha0lE6l8f0vO24Wt7msTGNqKrL0KXlwVAzLBbAPCofeMzAuS2hzOac0UxNGosjpP3vWMmNborWcBIf3sj7K63mzCrOJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790846712; c=relaxed/simple;
	bh=1cmkeL6NNqSgDV9cXsHb1H02x6Uxg17ndW/ZvVxWnqo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S5srm1aIU047X1WCB3wlMzDJUf8WhPL1JIr6ZjZiWKARMlh2g+CvbKNu7IDTBkmZTSwTLvgkM02oQxybwrbJBHOcEElzbl3VFgxBMfAA50JLqecHjM5H7Te6+Ww5d78jLbnQAJjqy7bW5+O2YNCUCEhO6DGV/P8ZOZEEiHCDp28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JrssmaCU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JrssmaCU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0E541F000FF;
	Thu,  1 Oct 2026 09:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790846711;
	bh=1cmkeL6NNqSgDV9cXsHb1H02x6Uxg17ndW/ZvVxWnqo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JrssmaCUovQI67qqQDtP0JIA9OFHIbiaYypjWEC9Yg3BORODawSRaW7OC0GEUVHFF
	 U5Mq3ndagRDzSrlk1yPNYE2BoJ1bYuOskqgqhjNg7FoZ6aWPVRr1fl350osKdrmK3F
	 lTcJaTWz1TK3nFTkYaoiEcpODXyAAAzn0wsQnuG6o1Ag0BasVU0nLEpFYiBX3IDEFU
	 u/aNmYsI4KLsT5uoq/dpzZhSwYwd//C71t72IJFG4pq9EpDFfYsRAiSWBowaoUXV6a
	 SARIkVM9yHdTspwcDuio6Wc/sCe5RBePS2bn+p3cnbP7Vcq5j0t72GxcsYgenJB5Eu
	 UfatXjkcDQkLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 01/16] cxl: Drop stale decoder interleave limit
 comment
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261001092227.3004747-2-smadhavan@nvidia.com>
References: <20261001092227.3004747-1-smadhavan@nvidia.com>
 <20261001092227.3004747-2-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 09:25:10 +0000
Message-Id: <20261001092510.C0E541F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> CXL 2.0 added 16-way memory interleaving, making the comment that the
> specification supports only 8-way interleaving stale. Remove the comment
> without changing CXL_DECODER_MAX_INTERLEAVE.
>=20
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Link: https://lore.kernel.org/linux-cxl/20260912003057.3db9335c@jic23-hla=
ptop/
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001092227.3004=
747-1-smadhavan@nvidia.com?part=3D1

