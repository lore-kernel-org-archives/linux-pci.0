Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:52524 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751879AbeDTSBz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Apr 2018 14:01:55 -0400
Date: Fri, 20 Apr 2018 19:02:51 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: Loic Poulain <loic.poulain@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: pci/host/fixes for v4.17-rc* - please pull
Message-ID: <20180420180251.GA4003@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

I have queued some fixes from Thomas and Loic on my pci/host/fixes
branch:

https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/log/?h=pci/host/fixes

they are not necessarily urgent but they definitely fix issues (some
longstanding) so I would kindly ask you to consider pulling that branch
and send it upstream for v4.17-rc* cycles instead of waiting for the
v4.18 patch queue.

Thank you (and Loic and Thomas for sending them) very much,
Lorenzo
