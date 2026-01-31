Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A300618027
	for <linux-pci@vger.kernel.org>; Sat, 31 Jan 2026 00:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769818735; cv=none; b=M6k8a9wMZKF7LQ4oCAdw9lLLWmtGgA7LcJlY4Q7heSaG4CkCn9DvDF0bDxc6VYdgfxP+WpkDc35HW5WopaoV7P0O91gojlmx32ib0oHIFX/8plM64yoK7fBps6Ahm4QJLOpI8OReMGBK/aeGmveEB8aG3qMFohgbG8bkJgjKyAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769818735; c=relaxed/simple;
	bh=bwZVVLfnZSX4nYeIDmAv42c4hzK11kPFiSAJ6Ut946E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jB396sfqe4A9l9QD0ZJZGW4CW2DHcOu1W1vNf+qthLKRbH2LGV95dpYBYwLiNOcq6fEPDFdweMiEz0GxcjJwbXuLv5QhNZnayYcrCUBvhynZyPnl7GUnXv6IaqF58d6InwoyZ6lCF5LufnHoUqyIFQZjvjElW7PGVmhnZCBoydQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qo+lGJkI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qo+lGJkI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D119C4CEF7;
	Sat, 31 Jan 2026 00:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769818735;
	bh=bwZVVLfnZSX4nYeIDmAv42c4hzK11kPFiSAJ6Ut946E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=qo+lGJkIUcRJakp2tbWI/qFrlHmWDsoBDbHCTCv5FPJLJgTR1yNYgm/+cEtc9T8tk
	 ICtzzBIAldWmjlMebIATwGoFgMvg/+kQKhmUd2pbHdZ/Cy0nTmt65RINEtLACn78Xt
	 Q/2Tt3lk132lNOtRDy7C39E1+Um962pYnNoJSBRLYuWfuq1pO2Uk9ca63gli/eYZJg
	 IWNyAgKcfYoTBFihQuDWG69J0j77DQ/TX5tTfDWYokOCZ5TuhM9bFpMQNzPvCqXOnO
	 QEJTEYRkQtlkrWuNep8b1+7fZn9poFWAIdEMYQ38F2fWjkOQpc/S6vx37fSF/ZGUnN
	 Irfse/9HqUpxA==
Date: Fri, 30 Jan 2026 18:18:53 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-pci@vger.kernel.org, alex@shazbot.org, lukas@wunner.de,
	dan.j.williams@intel.com, guojinhui.liam@bytedance.com,
	ilpo.jarvinen@linux.intel.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 0/4] pci: slot handling fixes
Message-ID: <20260131001853.GA31112@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130165953.751063-1-kbusch@meta.com>

On Fri, Jan 30, 2026 at 08:59:49AM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> This series fixes some older issues are the slot lock usage, with two
> follow on patches to address multi-function resets in pcie hotplug
> slots.
> 
> Previous discussions:
> 
>   https://lore.kernel.org/linux-pci/20260116184150.3013258-1-kbusch@meta.com/
> 
>   https://lore.kernel.org/linux-pci/aXvOOjZQ_EmZDgVs@kbusch-mbp/T/#t
> 
> Version change notes:
> 
>  * The first patch is unchanged from the original.
> 
>  * The second patch adds the local "bridge" to improve code clarity
>    (review comments from Dan)
> 
>  * The third patch removes pci_slot_resettable in addition to all the
>    other slot specific locking and state saving functions. I also
>    updated a code comment explaining that all bus devices are saved and
>    restored with the slot reset.
> 
>  * Included a fourth patch that fixes user suborindate bus resets when the
>    bridge is pcie hotplug capable; a previous version came from this
>    independent patch here:
> 
>   https://lore.kernel.org/linux-pci/20260116154244.1452246-1-kbusch@meta.com/
> 
>    And I'm including it in this series since it is all in the same area
>    with slot resets. I've made a minor change to the previous version to
>    remove the code duplication with pci_bus_error_reset().
> 
> Jinhui Guo (1):
>   PCI: Fix incorrect unlocking in pci_slot_trylock()
> 
> Keith Busch (3):
>   pci: fix slot reset device locking
>   pci: remove slot specific lock/unlock and save/restore
>   pci: make reset_subordinate hotplug safe
> 
>  drivers/pci/pci-sysfs.c |   3 +-
>  drivers/pci/pci.c       | 213 +++++++++++-----------------------------
>  drivers/pci/pci.h       |   2 +-
>  3 files changed, 61 insertions(+), 157 deletions(-)

Applied the first two on pci/virtualization for now (the first was
already there):

  67bcd817a012 ("PCI: Fix pci_slot_trylock() error handling")
  c6a26e539649 ("PCI: Fix pci_slot_lock () device locking")

If we get a review for the others I'll add them on top.

Thanks!
