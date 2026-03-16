Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0DC32B989;
	Mon, 16 Mar 2026 22:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773700351; cv=none; b=lylA+NLwz058z4Z+FWzwMkUQgEg84/pxLOTN+anXsOeWgftJz4XfrAzVp/4MbqgCDMIn0Q6Ya6RlOJYEtrNk0WsecegsGC1iPdZOP8wP5csb7w2VCBSY7GY+eXE1vKXZOV/hBLYBl7YFk4WUfBQP0JJJscCYVbpwq4B12OvqvR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773700351; c=relaxed/simple;
	bh=PVPxplOH61JhCV7kyo1bgxqMKpCA8yuTwsMvlHyNAjM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=SGJ0UhzMM7hRCi29QxGLw2Ry1eOjbr5QW3yXLjQJogQhXPhbXD+mKVh3DEU1axzwEaDjyR9kc5WEDJECazwnhcUHVS1iHNMq3Anlh9ao/uIkOtRnXpVY4KtAv2sK760ML35Z5q378j+gevJE0lyXGNBdOj2bby4QkEG3Vr/YJeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EN95CtU1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EN95CtU1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4C4C19421;
	Mon, 16 Mar 2026 22:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773700351;
	bh=PVPxplOH61JhCV7kyo1bgxqMKpCA8yuTwsMvlHyNAjM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=EN95CtU1SL18y7EdHuOXwIXqGKqlLxtOIugi9rSIQ0k2NjKoRP0UJ0D6wsIZQwBO8
	 JTtKcZQg+9Mqptmpv9z6mo8JwA0SQmJWHdP6ognnBpwhm/qsT8SHk5pRjoa9rlL3cE
	 edQaL9MSxNhOxQjUWCkAdFIRuFsHJ/9/1YoI7KDaLoQaaUmRql9TsUvyZ+wx3oyu+a
	 t1Um9MPH/cDN5UuRHltKz1dBHzaxC5pvy+IYAhQwcUzurta4xWtjDIaTEmfD/5F27o
	 DzwMKWWShWAzbbi5SMc8gfDvfX78BlEqE7cPQYkb5GHwv14BI2ozMYbkf/L3fl2XKo
	 ZjAvRLXRz5bNw==
Date: Mon, 16 Mar 2026 17:32:29 -0500
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
Subject: Re: [PATCH v2 0/2] PCI/pwrctrl: A couple of fixes
Message-ID: <20260316223229.GA58051@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223-pwrctrl-fixes-7-0-v2-0-97566dfb1809@oss.qualcomm.com>

On Mon, Feb 23, 2026 at 08:15:58PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
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
> Note for Bjorn H
> ================
> 
> Even though only patch 1 is fixing a regression on the IPQ board which was not
> part of the testbed of the pwrctrl rework went in for v7.0, patch 2 is also
> fixing an actual issue, but it is not impacting any of the current upstream
> supported platforms. But I'd like to get these two patches merged for v7.0 so
> that both the issues are fixed in the same major release where the issues
> originated.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
> Changes in v2:
> - Used the compatible match for detecting the PCI devices in DT
> - Link to v1: https://lore.kernel.org/r/20260217-pwrctrl-fixes-7-0-v1-0-b5671e58934f@oss.qualcomm.com
> 
> ---
> Manivannan Sadhasivam (2):
>       PCI/pwrctrl: Ensure that the remote endpoint node parent has the supply requirement
>       PCI/pwrctrl: Only create pwrctrl device if the device node belongs to a PCI device
> 
>  drivers/pci/pwrctrl/core.c | 54 +++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 41 insertions(+), 13 deletions(-)

Applied to pci/for-linus for v7.0, thanks!
