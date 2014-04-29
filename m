Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:55354 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754266AbaD2Fqs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Apr 2014 01:46:48 -0400
Date: Tue, 29 Apr 2014 07:45:59 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	jg1.han@samsung.com, Fabio Estevam <fabio.estevam@freescale.com>
Subject: Re: [PATCH v2] pci: pci-mvebu: Use '%pa' for printing 'phys_addr_t'
 type
Message-ID: <20140429074559.5c6970fd@skate>
In-Reply-To: <1398741896-5953-1-git-send-email-festevam@gmail.com>
References: <1398741896-5953-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Fabio Estevam,

On Tue, 29 Apr 2014 00:24:56 -0300, Fabio Estevam wrote:

>  		if (ret) {
>  			dev_err(&port->pcie->pdev->dev,
> -				"Could not create MBus window at 0x%x, size 0x%x: %d\n",
> -				base, sz, ret);
> +				"Could not create MBus window at [mem %pa - %pa] :%d\n",
> +				&base, &base + sz, ret);

Are you sure '&base + sz' works here? %pa needs a reference as
argument, so &base looks good. But '&base + sz' means you will print
the value which is at the address of base, to which 'sz' is added,
which is not what we want here. Probably you need something like:

	phys_addr_t end = base + sz;

and then use '&end'.

Or I am missing something?

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
