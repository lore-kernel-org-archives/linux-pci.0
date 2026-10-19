Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4C1489FB9
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 09:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792402230; cv=none; b=WXYeN787B5HhPfg6+ab1Q9qhi/CXchA9b3+kzku+YSrNS7Vkk6awQSQhRhlGknvzTkCq0mNl3ZhoEsuHsF7+7KJZE4/BkxhrvMG0oj5zRN5VoCkP4Gclt2qMVWhlwT32coL0LSW+ZF0E+qC3lQi+hOz0LzQ29zVM1OFG2Ijscwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792402230; c=relaxed/simple;
	bh=wVgM3lo/OWyZusrULgfXZSvPFNP479FhXyVjG6/5oqQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=E8rk2o/m1RauHChrpkywv6xM02VAdevCNj99qU0sgDmrbl9Ucxi3a+Y880stQL3ac/pt5VxUHeZ3+aeJB61XqDTd9mA6FRaIgZpOtakbprenziE/Fkt6rbi0Z+b76/jhMHjyNB3LmrJcG/+DWGUvwM+qLqdixtYN6zrvEOJDhHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZiDJazz6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZiDJazz6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 404AC1F000C4;
	Mon, 19 Oct 2026 09:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792402229;
	bh=wVgM3lo/OWyZusrULgfXZSvPFNP479FhXyVjG6/5oqQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZiDJazz6+8efBvEE84zqgVcMRoiodd63emqgCitQDc4XtTXpeJqgW72aJZ6W7vvvu
	 lJbISNxYG9evUfWik+FsTkaDhz22OAYvF7LOTTNf/W/v8qu8ae16CKjDhlkmmWPPLF
	 wZa3HvHkaU84fhCq91jLv+r0XB3oH8uLzzmLH0UGUR9vLb02JMXTopKSytZblAFzaX
	 d+LvGJFTFwUe1u/vnNZbu5oLaqujDasFq8d6RBxPLJKR7BvQWk5J0/5ycDI1zLDVnt
	 CM6WHcdzlXFfPejt/hbFdrQgHcjjLpieIKY6ATeVD4HLtNI6+GJEeNYcK9HBsw8RQq
	 cJEPZacMil0GA==
Message-ID: <sashiko-outbox-176909@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/6] arm64: qcom: monaco: Fix pcie1_phy compatible to
 list qcs8300 first
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261019-monaco_ep-v2-5-852cb9f5d012@oss.qualcomm.com>
References: <20261019-monaco_ep-v2-0-852cb9f5d012@oss.qualcomm.com>
 <20261019-monaco_ep-v2-5-852cb9f5d012@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 09:30:28 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The existing pcie1_phy node only listed qcom,sa8775p-qmp-gen4x4-pcie-phy
> compatible, since no QCS8300-specific compatible was documented for this
> PHY at the time.
>=20
> Now that qcom,qcs8300-qmp-gen4x4-pcie-phy is documented, list it first
> with qcom,sa8775p-qmp-gen4x4-pcie-phy as its fallback, matching the
> order used by the pcie0_ep and pcie1_ep nodes.
>=20
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019-monaco_ep-=
v2-0-852cb9f5d012@oss.qualcomm.com?part=3D5

