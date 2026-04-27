Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC946371CFF;
	Mon, 27 Apr 2026 20:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777322045; cv=none; b=njvlg8kYuEUUd3JqtOw+b+x9yGVmQJDv3bP51FLzhBug8/FAi6meg+/smqslokZXBLd2DGOJuK6/GwSbaRw0BABabrN4CvVGwU+t1kqEOnGaeebzUzfeCPtKXdlsNxyaN/TGOzGbTi6n8dqgx9XYBO6GJcRm/Wm8CSghFDuJjNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777322045; c=relaxed/simple;
	bh=SdulBXz7GBAyzVrKSc8VCh1nbo1vRKI12nbpooE3Mig=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bOX+pNnlXjSUx8Oz/jUDueEmdNgF9ZyTfA4cU6d2zeQvCxBgOiKzIi60Ely9p1OEPBaPnEkwsvnHMvM1AedDXYBFrgk57hP18HwV6XAtBP+Y/ei4RLAk8HGAK9o/EZAd0tIkHsQ+PdLvp8+jMyo9/kg3xSMsNxyyWlmAhG6Ksqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o7cOhVp1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o7cOhVp1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A58C2BCB9;
	Mon, 27 Apr 2026 20:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777322045;
	bh=SdulBXz7GBAyzVrKSc8VCh1nbo1vRKI12nbpooE3Mig=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=o7cOhVp1EeRXf1GFuHHh9wfMDS8SdTX3DP1bOXNCPBFQ8Z/VJk0aPsTo9furWDtWz
	 YvbPUw0TgRukwBu2O1I9WMkvUstyxYw3JO4Oa0hsP/oXqRXc/FRovLCr1SbbOdJZHy
	 /Q7a90UCFKxYcK1xh8P8yfWjtoQNf+FfiY3AlUOv8rK4+VL4DO0RYbo6xRupY2P+E6
	 HDlRIKnhgKTY5aaQ9VecpKgd5pXqbbU92GzRJPIVVMQJ62OIu8ZkYNOdbwBU2yt/va
	 7qo0BGUxni2bEAZJOYScUAyxBF1u7CPQfbfpwk4YjHcBg2tRwsNtdiFgzRfK62qTbC
	 PIIoPXgEvkcgw==
Date: Mon, 27 Apr 2026 15:34:04 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH 0/5] Improvements to PCI hibernate path
Message-ID: <20260427203404.GA182096@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427035341.1425576-1-superm1@kernel.org>

On Sun, Apr 26, 2026 at 10:53:36PM -0500, Mario Limonciello (AMD) wrote:
> A few cycles ago I sent out a kernel series for using the S4 paths when
> the system goes to S5.  Some parts of it got merged, and Rafael suggested
> to split the other parts into smaller pieces across multiple kernel cycles
> to make bisecting easier.
> 
> This fell into my backlog behind other things, so I wanted to try again
> this cycle for the PCI pieces. I have been carrying it, rebasing it and
> personally using it for a while now though.
> 
> This series attempts to unify the PCI suspend and hibernate paths and to
> fix some things that I observed to be wrong with how I expect hibernate
> to work.
> 
> It is based off 7.1-rc1 + Lukas' patch:
> "PCI: Stop setting cached power state to "unknown" on unbind"

Hi Mario, would you mind posting a v2 that includes Lukas' patch, so
the whole series applies cleanly so Sashiko can go through it?

I already applied Lukas' patch on pci/pm, but I guess Sashiko can't
parse that dependency.

> Mario Limonciello (AMD) (5):
>   PCI/PM: Disable device wakeups when halting or powering off system
>   PCI/PM: Split out code from pci_pm_suspend_noirq() into helper
>   PCI/PM: Run bridge power up actions as part of restore phase
>   PCI/PM: Use pci_power_manageable() in pci_pm_poweroff_noirq()
>   PCI: Put PCIe bridges with downstream devices into D3 at hibernate
> 
>  drivers/pci/pci-driver.c | 103 ++++++++++++++++++++++++++-------------
>  1 file changed, 69 insertions(+), 34 deletions(-)
> 
> -- 
> 2.43.0
> 
