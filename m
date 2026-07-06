Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEEF384CFD;
	Mon,  6 Jul 2026 02:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783306599; cv=none; b=XbhtQDbdwLiZ/RnTqjBY+Ijkr3aJw7UDexU/O6jMoMJ97+eUOpbzDtZhqsA3LqETiBWed3MhdHpHr7BIcPdYeqadNBZXdJ1DwElNo/nSm+kkmW4wt//x4fySEbTO1jws2ri34TUKp5rMLhgwIEtJXhudK6gDFp1P5eHyWMXATM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783306599; c=relaxed/simple;
	bh=IJqCjtXpCoUE/v7PgUvu5k5lyOP3sUybOj8mb5lDPuE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZMfg8TeDe5s3GlAnz97v3yXtPtb5/vNXSNKvFAhNBTBpL5lg4T0hMF06emi8T8Yg3ks6NEoGjqZQRS1C67QP+GGL4dCTUHZqK3mQsk4VPMSVQS2ua9ccRCisrqA+H1WoUu2NDyPHqCPIYp8VyVB/+3Gq5rnBhA2vGllQw16zbXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOQApDED; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOQApDED"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7AB1F000E9;
	Mon,  6 Jul 2026 02:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783306598;
	bh=IJqCjtXpCoUE/v7PgUvu5k5lyOP3sUybOj8mb5lDPuE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FOQApDEDQZh1FcqYgKX5SC2sk+8cG+lWv3X/jearzHH7ES0HWMSxKkhney4VKIa/4
	 aeWMGTFe6eTR81Bl9k95OsOlPjADg1u/VECKvkLtIFrnfKSkwiv1+zxIMVZyqydaMP
	 4raTEfk26PeXlO2dWwTpHdJpsFmlES27MSjWsDsRD6HTBFk+ZfbM+azFLAvhNUOPu5
	 3K8zWlhEWfwCty4EDdm/BM/gona9TBIYLQnmSsjU1MMuh5Q8CXSPvnFw94SaydokxR
	 7HpZg7xIOXw97rM0WJSreuGpl1n+UTPc+fJHWD9GI/+6WU1iKLF4tJwNXTPHE7ZEMS
	 kYHKmqAc0xfOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] PCI: dwc: Add force_l2 flag for platforms requiring
 L2 entry without D3cold
Reply-To: sashiko-reviews@lists.linux.dev
To: hongxing.zhu@oss.nxp.com
Cc: imx@lists.linux.dev, linux-pci@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260706024752.3256106-1-hongxing.zhu@oss.nxp.com>
References: <20260706024752.3256106-1-hongxing.zhu@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 02:56:36 +0000
Message-Id: <20260706025637.9F7AB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Richard Zhu <hongxing.zhu@nxp.com>
>=20
> Some platforms like i.MX have their PCIe RC controllers powered off
> during system suspend, requiring full re-initialization on resume.
> These platforms need to enter L2 state to properly notify endpoints
> before power loss, even when D3cold is not supported.
>=20
> Add a force_l2 flag to allow platform drivers to request L2 entry
> during suspend regardless of D3cold capability, and enable it for
> i.MX PCIe controllers.
>=20
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706024752.3256=
106-1-hongxing.zhu@oss.nxp.com?part=3D1

