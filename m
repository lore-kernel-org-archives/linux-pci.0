Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:33096 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934640AbdDFMY7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Apr 2017 08:24:59 -0400
From: Christoph Hellwig <hch@lst.de>
To: bhelgaas@google.com, davem@davemloft.net,
        netanel@annapurnalabs.com, jcliburn@gmail.com,
        chris.snook@gmail.com, sgoutham@cavium.com, rric@kernel.org
Cc: netdev@vger.kernel.org, linux-pci@vger.kernel.org
Subject: remove pci_enable_msix() V2
Date: Thu,  6 Apr 2017 14:24:44 +0200
Message-Id: <20170406122448.31854-1-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi all,

this series removes the remaining callers of the pci_enable_msix()
function and then the function itself.  All remaining users in in network
drivers, so if Bjorn is fine with it I'd like to handle it entirely
through the netdev tree.

Changes since V1:
 - replace the two previous thunderx patches with a new one from Thanneeru
