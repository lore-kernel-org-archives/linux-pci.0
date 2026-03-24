Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AE0366061;
	Tue, 24 Mar 2026 13:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774360780; cv=none; b=D6mVazh1VS1a5Y++kSFjxHjhGc8vNspUiclzyXaa0vNa6r7oGXrQXLFQ4XMS6qM1FhpxISl3dx5QXIysPvQVuEEIF5zHMoayfYU308+jXPepq4sGidLXEKZKeAeGA6D66dLpqGu0Wj+QElIt5rRTW/gfstK7uVPhheb5Z1MVpto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774360780; c=relaxed/simple;
	bh=BpBF4Xd3Un1KwZ2hq6An/tdIe23nMhzQBvd+Qgc5hDI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g1o6ZSWsfsiYUA/5hIQwfzMdMTlF1zXaBDjCfLVNbkJikyOUb4xnxtbobZsbmFshhl0+ePawZldlLoP5f18shzeU5G9f7BlHaQ68zScE/KEbIIUu31nHe0Q0cHisOVk4ZsP/V+pvEwdx0Lfe8LCkZS/ruBmzuSiHiMEw+HeXWSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FpNvKoL/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FpNvKoL/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19248C19424;
	Tue, 24 Mar 2026 13:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774360780;
	bh=BpBF4Xd3Un1KwZ2hq6An/tdIe23nMhzQBvd+Qgc5hDI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FpNvKoL/YhmF2A2z+7IkGLsAnm5yaOFJ5o03l3W+rVGXItO9TP3sReO0XbemuXHdV
	 ZXPs/QssNOgRRpki7X1Bp5S1+6PzageiJGqjYaj1wXd8vTdurfZTouQHQvll7c/E/s
	 Z6wuKKIGlduYuFyO5nsASJWylyTiNKt+tvgW0CiA9zLAkwHticIB7EBc51rNXZd8t6
	 88VtC7dulvBe03GjwCbtg7n2r6YwRb5lBh56gAtgcE94PKsXrXNzLFg040WWbif8Sv
	 ulAWL4kV+rernZEEdMjXYrd7UVIlLFEZEUNMJUmQy1OGJK3h8/TXQku6y2PjmS00MJ
	 6MnCQ5lxn+yQQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Marc
 Zyngier <maz@kernel.org>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Inochi Amaoto <inochiama@gmail.com>, Nam Cao <namcao@linutronix.de>,
 Shradha Gupta <shradhagupta@linux.microsoft.com>, Randy Dunlap
 <rdunlap@infradead.org>
Cc: Xunlei Pang <xlpang@linux.alibaba.com>, oliver.yang@linux.alibaba.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI/MSI: Update MSI-X irq domain hwsize
In-Reply-To: <20260324014754.4973-3-kanie@linux.alibaba.com>
References: <20260324014754.4973-1-kanie@linux.alibaba.com>
 <20260324014754.4973-3-kanie@linux.alibaba.com>
Date: Tue, 24 Mar 2026 14:59:35 +0100
Message-ID: <87mrzxgwfs.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Mar 24 2026 at 09:47, Guixin Liu wrote:
> After the upper-layer driver removes the device and before the next
> probe, events such as firmware updates may increase the number of
> interrupts supported by the device. However, the irq_domain still
> retains the old hwsize, which causes subsequent interrupt allocation
> failures. Update hwsize during MSI-X device domain setup to fix this
> issue.

When a device is removed then the corresponding struct device is torn
down, which implies that the device domain is freed as well. So how can
this end up with the old state on the next probe?

Thanks,

        tglx

