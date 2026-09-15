Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462824BD0F2;
	Tue, 15 Sep 2026 17:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789493770; cv=none; b=Mel4nicIH+PEmO6NIaY6Emi0JHV5Kj/s/8gnQsDAF5otm0BztDMt5DPvj6eZV4XfGcbnPYDG4C3tVLwcbv/TV9RTXxAe48SU/LcBGacwcv4Nhjoas7bbh3RMUzrnhqMhe13wengKdh9TSTYiZtsW9h/HOpzNIonQrBteumPU5iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789493770; c=relaxed/simple;
	bh=zfFQ8Nmq/zc3a+B9Vg7v6YXQkJCZIxNRo4MYZUJuzTo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hLtgzsgrBArT/jdnz8X2o8TpXGx5CRhxtG3B9wsT/OoG0WEXRUa6vlbJeWYD3VvPS+nruktFA4j4dfz7kN9zGQRhnsiLE7g64wjzFAf1Xflx3mstuOrzbArfFndnaOmNvvbUs30A6RPjJFf9rAh+FyvT72u2bkEWDEtztIbYwDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J1SSi9g/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J1SSi9g/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 850021F00893;
	Tue, 15 Sep 2026 17:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789493768;
	bh=i2bNyEK7lYxEjsGvbk1uWwxFmxiJWI8aeptZz5ozogQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=J1SSi9g/3rT4Ttgg0Zyp2QF980LG62Tm/6m/rtfghomAyEA7SvHNAmYt+9HiAJRhe
	 kr5nsQg5KZRCg4MYPTMJeoZzIYpDIYZoXYpxu15R0eplRidWHqpC/0nPupxOFr6nwC
	 XLv2DAl2YcuWNka2uW52/ihkGg194K2kJFXTYpjPBQ61BDv2rN3pW7HDBXiwCp1kQS
	 B5tazhbQ4J9OVwPqxOs2UUI77+8R3GPt7wo3SfV7EGZDB7a8wKQujXlqhNPPVtpD9T
	 fO4JYb4d/FuM9KhiXoRsJqFWtj3+njy3zh0F6UmYQHnT3o0r6B2561z9LsvryhbCaa
	 EGRlIY9bJFUWQ==
From: Vinod Koul <vkoul@kernel.org>
To: mani@kernel.org, frank.li@kernel.org, den@valinux.co.jp, 
 Devendra K Verma <devverma@amd.com>
Cc: dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, michal.simek@amd.com
In-Reply-To: <20260907101213.1917064-1-devverma@amd.com>
References: <20260907101213.1917064-1-devverma@amd.com>
Subject: Re: [PATCH RESEND v5 0/2] CPM6 Channel Separation Support
Message-Id: <178949376612.248239.2160223448056351336.b4-ty@kernel.org>
Date: Tue, 15 Sep 2026 23:06:06 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 07 Sep 2026 15:42:11 +0530, Devendra K Verma wrote:
> 'Designware Cores PCI Express DM Controller - Reference
> Manual', section 3.2.34.3, VSEC for DEVICE INFORMATION supports
> the channel separation mechanisms. Basically, the HDMA IP allows
> the user to configure the separation between DMA channel
> registers and retrieve it via the VSEC capability mentioned
> above.
> In order to use the VSEC functionality following changes have
> been made:
> 
> [...]

Applied, thanks!

[1/2] dmaengine: dw-edma: Enable Chan Separation via VSEC
      commit: 62fb4a3a59223abb4d7baa3e088169767a28d551
[2/2] dmaengine: dw-edma: Add changes to support Channel Separation
      commit: ff4dc66e80d2c31138a9ca31f1a4340dc4919d50

Best regards,
-- 
~Vinod


