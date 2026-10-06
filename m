Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F6037F337;
	Tue,  6 Oct 2026 09:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791277295; cv=none; b=qTz2uQpVSjGdrqXTp6p5qH0hH29CmRp8W0GzDTrtn56WhIGM7jjopNT2dOT0m4ryRsWbe34HPn5rqJKyTO48JOjcJA5LIWq1pkAnqPdpAaNW0dBvkh4yTHJhBS/ZD0JQLdBxHhlhi64Xj8Tp0373dVCnyKNWPj600cElPLjMWnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791277295; c=relaxed/simple;
	bh=NpTTfOyzWrYAUf4xq4vqee7Y44abl4q6Y9GUN5BRQc8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O87UvBJbU0Tc5IzLEIbsQa6wM1gzjEuFGXBiTlROXU/I17GEUPQU4+OlOO/z2HCTYAEXD3xq6XewSh4sTfXEXnBTRwWsCYvPBDHrDxHzeb8LgTAqjA7MtxIDfSY92m//zujSKFWft7O0KuTYAMe3V3yhROuLA0JOIchnQ01xlhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=heOmBfyr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="heOmBfyr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486181F000FF;
	Tue,  6 Oct 2026 09:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791277294;
	bh=NpTTfOyzWrYAUf4xq4vqee7Y44abl4q6Y9GUN5BRQc8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=heOmBfyr4CAYDH/sP0QRT71+YuixP/a9lPC9gQZPYRNnFpbzWvqhk0Y/7/wxELGrG
	 DcEZ2rxOfJpYtzyw1v1avHeZo6DEOHYJJiG7ftankyXLmpTsPnP8Yn9iTAIF5DDqSz
	 IDuWnuZI/7MuCdFVAQRUbgYwy4lAPZkY/BXE9JbMH7Xt8rKZcX4JH4GD7rXwu+j3Ex
	 PnXssWFKed807z3FV5haq39hhu01bHT3gJwIeEIRwjLen/j3s88PpYm76E8j5fXlgP
	 VeBTiskS3R2WnUQxdjioYnrh7b0SALFIocpIllAhKh/88j2Px03/h2w8p+q87NKfGe
	 53jdUgndD5Pog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/18] PCI: dwc: Free the MSI domain after the host
 .deinit() callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20261006084638.3821710-11-den@valinux.co.jp>
References: <20261006084638.3821710-1-den@valinux.co.jp>
 <20261006084638.3821710-11-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 09:01:32 +0000
Message-Id: <20261006090133.486181F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> dw_pcie_host_deinit() frees the iMSI-RX domain before calling the host
> .deinit() callback. For a core-owned parent interrupt,
> dw_pcie_free_msi() removes the chained handler right before the domain.
> A glue driver that owns the parent interrupt and demultiplexes the MSIs
> itself through dw_handle_msi_irq() can only stop its handler in
> .deinit(), after the domain is gone, so a late interrupt can still
> dispatch into the freed domain.
>=20
> Remove the domain after .deinit(), in dw_pcie_host_deinit() and in the
> dw_pcie_host_init() unwind. Keep removing the chained handlers of
> core-owned interrupts before .deinit(), which powers the controller
> down. Clear pp->irq_domain when the domain is removed so the unwind can
> tell whether it exists.
>=20
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006084638.3821=
710-1-den@valinux.co.jp?part=3D10

