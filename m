Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73D244781E
	for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2026 07:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792136908; cv=none; b=PmOTrxud0aNn1aiJg/5oju4gNUwgpoHI2a9rnWB1tJ6NOzsoc1DLS6Thgxs2WuDAqVm2Bo1+5eYjH8j/SwOn1/26iXik5IiskjGAS7xbIy2l72Adb90GcnIvrVDLdjmL5B9CFNecvEv6f6z4G6efVGJOtB2xv8CEns+oQQnG8FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792136908; c=relaxed/simple;
	bh=hpmSW5vz7bMQHHWdfJ2FH8KqSsMIjhXpyI9edh4jKoM=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=i91JF0oHldYqXIdLSe8ZwOsKUMZiYNxrxxxFatKwr8OinW8lkeLTcFJrv2z2Wb4I4luMTmkY0AOgjWxsDLJ21GlFSv8BTcI5FQeJzToK1DbLCGlJLKa4zCDE2VdvWGO1dU0uKC11jc5kiTt9aNWwD3TtlE5rpeImTHvYeu8tf+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFLHDnsy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFLHDnsy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E911F000C4;
	Fri, 16 Oct 2026 07:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792136904;
	bh=hpmSW5vz7bMQHHWdfJ2FH8KqSsMIjhXpyI9edh4jKoM=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=nFLHDnsysOu6a6l5VoqF+PrSoccOknf/hbQa5MAniX3QRYkEXfFjq1e1yAoLN23Wd
	 8t4b5pskCR9KGqWBg43j9oxpoPJSzYd6pOCsbhqa9lzeVI/0ZRMnBY+d8guv+OSPBM
	 A5f9l280sGNAFeQ49KMLCaiq0UKdZWeHU+YNCKPhXkn/q7ZK4vnBsfGUd5MyZirbVk
	 F72Qqwoiqdd1GsfZ3r8fnsqkLY6u6pEs01NHrzM5vBxkhqRTdvbkYUKY9yOxBax1Sw
	 Zc+R1Y86vg7EF03PN6b4sTA8fxpX/LinEC4lPLxDzrzfak9deHOWZcpwqJWYuKNY9M
	 E18Y6ZFZvTAOw==
Message-ID: <sashiko-outbox-173965@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/5] PCI: tegra194: Use standard RAS event selector
 mask
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manikanta Maddireddy" <mmaddireddy@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261016074026.564302-5-mmaddireddy@nvidia.com>
References: <20261016074026.564302-1-mmaddireddy@nvidia.com>
 <20261016074026.564302-5-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 07:48:23 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Use the common DesignWare EVENT_COUNTER_EVENT_SEL_MASK name after the
> complete RAS-DES event selector field mask has replaced the old narrow
> value mask.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016074026.5643=
02-1-mmaddireddy@nvidia.com?part=3D4

