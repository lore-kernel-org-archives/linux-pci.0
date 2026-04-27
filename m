Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362ED2FE575;
	Mon, 27 Apr 2026 22:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777328368; cv=none; b=hpX5emUy/J1tI8l7wyluqmk1r57i+vVw2p/E/oY3on7sKbfzijGl34NInJPvtusM/b04bETMG7Xph4paeJgjKQJ3ub4I2MPgvE/4s3Nv2UcHiZX9i7dS0j2WDEwlqMUGigCXYI+syBZmNmHH5vz1r7R2WLykHzwgmjLmz4MEs34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777328368; c=relaxed/simple;
	bh=qyYCFS4IXFv1pY019AjM/k03SbPKQAp3p+acClXpsog=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=GlYX4CvHlp0+A/P+icFOwicJ0L1YpYqIvHCvzcamW7yY++SDq11aISkcwmE07DPowXnyAy8NZWTX0Km+lRp0gnBJurV9cthP8eOh3wqlLozxrbFiGpM8ElVGDJ9a0Z5cZCSlTCA4eDsCNplcjrk/eN5Q1AFj+NP8MiVBFuZ5zN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LodmIVJe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LodmIVJe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED063C19425;
	Mon, 27 Apr 2026 22:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777328368;
	bh=qyYCFS4IXFv1pY019AjM/k03SbPKQAp3p+acClXpsog=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=LodmIVJe7RTqrJxP5XjKfPrHDfZPtcz/llm3l+gl2IifobakRiLTNSYeLL0cIq22c
	 mQCW3P+ys5y5R57GBJQX7k0zV9azXKoLwtqYesfJTwY5NQVzRZh+ELjiKHQ0kshoxc
	 XqKzUDf0zklLdjpYO3rSUDHwhoT2nbJnwvkT1mgDYSkSMpHUKp6CfCJ0RQVUhrrtZk
	 coDnUnpHkckt15dXPGrLQzFiIzHqOZkxtYVwqulqMIFKQsyEDiRU9fMs8fmrf7JrZ8
	 E1QAYMNwiAf/NWsKt0QawU8rHKX+5X5Yy1TM7l2nA/n7lXin/K5s/CDTWuB6LAgkMn
	 pkUAiXQy5trjw==
Date: Mon, 27 Apr 2026 17:19:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ziming Du <duziming2@huawei.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, liuyongqiang13@huawei.com
Subject: Re: [PATCH 0/4] PCI: Fix procfs PCI config access issues
Message-ID: <20260427221926.GA198396@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414024544.2975605-1-duziming2@huawei.com>

On Tue, Apr 14, 2026 at 10:45:40AM +0800, Ziming Du wrote:
> Hi,
> 
> As suggested by Bjorn, this series aligns the implementation of procfs with
> the sysfs counterpart and fixes procfs PCI configuration access issues.
> 
> The first two patches refactor proc_bus_pci_{write,read}() to align
> with pci_write_config() and pci_read_config() respectively:
>   - Rename variables (pos->off, cnt->count/size) for consistency
>   - Remove rebundant bounds check
> 
> The last two patches fix potential overflow issues:
>   - Prevent overflow when offset exceeds reasonable range
>   - Fix implicit 64-bit to 32-bit truncation in read path
> 
> Link: https://lore.kernel.org/all/20260303193253.GA3817951@bhelgaas/
> 
> Ziming Du (4):
>   PCI: Align proc_bus_pci_write() with pci_write_config()
>   PCI: Align proc_bus_pci_read() with pci_read_config()
>   PCI: Prevent overflow in proc_bus_pci_write()
>   PCI: Prevent overflow in proc_bus_pci_read()
> 
>  drivers/pci/proc.c | 115 ++++++++++++++++++++++-----------------------
>  1 file changed, 57 insertions(+), 58 deletions(-)

Can you take a look at this:
https://sashiko.dev/#/patchset/20260414024544.2975605-1-duziming2%40huawei.com
and see whether there's anything we should do?

From a quick look, there might be a temporary regression and possibly
a pre-existing proc_bus_pci_write() issue.
