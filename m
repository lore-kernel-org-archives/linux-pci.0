Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:47897 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752545AbdDKLBj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Apr 2017 07:01:39 -0400
From: Christoph Hellwig <hch@lst.de>
To: davem@davemloft.net
Cc: bhelgaas@google.com, netanel@annapurnalabs.com, jcliburn@gmail.com,
        chris.snook@gmail.com, sgoutham@cavium.com, rric@kernel.org,
        jiri@mellanox.com, idosch@mellanox.com, netdev@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: remove pci_enable_msix() V3
Date: Tue, 11 Apr 2017 13:01:20 +0200
Message-Id: <20170411110125.3446-1-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi all,

this series removes the remaining callers of the pci_enable_msix()
function and then the function itself.  The final removal has been
Acked by Bjorn.

Changes since V2:
 - add another patch on Dave's request
 - add various acks
 - spelling fixes in the commit logs

Changes since V1:
 - replace the two previous thunderx patches with a new one from Thanneeru
