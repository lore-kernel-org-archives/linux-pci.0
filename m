Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9F91B4F09;
	Mon, 21 Sep 2026 05:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789969344; cv=none; b=tyMbtbK/V5QvouhjUl+6nV7RJ6qCtxP9UwQ8YUjr4lvT5UEIlXpQ7jSygQH00t7neHZwxM+Ypma6n7s6zlO49xDF3LMzF0PvC+ynB3y4iPGygexV7lmPhIRIvw2PGCRuD34RLVfQWxzsv+VrqET1qztkAMfu7fcBPsPXxlY8zKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789969344; c=relaxed/simple;
	bh=qvvkfSYXJv7lXjlg3wYhqK1goazjJeFV14ZRhMtNh6Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=amODeV84Z+kUWLqm3Lel83ZWvWsBIAPxVsI11VdNdImkCq/Yq/AcrFWr0ytQAL8opP0fSxxdb8LjaRTT9PKhFqETfEnM0lmqwUCAUR8GMrmlPAZRZvL1JUXp1CF33EdibIzXU5N9KnN7NCGtjtsiDNGvf8C2JYp3PVxe66px8DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRgHaOmn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRgHaOmn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A931F00893;
	Mon, 21 Sep 2026 05:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789969342;
	bh=qvvkfSYXJv7lXjlg3wYhqK1goazjJeFV14ZRhMtNh6Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eRgHaOmn0mKxPfM1g1zXgAMkEekKlhF6fjhFscNRr9B+njM41ioJuIEo3cOKYSX6V
	 sWcWhYOUtyICm/yktLs97kfu8+0r68i0FSGmtOzqKtj2wVEJc2LazUkNmixfx+RCCN
	 2mCIxwaq3+MvXgqQ5Kg6KBQOKbciCJQ8M/q1ivv7c3VmkpjskgpXxCoRMOr0BhWhmM
	 nrAk0E7/HqOSRgt611dqHfM0UuXmiBhaUZqsIQV9QGYCTokWFH/JPSEZqohpYNATF2
	 2ADqswDLin2YuYD5mDw+rmhls93KTdRbQSeIkf0WO7SHMPh5Bt+9CdO8pgxObJB8CF
	 wDm78sZnB9pKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/6] phy: qcom: qmp: Move
 qphy_setbits/clrbits/checkbits to common header
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, olteanv@gmail.com, vkoul@kernel.org, conor+dt@kernel.org, robh@kernel.org, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, neil.armstrong@linaro.org
In-Reply-To: <20260921-nord-v4-4-ed05c6e09240@oss.qualcomm.com>
References: <20260921-nord-v4-0-ed05c6e09240@oss.qualcomm.com>
 <20260921-nord-v4-4-ed05c6e09240@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 05:42:21 +0000
Message-Id: <20260921054222.48A931F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> qphy_setbits(), qphy_clrbits() and qphy_checkbits() were duplicated
> verbatim across phy-qcom-qmp-pcie.c, phy-qcom-qmp-pcie-msm8996.c,
> phy-qcom-qmp-ufs.c, phy-qcom-qmp-usb.c, phy-qcom-qmp-usbc.c and
> phy-qcom-qmp-combo.c. Move them to the shared phy-qcom-qmp-common.h,
> which all of these drivers already include, and drop the local copies.
>=20
> This also makes the helpers available to phy-qcom-qmp-pcie-multiphy.c
> without introducing yet another copy.
>=20
> Suggested-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.co=
m>
> Reviewed-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-nord-v4-0-=
ed05c6e09240@oss.qualcomm.com?part=3D4

