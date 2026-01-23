Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D13626FDBF;
	Fri, 23 Jan 2026 20:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769199702; cv=none; b=NCVk+UoIxt8Vy7n7Kj4KPWoZFp8CjXO8HKTGUXkHumJ8Emfgvk968DQ1jbvOpM5l2VyoCXtH6HBJ3OOMVWmQSg2LgIjUHlQ5OVqSUqKjkGPXfGUIxpBv3syKW9EurIaUPg7AM6e+xpMxLDH/ugDJmVGAN9EPzOVUvX8QpInkd4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769199702; c=relaxed/simple;
	bh=8oWPlenlkiFGuWSiLTXLR7/Gzzv217xLGkIacaMBE4g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DQvMh8frdmw4LdydL7sF3VjdxgqYLrRzKLe9jD8OP/XVKBbb+EOjr/l2lCJFT39rlv6uy1kzImzbRp37Xh9gV1zUPM1WWwtJscQkcND/4nPj0szbQOcEZU7PDEMV7kgtjvUbqcqs5G0gJQt4dnUh+z4jkFWKLPpECXFAAcF6T+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aqt9nMp9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aqt9nMp9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0047C4CEF1;
	Fri, 23 Jan 2026 20:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769199701;
	bh=8oWPlenlkiFGuWSiLTXLR7/Gzzv217xLGkIacaMBE4g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Aqt9nMp9C4EDme27BeU7DrpwlRNf4awubw2KJxs6e3HKx6Jm5hevZhDC08i1vVfMo
	 msVzcIt/OKBtINZUdgOz9XQIdRz2PJvEdXSlfgLfQgYj3LZfYYDUjw7spW3+ruaU80
	 P1EGhnWG0yw4BtuOK+A1/jLpheNyM9u38SwSHwDligpUd6Mi+yPcBI6Ddy+9q+dB8J
	 KcT14FCEcOSJvulV6BQ2sw1B/QU6Kuy9uxUWxGKwV5cUUTiQ/3WWMeKZ3OPVdIkag0
	 O+UaUnMGNcP3W/PC0VPUMn96CK01uFGFkEwxDVweX412/wWxnt0L8v+kl1pK3WAr3S
	 UZr/U03On9AZg==
Date: Fri, 23 Jan 2026 14:21:40 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
Cc: mahesh@linux.ibm.com, oohall@gmail.com, bhelgaas@google.com,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, CobeChen@zhaoxin.com,
	TonyWWang@zhaoxin.com, ErosZhang@zhaoxin.com,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] PCI: dpc: Increase pciehp waiting time for DPC recovery
Message-ID: <20260123202140.GA84703@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123104034.429060-1-LeoLiu-oc@zhaoxin.com>

[+cc Lukas, pciehp expert and author of a97396c6eb13]

On Fri, Jan 23, 2026 at 06:40:34PM +0800, LeoLiu-oc wrote:
> Commit a97396c6eb13 ("PCI: pciehp: Ignore Link Down/Up caused by DPC")
> amended PCIe hotplug to not bring down the slot upon Data Link Layer State
> Changed events caused by Downstream Port Containment.
> 
> However, PCIe hotplug (pciehp) waits up to 4 seconds before assuming that
> DPC recovery has failed and disabling the slot. This timeout period is
> insufficient for some PCIe devices.
> For example, the E810 dual-port network card driver needs to take over
> 10 seconds to execute its err_detected() callback.
> Since this exceeds the maximum wait time allowed for DPC recovery by the
> hotplug IRQ threads, a race condition occurs between the hotplug thread and
> the dpc_handler() thread.

Add blank lines between paragraphs.

Include the name of the E810 driver so we can easily find the
.err_detected() callback in question.  Actually, including the *name*
of that callback would be a very direct way of doing this :)

I guess the problem this fixes is that there was a PCIe error that
triggered DPC, and the E810 .err_detected() works but takes longer
than expected, which results in pciehp disabling the slot when it
doesn't need to?  So the user basically sees a dead E810 device?

It seems unfortunate that we have this dependency on the time allowed
for .err_detected() to execute.  It's nice if adding arbitrary delay
doesn't break things, but maybe we can't always achieve that.

I see that pci_dpc_recovered() is called from pciehp_ist().  Are we
prepared for long delays there?

> Signed-off-by: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
> ---
>  drivers/pci/pcie/dpc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index fc18349614d7..08b5f275699a 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -121,7 +121,7 @@ bool pci_dpc_recovered(struct pci_dev *pdev)
>  	 * but reports indicate that DPC completes within 4 seconds.
>  	 */
>  	wait_event_timeout(dpc_completed_waitqueue, dpc_completed(pdev),
> -			   msecs_to_jiffies(4000));
> +			   msecs_to_jiffies(16000));

It looks like this breaks the connection between the "completes within
4 seconds" comment and the 4000ms wait_event timeout.

>  	return test_and_clear_bit(PCI_DPC_RECOVERED, &pdev->priv_flags);
>  }
> -- 
> 2.43.0
> 
