Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31C14534B7
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 06:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792393023; cv=none; b=ogNC+/2avaPpKunfhCChEprclnWsLlh1AJxImKnU1IcQyGJnAvkXaCr/184R1yV7yuw62r4MtqX5ygu97VSjh/TcL1y2kBnUKgaa8rD7iuushL8HO67iKPCdTN73Q9B/1c+t1m0GwkOBYLf3vd7tBPmilipPyXc1PajS4EPYP1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792393023; c=relaxed/simple;
	bh=Tu4D7nUvJYlMvxbWri9RY3T85+4xhRWkC1rUSKgSP1s=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=LIsz7Rxe2+3ImhKrpoKLMJasJJaEpkOO8f6WJ6NAk8bFjeu2xnYenzRHjc1blwE7aaEhsIZu0QxqLrkxMBctlVFvczdEqCcfbrc9h3fckCvBk2XJSaEm8uOenFW7yskL5GNe1R/OhVtzXbM5FhttmfsWSmc295Mhpzjmr7Bb5xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fu9Nd14r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fu9Nd14r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EEBA1F000C5;
	Mon, 19 Oct 2026 06:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792393022;
	bh=Tu4D7nUvJYlMvxbWri9RY3T85+4xhRWkC1rUSKgSP1s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fu9Nd14rrBYZfLlM07oYyhucGUVX8iCCpBO/mR6QyQRFqnOHJEWZQ9cWWrYhXVr7b
	 HMyY4WaHXPYzbvvbTvE3grvmigT7X0VvtYtH/gGCTyRd/1w2JgpmIpxQO70eVboRh1
	 ubxulCqi46ju7bhzdeEOF6YFaDU+d5JFdx//6uGiYs80pm3G/QWYtesdIJ7aLoni8/
	 cDWUZJRp39/2w+poSvM4bMcFIeWh38gmoUxvZBi2WcEzLcc/0iXBBs0RAZFFVsGDzy
	 wyA2AWSJwFnwMizlyi+vowly6Ry1G7qnKrXSHq5a0oQj/rlvUDJxV3EcUtQnPnAFCN
	 TJma/3RaPx6HQ==
Message-ID: <sashiko-outbox-176721@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 10/14] PCI: rzg3s-host: Move suspend/resume code into
 dedicated functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261019065025.2146539-11-claudiu.beznea@kernel.org>
References: <20261019065025.2146539-1-claudiu.beznea@kernel.org>
 <20261019065025.2146539-11-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 06:57:01 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> In preparation for implementing hotplug using
> pci_host_bridge::reset_root_port(), move the suspend/resume code into
> rzg3s_pcie_host_stop() and rzg3s_pcie_host_start(). These functions
> will later be reused by the hotplug implementation through
> pci_host_bridge::reset_root_port().
>=20
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019065025.2146=
539-1-claudiu.beznea@kernel.org?part=3D10

