Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F50E48F01B;
	Mon, 21 Sep 2026 11:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789988740; cv=none; b=R95oBX99J2hqXaIr/9MQyS+KJae2N5GBnoqx7xtyrHDYo9nlrAvDjyqnoKrk9BJenb8URbTrV//DkRmMHNBllPtwqUjQmPYS3HsUHuedS8ssH4D8HAuvGNjd69rJRlwIHG1o/hMvUW6LIiwz5qSuCOwp0VOso2NEoFOqUVsNVaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789988740; c=relaxed/simple;
	bh=Q23X9NFAUgyki7bVg3boIBIdGH2nvLPDKnO958Egv1U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NCvOTUbqrF4ijfP1N/HeBIB40o3fT9ingWLBZ2Flhd9km6sxJJqYI8zPdWapgTJMYlMeK3cM45/oBO0j/GscSnqDwX+/rE84PJ9Mh5hhTeHn7r87qlvNiVLfO6oIX6MXbhKfLvLoH/txP5uIPxBYEOHjLcstjxGv10zqK4t+a8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CkCRxeFr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkCRxeFr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC0611F000FF;
	Mon, 21 Sep 2026 11:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789988732;
	bh=Q23X9NFAUgyki7bVg3boIBIdGH2nvLPDKnO958Egv1U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CkCRxeFr/Q2nb4xBxr/Utz39L2az7K1/V7SwTaH4NygTtrOlQCkebrykmXtQrRDU9
	 D/Qqy0xQL8DCoA94jNbYocHWXDju5/ixp9bvZHr6pEH7UsHSvz2dQBsg+Avd1HiKw8
	 mVvx7BpSJFjuuQPZnbBgO/NhArmiB0uzmNFbr49nH4k8D9p0a2ppNiXGH0QyBgRSHr
	 XxvwrKntEdZ1qXf1KZzECNLFxCqfMskFotgjSxhmH8BJAMV2E7nrLtYrpha3g5sfLz
	 Il796J/Gvn/YHcQ14AeCLp02T4SaFA8je12UgTn/TXblrwcnzIdCyoi7XDr6cdA/So
	 mqR/r1HQxRNYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Add
 qcs8300 16 GT/s PHY
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: neil.armstrong@linaro.org, vkoul@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, linux-pci@vger.kernel.org, olteanv@gmail.com, linux-phy@lists.infradead.org
In-Reply-To: <20260921-monaco_ep-v1-1-63c5282fb0db@oss.qualcomm.com>
References: <20260921-monaco_ep-v1-0-63c5282fb0db@oss.qualcomm.com>
 <20260921-monaco_ep-v1-1-63c5282fb0db@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 11:05:31 +0000
Message-Id: <20260921110531.AC0611F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The QCS8300 16 GT/s x4 QMP PCIe PHY was previously described using only
> the qcom,sa8775p-qmp-gen4x4-pcie-phy compatible, since no QCS8300-specific
> compatible existed for this PHY. This was a mistake, as it left the PHY
> undocumented as QCS8300 hardware and indistinguishable from SA8775P in
> the binding.
>=20
> Correct this by documenting a dedicated
> "qcom,qcs8300-qmp-gen4x4-pcie-phy" compatible, with
> "qcom,sa8775p-qmp-gen4x4-pcie-phy" listed as its fallback compatible.
>=20
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-monaco_ep-=
v1-0-63c5282fb0db@oss.qualcomm.com?part=3D1

