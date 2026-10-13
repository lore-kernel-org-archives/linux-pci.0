Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB063F99E5;
	Tue, 13 Oct 2026 14:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791901626; cv=none; b=M0aKs7pAe3EeStJU0ujXbwP6Q56XXVYOuHJQfGlip6i7pxc4RYOJYxl24Mur4YGq8Pm3ZsnWCGqmJpX/oJ7+3Pim5X9UBZAFrINAQqFPmAadbolMMP+iR+JYrqYzLTVzWqjZkpGSysuIKKYqVBbURSB0hOJhs5/os5kgz5Lr1KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791901626; c=relaxed/simple;
	bh=J44nQYBYFn0Fv66lIwG+PLAKQifR+PgvSWYPOWChR3M=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=MwvZxc6+tDuDoq3EaN0widM1MCJJ0zrqnor5WyFifAzO6bQMcOxnyS95V4cVpBxygQ7VbDytAnlYYl9KFLwJe9164yT4Bp+Qi027Vw2AtMdtjHJg05s98TVXeu4Aitk36GQiWTBZGmbUE/HUiosCJWx8gUFBMXwPv9L7ESykBR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvIAhhVO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvIAhhVO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E4EE1F000FF;
	Tue, 13 Oct 2026 14:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791901624;
	bh=cWNvIp8S69hkXFumBRyCxBFStXTDWYSacoQ/ih/dbY8=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=dvIAhhVOblVJzOKm65WUb+Xm8MNBW0U5C83ptRHHVBrI8h4BqC1g1TCGUfIgN5cqV
	 mpjpBquLire2iBrURFWQrIpdiYY6z1yu0ZSoqvi/fLdc32iGu+iaPp4Uzk0IbH86QS
	 ho1ixRfWBEopO6SondsTfJzfx2+0A9TaPaPN9MTRqpZTCQDTN4tWje9XrWCjfY67PM
	 McuplboHnEdDiq84izjf6D9ErllL1MyTJ4eERANCYF5PD0z+2jr0IW4PhlW0o8JptR
	 wyuqAXB7IWcRjk4KssPD/gVAIDRYpsKf5sR6gLJ1tVh7hgHyzMCbxwHbHU6I9XIpHp
	 GHlmptToEdkuw==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] PCI: endpoint: pci-epf-vntb: Track link state from
 both sides
From: Manivannan Sadhasivam <mani@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: sashiko-reviews@lists.linux.dev, ntb@lists.linux.dev, 
 linux-pci@vger.kernel.org
In-Reply-To: <mbwka7qsw3gcphdwgl4wdqb3t4dweujrwvoj3rogxhwrpoorfx@3wdhmvi4lgfg>
References: <20260904162049.3432464-1-den@valinux.co.jp>
 <20260904163355.165061F00A3D@smtp.kernel.org>
 <mbwka7qsw3gcphdwgl4wdqb3t4dweujrwvoj3rogxhwrpoorfx@3wdhmvi4lgfg>
Date: Tue, 13 Oct 2026 19:56:59 +0530
Message-Id: <179190161902.12828.6253963189949078339.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6002; i=mani@kernel.org;
 h=from:subject:message-id; bh=J44nQYBYFn0Fv66lIwG+PLAKQifR+PgvSWYPOWChR3M=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqzj+2M5jbqXh+HZkE5bnadWmwnRiqHFGv8s+Ph
 RpUrn2ygEeJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCas4/tgAKCRBVnxHm/pHO
 9TUZB/9olfU+YD6PXzpRjWPFQuLw+N1zElbMUyWb/vtNpv6yBVob2HeHCnGvaY9bw6UhOJ8mjaV
 mvl03LZ54UDkVwR68m3bJs7t8sp72A7A1Dq/Q34pzjxqF4zzApD8Qui/TciUas1PziFKDWxB3nY
 LzA/bQMG3DvEh45eDJS+jeBPAyex1sr6HM6htsabKaNGupgv8Nbyi83mCu3nh4eBhKAbQPC9ehG
 Ul4LkdAVGqixixYkwX7wpCw4Nzgms2peMz1OOVJHpY2yFcSORWXrEH7SnqXQhRQPC+jPTqQqcTd
 Ma483PfkWyffY6ODqQRqtIePdp7atcm/223i5M87CH1klxUM
X-Developer-Key: i=mani@kernel.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

+ Frank

