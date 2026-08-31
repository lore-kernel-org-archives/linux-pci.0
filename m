Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0A01F16B;
	Mon, 31 Aug 2026 07:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788161380; cv=none; b=pSoGac5Shtst7LTm9VA1/4XGWrY/lNwvdYjZGbL0SAE/GfxySLvfEswHkbx3hXOdeoGM5hBhWK/W6aMaLAQc+mvYDLg4Wky0ZupFAuCTG4A5HZBEu5lcNAXzqNuMkQOCuEytNWz3gNpi7z2BUJU+ic84J83Y18XfhIFnHN8hFNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788161380; c=relaxed/simple;
	bh=Kktc031UzCEMI6JagxmPA+1IooGPvoNesv/14HrP77c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AWQDQ2QUk7NUGg1EVoUK6sHyBX/CoNxeHeWe7+zNeUuRmLvfcfudTer1Q9YsBSv5RIfCEBGa7ah8zySvOpp/7dXgA30tDIeB3NMtkUHFtUrQNWSAAXOwJVl0SQwI66t7FqX3Elttq7J/wxkcMPRrE+hIsPr7kXEEFPDOMd0Z5yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKkrJKRx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKkrJKRx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E7261F000E9;
	Mon, 31 Aug 2026 07:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788161379;
	bh=Kktc031UzCEMI6JagxmPA+1IooGPvoNesv/14HrP77c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GKkrJKRx7lUuVIckCGWqPOA8+LurVWECrQpnRQg3zwBVYIkijbCYRAoqy5kyXfNtM
	 K2I1sv6fV9erv2OvIkGbR6WxxCIT6mA4NgbGUukgFDhjXTzgLV6Vt8In0L6uVC8nky
	 L4w+jz3cCSnr6IE4RbsjBSCr2kxoo4S/VFDMegRjgFsaEiJOP0pT7/7E91+rAxB+gw
	 NnWaH9M5hXgjbQbaL7rFnQ+zBdwLSNi5UVGNjf9tbjY2uzx9zWDhH6863kyYJOJibc
	 JyOM1WvfXYMgG2iRl4X+GqUm/028e36o3efgjk/+nmJFvM+5lMine2aNnM6aAO6AvZ
	 hX2PYXP3d1WjQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: phy: sc8280xp-qmp-pcie: Document
 Shikra PCIe phy
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sushrut Shree Trivedi" <sushrut.trivedi@oss.qualcomm.com>
Cc: conor+dt@kernel.org, robh@kernel.org, neil.armstrong@linaro.org, vkoul@kernel.org, linux-pci@vger.kernel.org, linux-phy@lists.infradead.org, olteanv@gmail.com, devicetree@vger.kernel.org
In-Reply-To: <20260831-shikra-upstream-v2-1-406661d75afa@oss.qualcomm.com>
References: <20260831-shikra-upstream-v2-0-406661d75afa@oss.qualcomm.com>
 <20260831-shikra-upstream-v2-1-406661d75afa@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 07:29:38 +0000
Message-Id: <20260831072938.6E7261F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Document the compatible of the Shikra PCIe phy which supports
> Gen2x1.
>=20
> Signed-off-by: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-shikra-ups=
tream-v2-0-406661d75afa@oss.qualcomm.com?part=3D1

