Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CD836405C
	for <linux-pci@vger.kernel.org>; Fri, 19 Jun 2026 09:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781860333; cv=none; b=AQxnlM3/nv5zYwrBq7APYvuIYnSU/h5ZiAeEfvgG6RyhU9hUv/BQ8T7Dpy5Z9JOQH4oQRfV7Hg9TH9VCtaacjXG8gnvQasK9w9WTs7IMaAdB+UMDWPnzGSFfZC/1ZsNyE/9a0VaoKRH0Hgckct0w3zMlPdaojiP87BqD+eLtJlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781860333; c=relaxed/simple;
	bh=kE0dtujUb5JhGdlF6Lx8OiB4AVp3Oqve4WrPXuI1Vx8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=larb76cz1PhB4FJmrHQG8PmxpKqjaZKkAEPUpchVeYwB2MPrK/PtJxi7i9vnASGnWFNzDhQ6rrl9txOY7dOhe49lkwvtC75n7y6aaD5u9XgbnqaO1qXb5d7cZLg5SVtUo2X0tSxO2XU0PJpSi5r/R0T1kg5M2II4KbrS501XOOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkB8XmHz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkB8XmHz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 793B11F00A3A;
	Fri, 19 Jun 2026 09:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781860329;
	bh=kE0dtujUb5JhGdlF6Lx8OiB4AVp3Oqve4WrPXuI1Vx8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JkB8XmHzN4KfOy/ZV5HEN3HwYoKJeHnKAZP/udKbHJ0ZHFNGVTzhxBDgvFZ7ioHLg
	 0lgLSvi6fWUwSuG+l6qgIxeIXs7V2d05v53KxaA4uPiyvFusNfu2t+1FZbs4UhYqu5
	 jkeQTyhxg/uDC2uUZEwaH4rEg/KpXy0sp3nw7hovOauGSnJhCJCVq5YUrzsfXB4a8D
	 WqcBk3Y0/Zh6Olhcxwlo8RTyOPzii1yfnME2TfyIn/uhdgrI2+t3QGRvLcgrIYhrH/
	 TtMVizjVTlfrZi/GnhfG4Zot6b+D+o9RFFgIk+EK5zxIJTWHUWFFh29G6j6shOz0p3
	 Sa3OY8te7DWMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 19/25] PCI: Add macros for legacy I/O and memory
 address space sizes
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260619085200.3729431-20-kwilczynski@kernel.org>
References: <20260619085200.3729431-1-kwilczynski@kernel.org>
 <20260619085200.3729431-20-kwilczynski@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 09:12:09 +0000
Message-Id: <20260619091209.793B11F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add defines for the standard PCI legacy address space sizes,
> replacing the raw literals used by the legacy sysfs attributes.
>=20
> Then, replace open-coded values with the newly added macros.
>=20
> No functional changes intended.
>=20
> Suggested-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> Signed-off-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619085200.3729=
431-1-kwilczynski@kernel.org?part=3D19

