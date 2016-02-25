Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:36282 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104AbcBYQwW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 25 Feb 2016 11:52:22 -0500
Subject: Re: [PATCH RESEND v9 1/2] PCI support added to ARC
To: Bjorn Helgaas <helgaas@kernel.org>,
	Joao Pinto <Joao.Pinto@synopsys.com>
References: <cover.1454952698.git.jpinto@synopsys.com>
 <8294ff8ecdae71799292c0d8b0bfc2f99967c26d.1454952698.git.jpinto@synopsys.com>
 <20160225163024.GH8120@localhost>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org, CARLOS.PALMINHA@synopsys.com,
	Alexey.Brodkin@synopsys.com, robh+dt@kernel.org,
	pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org, arnd@arndb.de
From: Vineet Gupta <vgupta@synopsys.com>
Message-ID: <56CF3139.4000008@synopsys.com>
Date: Thu, 25 Feb 2016 22:22:09 +0530
MIME-Version: 1.0
In-Reply-To: <20160225163024.GH8120@localhost>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 25 February 2016 10:00 PM, Bjorn Helgaas wrote:
> On Wed, Feb 17, 2016 at 05:46:18PM +0000, Joao Pinto wrote:
>> > This patch adds PCI support to ARC and updates drivers/pci Makefile
>> > enabling the ARC arch to use the generic PCI setup functions.
>> > 
>> > Signed-off-by: Joao Pinto <jpinto@synopsys.com>
> Did we have an ack from the ARC arch maintainer for this?  I seem to
> remember one, but it would help me out if you included it here so I
> didn't have to track it down.
> 

Indeed I'd acked it before. Still if it helps avoid a respin !

Acked-by: Vineet Gupta <vgupta@synopsys.com>

