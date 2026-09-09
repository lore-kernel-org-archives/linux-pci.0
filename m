Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7DE53FD5A;
	Wed,  9 Sep 2026 11:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954841; cv=none; b=R8lZkzsuMc386MK3DbiXVFYUlxQq/IaOdFbNfzBwyjGdy309tHJud+3Oe9JIPDKCL89aptwPwc6hQB2AF/m8ppPl02juEPVwxYMy3Ij6M9Y5Jgyr6BGSeu3Ch9XqMX7uld9MzEAb9l2XHEyJFJYK+55SJJSJeV1Q5MhJAgW1YeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954841; c=relaxed/simple;
	bh=bppV9sZYQPJ832aMUqwuuqcPZt+50nokbdiWaISMnTQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oQmGyTLWf/aQN8uvBvuLBRJkaaM8oZMOWPT04aETUWCr9KtefMDmgIhvG7FOuQrJ72H/c7Nmyd6e7FQ/0RWz1Pgc+w1vpTFyG6ww5xuwARahnPkMZhmNWscBMRXA4K5PiMBklohdXDZzLJ6Rt6fU5+4MhLr62BbiWazIP0XNGSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEHL/abo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEHL/abo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129931F00A3D;
	Wed,  9 Sep 2026 11:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788954840;
	bh=bppV9sZYQPJ832aMUqwuuqcPZt+50nokbdiWaISMnTQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CEHL/abomsEgW1h4eW0xxBCiNW9NVpGB18MH1QrRaaTeoRIZLX+72NiX61U36jGxh
	 Y3CYLfvU+PovQRu3ZxzPQZp/xlxEMpnrgZWdshR9o3BPtJ/2vBp4CLluKDsP1Nq7e1
	 vu9zOgCfsYpawcFpls2ppxzGBmlTVSW17PhCIdSpoLh6x6WdVUe7L1N2OUa3ZNP26Z
	 ByrJNtuZO6OoOGlLWy6qJvcEBtTg63GcO3feE+ix+ApXnBtf2tLOZl7eEh4ejN51l1
	 TJxVxAeSl/D3XgZXiZlov/J3dHU5L2Njd4vHBSKgejJRuBUtaUqgOaGRCILquI/6Ff
	 Yym0yUyAe5EWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/5] dt-bindings: phy: qcom: add Nord QMP PCIe PHY
 binding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: olteanv@gmail.com, vkoul@kernel.org, linux-phy@lists.infradead.org, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, neil.armstrong@linaro.org, linux-pci@vger.kernel.org
In-Reply-To: <20260909-nord-v3-1-b0a82721c547@oss.qualcomm.com>
References: <20260909-nord-v3-0-b0a82721c547@oss.qualcomm.com>
 <20260909-nord-v3-1-b0a82721c547@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 11:53:59 +0000
Message-Id: <20260909115400.129931F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Document the PCIe PHY found on the Qualcomm Nord platform.
>=20
> Nord has a Gen5-capable QMP PCIe PHY that can operate in multiple
> lane configurations using four PHY segments (A/B/C/D). The active
> topology is selected by firmware through a TCSR configuration
> register and may be configured as x16, x8+x8, x8+x4+x4, or
> x8+x4+x2+x2.
>=20
> The binding describes the register regions, clocks, resets, power
> domains, regulators, PHY provider interface, clock provider interface,
> and the qcom,link-mode property used by the driver to discover the
> active lane configuration programmed by firmware.
>=20
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-nord-v3-0-=
b0a82721c547@oss.qualcomm.com?part=3D1