On 2026-09-05 03:18 +0900, Koichiro Den wrote:
> On Fri, Sep 04, 2026 at 04:33:54PM +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> > 
> > New issues:
> > - [High] Internal state is not rolled back if the link notification fails.
> > 
> > Pre-existing issues:
> > - [High] Missing ntb_unregister_device() causes NTB device leak and subsequent Use-After-Free.
> > - [High] Virtual PCI root bus allocated in vpci_scan_bus() is never removed.
> > - [High] Missing dma_rmb() between reading `command` and `argument` from the shared DMA memory.
> > --
> > 
> > commit 31e5bb87c3524261d2384c7e27a492debb83840b
> > Author: Koichiro Den <den@valinux.co.jp>
> > 
> >     PCI: endpoint: pci-epf-vntb: Track link state from both sides
> > 
> >     The control-region link status is currently updated only by
> >     COMMAND_LINK_UP and COMMAND_LINK_DOWN from the HOST. The virtual
> >     NTB link callbacks are empty. Consequently, the HOST can see the link as
> >     up before the VHOST has enabled it, and ntb_link_disable() on the VHOST
> >     leaves LINK_STATUS_UP set without notifying either NTB client.
> > 
> > Link: https://lore.kernel.org/r/20260904065335.3059625-1-den@valinux.co.jp/
> > 
> > > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > index fba65abfb6b21..f921c7c7019aa 100644
> > > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > [ ... ]
> > > @@ -178,24 +182,57 @@ static struct pci_epf_header epf_ntb_header = {
> > [ ... ]
> > >  static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
> > >  {
> > > -	if (link_up)
> > > -		ntb->reg->link_status |= LINK_STATUS_UP;
> > > -	else
> > > -		ntb->reg->link_status &= ~LINK_STATUS_UP;
> > > +	bool notify;
> > > +
> > > +	scoped_guard(mutex, &ntb->link_lock) {
> > > +		notify = ntb->host_linkup != link_up && ntb->vhost_linkup;
> > > +		ntb->host_linkup = link_up;
> > > +		epf_ntb_update_link(ntb);
> > > +	}
> > > +
> > > +	if (notify) {
> > > +		/* Publish link status before completing the HOST command. */
> > > +		dma_wmb();
> > > +		return epf_ntb_notify_link(ntb);
> > > +	}
> > 
> > [Severity: High]
> > If epf_ntb_notify_link() fails (e.g. failing to raise the MSI IRQ), does the
> > internal state machine become permanently desynchronized? The effective link
> > state (host_linkup) is updated in the locked section, but there is no
> > rollback on failure.
> > 
> > When the host retries the command, would notify evaluate to false, skipping
> > the notification entirely and leaving the event swallowed?
> 
> Hm, the concern seems valid to some extent, but I don't think simply rolling
> back the link state is the right fix. The VHOST client has already received
> ntb_link_event() by the time raising the MSI IRQ fails.
> 
> pci-epf-ntb also keeps the updated state when raising an IRQ fails, but it
> allows the notification to be retried. This v2 implementation does not, because
> the local 'notify' variable evaluates to false on the retry. If the first 'echo
> N > link' fails because the MSI IRQ could not be raised, repeating it succeeds
> without retrying the notification, unlike pci-epf-ntb.
> 
> I think I should make such a retry possible, in line with pci-epf-ntb.
> If anyone has a better idea, any comments would be appreciated.
> 

I'll let Frank comment on it.

- Mani

> Best regards,
> Koichiro
> 
> > 
> > [ ... ]
> > 
> > drivers/pci/endpoint/functions/pci-epf-vntb.c:epf_ntb_cmd_handler() {
> >     ...
> > 	ctrl = ntb->reg;
> > 	command = ctrl->command;
> > 	if (!command)
> > 		goto reset_handler;
> > 	argument = ctrl->argument;
> >     ...
> > }
> > 
> > [Severity: High]
> > This is a pre-existing issue, but does missing a dma_rmb() between reading
> > the command and the argument allow the CPU to fetch a stale argument for a
> > newly issued command?
> > 
> > Since the CPU can reorder reads, can it fetch a stale argument from the
> > shared DMA memory? Because the argument is used without bounds checking in
> > operations like COMMAND_CONFIGURE_MW, could reading a stale (and potentially
> > large) argument cause an out-of-bounds array access (ntb->vpci_mw_phy[argument])
> > leading to a kernel panic?
> > 
> > 
> > drivers/pci/endpoint/functions/pci-epf-vntb.c:pci_vntb_probe() {
> >     ...
> > 	ret = ntb_register_device(&ndev->ntb);
> > 	if (ret) {
> >     ...
> > }
> > 
> > static struct pci_driver vntb_pci_driver = {
> > 	.name           = "pci-vntb",
> > 	.id_table       = pci_vntb_table,
> > 	.probe          = pci_vntb_probe,
> > };
> > 
> > [Severity: High]
> > This is a pre-existing issue, but does vntb_pci_driver lack a .remove callback
> > to unregister the NTB device?
> > 
> > Is the NTB device never unregistered from the NTB core during device teardown?
> > If the parent EPF device is unbound and devm-allocated memory is freed, could
> > this lead to a use-after-free because ntb_unregister_device() is skipped?
> > 
> > 
> > drivers/pci/endpoint/functions/pci-epf-vntb.c:vpci_scan_bus() {
> >     ...
> > 	vpci_bus = pci_scan_bus(ndev->vbus_number, &vpci_ops, sysdata);
> > 	if (!vpci_bus) {
> > 		pr_err("create pci bus failed\n");
> > 		return -EINVAL;
> > 	}
> >     ...
> > }
> > 
> > [Severity: High]
> > This is a pre-existing issue, but is the virtual PCI root bus allocated in
> > vpci_scan_bus() ever removed?
> > 
> > Does this lead to a resource leak and use-after-free? When the EPF is unbound,
> > it appears pci_remove_root_bus() is never called, which would leave the virtual
> > PCI root bus registered with a dangling sysdata pointer.
> > 
> > -- 
> > Sashiko AI review · https://sashiko.dev/#/patchset/20260904162049.3432464-1-den@valinux.co.jp?part=1
> 
> 


