Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E7136BCF0;
	Thu, 28 May 2026 12:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779971126; cv=none; b=jr/dknS8k7HhD5qYwnRzAl172VJCpZ1DteMX7tEsfsZkLRhOXjOlKbf7QhcSgI0yvV+CzFx4tfurEs2T6yJrg/jcukOOToSceoJtxc0XukBSFUhCHm+s+7bO8dUZ/FQP/BZuJdow5lghdkjglICGHuWmGB9QjUKdnm3zsBbjyvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779971126; c=relaxed/simple;
	bh=auMGNsBQxma9YoUqqEhZAHbQr2HiBAMAuunbQwSQ2aQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=if0Oc40tUWXQtKxT/9x6ytVcjL8ph1NqPmHzg6djYCmIViuEDUU/NKaLCGtIsYaaWE2cjKYBbedI9hJXbpwuRX6oy0dZLyTQkFFqErYBBCQf8l6rH6IkUx4JXslTWKRZV6NCj80YLa9hvCCqJAHltq6YEEFHJhUsVg4Up1qC8pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OkM3dV3E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OkM3dV3E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89ECA1F00A3E;
	Thu, 28 May 2026 12:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779971125;
	bh=ee57S4UZoQ6zqEqaoGqq0lps43BN3W9FOYLXp5yMnKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OkM3dV3ERw2tXIJ/kTsqCbcTPyJe8iIEgSqPZAAVyjMk2nAAJhnuu1/i/1HQBPwE9
	 zH78yBVPODNYltObKXkEdcBEYHSIA67ldc30pjl9uRrX6cwMYEz5sZ7xKg1EJDPRMZ
	 fx4gwdMjtXUcONFdoyP+1aVREttCLTIL1x2RB/SW/psrkfud68GOp7thPm63PALyru
	 ZJcm7GXgPWfk5fzSVZRWFbRNzzFWAypM7NpsVyti9U6GyOl03Swm75cxk/1v3OlW1u
	 hPaSJCU0zURMzayD/XMTa4xHaZOqB3v9vpmDpZuNvGY98B4/EvGh3qBs8xS8y6zMgJ
	 Qcx83/AKBySFA==
Date: Thu, 28 May 2026 14:25:21 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Qiang Yu <qiang.yu@oss.qualcomm.com>, linux-pci@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom: Disable ASPM L0s for SA8775P
Message-ID: <63ekyvawag6wsihfvjdwhqwlapkaw2o6eivp3loeueffvrxo3c@h45hhk3muhqf>
References: <20260419093934.1223027-1-shengchao.guo@oss.qualcomm.com>
 <453jc2ff65zdn3yahdwkdh2uqzz2coi4kv3siqfygfgmfd3v4w@4dkwj3s4dkfp>
 <aebnPAPLO8cI0H-J@QCOM-aGQu4IUr3Y>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aebnPAPLO8cI0H-J@QCOM-aGQu4IUr3Y>

On Tue, Apr 21, 2026 at 10:55:56AM +0800, Shawn Guo wrote:
> On Mon, Apr 20, 2026 at 12:08:25PM +0530, Manivannan Sadhasivam wrote:
> > On Sun, Apr 19, 2026 at 05:39:34PM +0800, Shawn Guo wrote:
> > > Commit f5cd8a929c82 ("PCI: dwc: Remove MSI/MSIX capability for Root Port
> > > if iMSI-RX is used as MSI controller") removed MSI/MSI-X capabilities
> > > from the Root Port on platforms using iMSI-RX (including SA8775P, which
> > > has no msi-parent/msi-map in DT).  This causes PME and AER service
> > > drivers to fall back from MSI to INTx.
> > > 
> > > With INTx-based PME active, the QCN9100 modem endpoint sends PME messages
> > > during D-state transitions early in boot.  The level-triggered INTx
> > > assertion coincides with ASPM L0s exit sequencing on SA8775P hardware,
> > > causing Data Link Layer Replay Timer Timeout errors on both sides of the
> > > link.
> > > 
> > 
> > How did you conclude that INTx collides with ASPM L0s exit sequence? Also,
> > AFAIK, L0s is supported and work well on this chipset.
> > 
> > What we are dealing with could be the board specific issue.
> 
> I just got looped into an internal discussion.  The issue seems to
> be refgen voting related, so likely affects all Lemans (and Monaco)
> boards with PCIe enabled.
> 
> Before a proper fix is available, 'pcie_aspm=off' on kernel cmdline is
> suggested as a temporary workaround.
> 

As I checked internally, it turned out that the SA8775p SoC has some hardware
issue that affects the transition from L0s to L0. So I went ahead and applied
the patch with a change in commit message and fixes tag, thanks!

- Mani

-- 
மணிவண்ணன் சதாசிவம்
