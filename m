Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750722AbeDCOE3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Apr 2018 10:04:29 -0400
Date: Tue, 3 Apr 2018 09:04:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: kbuild@01.org, Tal Gilboa <talgi@mellanox.com>, kbuild-all@01.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [pci:pci/enumeration 5/15] drivers/pci/pci.c:5190
 pcie_bandwidth_available() warn: variable dereferenced before check 'speed'
 (see line 5171)
Message-ID: <20180403140427.GA60020@bhelgaas-glaptop.roam.corp.google.com>
References: <20180403080803.o37a2effl4cmiqkd@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180403080803.o37a2effl4cmiqkd@mwanda>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 03, 2018 at 11:08:03AM +0300, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/enumeration
> head:   4ca0362aafeb3b357f85ae3121328edbf979fc9a
> commit: a88de411b5ed7ff28f3cac96581eb3b5d5bf8b61 [5/15] PCI: Add pcie_bandwidth_available() to compute bandwidth available to device
> 
> smatch warnings:
> drivers/pci/pci.c:5190 pcie_bandwidth_available() warn: variable dereferenced before check 'speed' (see line 5171)
> drivers/pci/pci.c:5192 pcie_bandwidth_available() warn: variable dereferenced before check 'width' (see line 5172)

Thanks, Tal pointed this out earlier, and it's fixed already.
