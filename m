Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:57695 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754708AbcI2L0E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Sep 2016 07:26:04 -0400
Date: Thu, 29 Sep 2016 08:25:58 -0300
From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
To: "tj@kernel.org" <tj@kernel.org>
Cc: "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "holler@ahsoftware.de" <holler@ahsoftware.de>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: ATA failure regression
Message-ID: <20160929112558.GA24350@khazad-dum.debian.net>
References: <DM5PR12MB17698A0E873273577E60A97BA0C80@DM5PR12MB1769.namprd12.prod.outlook.com>
 <8520D5D51A55D047800579B094147198258E4869@XAP-PVEXMBX01.xlnx.xilinx.com>
 <MWHPR12MB177486F96C515BCAEADC7D70A0CF0@MWHPR12MB1774.namprd12.prod.outlook.com>
 <20160929082229.GA11087@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160929082229.GA11087@mtj.duckdns.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 29 Sep 2016, tj@kernel.org wrote:
> On Wed, Sep 28, 2016 at 05:45:08AM +0000, Shah, Nehal-bakulchandra wrote:
> > Can someone please help me to debug this issue?
> 
> The only thing I can do from libata side is disbling msi on the
> affected platform, but the problem doesn't seem confined to ahci, so
> probably the right thing to do for now is disabling msi on the
> platform?

Actually, according to Shah's post from the 26th to this thread,
everything works just fine even with the IOMMU enabled, as long as the
system is configured to NOT auto-shutdown unused SATA ports.

That seems to give some extra avenues at fixing/working around the
issue, maybe?

-- 
  Henrique Holschuh
