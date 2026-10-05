Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D0D3DAAB9;
	Mon,  5 Oct 2026 12:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791203351; cv=none; b=ELnveRqDtxyPPjE5PzDh6fkVRtDs8uAcUqaZPGvdvKQypqGmxzC2UeiGRO8hFRXUB8OokOX/4tqGiMKZYDPQbZgv+Xk4aAHMFzlFboIDAuf8ONcrHjukXSws1MQSZ9jiE5TWNBYPhm81fciGl2n2ERJNfGzgGOmbKatkCXQbWas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791203351; c=relaxed/simple;
	bh=/oNfkegiwRT1rMxztT28gsa5kIeuGk+pYJJ3ZxDPXD0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V9um+DbG8MB1jhHVxrao3jdMtIgj+Noj9yefqM6pZ4J0dfWqWiSmf9UKNVt5YpsqATyKyx3vSch3VcQAkX8FbMzVJ+u8UPUeCm8IiyVP8eUvRaFo3qG+JuiNm6wyJPuEUw41Qgd2mT39vZ9KYnWpwst63gIB4VthIpSrjN02/PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2YgUCHg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2YgUCHg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FDF31F000FF;
	Mon,  5 Oct 2026 12:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791203349;
	bh=/oNfkegiwRT1rMxztT28gsa5kIeuGk+pYJJ3ZxDPXD0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I2YgUCHgjj/4W2JpLEsUgnUm82OWuTYsi6c0Y837yFSqVbxrikhdhwjeXwctTjDOB
	 S6DEGgfZ+yGS8uzdazTDBXjf0ETuUG4tWsFlQQOzGah7/nOvnnl021eVZLi86psVO1
	 L9kbDzq1MPNNP5O8D7719kSvMf3GR/fCfJYZM9McFCreXoie+kn91/rKxv9kWp9pDs
	 0k2ntdM5hMg5mCdOzk9CG2dlZqhw4lvMjBEUgGJs87R5OOnNYNSXb6hRJvjxYZn/Dj
	 FcckoJmjGppnbljSwezMebsnwUfq2/tryM7L1ADnaIFtmkeuLlY/eQmEf3Ecwbh3ev
	 s0/xSxN5bU8tQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 6/8] Bluetooth: hci_qca: Flatten struct qca_power
 into struct qca_serdev
Reply-To: sashiko-reviews@lists.linux.dev
To: "Loic Poulain" <loic.poulain@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20261005-monza-wireless-v7-6-5a6de7662dcb@oss.qualcomm.com>
References: <20261005-monza-wireless-v7-0-5a6de7662dcb@oss.qualcomm.com>
 <20261005-monza-wireless-v7-6-5a6de7662dcb@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 12:29:09 +0000
Message-Id: <20261005122909.9FDF31F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005-monza-wire=
less-v7-0-5a6de7662dcb@oss.qualcomm.com?part=3D6

