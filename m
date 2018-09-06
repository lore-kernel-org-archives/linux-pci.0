Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:42143 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728106AbeIFWLb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Sep 2018 18:11:31 -0400
Date: Thu, 6 Sep 2018 11:36:28 -0600
From: Keith Busch <keith.busch@intel.com>
To: Thomas Tai <thomas.tai@oracle.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv2 00/20] PCI, error handling and hot plug
Message-ID: <20180906173628.GA31024@localhost.localdomain>
References: <20180905203546.21921-1-keith.busch@intel.com>
 <81a2db94-f4a9-73a6-6853-16d31fa749b9@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <81a2db94-f4a9-73a6-6853-16d31fa749b9@oracle.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 06, 2018 at 01:30:47PM -0400, Thomas Tai wrote:
> Hi Keith,
> Which tag or branch is your patch based on? I can't apply it on the master
> branch of https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git

Sure, it was built on the pci/hotplug branch:

https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=pci/hotplug
