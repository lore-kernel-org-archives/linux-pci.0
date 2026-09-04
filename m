Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2DC4EC645;
	Fri,  4 Sep 2026 15:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788537449; cv=none; b=bCF+nuT/qS/DtAJyHcgke2Zn4QPwRo4/PzR4RO+0TnF+mdhs6NSaEwdmduUJApI64wcpfP4nQfYkBqV4I7n3HzjJp1MchXNPKoCvPsqiLrhPilirothUNDRathBHLxXhrKt+DRkMsUJtrSdQORSNBq1fVmqfkYlq5s3a0wTfDSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788537449; c=relaxed/simple;
	bh=S0hgAg51wxf5ZU9KsT5K6K5+IwYs3A3lDfDJg/PLPfA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hKiRQFTl/RNW86EGBNCiWsmlkRO8lfuhPoj/YwUcfCp11HCQrqcWLQLVfpgtuRt5U1uHP5VMYov2+dgCxbLhZFqBH4M40Id8SN47VX9g8IbRLlpUVn1c59ihrEXHLiW+yXgbzsE2fmFRhakoLphPQEYScKb/NLk/2LOcpH/M8wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZBC5DQSp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBC5DQSp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C55E1F00A3E;
	Fri,  4 Sep 2026 15:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788537447;
	bh=S0hgAg51wxf5ZU9KsT5K6K5+IwYs3A3lDfDJg/PLPfA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZBC5DQSpiMr8KRqm2+kbvwH7jEVU59APU5R7C9qpA5e22kmb5Quig9NzpW4OGgOg4
	 Rj/D25yl2fCOG9pRUnTI0dGxeOkJUzbgI3iY1JebPD9e30mDfw0US85jOGqg7oWFCg
	 byAAD+UY2+ZswcpkR+HqSIQaa119M9URn/YOQdwCK7uIZQgg1PlVO/AHyQGVNpGcic
	 x0GyqIFiTUGQeWiDzp77HIueyzdHAE71dSDQEIu7EQAkBbM2VVtesrwQqTn2ZDGZP2
	 WHx1tfOMqYh8kg3bfp7VWm69ZfO82YBnkpUSsliqhKtB1byLS4+svlSD0Hl0+SXErp
	 +mmzhHDC5NoYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 09/11] Bluetooth: hci_qca: Flatten struct qca_power
 into struct qca_serdev
Reply-To: sashiko-reviews@lists.linux.dev
To: "Loic Poulain" <loic.poulain@oss.qualcomm.com>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260904-monza-wireless-v6-9-d8c5042b3efd@oss.qualcomm.com>
References: <20260904-monza-wireless-v6-0-d8c5042b3efd@oss.qualcomm.com>
 <20260904-monza-wireless-v6-9-d8c5042b3efd@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 15:57:26 +0000
Message-Id: <20260904155727.6C55E1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> struct qca_power currently only groups a handful of fields
> (vreg_bulk, num_vregs, vregs_on, pwrseq) that are exclusively used
> from struct qca_serdev, via its embedded bt_power member. The extra
> indirection level does not provide any isolation or reuse benefit,
> and just adds qcadev->bt_power.<field> noise throughout the driver.
>=20
> Drop struct qca_power and move its fields directly into
> struct qca_serdev, updating qca_init_regulators() to take a
> struct qca_serdev pointer instead. No functional change intended.
>=20
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-monza-wire=
less-v6-0-d8c5042b3efd@oss.qualcomm.com?part=3D9

