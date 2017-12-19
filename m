Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:52704 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753439AbdLSXzb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Dec 2017 18:55:31 -0500
Date: Wed, 20 Dec 2017 00:55:27 +0100
From: Niklas Cassel <niklas.cassel@axis.com>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kishon@ti.com" <kishon@ti.com>
Subject: Re: [PATCH v5 01/18] PCI: dwc: Use the DMA-API to get the MSI address
Message-ID: <20171219235527.GA1344@axis.com>
References: <20171120133222.27771-2-niklas.cassel@axis.com>
 <20171130152843.GC12096@red-moon>
 <20171213135953.GA30833@axis.com>
 <ff784f40-a629-b9cb-0d85-d1356eb69a38@synopsys.com>
 <ac5ceb21-b547-427c-f5fc-a3deb6398c99@synopsys.com>
 <20171214122229.GB27348@e107981-ln.cambridge.arm.com>
 <816956be-90ff-be0e-748f-39c64e4e7833@synopsys.com>
 <20171218155726.GB8157@red-moon>
 <6ef8e160-1bf6-7fb2-d9c8-c9d27c04541d@synopsys.com>
 <95866c7e-5177-69d6-ac64-1ba7f8b3e36d@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <95866c7e-5177-69d6-ac64-1ba7f8b3e36d@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Dec 19, 2017 at 12:45:30PM +0000, Gustavo Pimentel wrote:
> Tested-By: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> 
> Using an arc board with USB and SATA end points with a root complex PCIe IP core
> version 5.00, I ran the the following tests:
>  - I checked that all end points were listed correctly;
>  - I checked that no PCI related errors was present in dmesg;
>  - I copied a file from arc to the USB flash drive and checked the checksum;
>  - I copied a file from USB flash drive to the ARC and checked the checksum;
>  - I copied a file from arc to the SATA disk and checked the checksum;
>  - I copied a file from SATA disk to the arc and checked the checksum;
>  - I copied a file from USB flash drive to the SATA disk and checked the checksum;
>  - I copied a file from SATA disk to the USB flash drive and checked the checksum;
>  - I checked that no PCI related errors was present in dmesg;
> 
> Everything seemed normal to me.

Hello Gustavo,

Thanks a lot for testing.

FYI: I submitted a new patch set to address Lorenzo's review comments,
however, I do not think that we need to redo all the testing, since
now we are using the same GFP flags for MSI as we did before, which
obviously worked.

https://marc.info/?l=devicetree&m=151372652827788&w=2

Regards,
Niklas
