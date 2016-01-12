Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:51433 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883AbcALGHR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jan 2016 01:07:17 -0500
Subject: Re: [PATCH v4 1/2] PCI support added to ARC
To: Joao Pinto <Joao.Pinto@synopsys.com>, <helgaas@kernel.org>
References: <cover.1452526707.git.jpinto@synopsys.com>
 <b46c0fbfe3d383ca527e8eb7cbf953e59d346577.1452526707.git.jpinto@synopsys.com>
CC: <Vineet.Gupta1@synopsys.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-snps-arc@lists.infradead.org>,
	<CARLOS.PALMINHA@synopsys.com>, <Alexey.Brodkin@synopsys.com>,
	<robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Message-ID: <569497AE.3030405@synopsys.com>
Date: Tue, 12 Jan 2016 11:35:34 +0530
MIME-Version: 1.0
In-Reply-To: <b46c0fbfe3d383ca527e8eb7cbf953e59d346577.1452526707.git.jpinto@synopsys.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday 11 January 2016 10:54 PM, Joao Pinto wrote:
> This patch adds PCI support to ARC and updates drivers/pci Makefile enabling
> the ARC arch to use the generic PCI setup functions.
> 
> Signed-off-by: Joao Pinto <jpinto@synopsys.com>

BTW this patch has whitespace errors still - can you make sure they are not in the
next version(s)

-Vineet
