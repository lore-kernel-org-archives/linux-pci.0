Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CFF3264E9;
	Mon, 28 Sep 2026 01:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790559831; cv=none; b=MCFqlvE65sWMAq0BVrr/wFiYbcmHwskSlf49V6MYajvRuvoHM1KVspIo1mPUgba0CKzvrQZW7nkBFRKByvfdWbjsDS5Doxut0zNv1Ah64iQHSGmQKVkWUUWaOROHOWeLfxoyd1ZjHl7iIKRU8TnvPEpy8YdaS5WpwaxCtyRMnS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790559831; c=relaxed/simple;
	bh=CT9KbY5BbL2aYYpXaK78REnAw6ac7l+FL061tiX1Bxk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D6sTt5wBtzpdu5pxb4zvyELx26aHsKoGkDBPuewZpG9+6oXU52h9kdV1siOZl+FXzDWAOGh6Cd5BPLIku0zakYUDsdzuhmd20sdfHwqlqXQrJJFN6xRFzMyzTWitOtEAOgyHi5jfoFEr+KkblkkKFT7X+kDjwIZQ4EQYyrlPl5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCnQy9Md; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCnQy9Md"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6221F000FF;
	Mon, 28 Sep 2026 01:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790559830;
	bh=CT9KbY5BbL2aYYpXaK78REnAw6ac7l+FL061tiX1Bxk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SCnQy9MdxwUuZaXt7N1Uv/8fIPpMoI2vhtxtPqg8tMgMo+I3PF1x2z95qcebTy8rS
	 sEA/RRpfa1I65/RASg5wREKiVkU16EX97s4YHqtquMGHSGbqsClVqxYt682LaKaxS3
	 dTZdkJMXEBu9REipmAnkPMqTD00hThGA6SM7VinM4UCoQh8QuHIjcVmrGKdG5X1Wx0
	 mnmuq2WiOf9+KXtU92lX2z6k6lc1YcrgZIxlyeaAOFQaQVG6+9p8mYVkN5NLtmi82r
	 o6fyrP/mY+CXClo2OSglSGZmLEY83PaAGjfdJSlpzM+/C3yaYnE8l9vKU6HbMid5Bw
	 Tlcb3G4BtbQWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 12/22] PCI/TSM: Support connecting to PCIe CMA
 devices
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: ojeda@kernel.org, gary@garyguo.net, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260928011123.450800-13-alistair.francis@wdc.com>
References: <20260928011123.450800-1-alistair.francis@wdc.com>
 <20260928011123.450800-13-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 01:43:49 +0000
Message-Id: <20260928014349.CF6221F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Alistair Francis <alistair.francis@wdc.com>
>=20
> In the next patch we are going to add a PCIe CMA TSM driver, as such we
> need to ensure that is_pci_tsm_host() will allow us to connect to CMA
> capable devices. These devices don't necessarily has DEVCAP_TEE or IDE
> support.
>=20
> To avoid calling pci_find_doe_mailbox() everytime is_pci_tsm_host() is
> called we can cache the CMA support in struct pci_dev and just check
> against that.
>=20
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928011123.4508=
00-1-alistair.francis@wdc.com?part=3D12

