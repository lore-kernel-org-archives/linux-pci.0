Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795521304;
	b=dOvLMRSICb8uc5LOsw989YquqM6V2WYRZUjElYXHJrzpeq57UdAOcLYgZ2S3d2vnFdvg
	 uCpyVBsJgLJRr9xMAljAvIWOsckIh5hPgbiMMDNrfoJWaHdnUUcvTGRtSyFvEZo3btXXn
	 mEiTsb5M/61lk1VtspZCzzN8lrYWfwSmZedp5matzVI5qvU9/i2rIQY5zEWxoSDsfEr8C
	 qP/V++pxABT5FqapI2qkReTGqeUwAdYEYCm79Yu4/j+CpcwccbGeAs1uMgu3LVa5yB9W8
	 ioMxnKVb7FGtXFfD+tE4Z5i/iidwsu1xkNZqjlk0EjXlLG7zrvJVc3LhTxP6Rkip03A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795521304;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=fmZo+0Ao3EF+QIl04S3p/W9Lj1cWNEMUZFJap4lCZFU=;
	b=aueVY4LH+t7D/Zl6ohFFRw+5R7zPSyktkJO+B3svtYAo77IdzUlGHyvZTB/rAzVOMA7A
	 lmEaE28i9s8sIjUMzk7HkrMPqCG9rrqHJs4UDe015ieQB6tbVPYZbzaqsdszO5R5bj6Xi
	 eeryzfIxh41vVW+lglW707jGFuuGHBfZ1WUJtnyH1m533zWTsiW9l2i+PvJITQCn0lLmZ
	 rbuCu2DsyJ8wFT0c74asykWR2ROBFI09J124mx65HMRKLuaMUZg2gW9o2NCUjoXwegpbn
	 eooidh72kAW9AI1cPEQRaQ9/1ytW4+n17B9sB3tYHwxyil5T6rMa61wuj/Cm3b9hJWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T3pYvJHL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0667606A31E;
	Tue, 24 Nov 2026 11:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T3pYvJHL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 942CB1F000D0;
	Tue, 24 Nov 2026 11:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795521304;
	bh=fmZo+0Ao3EF+QIl04S3p/W9Lj1cWNEMUZFJap4lCZFU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=T3pYvJHLYy5vKyu8LB3UEg/PMFLBcBDp/eCMnScvwUojcDMDhrMfxUCp8F/oiRU6Q
	 dkrZgVLgeSgC1FmTIGNbOweOxRlWStQ7Ga4+Gd/OxWijqX36jSP2R5KXFu/CwOiF/Y
	 EMB7Q3ghlrKevRuJqc580qRP6WIKHFKGTdEM9cp6RXKOPIeK71+E1FX0MbsuoJ5OJG
	 GY9QEXnjq+KXb672Nqpn2xqwqKGgRh2yBzQYZeFtkpYEdlQBNRFikM/Pc4fB56+CI/
	 9EJDhi1ZClinNxLTCoCzZBGG2Q6EXKCboUowcKk/2C4Z9soEHBaqnja+lk4Jd9vTV5
	 Xb59PauHKHmtw==
From: Manivannan Sadhasivam <mani@kernel.org>
To: =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Niklas Cassel <cassel@kernel.org>, 
 Koichiro Den <den@valinux.co.jp>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Frank.Li@oss.nxp.com
Cc: imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
In-Reply-To: <20261106222142.86087-1-Frank.Li@oss.nxp.com>
References: <20261106222142.86087-1-Frank.Li@oss.nxp.com>
Subject: Re: [PATCH 1/1] PCI: epf-test: Use dmaengine_has_cap() instead of
 dma_has_cap()
Message-Id: <179552130022.34532.6770615796596970693.b4-ty@b4>
Date: Tue, 24 Nov 2026 12:55:00 +0100
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16.0


On Fri, 06 Nov 2026 17:21:39 -0500, Frank.Li@oss.nxp.com wrote:
> dmaengine_has_cap() takes a dma_chan pointer and avoids direct access
> to the cap_mask field inside struct dma_device, which is a step toward
> making struct dma_device internals private.

Applied, thanks!

[1/1] PCI: epf-test: Use dmaengine_has_cap() instead of dma_has_cap()
      commit: dd3bc74bea3263774e30fd6305012eb16dc0ec96

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


