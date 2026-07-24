Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46773C4168
	for <linux-pci@vger.kernel.org>; Fri, 24 Jul 2026 08:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784881854; cv=none; b=NZ/AsnPavdCtdB9u8+MNDNbiIQDQCvKzqB1iElbU9S7C0svyNb6/3zO3r11bi+OPSCBzrmM2EJBOchpeUpwU6zue0cOGN0WE7xv1WvMY5ss5iX9Uk1jrhis3QIgF3ehpDE0Jw4l4tvi/xxa7dj4WOGTpA8JAHYneFpJHYyBdnHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784881854; c=relaxed/simple;
	bh=W1Yhj6vhi2adP+pSCH74MZOmiLQKg3+Arw3dtd+wg8M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nhJjsuUBbfHxNhn641MP03D3g6PxjU3YifgkEDxi7r7k7mPeOjbdyUKSQ8XZpyJnrqhiXIMjuorzgQiM231jLl8Djqrsmfo4AJh2oEGZ3hIFcP4OSLDvr/PxxLPLkcAJjLtY/coaxx8WYQuO6YcdvM0kSV8k2jjMwOVFJ4F+bG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cw5JI2W8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cw5JI2W8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE9BB1F000E9;
	Fri, 24 Jul 2026 08:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784881850;
	bh=W1Yhj6vhi2adP+pSCH74MZOmiLQKg3+Arw3dtd+wg8M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cw5JI2W8+5xPnT1G27wavvzl3uQFAh9TqEF8VN4V8n6pcPiYtmPqV0th6rtcaEokl
	 m+mYlbGHv+vHVh8isnKca3IaWSti4CZLzxMUScEoVg9tWYxaP2dIkshfxeoUkjn4nW
	 +d/6U26ESA8xqwKr4YJj130uGhSt9zFK588X6h+r3iAfCo1OnuK23HQUhhtk/atgV6
	 BdJzgj0kgRaKJrp6DlKUhK8AK06m0uwUFdRPcuI6II1/05MdR1/IeWQBES+kSdP5mc
	 yL8pTzWfwaGDb4FQEhkSxE5BPQApgVsjKN2JpEViafNtDnXEtCoN6UBLoI9T9AbJWP
	 lPV/XkhmHvTCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] power: sequencing: pcie-m2: Match WCN6855 and
 WCN7851 UART BT variants by subdevice ID
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Deng" <wei.deng@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260724-hamoa-m2-sub-id-v2-v3-1-af97de70bbbe@oss.qualcomm.com>
References: <20260724-hamoa-m2-sub-id-v2-v3-1-af97de70bbbe@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 08:30:49 +0000
Message-Id: <20260724083049.EE9BB1F000E9@smtp.kernel.org>
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
> their respective sub-system IDs, so USB variants no longer trigger
> UART serdev creation.
>=20
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724-hamoa-m2-s=
ub-id-v2-v3-1-af97de70bbbe@oss.qualcomm.com?part=3D1

