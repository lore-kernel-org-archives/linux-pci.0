Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AAC3ACA74
	for <linux-pci@vger.kernel.org>; Mon,  6 Jul 2026 03:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783307099; cv=none; b=BbyzhrEfNUtXrcMe4+OWwjnshcOArVrs5/GInklwAvyQRuwN0g/m+gXd09ghri0tyWI5rJ7/6rRSWD1NBvqDsVG6jGUa5nL+yysS+01N1KsFv5ttjVO9GnTx3CGiQceDGLMdTyNGwQULAV1Uhy80c6Oh9kPuQVodiNEV8c6Y4EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783307099; c=relaxed/simple;
	bh=dct+VDgVDM/xeD8BDbgzTaXfHOfkBFEB4mH/ezZNyzw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=auZmvL/90J9j112EQxqitPwZNp8zB0no8FpNFyV6MFoIwqzh7AfHnuwBs5HP/6yGN+XJoEXKIXUdyL6bZkxY6RvHCu6+5cTkxqA9vx5nBkq+AdgOJ3Dez72WVS9TTQkNlvo5p0H12xEY910jS6ITIiRPfEJcM8SPB/s6TZqr0m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqGJUic5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqGJUic5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37CFD1F000E9;
	Mon,  6 Jul 2026 03:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783307095;
	bh=r8+xCET5oDDa7DL1iZxykaEb3Laf9s4sg51AXgbykrQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mqGJUic5MC/HFmVBwfVHdWp4UZRviqgnknIfqNtO7n5MIvW2KqjvznME8dF5HVifi
	 /jC2b/M3QMMWUIuxTEQHabXSnTOiR5UFoFOAFhLLliz7HYlIzxvxKAycowatUiD0Al
	 wmUxFw/wn273qERv61py1l7S09xM7o7Gdx0Qw+5xWh1S3CewGGxUBqpv5RkzacXaSS
	 7Q/4O52R5FBONPBSHdPS1NCzxsxfMnfvKaNtOCJVRT/lGUSPxbMwKruoSNphyx+b7O
	 JYlO1IFs0lVtq0bgsueNs4JyhftBsBWe+EJOUzqEoXa73eNd9XWu+SNcmZ8kyvKFNj
	 OqGbczyS7013w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] PCI: Disable ASPM L0s for Realtek RTS525A
Reply-To: sashiko-reviews@lists.linux.dev
To: "Max Lee" <max.lee@canonical.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260706025358.516607-1-max.lee@canonical.com>
References: <20260610024723.188514-1-max.lee@canonical.com>
 <20260706025358.516607-1-max.lee@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 03:04:54 +0000
Message-Id: <20260706030455.37CFD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The Realtek RTS525A PCIe card reader reports an AER Correctable Replay
> Timer Timeout storm when ASPM L0s is enabled on its link.  On an affected
> HP ZBook Power 16 inch G11, the Root Port received tens of millions of
> AER interrupts from the RTS525A even when the rtsx_pci driver was
> blacklisted and the endpoint was not enabled by a driver.
>=20
> Testing with OS-native AER control showed that disabling only L0s on the
> RTS525A link stops new AER interrupt and counter growth while leaving L1
> enabled.  Disabling L1, L1 substates, or Clock PM alone did not stop the
> storm.
>=20
> Prevent the broken L0s configuration by removing L0s from the RTS525A
> advertised ASPM capability.  This avoids enabling the non-working ASPM
> state instead of masking the resulting AER Replay Timer Timeout reports.
>=20
> Signed-off-by: Max Lee <max.lee@canonical.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706025358.5166=
07-1-max.lee@canonical.com?part=3D1

