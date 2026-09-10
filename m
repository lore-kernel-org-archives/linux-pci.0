Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2C53148B4
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 02:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789005876; cv=none; b=dzAT/9rU08+kyY/oYWvVg4OkfCTrg2k+O9e90FriEjn77XzuWuHty/cfxQAUx2lwkRcQmSbsfaaIEnuEqcFKKO7Cwlq6lvTzzeopBtL+CUASVdNfcYsQRGCZwWnSY/iU38j5CHSBQkRkiXxG6eQSCOCKwWhFMWy5QFhr+7Im0zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789005876; c=relaxed/simple;
	bh=glBPFMYqsIC9oCRqenq703RxpFycj++MovlGlHPDDHE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d35HwjgKRTetN5OWjMxrVa/Lfw4ayZEUrlipBMIJ2wxFUbQFval6HgX/PcvU7roI1MsmrfOey5DjNlgJdxTGz48aBq7/0VsAHcRMXP3D4jYsPdYvIgfUijFUBrAm+Ds+0HGuW4UWyN7+iTmcHJTU2+p9h9obsSZpH/rmbAv7tEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZlrGb2NM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZlrGb2NM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C16F1F000FF;
	Thu, 10 Sep 2026 02:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789005874;
	bh=Pv+3MJfH6STwiXfwe4q60haVPINuNMoQzcJ9gMAkxcA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZlrGb2NMZd5h+GE0V09ICP7Wpv1Y7lFZ95p9fO1vEtfNVlCvUmHgewkTp9IvtlKwE
	 X9mMM8WJoF25J6s2eCWt4KuZnJtL5+MTUygnwLlj+2MBh068D3cvnBUfLWNWADb+N6
	 ti4+vaYJK1VydTjigSB3881PjZ/uzugVSyH9J89r4BpW7AqtVbm4DI8IF4LNFLbc2O
	 rcPjBy8dhCIeywbpC3t8LHzG2PyZJ/mFx8IB/7QY1XphcvXwXedrizdP97C6zm7dW+
	 w++uHIkDRUlfyYTH+3cuBpB8dHyq1qmJlckYlR+MjYIUHr+Gb2gutPaEkgFYtU/n9A
	 3zWz4pduK++xA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] PCI: pciehp: Allow more time for link activation
 after slot power-on
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hongbo Yao" <andy.xu@hj-micro.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260910015151.1876630-1-andy.xu@hj-micro.com>
References: <20260910015151.1876630-1-andy.xu@hj-micro.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 02:04:33 +0000
Message-Id: <20260910020434.4C16F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The OCP NIC 3.0 Specification, version 1.6.0, Figure 132 [1], requires
> an interval greater than one second between Main Power Valid and PERST#
> deassertion.  The diagram labels this interval T_PVPERL.  PCIe link
> activation requires additional time after PERST# is deasserted.
>=20
> In the reported scenario, the adapter is already installed in a
> powered-off slot.  Pressing the Attention Button generates the event
> that causes pciehp to enable slot power and then check the link.
> The one-second DLLLA polling timeout does not account for the above
> reset hold interval when that interval overlaps the link wait, so it
> can report failure before the adapter can activate the link.
>=20
> This is observed with an OCP ConnectX-7 (MT2910 family) adapter.  On the
> affected platform, power-on to PERST# deassertion takes about 1.2 seconds,
> followed by a few hundred milliseconds for link activation, exceeding
> [ ... ]
>     "Power-Up Sequencing - Normal Operation".
>=20
> Link: https://www.opencompute.org/wiki/Server/NIC
>=20
> Signed-off-by: Hongbo Yao <andy.xu@hj-micro.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910015151.1876=
630-1-andy.xu@hj-micro.com?part=3D1

