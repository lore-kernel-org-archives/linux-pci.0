Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp-out6.electric.net ([192.162.217.182]:59732 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932189AbdJ3P6U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Oct 2017 11:58:20 -0400
From: David Laight <David.Laight@ACULAB.COM>
To: 'Manikanta Maddireddy' <mmaddireddy@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>
CC: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "vidyas@nvidia.com" <vidyas@nvidia.com>,
        "kthota@nvidia.com" <kthota@nvidia.com>
Subject: RE: [PATCH 07/12] PCI: tegra: Disable AFI dynamic clock gating
Date: Mon, 30 Oct 2017 15:58:36 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD00A90B0@AcuExch.aculab.com>
References: <1509132569-9398-1-git-send-email-mmaddireddy@nvidia.com>
 <1509132569-9398-8-git-send-email-mmaddireddy@nvidia.com>
In-Reply-To: <1509132569-9398-8-git-send-email-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Manikanta Maddireddy
> Sent: 27 October 2017 20:29
> When there are 32 outstanding writes from AFI to memory, the outstanding
> write counter overflows and indicates that there are "0" outstanding write
> transactions. This outstanding write counter is used to generate IDLE
> signal to dynamically gate the AFI clock.
> 
> When memory controller is under heavy load, its possible that write
> completions will come back to AFI after long delay and AFI write counter
> overflows. AFI clock gets gated even when there are outstanding
> transactions towards memory controller resutling in system hang.
> 
> Disable dynamic clock gating of AFI clock to avoid system hang.

At least some of the above really ought to be comments in the code.
(and with the earlier fix for limiting the number of writes.)

	David
