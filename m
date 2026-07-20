Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D620E419FAC;
	Mon, 20 Jul 2026 12:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784551674; cv=none; b=Q4GDRlraZY8FVZlibID6AX0odS2Uds/09mJCfYJcn3a2DksSKx8MBMv37h5/5qz3Eb46qo1gjWs9MwuBb5H1Qe2otkSc/gCKQ3ES52h22k/0jOlGHomEvjMjKUfN56M+970OzQOpXLao3KsOVcAms2NqFQ5PiQAIeXWysvAzH28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784551674; c=relaxed/simple;
	bh=/tRP9dKRDg5T0dFJ+56y2diT+nUgMjq6OiIf4j29wJw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kL2KFMsWc5kJcKB8vRRwQKkrS9ea3PXhK3mu2qhmDpQjTZWo6jJ9h7+2CRWSeqw1nXVy0WTYakcY/fyHTptNDoutFcOvkwWuM/9EQa0w+dC4l9KDFkqINaT6NrO7zv06fbnF4QNAalVYVpaciBZKA1cCsUKJNOXrLVlhXTVtjPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+oYlfKa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+oYlfKa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 632BB1F000E9;
	Mon, 20 Jul 2026 12:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784551673;
	bh=GF3I0FN9NaDCRvNKAGKjBQscJbimvB5IvicxLWR9+EA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=T+oYlfKaz12OFo9mI5spxNIhMZ91plK9R8yMAVwFB+AjuVwTVIwcrYA9589+St3XK
	 xyC0Z27KiAI+B/chFeeVDVUkesYMbJesoRaNdjhQNkrT4dSPR9tWv2u9yBb6RlyvB/
	 6kIPGyib3LZDb8xeZwoB07OtAFKOAIQgfBds8vF5NwxBo7Zlo37EaJvoWtBCbX0YCb
	 bSnfxyOZ6KLXSnE403Punoqsfce0dEKZHzSj6+PLEcFCRMZzT19/uPLVkgZc9x4pvW
	 70aqRhvRe0mW+Tyw9Tpif3Vt+Cl/hgyXO+p2yhunOhPD7rcH3dkqgxEEDF2vbjriFX
	 Jev1F7aGLIADg==
From: Manivannan Sadhasivam <mani@kernel.org>
To: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org, 
 kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, 
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
 hongxing.zhu@oss.nxp.com
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Richard Zhu <hongxing.zhu@nxp.com>
In-Reply-To: <20260715073024.1377228-1-hongxing.zhu@oss.nxp.com>
References: <20260715073024.1377228-1-hongxing.zhu@oss.nxp.com>
Subject: Re: [RESEND PATCH v2] PCI: imx6: Add runtime PM support for i.MX95
Message-Id: <178455166894.22240.7222803146225421685.b4-ty@b4>
Date: Mon, 20 Jul 2026 14:47:48 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Wed, 15 Jul 2026 15:30:24 +0800, hongxing.zhu@oss.nxp.com wrote:
> Enable runtime PM support for i.MX95 PCIe Root Complex to allow dynamic
> power management when the PCIe link is idle.
> 
> The i.MX95 PCIe controller supports entering D3hot state when PCIe
> devices are not actively in use. This implementation uses
> pm_runtime_no_callbacks() to leverage the PCI core's generic runtime PM
> handling. The PCI core automatically manages D-state transitions based
> on the runtime PM state of connected endpoint devices.
> 
> [...]

Applied, thanks!

[1/1] PCI: imx6: Add runtime PM support for i.MX95
      commit: c2b9620359b759d2c73be47689b3a344cb4e091b

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


