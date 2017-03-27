Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:42936 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752153AbdC0JDw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Mar 2017 05:03:52 -0400
From: Christoph Hellwig <hch@lst.de>
To: bhelgaas@google.com, davem@davemloft.net,
        netanel@annapurnalabs.com, jcliburn@gmail.com,
        chris.snook@gmail.com, sgoutham@cavium.com, rric@kernel.org
Cc: netdev@vger.kernel.org, linux-pci@vger.kernel.org
Subject: remove pci_enable_msix()
Date: Mon, 27 Mar 2017 10:29:31 +0200
Message-Id: <20170327082936.6830-1-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi all,

this series removes the remaining callers of the pci_enable_msix()
function and then the function itself.  All remaining users in in network
drivers, so if Bjorn is fine with it I'd like to handle it entirely
through the netdev tree.
