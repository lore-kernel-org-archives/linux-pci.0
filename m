Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830E82E7386;
	Sat, 25 Jul 2026 09:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784970437; cv=none; b=FymmJMoNtppRmT94Qg5bna6917ENCMk3sbCPcpHMPYysP/NJVf9DY49zHzjP+RklHtL2Yo7hZ5FDlL+D3OlVNM00S58NUG9UGRzHO6NffsmHhJG/jqPK+MQcLwxGAM7TCou//DU5tJ5ufIWDu9G/2z0wTZ7B3MvHUSS4A2lMx+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784970437; c=relaxed/simple;
	bh=Sy2jTWDM7Abr5XHENpRR5LJ/LBB+F4DfCr7Lt5MHvJ8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rnAoQ69nG9u+1mvk3B6nIrMHmYYDtmrAs9rkmVPVAhWz1/b3l4npz0c1XyP6/otkwlk2w1TFrTHYYkQ3u8RzgOWjy7/fBtsKDSRQFEP99szK3oEXdqWbF05zplClQxCnHjncQ2JLRo1JtrSXTr+OjJfKJOQgdO7h7MdfcBMvF30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=os9RRW4Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="os9RRW4Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6CA71F000E9;
	Sat, 25 Jul 2026 09:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784970436;
	bh=Sy2jTWDM7Abr5XHENpRR5LJ/LBB+F4DfCr7Lt5MHvJ8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=os9RRW4Q9ZteHKzprsLCcrHsXLlEE45d3eqrDTbFMJLcLPVZsvqoEedf0gGOdYmMA
	 3DWWMNFBtxqEsyIsABgV5owYLkULjIqL8nLW6nKUqnQCxjqpU/kOt7Ue9Tk/1isuMf
	 6nLMEuFLoMaxAVQ25guD5KwUQU6ojM63P9P09ntmbDNuQs/MEpRPRfax+/TmoD11Ca
	 iah25VPcubfwyTumEEi1cFAcRC5YPvi/thY+dWtSiolqPHkSsGRz4NJhmYsA0+8AIQ
	 KYuUOFRv/qpQW1bK44IJERZZ3SppqfBQpyDPiuCNTxFllgvBywOsgBUTlOCIUWtH+l
	 J4Tl8/Ei04aEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/6] PCI/pwrctrl: tc9563: Power off only the external
 ports in tc9563_pwrctrl_disable_port()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manivannan Sadhasivam" <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260725-tc9563-fix-v1-3-ec4286e31331@oss.qualcomm.com>
References: <20260725-tc9563-fix-v1-0-ec4286e31331@oss.qualcomm.com>
 <20260725-tc9563-fix-v1-3-ec4286e31331@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 09:07:15 +0000
Message-Id: <20260725090715.B6CA71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>=20
> TC9563 supports powering off only the external facing ports like DSP1 and
> DSP2. It is not recommended to power off USP and DSP3 as they have fixed
> ports/endpoint connected.
>=20
> Hence, fix tc9563_pwrctrl_disable_port() to power off only DSP1 and DSP2.
>=20
> Fixes: 4c9c7be47310 ("PCI: pwrctrl: Add power control driver for TC9563")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.=
com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725-tc9563-fix=
-v1-0-ec4286e31331@oss.qualcomm.com?part=3D3

