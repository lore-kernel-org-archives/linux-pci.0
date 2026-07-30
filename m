Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC282236EB;
	Thu, 30 Jul 2026 12:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785415536; cv=none; b=jNkDq2ioju1+kXF0mwqncTyyYS6osMswsA5WH8qwe8//XplhyJXIayNU+5eT/drgz/ZpO18H1NzReSbAYnX2qCx5II5GH3Te0tWdTm2SPTdZ3FOLv8J+xoK6Aj5EyKVDT646KUHStnMURaHhEpknFxP4eEQPZUvAPsTcdpExH2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785415536; c=relaxed/simple;
	bh=nTydtmhn1lhJ4MKcWra0XAklGffJjwU78X2jnUJKYB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkgEREh2boYp3QVks2yQVsCU3i7PlKezvzvQ93x6Crh/FrGBveDBVzkD3dYKNQvrQx0YzudPNX1HS4RsQZc+Rj/OhFJjLVZy35Rw4xIMn5/1y5OpyI6Y6v9CMTnEL43pR+p1ihLsrPzuT4Ro8v/RmqucKdhj9p1t6ovTcLGfavk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOsOcfpU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOsOcfpU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD0B91F000E9;
	Thu, 30 Jul 2026 12:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785415535;
	bh=w+73Ztur43JwVS7yJyDov3n67PjISqqfJERSDfVIXYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YOsOcfpUV/qKkbj8qbXUcrzi96LeELaWRrztCEYhZh9YUkNA94i+PZo7Y3ohCME0+
	 2fP94wI7A5P0n4s52c4YdPN6rMd0JF+hhBmhPs4QDZXIC9Q0uM0okY1Ogw4vjcr3sv
	 WXq29j3DDtzRTJhlwsHfNo8AfVrzXiZpys7zQNPeiLpoliRfCuCXsfbhjtUTCDCu0d
	 cvq8Up3mB+pxTRCod4B9AxkpkERh9R/13J+hqlfZdQOuehHLAFYGOde///AT+PSIiy
	 EPPVeyRp+oVrLHBvBYf3MYLyiNm64CoMmQOOdNhRWfLYj1EK+B64KsPEzfODwqS+nK
	 ippntlrA0VqdA==
Date: Thu, 30 Jul 2026 14:45:32 +0200
From: Niklas Cassel <cassel@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] misc: pci_endpoint_test: Improve logic to check
 status for doorbell test case
Message-ID: <amtHbHP0_2bBBa4C@ryzen>
References: <20260730122045.1382749-4-cassel@kernel.org>
 <20260730122045.1382749-6-cassel@kernel.org>
 <20260730123357.D349F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730123357.D349F1F000E9@smtp.kernel.org>

On Thu, Jul 30, 2026 at 12:33:57PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> 
> New issues:
> - [Medium] PCIe surprise removals masked by incorrectly evaluating an all-1s read as success.
> 
> Pre-existing issues:
> - [High] Unvalidated endpoint input leads to NULL pointer dereference and out-of-bounds MMIO write.
> - [High] Race condition between module teardown and active ioctls leading to double-free or UAF of IRQ vectors.
> - [High] Unbounded, uninterruptible waits on endpoint interrupts create unkillable tasks and a global ioctl deadlock.
> --
> 
> --- Patch [2]: [PATCH 2/2] misc: pci_endpoint_test: Improve logic to check status for doorbell test case ---
> commit e34bb71884c618c46be8a57cc0405805a9d2c585
> Author: Niklas Cassel <cassel@kernel.org>
> 
> misc: pci_endpoint_test: Improve logic to check status for doorbell test case
> 
> This patch modifies the doorbell test case to verify if the SUCCESS bit was
> set rather than checking if the FAIL bit was set. This handles cases where
> an IRQ timeout occurs or buggy EPC drivers send multiple IRQs.
> 
> > diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> > --- a/drivers/misc/pci_endpoint_test.c
> > +++ b/drivers/misc/pci_endpoint_test.c
> > @@ -1094,7 +1094,7 @@ static int pci_endpoint_test_doorbell(struct pci_endpoint_test *test)
> >  	left = wait_for_completion_timeout(&test->irq_raised, msecs_to_jiffies(1000));
> >  
> >  	status = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
> > -	if (!left || (status & STATUS_DOORBELL_ENABLE_FAIL)) {
> > +	if (!left || !(status & STATUS_DOORBELL_ENABLE_SUCCESS)) {
> 
> [Severity: Medium]
> If the PCIe endpoint surprise-disconnects or the link goes down, MMIO reads
> like pci_endpoint_test_readl() will return all-1s (0xFFFFFFFF). By checking
> !(status & STATUS_DOORBELL_ENABLE_SUCCESS), an all-1s read evaluates as true
> for the bitwise AND, making the logical NOT false.
> 
> Does this inadvertently bypass the error handler during a hardware failure?

With this logic, every readl() in drivers/misc/pci_endpoint_test.c should check
if the return value is 0xFFFFFFFF.


Which they do not:

reg = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);          
        if (!(reg & STATUS_READ_SUCCESS))                                       
                ret = -EIO;                                   


This brings pci_endpoint_test_doorbell() in line with pci_endpoint_test_read().

I still think this patch makes sense.


Kind regards,
Niklas
