Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788C649B21E
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 08:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399420; cv=none; b=GUsK6bYWfHURLWCvaYsSZMLanE580w/ytLR6bxHa1qDMStgcuELCVQ+Q6NYGCjoEwpFPAqzxvZw34tCwzFbMJe84UN3AFncgl804RtB6jaa/d0P2peK79W1HtuxQEqZKyTE86+jonk0TmUpIZWZ85h3yi5GchmOkZfwnyTT0PQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399420; c=relaxed/simple;
	bh=yBpeNkjvcJsYW8Sg+mDPyPMD6phUPU8WTdlSFGwn1Pc=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=TeuvWFqI0LSlGQiAmtiQ2+jGBnYTjVfoSYs1WKeCwRI583IoIGTvzcQALTm/BfIVym2fD11OzrE5ujVS/1VCIkLjukVR77jHz/Wv1dP1+wjJvTsd04qHzUTOTCM6cTS6xzLKa1VzUtL1N1Cr0OR9tYvM3k02IR7kEoI59tvCzKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YfASGTJl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfASGTJl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 063831F000C5;
	Mon, 19 Oct 2026 08:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792399419;
	bh=yBpeNkjvcJsYW8Sg+mDPyPMD6phUPU8WTdlSFGwn1Pc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=YfASGTJlZPzKuqyrc01NLQJDvyv8epJv/8N7yGuSJe5JtstKg3rStXQmGEpazfmN4
	 Tm+zG0L9At1Hx791Z8WjChVFYn7keOaU3irnIGHtu88Zyozw4OCE3NBLok4RaBEVv1
	 3x8wfx2sa2wzM+7rk+QyyQFs2ruWpdpnktp8hkI+0272kz6rVYMryFwA1eJVfqY4Yw
	 yrzZUjxJmoxIDJ8GAxPLq7l62EGpay8DEDAzEBuJisecR7xEtExNhhP4ujYiUz68oN
	 DWjcH66FMGY/oWRjupQTy9gZly6qnz4TaDddByexzNorII7eJ4DkuVS8+TC3TgcTNL
	 ocEqw5hK7n5LA==
Message-ID: <sashiko-outbox-176827@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 12/13] liquidio: Use pci_iov_get_virtfn()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lukasz Laguna" <lukasz.laguna@intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261019083514.838640-13-lukasz.laguna@intel.com>
References: <20261019083514.838640-1-lukasz.laguna@intel.com>
 <20261019083514.838640-13-lukasz.laguna@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 08:43:38 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> lio_vf_pci_dev_by_qno() finds the VF by walking PCI devices with the
> CN23XX VF device ID and checking that they belong to the PF and match
> the VF ID. Replace it with pci_iov_get_virtfn(), which looks up the VF
> directly by its VF ID.
>=20
> Signed-off-by: Lukasz Laguna <lukasz.laguna@intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019083514.8386=
40-1-lukasz.laguna@intel.com?part=3D12

