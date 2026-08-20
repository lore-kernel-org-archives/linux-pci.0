Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAF53CBE91;
	Thu, 20 Aug 2026 09:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787217294; cv=none; b=ovALnDwRuTDKD62kOKDD/zvS/8zkJMDm39z3T+uLPSaC/zZ5LMsrVHEBjgyyqQM8ui4nRi4ICYcThqP/tq6zmLrO+LWDIYG3FNwxr6WEsVlOxYJVHHwdgHHRvbZwqLKuWh2kVkPHBps1NQ7xkv83KJqCiwi6NYqPSw3tkzpWvbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787217294; c=relaxed/simple;
	bh=/KMZPFtkj9t2gxRoH96upTqZWXgL6wzpycQ1+IKTLlo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZlBW+/Eq0ZFKlfPQcAFJrWts2wFphWNqPnr2wlwXOnNvDkqFX03HKxFOnamHSVwXyINFgh5rJrlLKqvNjVae6wTHXwaWRwtO5fweE2p49EYSdkWQUrkSirveO6NRVjNX0ibubR4WR4kCobPE1mIbSeJ1J0z7o5D4jsHCGgjJWZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKDNtouC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKDNtouC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 302F41F000E9;
	Thu, 20 Aug 2026 09:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787217292;
	bh=/KMZPFtkj9t2gxRoH96upTqZWXgL6wzpycQ1+IKTLlo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AKDNtouCt9xF0gsmtt65d7BNzVvZqW2N3+JbxIs60fMfLyeooSZYwAIrllisnBZRf
	 LIg2AIEue8WocAmvpEnog/0Fatgk6dFV0hlps+AMFXAn/dgwpn6rKw3vxaCFrDKNOC
	 +4f3YZEVynElGgW0yeuxIFK+kozLQ2psUvEBWuneH5mmTLQdMwbXAjmjCKNWNzJSuB
	 BfbTZ99MDfHRdTGUfGq+g4EpJZo3UtRSPNBfBnjeyLSkqWfZnpbGGlvGgcn+LlZNFK
	 v/bQNW0Dye4F/7/yJnJhkSX2l9Bf44BvLgWKElQrx/fM3xpisiXFBfTnlrOkGyifmb
	 Kqz8E+kst4D3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] dmaengine: dw-edma: Cosmetic Changes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Devendra K Verma" <devverma@amd.com>
Cc: linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260820091314.684871-1-devverma@amd.com>
References: <20260820091314.684871-1-devverma@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 09:14:51 +0000
Message-Id: <20260820091452.302F41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> o Arranging macros in ascending order as per the bits represented
> o Cosmetic changes, typo corrections
>=20
> Signed-off-by: Devendra K Verma <devverma@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820091314.6848=
71-1-devverma@amd.com?part=3D1

