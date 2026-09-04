Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3343B840B;
	Fri,  4 Sep 2026 15:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788536929; cv=none; b=ofElbFgdZI42QF5Hfo7MnHXO/UknDUQksbV8wsSu21pkh29B1WPu3hyCf691ejwZ7+qKEckTHBh+s83UZKKELY7D28BKX/G5Q0YCJv1nEpPE0ULqLrXiwO9AQ6LpsV8tJbyMAlP4Y8KizZPgqwWyOXQwGrZH4dZyVRNDZvtnFYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788536929; c=relaxed/simple;
	bh=yfWnRs6Juz4wgAxAFAHLQuN13oSwkjYXEC+yJ6d3rmI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SYhWxSUpYwOrA6Jo3uora/lR1Cwxhsu02xxdaQDkQx5GMpw0I7RQprO50R3X69mFN6rD3UXIdQSo76NzOqsSljHS62Ptg6gjl7L4k2fpE+92CKXXlcIHQSH6IosfLPdjETQcDXoh0C0Yo/qa46yA2xDNj3eJ0bSvAF82tCzqc9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PyFkiiV4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PyFkiiV4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881FE1F00A3E;
	Fri,  4 Sep 2026 15:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788536927;
	bh=yfWnRs6Juz4wgAxAFAHLQuN13oSwkjYXEC+yJ6d3rmI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PyFkiiV4W+p+rauiq/2XcxDyGB5CFh48jTFVLdWe3X67ghTQWe9/kzzJyy+JcknM4
	 nkmvHXmvg3zD+hRJxKVd0mSLSM1IRVIKuI5uD1kZYusMG0BPBrDz57vtTMFkYlVt6a
	 NkrRhaq/+0M+zj7e7m1mD40PSc4BXHuvymTMl6J3QbmFvcjVtKzSdGAFQSQLr5r59q
	 +RzswLUZ7UzBnRnSsP3RGPxeAfAIiw39tdqsRO18+e7MPWFAIxPpf9QNHEFNLFOGow
	 ud8qTtDcDNK36N90++4BgNtF51vK/xXq+lHg+7kDRF67tJ8geOx6dwJoM0Pyk8K770
	 z/HWC24QmoiAw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 04/11] power: sequencing: pcie-m2: Report power
 controllability
Reply-To: sashiko-reviews@lists.linux.dev
To: "Loic Poulain" <loic.poulain@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260904-monza-wireless-v6-4-d8c5042b3efd@oss.qualcomm.com>
References: <20260904-monza-wireless-v6-0-d8c5042b3efd@oss.qualcomm.com>
 <20260904-monza-wireless-v6-4-d8c5042b3efd@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 15:48:47 +0000
Message-Id: <20260904154847.881FE1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The M.2 Key E connector gates/resets its functions through the
> W_DISABLE1# (PCIe/WiFi) and W_DISABLE2# (Bluetooth) signals.
> When a signal is not routed to a host GPIO, the corresponding
> enable/disable callbacks are no-ops, so the consumer cannot gate
> or reset that function on its own.
>=20
> Implement the .is_controllable() callback on the "uart" and "pcie"
> targets so that consumers can query this per instance (based on the
> runtime presence of the W_DISABLE2#/W_DISABLE1# GPIOs) via
> pwrseq_is_controllable().
>=20
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.co=
m>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-monza-wire=
less-v6-0-d8c5042b3efd@oss.qualcomm.com?part=3D4

