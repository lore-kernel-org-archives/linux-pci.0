Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8D63EB801
	for <linux-pci@vger.kernel.org>; Wed,  8 Jul 2026 07:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783494637; cv=none; b=FLzK/G0X/bVE+UiHMzMQA3+ALWIU4K1axNfyFMD+Q/KcoNjGwzNpOyKUsYxK7SENHoAj4tF3iN2Dd6KXxu55hTDiUU9Zk1IzoVmTO70k6jFWBh4wJcddLK7GehpGh7EWtFKk2zxJUw/46OCElbRXcKun6p3ut5vIQJPpvooE5ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783494637; c=relaxed/simple;
	bh=0Ek4Uv5uh/IDEP1D5U/PtvOShmLMQO3NCQMTucKUsc0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KqWf+sD9UMN70ZJuFxMLD4nXTj5nOaoJCv80SddTkGmMTvf2aG2fFcGU78mjNUoLtEceV4SZH9HlE7LyReA4Kmg4xIHqo0TQkUnz4w1WdLCYZmntCjKxAIAu40aoSBEMAEfDBUnRYu7IoGUTdpwg66WFHluXF7CqQkKEPTJ6Nvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=heo2C6Fj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="heo2C6Fj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B50CE1F000E9;
	Wed,  8 Jul 2026 07:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783494616;
	bh=0Ek4Uv5uh/IDEP1D5U/PtvOShmLMQO3NCQMTucKUsc0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=heo2C6FjDvWaQLzovNiwOtlJmvu8RDRjr+UOo1F/6hmdEhY8+BAmH20JbdNzZQvJH
	 vzwvs7CGXk48psmaFwoHcpaT9DK/mVMnrkt2Y/wGiXLecWqrF7nM+wnj2pos0vnCBM
	 /khvPVUoLz+ZF4N+dyJW8VgZBCDFqXDpxdojmwnuEbuZFG1eY5ADia0nPuiykEhcRS
	 xS59+EFuFVGQcAX/4ThXd5y0G+iZ9ujzhWdqIscSoatrkEEaPfgPJ3qkpoVjeHnVf6
	 Rk9RHRE8c/RgpYI/2SAF7szTJa522kBMH73lsb1LbXmLzbHYKtdmq6uFmkScRuN2r/
	 GO5DFw26pILlQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] PCI: vmd: Add VMD Device ID Support for Intel Nova
 Lake (NVL) and Dunlow (DNL) Add VMD Device ID Support for NVL and DNL
 processors.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Szymon Durawa" <szymon.durawa@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260708092957.3269545-1-szymon.durawa@linux.intel.com>
References: <20260708092957.3269545-1-szymon.durawa@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 07:10:16 +0000
Message-Id: <20260708071016.B50CE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Dan Williams <djbw@kernel.org>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: linux-pci@vger.kernel.org
> Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708092957.3269=
545-1-szymon.durawa@linux.intel.com?part=3D1

