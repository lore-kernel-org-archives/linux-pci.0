Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DFA2C9D
	for <linux-pci@vger.kernel.org>; Fri, 17 Apr 2026 18:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776450371; cv=none; b=JQK7i++q0Iv/7HqJ9hhQr49tnzPUZ7+QdUCEvQj8EK0wyhRNijdKtlQI6D9yFKAt0k0kZXm/17itHA05PT8kIosxVcGuXsSH+pyOxPzc9tKIVNGGGhNvcgjzMAiS6wT43yIdDiTDzis6T8qbK8gIUy8MdmMwejsZuhyr99VBe/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776450371; c=relaxed/simple;
	bh=WDxib3BR9wG5EfEd+gJpd06gX+LFgK/YUO47GtGFGtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dzt/DkMG9Lvn/+IYBd+o+EwnOSogWyj3Xm5TLvn6tMUhkYl5B5QdDpEZzd5FPk7xISsxRK37LeIf1QQczIfJV24WfyMtPV7W0VWLpusfA25c9h2ZJYHDqrzmpOP27/dePAbUpL6q/NsHOAN+oVCY+IiZCgBX/LIb+rmNTBNURHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6mle7Xg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6mle7Xg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34815C19425;
	Fri, 17 Apr 2026 18:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776450370;
	bh=WDxib3BR9wG5EfEd+gJpd06gX+LFgK/YUO47GtGFGtE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=W6mle7XgtdP+vOieX0znv0yHJfqrgXsY5QdzmDORtEsyGFfXLNpgJOsf+i8CX6ARJ
	 etaIph7vQ6sXHs7JeBAhBEdTv/D9f9LvIqn/JvYG1AoldKKBdoZ2CczulVnbuQg8Bd
	 HAbKrMwQkoPxuLtO93TSVabsEuZWT54CH+LVWKrNqIPJzBZVY+WjU3hnqrwJ1C26IY
	 7tIXfeSGA+EOFT7jU9iPAARNNrrqLVkcPsn19+y92q3kHasghjjq1qFckfs0LgKy/4
	 0J08M2Y4Y2cUcMx1+6lm1tNkrJ6t5GaA3nnzx7ig0J8s6fw6m5f0nS2QflFtENSqcm
	 6Ebbl3SxVGjMw==
Message-ID: <7ebd7665-4ae8-4937-8d48-04fe9c04fbe1@kernel.org>
Date: Fri, 17 Apr 2026 13:26:09 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Stop setting cached power state to "unknown" on
 unbind
Content-Language: en-US
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Alex Williamson <alex@shazbot.org>, linux-pci@vger.kernel.org
References: <af7d11d3ceb231acc90829f7a5c8400c2446744f.1776415510.git.lukas@wunner.de>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <af7d11d3ceb231acc90829f7a5c8400c2446744f.1776415510.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/17/26 03:51, Lukas Wunner wrote:
> When a PCI device is unbound from its driver, pci_device_remove() sets the
> cached power state in pci_dev->current_state to PCI_UNKNOWN.  This was
> introduced by commit 2449e06a5696 ("PCI: reset pci device state to unknown
> state for resume") to invalidate the cached power state in case the system
> is subsequently put to sleep.
> 
> For bound devices, the cached power state is set to PCI_UNKNOWN in
> pci_pm_suspend_noirq(), immediately before entering system sleep.
> 
> Extend to unbound devices for consistency.
> 
> This obviates the need to change the cached power state on unbind, so stop
> doing so.
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

FWIW I also had review-prompts /kreview check for corner cases and it 
didn't find any.

> ---
>   drivers/pci/pci-driver.c | 10 ++--------
>   1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 7c2d9d5..774892d 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -482,13 +482,6 @@ static void pci_device_remove(struct device *dev)
>   	pm_runtime_put_sync(dev);
>   
>   	/*
> -	 * If the device is still on, set the power state as "unknown",
> -	 * since it might change by the next time we load the driver.
> -	 */
> -	if (pci_dev->current_state == PCI_D0)
> -		pci_dev->current_state = PCI_UNKNOWN;
> -
> -	/*
>   	 * We would love to complain here if pci_dev->is_enabled is set, that
>   	 * the driver should have called pci_disable_device(), but the
>   	 * unfortunate fact is there are too many odd BIOS and bridge setups
> @@ -862,7 +855,7 @@ static int pci_pm_suspend_noirq(struct device *dev)
>   
>   	if (!pm) {
>   		pci_save_state(pci_dev);
> -		goto Fixup;
> +		goto set_unknown;
>   	}
>   
>   	if (pm->suspend_noirq) {
> @@ -914,6 +907,7 @@ static int pci_pm_suspend_noirq(struct device *dev)
>   		goto Fixup;
>   	}
>   
> +set_unknown:
>   	pci_pm_set_unknown_state(pci_dev);
>   
>   	/*

