Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.47.9]:57294 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754504AbcBBK5J (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 2 Feb 2016 05:57:09 -0500
Subject: Re: [PATCH v7 1/2] PCI support added to ARC
To: Joao Pinto <Joao.Pinto@synopsys.com>, <helgaas@kernel.org>
References: <cover.1454349430.git.jpinto@synopsys.com>
 <cd8c068e6a2adca346769f0f9c1e0c291d001048.1454349430.git.jpinto@synopsys.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-snps-arc@lists.infradead.org>,
	<CARLOS.PALMINHA@synopsys.com>, <Alexey.Brodkin@synopsys.com>,
	<robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<arnd@arndb.de>
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Message-ID: <56B0896C.8000701@synopsys.com>
Date: Tue, 2 Feb 2016 16:18:12 +0530
MIME-Version: 1.0
In-Reply-To: <cd8c068e6a2adca346769f0f9c1e0c291d001048.1454349430.git.jpinto@synopsys.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday 01 February 2016 11:37 PM, Joao Pinto wrote:
> This patch adds PCI support to ARC and updates drivers/pci Makefile
> enabling the ARC arch to use the generic PCI setup functions.
> 
> Signed-off-by: Joao Pinto <jpinto@synopsys.com>

Acked-by: Vineet Gupta <vgupta@synopsys.com>

@Bjorn - feel free to pull this patch into your tree !

Thx,
-Vineet
