Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FC9340281;
	Mon, 13 Jul 2026 17:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783962581; cv=none; b=Tum+8XIaitvD8BNVG2x6qjbkLqhfv/qlirtA8rxfn0nEWb6VNuywVkycTUr4TY8AT8XpfYU++52DQduQPdtyX/WVI2u/8CvJc0DyAJG2GqDtCqielHgY/gKbyrGvw4YwDM+dumzMmOFkEfer6uuYBPR+Ye4Bq/yp/84sczb5Te0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783962581; c=relaxed/simple;
	bh=hcOlYgicv5iaaTCZdSXw4LLy6DafP7i3HBBJ+Bul9bo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iK4i4xArE2ted7v0b0CwihRjpkNxUHLlLlv24d+7ImpmW93sqgt5T5UBw7cg36H2H/fZOiyq/o3W/KiXjTl4nMelO9P69JQ2cQWEXB+l1sjsuhP3PSZ5UnpO2JqKfLPXu3TZk3XtiiJ26y6I3uL63KS0f3+ZFSSXlEd4tF5SO9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lW5FgOOZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lW5FgOOZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A44A1F000E9;
	Mon, 13 Jul 2026 17:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783962579;
	bh=hcOlYgicv5iaaTCZdSXw4LLy6DafP7i3HBBJ+Bul9bo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lW5FgOOZSFpvOgGBXTZBO0JHQQWAlFI3fqhXWPAGDD5VcofBa/mGWeG5DOzv32DFX
	 wHgyV5VG+867mDBEoFmUtt+3B8xgKN3JwyZzalYB07rjsKhF3Xz3yRQRMfOvJG/27P
	 NRaBwo01bRJqhijKwQ7LzpPYDZzhw9KAyPUExtmEDD/BYfrE2QVVUqmTpjnIP8Sxsi
	 4jKk6ObFWtGaXujyQKtVkB8Jf/KRszuznvguephBOky83f07+slOVR8MMLFQnTW9UQ
	 9+FaNT35SXyoVseGjPRUL22kYTGwCtp80q3nbobPBbQGGuJxwHThEVNJmWAAu+6oh3
	 a5nJU7zWOU9kw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 05/10] dmaengine: dw-edma: Add helper
 dw_(edma|hdma)_v0_core_ch_enable()
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: Frank.Li@kernel.org, linux-pci@vger.kernel.org, vkoul@kernel.org, imx@lists.linux.dev, dmaengine@vger.kernel.org
In-Reply-To: <20260713-edma_ll-v7-5-6fb7498c901e@nxp.com>
References: <20260713-edma_ll-v7-0-6fb7498c901e@nxp.com>
 <20260713-edma_ll-v7-5-6fb7498c901e@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 17:09:39 +0000
Message-Id: <20260713170939.8A44A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Frank Li <Frank.Li@nxp.com>
>=20
> Move the channel-enable logic into a new helper function,
> dw_(edma|hdma)_v0_core_ch_enable(), in preparation for supporting dynamic
> link entry additions.
>=20
> No functional changes.
>=20
> Tested-by: Koichiro Den <den@valinux.co.jp>
> Tested-By: Devendra Verma <devendra.verma@amd.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713-edma_ll-v7=
-0-6fb7498c901e@nxp.com?part=3D5

