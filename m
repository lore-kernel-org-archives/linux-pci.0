Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17120277029;
	Fri, 17 Jul 2026 15:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784300596; cv=none; b=gaOfU7YFPtvB3qdTjZTlDM6IZio3zkVUC3086yQBkzJRdQGfPPW4KFIrPplfK6/Q2GwlLb8BCOioUIvx9w5Wy709ZGtdmPaw9PzRhFO58/XsvaMS9odiib0zJA478VBjVFwZtLJnBKmI4Kkg+SCVmsKpD6/MLwDwU0HslkSdB6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784300596; c=relaxed/simple;
	bh=iObE2kwV/RRYvT8Tyql+/IF52uIldebvnfCD7AV1/OU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B2BU2qrFu3dVulctf1qARZ5eM4s1yPBAO0k52vQACP/CjCIcEqHpDQGEan18Hs1x+WI/oWUy9Jo4YQZJGSNJFy3J/wfWyTQV28aaYrHqoU5LPkbZSB5T41Fnjj00Z/78el1v3ny0B6LV4f9jqpGCtVLnScsDi/zZpoHBkvIdyBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6Q6hzrD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6Q6hzrD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB221F000E9;
	Fri, 17 Jul 2026 15:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784300594;
	bh=iObE2kwV/RRYvT8Tyql+/IF52uIldebvnfCD7AV1/OU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S6Q6hzrDF1BTP22Q0EX7PzLTJ4ZLYd36MQgaDjSs3fFMZLhbkwdryLIvq7gNK5FTB
	 Fu1FGPnKI/4BXiupdsYNK067QfAGTwc0M5x64ZBr03vPhroNArL27ioPH3Uo/usqek
	 4+jH+i46Z1ZoTU9W05N+KS0RALOfuLuGKLPURY13VdC/gdqMrpF0c9xOsBijboGdiP
	 eJepP0Ht1uEOy2S8pQiVUurvBU7uH6ek888h7Nlxqqqwa4A8Hta6I2SQgjifogNd/v
	 Yrw1EnZXhZIiG6/2sRB7Vx5YryoV9lLmYbGteXjU+W3F7oIpc27Q6nXxSLzKNfofyq
	 sJFfxZxq8GYfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 06/10] PCI: of: Use fw_devlink_set_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260717145147.823749-7-herve.codina@bootlin.com>
References: <20260717145147.823749-1-herve.codina@bootlin.com>
 <20260717145147.823749-7-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 15:03:14 +0000
Message-Id: <20260717150314.7CB221F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The code set directly fwnode.dev field.
>=20
> Use the dedicated fw_devlink_set_device() helper to perform this
> operation.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717145147.8237=
49-1-herve.codina@bootlin.com?part=3D6

