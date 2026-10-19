Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF244F85AD
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 14:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792419648; cv=none; b=Cl5r8aI3nXqOVYyoboHuUQ72cpEuKissWy4sXqwi4/ZII5151I9cqlf6+eArVZdqhc4wJGjBcWAjbCvmJjXmlW6wdCLFtzlke8r0SgsvY5CdNgyD1N6xgafig03gp1oJysKjeWErIcU6wpw4g/KMgf4f2dfjwfaGZbeOdCuNesA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792419648; c=relaxed/simple;
	bh=2aHSiSNZSj50GV219NkfX6S59WqMZ02jPI0Ei5yDIsw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=sJgyVPyXJCZGxcFwtGEmFngslDamCxoN1+GiO94ihE2rkUpYdr0HzRb7dq8ySpvsPhjXChjFY4yssYGGypZ09vFUCJZm7R/oxAuI3gKN9h7UNqKy/WkyK14SDKYBINpLxM2ZFq5R/uQfBNxaVAifCJbQgvp0wgEbdByJkaOWlwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGW+4DEJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGW+4DEJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F8F21F000C4;
	Mon, 19 Oct 2026 14:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792419647;
	bh=2aHSiSNZSj50GV219NkfX6S59WqMZ02jPI0Ei5yDIsw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YGW+4DEJbbtEbE66A3xLAy5S9TFfi2QUAR3ZGBb4d5Wd8mK0IUA293ZYU4EMKJJF5
	 A5u1971Uvi1tEK3uwT578/1DyE9ZxVlxJCHbr0007aZlGuCN6B2OmhRUXK17e+fAnH
	 76jqeWOj6H4palYW6T0kKWqcYAxi6lEDJTGLpcROAQ3Hnzah9/IY829fPo94HHoRVg
	 4T/zmr5wN3QzOtbBqjIdeXwj14ZgdEAatmH0lXN4ssyGELilaMCuBNmW3wU4NrA3NN
	 ufN1BmvUvC9OMOZoi70Mb+M2Yl/T9pC7869GrIVf0Fl9Y7eOI6UFjVUpCGYI4pJIav
	 Y9zTwTzpF+hGA==
Message-ID: <sashiko-outbox-177353@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18] PCI: vmd: Add Nova Lake (NVL) and Dunlow
 (DNL) Device IDs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261019135441.1420968-115-sashal@kernel.org>
References: <20261019135441.1420968-1-sashal@kernel.org>
 <20261019135441.1420968-115-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 14:20:46 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Szymon Durawa <szymon.durawa@linux.intel.com>
>=20
> [ Upstream commit 55aa45154fe48b7d8e96bc031ad27d5b0edfcdb8 ]
>=20
> Add VMD Device ID Support for Intel NVL/DNL processors.
>=20
> Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Nirmal Patel <nirmal.patel@linux.intel.com>
> Cc: Jonathan Derrick <jonathan.derrick@linux.dev>
> Link: https://patch.msgid.link/20260819130523.398493-1-szymon.durawa@linu=
x.intel.com
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019135441.1420=
968-115-sashal@kernel.org?part=3D1

