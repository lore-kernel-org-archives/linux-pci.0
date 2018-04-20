Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753677AbeDTSQZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Apr 2018 14:16:25 -0400
Date: Fri, 20 Apr 2018 13:16:23 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Evan Wang <xswang@marvell.com>, Victor Gu <xigu@marvell.com>
Subject: Re: pci/host/fixes for v4.17-rc* - please pull
Message-ID: <20180420181623.GS28657@bhelgaas-glaptop.roam.corp.google.com>
References: <20180420180251.GA4003@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180420180251.GA4003@red-moon>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Evan, Victor because this also includes a few aardvark fixes]

On Fri, Apr 20, 2018 at 07:02:51PM +0100, Lorenzo Pieralisi wrote:
> Hi Bjorn,
> 
> I have queued some fixes from Thomas and Loic on my pci/host/fixes
> branch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/log/?h=pci/host/fixes
> 
> they are not necessarily urgent but they definitely fix issues (some
> longstanding) so I would kindly ask you to consider pulling that branch
> and send it upstream for v4.17-rc* cycles instead of waiting for the
> v4.18 patch queue.

I merged these to for-linus for v4.17, thanks!
