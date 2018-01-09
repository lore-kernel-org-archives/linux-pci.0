Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:15838 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759647AbeAIUAa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Jan 2018 15:00:30 -0500
Date: Tue, 9 Jan 2018 22:00:25 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Koen Vandeputte <koen.vandeputte@ncentric.com>,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com,
        niklas.cassel@axis.com
Subject: Re: [PATCH] PCI: dwc: fix enumeration end when reaching root
 subordinate
Message-ID: <20180109200025.GU27654@lahna.fi.intel.com>
References: <1515508941-20055-1-git-send-email-koen.vandeputte@ncentric.com>
 <20180109152550.GA16285@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180109152550.GA16285@red-moon>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 09, 2018 at 03:25:58PM +0000, Lorenzo Pieralisi wrote:
> On Tue, Jan 09, 2018 at 03:42:21PM +0100, Koen Vandeputte wrote:
> > The subordinate value indicates the highest bus number which can be
> > reached downstream though a certain device.
> > 
> > Commit a20c7f36bd3d ("PCI: Do not allocate more buses than available in
> > parent")
> > ensures that downstream devices cannot assign busnumbers higher than the
> > upstream device subordinate number, which was indeed illogical.
> > 
> > By default, dw_pcie_setup_rc() inits the Root Complex subordinate to a
> > value of 0x01.
> > 
> > Due to this combined with above commit, enumeration stops digging deeper
> > downstream as soon as bus num 0x01 has been assigned, which is always
> > the case for a bridge device.
> > 
> > This results in all devices behind a bridge bus to remain undetected, as
> > these would be connected to bus 0x02 or higher.
> > 
> > Fix this by initializing the RC to a subordinate value of 0xff, meaning
> > that all busses [0x00-0xff] are reachable through this RC.
> 
> This is not a correct description of the problem. AFAICS all busses
> are reachable through this RC _regardless_ of whatever subordinate
> bus number value you programme into it.

Type 1 (the ones directed to the other side of the bridge) configuration
transactions are not forwarded if the bus number in the transaction is
not included in secondary and subordinate numbers of the root bridge. I
think the description here is pretty accurate as the bridges (anything
higher than bus number 1) below are effectively hidden.
