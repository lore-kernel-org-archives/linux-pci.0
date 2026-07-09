Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1087543932C;
	Thu,  9 Jul 2026 07:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783582756; cv=none; b=VrBcrOoqJ2OsHxs9hgAG0lGT8ueWbcXrVSbOZR5bpErRsORdhMV+pr4wx5ZayzadOzuMDgHwp+11XVyhqb5UEO/0Me/Bmyps/OWPZ/0P/zfQUd9uhh5EC/8z4+aeeBpP+i+veSDhdNEPXIdDVGrcVKVy5fsHRBSgbszBmU4oHNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783582756; c=relaxed/simple;
	bh=bIyJyBFkm+izpnaIhnIa9OEP0eoxm0utCtxvZutld5Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=byXy/T39JTky2GbpTtVlpZVXkHYG52yZrEJUERD7udcV2we2gU8dMFjkL7qaLpWFhRGlGo3gTkVSZswiA+Mdayq+4ivC2K92W7hcAuUhmG6FYFLeUjSUkpTXai5zCIgmtTWwqdxeGi116/TKHQEHtnr/wqZplhD90fr+1N/K5uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kW34Dh9w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kW34Dh9w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 557391F00A3D;
	Thu,  9 Jul 2026 07:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783582752;
	bh=bIyJyBFkm+izpnaIhnIa9OEP0eoxm0utCtxvZutld5Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kW34Dh9wTUoRNTXUJ2OxcuJ7PIqPG+wOxI8ls+jb6b8pcs5j71hozxLgNq3ngDJMW
	 xNojN2UConlq/XKfyh3yoK6A5u/4z4EdETCZdMmfTf1EKVdcnrqkig/ySjdApVWOX5
	 pMueZsfzy1A2L9donBU6pDV+81/4lO9kRL1ufoTZanR/uCx331kMQ48mRBJIt+Ggxf
	 NDXEdrWJsiXn1Vyv4oRGacQzdQMQI0tas7+wOJtlhKb3gAze7E3UlG2sqf/jip7TrF
	 kYjcFmBwdjiCWVkOnFmqqkfKUuif5Ua5id9eeFGmbzRcbBn1tq0liSnUrWygQb4Kys
	 gQAnOFT5XaS/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] power: sequencing: pcie-m2: Match WCN6855 and
 WCN7851 UART BT variants by subdevice ID
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Deng" <wei.deng@oss.qualcomm.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260709-fix-hamoa-m2-w-disable2-v1-2-5e725091266a@oss.qualcomm.com>
References: <20260709-fix-hamoa-m2-w-disable2-v1-0-5e725091266a@oss.qualcomm.com>
 <20260709-fix-hamoa-m2-w-disable2-v1-2-5e725091266a@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 07:39:11 +0000
Message-Id: <20260709073912.557391F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The WCN6855 and WCN7851 combo chips are available in M.2 card variants
> that differ by their BT interface: some expose BT over UART while others
> expose BT over USB. Both variants use the same PCIe device ID for the
> WiFi interface, distinguished only by their sub-system device ID.
>=20
> The bare PCI_DEVICE() entries match all sub-system IDs, so both UART and
> USB variants hit the same table entry and trigger UART serdev creation.
> For USB variants this is wrong =E2=80=94 there is no UART BT interface on=
 such
> a card, and the serdev probe will fail.
>=20
> Narrow the matches to UART variants only by using PCI_DEVICE_SUB with
> their respective sub-system IDs. USB variants no longer match the table
> and will be handled separately to deassert W_DISABLE2# for USB BT
> enumeration.
>=20
> Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-fix-hamoa-=
m2-w-disable2-v1-0-5e725091266a@oss.qualcomm.com?part=3D2

