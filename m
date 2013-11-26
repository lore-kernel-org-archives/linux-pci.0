Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:56901 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757569Ab3KZSHD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 26 Nov 2013 13:07:03 -0500
Date: Tue, 26 Nov 2013 11:06:59 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 2/2] PCI: mvebu - Support a bridge with no IO port
 window
Message-ID: <20131126180659.GB19852@obsidianresearch.com>
References: <1383262380-6984-1-git-send-email-jgunthorpe@obsidianresearch.com>
 <1383262380-6984-2-git-send-email-jgunthorpe@obsidianresearch.com>
 <20131125181008.158b5b09@skate>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131125181008.158b5b09@skate>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 25, 2013 at 06:10:08PM +0100, Thomas Petazzoni wrote:

> Thanks, and sorry again for the huge time it took me to test this
> version of your patches.

Thanks Thomas, I've rebased to v3.13-rc1, re-tested here, and re-sent
the patches.

There are two more you should look at - one should head into v3.13 as
it fixes a small regression.

Bjorn, Jason C has asked these go through your tree from now on.

Thanks,
Jason
