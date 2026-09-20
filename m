Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BF6366051;
	Sun, 20 Sep 2026 06:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789887303; cv=none; b=qN5uy6QW+akrbeTrvaikyrObRz2By6XInFNs3/cJaOHz7ZuM4lu/hr7QDl8UEFR1Cn8A6RjxjKppCSznhuZjLelolvUHRkzT93yiA5VW+YdtgC//CN1xSKJDgYI7JFNhULTMxVsfIiPSnNuP4tVj/wk8HGYCTxbs24f8493xtXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789887303; c=relaxed/simple;
	bh=6JZYwxuSQcwk3MClJGMHPbrLkG1DrLiadFNbDUxdabQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jma7FJ59mMS1esy1/Gtc+JmXZ8sdyBw7rWOpJOtNSj7Oe3ZygrL+wJeuL7x8R+SMb5/zSl5UEpGEgrs/ZvEZ8bISjtKhZVcFtU+QgwtVwap6Nide5Hmus9uR2COKcYqRPS7/irluS/i/pXI38jy1/XhogA2IhRN6/55wAiKqPS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMga302F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMga302F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 447851F0089A;
	Sun, 20 Sep 2026 06:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789887301;
	bh=6JZYwxuSQcwk3MClJGMHPbrLkG1DrLiadFNbDUxdabQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kMga302FTM4GU/rTlncThiwbrrpj27bTCSFHR2edXyN780mUmv4S0r+Z3JbF9FkC7
	 p+ETMeP5OuQWKbMA1qisKFRd96h4fInjzCRzXFfKDcya9BbgRU5JIXCBuTPDOPYkON
	 JEhYUq5XOEqXWfJBNyu4SS8dGXixHK1h5bUzY6qoLbiea/gzV3kGS5i+Z6BASqpy91
	 Y2QVh0IWPCKWeHN6HrNUH+4fEpwwua0aBrNEB0shx0BZO5uFCY5fj7+RopEUbsjnB3
	 ohSVAxFfW147VMpHAtQzW88sug+buTKXlQEzsXr2oEhUfzhPTkmW/uC2tEwaS1lWF6
	 yq1YY4W7xiy6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 10/12] arm64: dts: s32g: Add SerDes controller
 nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SmFuIFBldHJvdXMgKE9TUyk=?= <jan.petrous@oss.nxp.com>
Cc: vkoul@kernel.org, wsa+renesas@sang-engineering.com, olteanv@gmail.com, neil.armstrong@linaro.org, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260919-s32g_serdes-v3-10-9d68868c1e89@oss.nxp.com>
References: <20260919-s32g_serdes-v3-0-9d68868c1e89@oss.nxp.com>
 <20260919-s32g_serdes-v3-10-9d68868c1e89@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 06:55:00 +0000
Message-Id: <20260920065501.447851F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
>=20
> Add the SerDes/PCIe combo-PHY controller nodes for S32G2 and S32G3 in
> the disabled state. Each SoC integrates two SerDes instances (SerDes_0
> and SerDes_1) with identical register layout; every instance exposes
> the PCIe PHY and the two XPCS instances used for SGMII. Board device
> trees enable the required instance and add the lane PHY child nodes
> matching the wanted SerDes subsystem mode.
>=20
> Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919-s32g_serde=
s-v3-0-9d68868c1e89@oss.nxp.com?part=3D10

