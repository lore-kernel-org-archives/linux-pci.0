Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0A536D4EB;
	Tue, 17 Feb 2026 16:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771344369; cv=none; b=BcTZsTxz3imHDs28Mz2PFtHOH4GddtoxYwA0XQm+Sttu8Ixq2ZJ3a6DBBBx3gS80L9K7RM4lf3Q1tn4iq0mV8BmScv4OcFwLOQda2nL4fyfgl7V14idmP0gVP0IFb2LmEddTIcoM+u9yr3mVtSOnkNEzjaqJarvcqc/sYZXp3Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771344369; c=relaxed/simple;
	bh=WDpzrYyXTW/aR9fbkG2cdvSaVoCpV5uX1W42IerYW5w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gqMXzJgmW9EGSmmi4SGfv2Is/Mc6Vi5q1QBU6Tt7X/ZNg7n6gRT4meQ6dWFwzogzVMQi5m4K8cO16RqdMEemF2LdS/4vxvwhNThtgy9njETk22tmebrZGLaEgohrVYRXr2vVG5nKFqw9/0oXNTuWWxdhwTWRHw/NTpJK/KeM+rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+C1EXLv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+C1EXLv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D1C7C4CEF7;
	Tue, 17 Feb 2026 16:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771344369;
	bh=WDpzrYyXTW/aR9fbkG2cdvSaVoCpV5uX1W42IerYW5w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=D+C1EXLvvd9alWdRDi/ZDSUrq8Msmc7GZ1NrFy15A88TqvJJaKmaNGno3wpMawtxa
	 MioY1rAj24UXe23Qjw7zCzuiRGCyRF5VXPqRP9emrpojt2hxQ666LcRmb+TcVAIarQ
	 L2/dUShoaGIyUDyoGrwEkbdXNN44nhbMFu+PG/6JCfADSlZE59iVDLbIUsd5FTOVKo
	 t99o+xcYM/H2xlBqHw7D+1SS1Z1KXh/j2h+X+hlHMTY8w6RCj3TiRADF3xZ+0AeQU9
	 vHURkaXim8IibTMeW/Cq3S2qQDiDt+KxcHPfaojBHwCbLZO1iaK3xoVg0lK3AfMeay
	 iFhAJ9gYuexOA==
Date: Tue, 17 Feb 2026 10:06:08 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Subject: Re: [PATCH 0/2] PCI/pwrctrl: A couple of fixes
Message-ID: <20260217160608.GA3377925@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217-pwrctrl-fixes-7-0-v1-0-b5671e58934f@oss.qualcomm.com>

On Tue, Feb 17, 2026 at 03:48:45PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> Hi,
> 
> This series fixes a couple of issues introduced in the recent pwrctrl rework
> for v7.0. Both issues are due to some incorrect assumptions on deciding when to
> create pwrctrl devices. First issue is due to assuming that all OF graph nodes
> require pwrctrl and another one is due to assuming that all PCI child nodes are
> PCI devices.
> 
> Both issues are fixed by changing the pwrctrl device creation logic in
> pwrctrl/core.
> 
> Testing
> =======
> 
> This series is tested on Lenovo Thinkpad T14s.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
> Manivannan Sadhasivam (2):
>       PCI/pwrctrl: Ensure that the remote endpoint node parent has the supply requirement
>       PCI/pwrctrl: Only create pwrctrl device if the device node is of type "pci"
> 
>  drivers/pci/pwrctrl/core.c | 51 ++++++++++++++++++++++++++++++++++------------
>  1 file changed, 38 insertions(+), 13 deletions(-)
> ---
> base-commit: 1c2b4a4c2bcb950f182eeeb33d94b565607608cf
> change-id: 20260217-pwrctrl-fixes-7-0-b90eb30bbfe7

Are these v7.0 material?  I assume the pwrctrl changes merged for v7.0
were tested but maybe not on this platform or this DT structure?

Is there a functional regression from v6.19 to v7.0 that would justify
including these in v7.0?
