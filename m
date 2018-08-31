Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:3997 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727181AbeIADIL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 31 Aug 2018 23:08:11 -0400
Date: Fri, 31 Aug 2018 16:59:48 -0600
From: Keith Busch <keith.busch@intel.com>
To: Sinan Kaya <okaya@kernel.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH 14/16] pciehp: Ignore link events during DPC event
Message-ID: <20180831225948.GF9677@localhost.localdomain>
References: <20180831212639.10196-1-keith.busch@intel.com>
 <20180831212639.10196-15-keith.busch@intel.com>
 <01398ef7-88a8-cac1-3e15-ef68c165f7a4@kernel.org>
 <20180831223352.GE9677@localhost.localdomain>
 <1ad6771a-f396-452b-9697-b407b95643bf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1ad6771a-f396-452b-9697-b407b95643bf@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 31, 2018 at 03:55:58PM -0700, Sinan Kaya wrote:
> On 8/31/2018 3:33 PM, Keith Busch wrote:
> > Darn, you're right. The kernel allocates up to 32 vectors and the port is
> > free to divvy them up however it wants amont its supported services. It
> > just so happened most of the ports I tested used the same one. There's
> > no way to really close this race if they are separate vectors though,
> > so maybe just leave this as  a 'best effort' approach and update the
> > change log accodingly.
> 
> or take the big hammer and move them into a single workqueue?

That wouldn't really help if they're different interrupt vectors since
they could happen in either order with a delay between the CPU seeing
each of them.
