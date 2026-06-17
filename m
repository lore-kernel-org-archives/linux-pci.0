Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89543E92AF
	for <linux-pci@vger.kernel.org>; Wed, 17 Jun 2026 14:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781706840; cv=none; b=eI52LlvqmwiPCCBmHC+PdejAe3cUlvx0UdD3M2Sw8SjAaimBlaAOiFDOVkNqzZLuzl5JybK2MCZB9P6CpCuKvlWmvtasFVz1V3we8uV/7v2z/S6gG6OMnTjYbStmKKlzmGan1Y1OdpZZ/RzwFwFRaOTSSvpEGyFquqkULrbJQdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781706840; c=relaxed/simple;
	bh=axfT5dGl9n/Ky1t4WLSpev5VQUHFlYQf/lq1CVr3UWA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hTZeRz73eqrfVc47fqTweRmUamDlPeddF4PNC8wuB70t4a0LCiqmXZl2uOaEVye20dQYD7qtLJ4SRYA48x3dfYSLZK6i0V6Ryl7e21nTcUsLyknPYpePSRpoeq6wZaj4C5Nm9mwrTqOLeqhmaB0uOk9/ykIasEhNAzzPq11Cdsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GECfRdbU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GECfRdbU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF161F00A3A;
	Wed, 17 Jun 2026 14:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781706838;
	bh=axfT5dGl9n/Ky1t4WLSpev5VQUHFlYQf/lq1CVr3UWA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GECfRdbUpNuhBq4dS1MZABow4pbMZfS/Cm35RKRafyB9/vuLkc0HNVbWDnaCf5H4U
	 TpTAlclSlSel1Jc3T9Dj6EZLEigWhlB5m/0BN8Pt4iB+hdsCW3MLAb6CMGZxuIhs6u
	 xzWFD9CQ6c/8P5b0/3Y4hd67vkK5eluVS2kGULtMV3WYgh8dLzs8PLc+0T9zkfhuye
	 JV+RCyFOLTPxKTCqN9aOhILfI2hUuXeV43F5QmKclFMsZl2XlEoHIUqnynXo8Ho/Mp
	 o6+2krljn2hTa/T4WY0oqqJxs5ZDwcvCFpyXxFEJV52GKjqsrYQ4Ow3X6JC3YEUFvg
	 6ZmyvUW/0w+UQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] power: sequencing: pcie-m2: Sort PCI device IDs in
 ascending order
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Deng" <wei.deng@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260617143055.820096-1-wei.deng@oss.qualcomm.com>
References: <20260617143055.820096-1-wei.deng@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 14:33:58 +0000
Message-Id: <20260617143358.6EF161F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Sort the entries in pwrseq_m2_pci_ids[] by device ID in ascending order:
> 0x1103 (WCN6855) before 0x1107 (WCN7850).
>=20
> Fixes: 2abcfdd91e6a ("power: sequencing: pcie-m2: Add PCI ID 0x1103 for W=
CN6855 Bluetooth")
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617143055.8200=
96-1-wei.deng@oss.qualcomm.com?part=3D1

