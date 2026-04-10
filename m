Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA0C3B7742;
	Fri, 10 Apr 2026 11:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775819406; cv=none; b=SdAzPoR3Qku/uXxWfQ0qTMGDUJgKDAW6/zPilGepPE/9kufcAbNaoWe6Hh18dJ/w14Ds12h7RL+mZ/fswGsOsdtcDyL4F1aJCuEKGj9GWWRaR91jLmd8mCkuukUUbbitD1CyXa44K5Li4V3IZT7oq07rcQIyTsVpiwAom68+E/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775819406; c=relaxed/simple;
	bh=J9CQoX7GTnEen2B2gzOk+uOsLwI3v0SjpCO+RqDM+0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=se2oZAZG8BgS3jyu0m8b+dspBv7puDhKtTcLYxHqF1kFNMT0nZTAPHpIAaUv/VNKLK8W7sxo6muZUY0i3JN1MKnaRdglnqKui7tHl0NXCHIhnlbcd6P8iERChs+Lbl0KwBLkuCIvnthvA6y+8E4QYqlO/56N3XYlyQWYDgxdMso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HfvGo9op; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HfvGo9op"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F97AC19421;
	Fri, 10 Apr 2026 11:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775819405;
	bh=J9CQoX7GTnEen2B2gzOk+uOsLwI3v0SjpCO+RqDM+0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HfvGo9opSrGDxa/afsb88WuMvZhMT79PSWGaCkUCXr+PWuyTIlqzJku/vQIfjwWzL
	 j2vA53DlizDMUF4zGV35/RZldLiqoGohXZq6jnSNOk01PxuBBZUCXkjRNlagG6ky4a
	 MXb0vT3zawPDmi/1awFBO/99cerh8h1xZTxJfColV8aXphUT0XSSO0DLJkexxwh2ga
	 ppeWV2HjA3itU5agbnn2tKpIsJPnDq3FnXy/j0/yEbBbFZes7bKtcmd5SIU0SXLjYM
	 zOiNgiowSHB/nNlZglFxRlfwkT6zSGpE8Db96Qj+Mhs5V1Kpl2dpMBp08WZXhKF6/3
	 Bvk2bfIBUQynQ==
Date: Fri, 10 Apr 2026 20:10:03 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Christophe Leroy <chleroy@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Dexuan Cui <decui@microsoft.com>,
	Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
	Lukas Wunner <lukas@wunner.de>,
	Oliver O'Halloran <oohall@gmail.com>,
	Saurabh Singh Sengar <ssengar@microsoft.com>,
	Shuan He <heshuan@bytedance.com>,
	Srivatsa Bhat <srivatsabhat@microsoft.com>,
	linux-pci@vger.kernel.org, linux-alpha@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 10/20] alpha/PCI: Add security_locked_down() check to
 pci_mmap_resource()
Message-ID: <20260410111003.GA1750802@rocinante>
References: <20260410055040.39233-1-kwilczynski@kernel.org>
 <20260410055040.39233-11-kwilczynski@kernel.org>
 <93f81aa9-ce74-92bb-5227-d2ccb0a3e06c@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <93f81aa9-ce74-92bb-5227-d2ccb0a3e06c@linux.intel.com>

Hello,

> > Currently, Alpha's pci_mmap_resource() does not check
> > security_locked_down(LOCKDOWN_PCI_ACCESS) before allowing
> > userspace to mmap PCI BARs.
> > 
> > The generic version has had this check since commit eb627e17727e
> > ("PCI: Lock down BAR access when the kernel is locked down") to
> > prevent DMA attacks when the kernel is locked down.
> > 
> > Add the same check to Alpha's pci_mmap_resource().
> > 
> > Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
> 
> Maybe add Fixes: eb627e17727e ...

Good call, will do!

Thank you!

	Krzysztof
