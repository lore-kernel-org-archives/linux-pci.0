Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:64852 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965589AbcBDPXP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Feb 2016 10:23:15 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Joao Pinto <Joao.Pinto@synopsys.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Vineet.Gupta1@synopsys.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org, CARLOS.PALMINHA@synopsys.com,
	Alexey.Brodkin@synopsys.com, robh+dt@kernel.org,
	pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org
Subject: Re: [PATCH v7 2/2] add new platform driver for PCI RC
Date: Thu, 04 Feb 2016 16:22:19 +0100
Message-ID: <3373582.ygj8SQ4T4P@wuerfel>
In-Reply-To: <56B35B96.3090005@synopsys.com>
References: <cover.1454349430.git.jpinto@synopsys.com> <56B33278.3000408@synopsys.com> <56B35B96.3090005@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 04 February 2016 14:09:26 Joao Pinto wrote:
> Hi Bjorn and Arnd,
> 
> Removing the irq_handler causes the irq request to fail because in
> request_threaded_irq() both handler and thread_fn are NULL.
> 
> What's the typical procedure for this?
> 

Don't call request_irq? ;-)

	Arnd
