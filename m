Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954873EF643
	for <linux-pci@vger.kernel.org>; Wed, 14 Oct 2026 07:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791963028; cv=none; b=M72+ogg7txXYB54UQ+eGz/TVCQSbRipIUqXyjrHo83DgRpfbVWZt0XdqKzx4p+C62NWFezOj1Lr9QA0yESILCDvPloep4DTwzeCEL3wwxMwJLUqUAbdAluNXHRoFEda+nNjBHohdTnhGjLB+t0T1npns0LcwTypONqHCx3yRhEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791963028; c=relaxed/simple;
	bh=gFhoQyssDbR5J60S0+BWOdzN1NQWha967+J/c5ZoLkc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=YTcB+2lz4PO8yGjlcSoFZPrp85vW/5zyxZb1mCH9PxK+6shlB0DabJQlaNIMYUqjJskYyIK/xONKDUmoGPyfqSNWZptgbfgOlmbFAcvZTojCB2MzXk+I1UD+SNoI302KSMAF58M24Se9IL6mZ1F/uS/95dsJpnlrkBN6EOdE0T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyjD7K0q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyjD7K0q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC3FC1F000FF;
	Wed, 14 Oct 2026 07:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791963021;
	bh=gFhoQyssDbR5J60S0+BWOdzN1NQWha967+J/c5ZoLkc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GyjD7K0qC0YbJXZpglSF4nFOUYyxA8x0ZjZ5MUnuEkserVTnVCvHc2qn4Jm1d6DxP
	 x2O0EBKaJvZSreDLmkKSmIldb94nerCVbU1rvmpbFswz0EgyLN/I4InRYv7fiYfHT+
	 nbbW2zaO6e4+4s8ly6dkPJ6da9AR/y8d/N0w6QBhFJnwdE09GYtxj3dQVLD9bse5dp
	 nVhYVBEcXyDaqL09obZl13+5XQvpnV04GBNn1IdNEolk0DJBS+rrqIse5LWGxNCmLo
	 s5cjShpBSUqlecZbyMuGYoAFRdEjR9Mes+/Vgm9hZN6jE/iaYBmzwq1pdpfR8Wl5ms
	 qD4vexDl7+20Q==
Message-ID: <sashiko-outbox-170943@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] dmaengine: dw-edma: correct IP name in
 xilinx_cpm6_dma_data comment
Reply-To: sashiko-reviews@lists.linux.dev
To: "Devendra K Verma" <devverma@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261014072907.581539-3-devverma@amd.com>
References: <20261014072907.581539-1-devverma@amd.com>
 <20261014072907.581539-3-devverma@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 07:30:21 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Replace 'MDB' with 'CPM6' in the xilinx_cpm6_dma_data comment to
> fix the IP name typo.
> No functional change.
>=20
> Signed-off-by: Devendra K Verma <devverma@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014072907.5815=
39-1-devverma@amd.com?part=3D2

