Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9EE5AB918
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 14:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792421430; cv=none; b=PpjtyzvpmOk+PRIwNUuFs1lLlxklkjzEYQ67193SBvziApa8HC/y1GJSHln291xc4nzczLsV+84TEkQNf3sKHasSWT2TgOO8lsSgHFSnkYWZLBl0Z6XTgW7onydlfyY2vGIOuve3LyS9OwXBvQX96I0uk7ZC4OwtpxX+TzGhZzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792421430; c=relaxed/simple;
	bh=qq+TIEp4lWoS4sSDRgq/P8zzwAijPYMVIY+uP9xrQ+k=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Zusz/Ct0++UitL4hgEl6lF+5BeNOpw1koiLSCfAU/E2x/KIe6nkaOv+aP40Wvuh99hzn8gZFCKo6sWX9xQnEetokzks2I52RZTW1n2JzTEjKLqmEuqHiZk1ItsfmHH5jjYXSKFqgzFPEuf4ju/WBkKDlDCIQoqDh+m+DKdMSLPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d74upUcM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d74upUcM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDECC1F000C4;
	Mon, 19 Oct 2026 14:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792421429;
	bh=vc5yTVU40r/2iAc3TIVYvZnrEhcxaj2bsKxBQVI+Wek=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d74upUcMHgaV4rv26pfa6QN5NK9ScW3CT9s/RKkqYSRxUO9B/wI0q/oO5It624y6U
	 cxHQYJy40I/0UKCCIjGTFqAFSoKyJcrfcxGQZo8pZ5GpnKP3gm2GWbSrdw1xitrs1e
	 L4LCilfC7Bzai0YAzKdGhbwUcEfeyxx5IdTuIiBn0m0AFPByI8g0zJH87LcUzBxVt5
	 92xE9+llLta/6qcGJQAEFvq/1MnRvGFBqa0KAILb/snDMcwxvdjdG2J5yQ475a/Kpm
	 1RUfzu8DGdMOEzCNOR/uwJdm6cXqcpp6GiTRXLfIBt8p+7YUyy3japyRJI+WhT1W4W
	 arCjC1L4y1QYg==
Message-ID: <sashiko-outbox-177518@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-5.10] PCI: vmd: Handle BUS_RESTRICT_CFG
 value 3 for Arrow Lake-HX
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261019135441.1420968-288-sashal@kernel.org>
References: <20261019135441.1420968-1-sashal@kernel.org>
 <20261019135441.1420968-288-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 14:50:28 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Ali Alaei <ali.alaei.tabatabaei@gmail.com>
>=20
> [ Upstream commit 72b32eccbcd591b9606edacf3bd7c455176d7660 ]
>=20
> On Intel Arrow Lake-HX systems (e.g. Core Ultra 9 275HX on Acer Predator
> PH16-73), the VMD controller reports BUS_RESTRICT_CFG =3D 3 in the VMCONF=
IG
> register. The existing switch statement only handled values 0, 1, and 2,
> causing vmd_get_bus_number_start() to return -ENODEV and aborting the
> entire VMD probe. This leaves NVMe drives behind the VMD controller
> invisible to the kernel.
>=20
> Hardware registers (VMCAP/VMCONFIG at offsets 0x40/0x44):
>=20
>   VMD 0000:00:0e.0 (8086:ad0b): VMCAP=3D0x000f, VMCONFIG=3D0x03b8
>   BUS_RESTRICT_CFG(0x03b8) =3D (0x03b8 >> 8) & 0x3 =3D 3
> [ ... ]
> Signed-off-by: Ali Alaei <ali.alaei.tabatabaei@gmail.com>
> Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Link: https://patch.msgid.link/20260628143450.92492-1-ali.alaei.tabatabae=
i@gmail.com
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019135441.1420=
968-288-sashal@kernel.org?part=3D1

