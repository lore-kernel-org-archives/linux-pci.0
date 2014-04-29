Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:19343 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752002AbaD2FxJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Apr 2014 01:53:09 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N4S004ML30K0W70@mailout2.samsung.com> for
 linux-pci@vger.kernel.org; Tue, 29 Apr 2014 14:53:08 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>,
	'Fabio Estevam' <fabio.estevam@freescale.com>
Cc: 'Fabio Estevam' <festevam@gmail.com>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>
References: <1398741896-5953-1-git-send-email-festevam@gmail.com>
 <20140429074559.5c6970fd@skate>
In-reply-to: <20140429074559.5c6970fd@skate>
Subject: Re: [PATCH v2] pci: pci-mvebu: Use '%pa' for printing 'phys_addr_t'
 type
Date: Tue, 29 Apr 2014 14:53:07 +0900
Message-id: <001301cf636f$4bba6460$e32f2d20$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, April 29, 2014 2:46 PM, Thomas Petazzoni wrote:
> On Tue, 29 Apr 2014 00:24:56 -0300, Fabio Estevam wrote:
> 
> >  		if (ret) {
> >  			dev_err(&port->pcie->pdev->dev,
> > -				"Could not create MBus window at 0x%x, size 0x%x: %d\n",
> > -				base, sz, ret);
> > +				"Could not create MBus window at [mem %pa - %pa] :%d\n",
> > +				&base, &base + sz, ret);
> 
> Are you sure '&base + sz' works here? %pa needs a reference as
> argument, so &base looks good. But '&base + sz' means you will print
> the value which is at the address of base, to which 'sz' is added,
> which is not what we want here. Probably you need something like:
> 
> 	phys_addr_t end = base + sz;
> 
> and then use '&end'.
> 
> Or I am missing something?

I agree with your suggestion.
Thanks.

Best regards,
Jingoo Han

> 
> Thomas
> --
> Thomas Petazzoni, CTO, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com

