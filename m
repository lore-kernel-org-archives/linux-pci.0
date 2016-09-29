Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yb0-f169.google.com ([209.85.213.169]:33477 "EHLO
        mail-yb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750940AbcI2LdP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Sep 2016 07:33:15 -0400
Date: Thu, 29 Sep 2016 13:33:11 +0200
From: "tj@kernel.org" <tj@kernel.org>
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "holler@ahsoftware.de" <holler@ahsoftware.de>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williamps@intel.com>
Subject: Re: ATA failure regression
Message-ID: <20160929113311.GA26566@mtj.duckdns.org>
References: <DM5PR12MB17698A0E873273577E60A97BA0C80@DM5PR12MB1769.namprd12.prod.outlook.com>
 <8520D5D51A55D047800579B094147198258E4869@XAP-PVEXMBX01.xlnx.xilinx.com>
 <MWHPR12MB177486F96C515BCAEADC7D70A0CF0@MWHPR12MB1774.namprd12.prod.outlook.com>
 <20160929082229.GA11087@mtj.duckdns.org>
 <20160929112558.GA24350@khazad-dum.debian.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160929112558.GA24350@khazad-dum.debian.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

(cc'ing Dan, hi!)

On Thu, Sep 29, 2016 at 08:25:58AM -0300, Henrique de Moraes Holschuh wrote:
> Actually, according to Shah's post from the 26th to this thread,
> everything works just fine even with the IOMMU enabled, as long as the
> system is configured to NOT auto-shutdown unused SATA ports.
> 
> That seems to give some extra avenues at fixing/working around the
> issue, maybe?

Hmm... it could be that the multiple msix routing gets screwed when
the bios disables unoccupied ports.  Dan, can you please look into
this?  Shah is seeing ahci failing during boot on an AMD platform with
msi enabled.  If disabling of unoccupied ports is turned off in bios,
the problem goes away.  Maybe we're mapping the irqs incorrectly in
such cases?

Thanks.

-- 
tejun
