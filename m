Return-Path: <SRS0=vBCh=MJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722C3C43382
	for <linux-pci@archiver.kernel.org>; Thu, 27 Sep 2018 20:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 176F32170E
	for <linux-pci@archiver.kernel.org>; Thu, 27 Sep 2018 20:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIdBgZjJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 176F32170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbeI1DM6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 27 Sep 2018 23:12:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:49696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727340AbeI1DM6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Sep 2018 23:12:58 -0400
Received: from localhost (unknown [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C9B72159D;
        Thu, 27 Sep 2018 20:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538081568;
        bh=eOTeY8rb4+XzZDlrWn/3AYBkWAlSwjNkZgYDnEt2n+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jIdBgZjJzGVKGmKTPxRAi0Ye/iCoTBf2dvngGn8ooNbpYtNHLqlbKoINH7HYvNSL2
         7aYzGXO12HyURW0pd1zATVptbPVIld4cKMfdeV6AhvPgNgwmj6eCgzu7hzw9ICbpOI
         sMAH8Am0B0kgOJv2+FTo0xORXWFtQUv3EeM7EIps=
Date:   Thu, 27 Sep 2018 15:52:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Daniel Drake <drake@endlessm.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org, linux@endlessm.com,
        nouveau@lists.freedesktop.org, linux-pm@vger.kernel.org,
        peter@lekensteyn.nl, kherbst@redhat.com,
        andy.shevchenko@linux.intel.com, rafael.j.wysocki@intel.com,
        keith.busch@intel.com, jonathan.derrick@intel.com,
        kugel@rockbox.org, davem@davemloft.net, hkallweit1@gmail.com,
        netdev@vger.kernel.org, nic_swsd@realtek.com, rchang@marvell.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: Reprogram bridge prefetch registers on resume
Message-ID: <20180927205247.GA18434@bhelgaas-glaptop.roam.corp.google.com>
References: <20180913033745.11178-1-drake@endlessm.com>
 <20180918213244.GE13616@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918213244.GE13616@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc LKML]

On Tue, Sep 18, 2018 at 04:32:44PM -0500, Bjorn Helgaas wrote:
> On Thu, Sep 13, 2018 at 11:37:45AM +0800, Daniel Drake wrote:
> > On 38+ Intel-based Asus products, the nvidia GPU becomes unusable
> > after S3 suspend/resume. The affected products include multiple
> > generations of nvidia GPUs and Intel SoCs. After resume, nouveau logs
> > many errors such as:
> > 
> >     fifo: fault 00 [READ] at 0000005555555000 engine 00 [GR] client 04
> >           [HUB/FE] reason 4a [] on channel -1 [007fa91000 unknown]
> >     DRM: failed to idle channel 0 [DRM]
> > 
> > Similarly, the nvidia proprietary driver also fails after resume
> > (black screen, 100% CPU usage in Xorg process). We shipped a sample
> > to Nvidia for diagnosis, and their response indicated that it's a
> > problem with the parent PCI bridge (on the Intel SoC), not the GPU.
> > 
> > Runtime suspend/resume works fine, only S3 suspend is affected.
> > 
> > We found a workaround: on resume, rewrite the Intel PCI bridge
> > 'Prefetchable Base Upper 32 Bits' register (PCI_PREF_BASE_UPPER32). In
> > the cases that I checked, this register has value 0 and we just have to
> > rewrite that value.
> > 
> > Linux already saves and restores PCI config space during suspend/resume,
> > but this register was being skipped because upon resume, it already
> > has value 0 (the correct, pre-suspend value).
> > 
> > Intel appear to have previously acknowledged this behaviour and the
> > requirement to rewrite this register.
> > https://bugzilla.kernel.org/show_bug.cgi?id=116851#c23
> > 
> > Based on that, rewrite the prefetch register values even when that
> > appears unnecessary.
> > 
> > We have confirmed this solution on all the affected models we have
> > in-hands (X542UQ, UX533FD, X530UN, V272UN).
> > 
> > Additionally, this solves an issue where r8169 MSI-X interrupts were
> > broken after S3 suspend/resume on Asus X441UAR. This issue was recently
> > worked around in commit 7bb05b85bc2d ("r8169: don't use MSI-X on
> > RTL8106e"). It also fixes the same issue on RTL6186evl/8111evl on an
> > Aimfor-tech laptop that we had not yet patched. I suspect it will also
> > fix the issue that was worked around in commit 7c53a722459c ("r8169:
> > don't use MSI-X on RTL8168g").
> > 
> > Thomas Martitz reports that this change also solves an issue where
> > the AMD Radeon Polaris 10 GPU on the HP Zbook 14u G5 is unresponsive
> > after S3 suspend/resume.
> > 
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=201069
> > Signed-off-by: Daniel Drake <drake@endlessm.com>
> 
> Applied with Rafael's and Peter's reviewed-by to pci/enumeration for v4.20.
> Thanks for the the huge investigative effort!

Since this looks low-risk and fixes several painful issues, I think
this merits a stable tag and being included in v4.19 (instead of
waiting for v4.20).  

I moved it to for-linus for v4.19.  Let me know if you object.

> > ---
> >  drivers/pci/pci.c | 25 +++++++++++++++++--------
> >  1 file changed, 17 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 29ff9619b5fa..5d58220b6997 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -1289,12 +1289,12 @@ int pci_save_state(struct pci_dev *dev)
> >  EXPORT_SYMBOL(pci_save_state);
> >  
> >  static void pci_restore_config_dword(struct pci_dev *pdev, int offset,
> > -				     u32 saved_val, int retry)
> > +				     u32 saved_val, int retry, bool force)
> >  {
> >  	u32 val;
> >  
> >  	pci_read_config_dword(pdev, offset, &val);
> > -	if (val == saved_val)
> > +	if (!force && val == saved_val)
> >  		return;
> >  
> >  	for (;;) {
> > @@ -1313,25 +1313,34 @@ static void pci_restore_config_dword(struct pci_dev *pdev, int offset,
> >  }
> >  
> >  static void pci_restore_config_space_range(struct pci_dev *pdev,
> > -					   int start, int end, int retry)
> > +					   int start, int end, int retry,
> > +					   bool force)
> >  {
> >  	int index;
> >  
> >  	for (index = end; index >= start; index--)
> >  		pci_restore_config_dword(pdev, 4 * index,
> >  					 pdev->saved_config_space[index],
> > -					 retry);
> > +					 retry, force);
> >  }
> >  
> >  static void pci_restore_config_space(struct pci_dev *pdev)
> >  {
> >  	if (pdev->hdr_type == PCI_HEADER_TYPE_NORMAL) {
> > -		pci_restore_config_space_range(pdev, 10, 15, 0);
> > +		pci_restore_config_space_range(pdev, 10, 15, 0, false);
> >  		/* Restore BARs before the command register. */
> > -		pci_restore_config_space_range(pdev, 4, 9, 10);
> > -		pci_restore_config_space_range(pdev, 0, 3, 0);
> > +		pci_restore_config_space_range(pdev, 4, 9, 10, false);
> > +		pci_restore_config_space_range(pdev, 0, 3, 0, false);
> > +	} else if (pdev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
> > +		pci_restore_config_space_range(pdev, 12, 15, 0, false);
> > +		/* Force rewriting of prefetch registers to avoid
> > +		 * S3 resume issues on Intel PCI bridges that occur when
> > +		 * these registers are not explicitly written.
> > +		 */
> > +		pci_restore_config_space_range(pdev, 9, 11, 0, true);
> > +		pci_restore_config_space_range(pdev, 0, 8, 0, false);
> >  	} else {
> > -		pci_restore_config_space_range(pdev, 0, 15, 0);
> > +		pci_restore_config_space_range(pdev, 0, 15, 0, false);
> >  	}
> >  }
> >  
> > -- 
> > 2.17.1
> > 
