Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629F923D281;
	Wed, 28 Jan 2026 19:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769629717; cv=none; b=nyvkc8TZmcI/hnPaea5RUzDF/oth91jb2l7YYoqjqf7Vs9T4WoNbG3pylnQmfBUUfvaUCIT3LE2WPD9MuWCBSApiLY2xO3A3LJhx+koI60XxnMMZ0zP8AOb48VU0qDsC+6bdjTeFjPeJthurtTnhJXuOffwqDZ8sDc14lBEUpEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769629717; c=relaxed/simple;
	bh=8k2zqY2UBXcb3AiTXacsupFOjChTmeLUTb28Hj18CAU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ljlHprYIW35Mj/2oN8zq97d1Zn2Aov/q8U185L0XJNw/dscLVkCGfZfT+PYizDKSX/FOXypsMkyZgvgZa2YC1EwzzhjYfsTPe6LRj1IsxAKCF4KpGXXpJ+TDOItbd+n5bT1ET3RZHxOwMqR1Ke5WxvjNkjhMV6LCFSPoUYFwGwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hx0jjySL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hx0jjySL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D67C4C4CEF1;
	Wed, 28 Jan 2026 19:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769629717;
	bh=8k2zqY2UBXcb3AiTXacsupFOjChTmeLUTb28Hj18CAU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Hx0jjySLGN4z+8gLrEhJ4woQo+uDtf80aNCEIuBDjq+vQ4Ny5aELMVf5tKZkrBJ//
	 Rs1EN8Ufzoh+4B/rVDbaae4HaPYUikiBFJEgqeOVA5vBhCZWdPrugN4BBUAX8hKsQ/
	 x6WY6h1DsbW8zdB+BY9w2UhmfpjsI/+OnyfiEFii3Rh14Otl7a37UYGhq5+8iiErwz
	 DAK3t2flUIinGO2J8JQx53z9kMTUfwb/j6p4rLOj6b1wAO7+ZIMQdN2pZE+vxLwyNJ
	 jVFyArNi4gLSLYygsYPTkkezpPt6+xydKt8P9prY81iduqId4UUcZiTkIYJKDBqh/6
	 50thK54RmXKtQ==
Date: Wed, 28 Jan 2026 13:48:35 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
Cc: mahesh@linux.ibm.com, oohall@gmail.com, bhelgaas@google.com,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, CobeChen@zhaoxin.com,
	TonyWWang@zhaoxin.com, ErosZhang@zhaoxin.com,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] PCI: dpc: Increase pciehp waiting time for DPC recovery
Message-ID: <20260128194835.GA429644@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3af9f754-d282-485c-a3f2-49a230bfe143@zhaoxin.com>

On Wed, Jan 28, 2026 at 06:07:51PM +0800, LeoLiu-oc wrote:
> 在 2026/1/24 4:21, Bjorn Helgaas 写道:
> > [这封邮件来自外部发件人 谨防风险]
> > On Fri, Jan 23, 2026 at 06:40:34PM +0800, LeoLiu-oc wrote:
> >> Commit a97396c6eb13 ("PCI: pciehp: Ignore Link Down/Up caused by DPC")
> >> amended PCIe hotplug to not bring down the slot upon Data Link Layer State
> >> Changed events caused by Downstream Port Containment.
> >>
> >> However, PCIe hotplug (pciehp) waits up to 4 seconds before assuming that
> >> DPC recovery has failed and disabling the slot. This timeout period is
> >> insufficient for some PCIe devices.
> >> For example, the E810 dual-port network card driver needs to take over
> >> 10 seconds to execute its err_detected() callback.
> >> Since this exceeds the maximum wait time allowed for DPC recovery by the
> >> hotplug IRQ threads, a race condition occurs between the hotplug thread and
> >> the dpc_handler() thread.

> > Include the name of the E810 driver so we can easily find the
> > .err_detected() callback in question.  Actually, including the *name*
> > of that callback would be a very direct way of doing this :)

AFAICS there is no ".err_detected()" callback.  I assume you mean the
".error_detected()" callback in struct pci_error_handlers.  Sorry to
be pedantic, but it makes things a lot harder to review if we don't
refer to the actual names in the code.

And my guess is that E810 means the Intel E810 NIC, probably claimed
by the "ice" driver, which would mean ice_pci_err_detected() is the
callback in question?

> > I guess the problem this fixes is that there was a PCIe error that
> > triggered DPC, and the E810 .err_detected() works but takes longer
> > than expected, which results in pciehp disabling the slot when it
> > doesn't need to?  So the user basically sees a dead E810 device?
>
> Yes, this patch is to solve this problem.
> 
> > It seems unfortunate that we have this dependency on the time allowed
> > for .err_detected() to execute.  It's nice if adding arbitrary delay
> > doesn't break things, but maybe we can't always achieve that.
> > 
> I think this is a feasible solution. For some PCIE devices, executing
> the .err_detect() within 4 seconds will not have any impact, for a few
> PCIE devices, it might increase the execution time of pciehp_ist().
> Without this patch, PCIE devices may not be usable and could even cause
> more serious errors, such as a kernel panic. For example, the following
> log is encountered in hardware testing:
> 
> list_del corruption, ffff8881418b79e8->next is LIST_POISON1
> (dead000000000100)
> ------------[ cut here ]------------
> kernel BUG at lib/list_debug.c:56!
> invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> ...
> Kernel panic - not syncing: Fatal exception

This is an interesting panic and looks like it might have been hard to
debug.

Do you have any idea what exactly caused this and how it's related to
the timeout in pci_dpc_recovered()?  Is there a race where pciehp
disables the slot and removes the driver, but eventually
ice_pci_err_detected() completes and we're running some ice driver
code while it's being removed or something?

Simply increasing the timeout doesn't feel like a very robust way of
solving the problem.  What happens when some other device needs 17
seconds?

But if increasing the timeout is the best we can do, maybe a warning
message in pci_dpc_recovered() when we time out would at least be a
hint that we might be heading for trouble?

> > I see that pci_dpc_recovered() is called from pciehp_ist().  Are we
> > prepared for long delays there?
>
> This patch may affect the hotplug IRQ threads execution time triggered
> by DPC, but it has no effect for normal HotPlug operation, e.g.
> Attention Button Pressed or Power Fault Detected. If you have better
> modification suggestions, I will update to the next version.

> >> +++ b/drivers/pci/pcie/dpc.c
> >> @@ -121,7 +121,7 @@ bool pci_dpc_recovered(struct pci_dev *pdev)
> >>        * but reports indicate that DPC completes within 4 seconds.
> >>        */
> >>       wait_event_timeout(dpc_completed_waitqueue, dpc_completed(pdev),
> >> -                        msecs_to_jiffies(4000));
> >> +                        msecs_to_jiffies(16000));
