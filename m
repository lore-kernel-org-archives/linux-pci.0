Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:41476 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754266Ab3JCMpC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Oct 2013 08:45:02 -0400
Date: Thu, 3 Oct 2013 14:44:57 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Jason Cooper <jason@lakedaemon.net>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH RESEND] PCI: mvebu: Dynamically detect if the PEX link
 is up to enable hot plug
Message-ID: <20131003144457.4131aea3@skate>
In-Reply-To: <1380650281-16175-1-git-send-email-jgunthorpe@obsidianresearch.com>
References: <1380650281-16175-1-git-send-email-jgunthorpe@obsidianresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Jason Gunthorpe,

On Tue,  1 Oct 2013 11:58:00 -0600, Jason Gunthorpe wrote:
> Otherwise hotplugging the PEX doesn't work at all since the driver
> detects the link state at probe time. Simply replacing the two tests
> of haslink with a register read is enough to fix it.
> 
> Tested on kirkwood with repeated plug/unplug of the link partner.
> 
> Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>

Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
-- 
Thomas Petazzoni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
