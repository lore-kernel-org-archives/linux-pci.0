Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59640 "EHLO
        devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754024AbcI0L3u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2016 07:29:50 -0400
Subject: Re: [RFC PATCH 07/11] pci: controller: designware: Add EP mode
 support
To: Rob Herring <robh@kernel.org>
References: <1473829927-20466-1-git-send-email-kishon@ti.com>
 <1473829927-20466-8-git-send-email-kishon@ti.com>
 <20160923144141.GA24842@rob-hp-laptop>
CC: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Jingoo Han <jingoohan1@gmail.com>, <hch@infradead.org>,
        <Joao.Pinto@synopsys.com>, <mingkai.hu@nxp.com>,
        <m-karicheri2@ti.com>, Pratyush Anand <pratyush.anand@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Joao Pinto <jpinto@synopsys.com>, <nsekhar@ti.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <57EA57DC.9030304@ti.com>
Date: Tue, 27 Sep 2016 16:58:28 +0530
MIME-Version: 1.0
In-Reply-To: <20160923144141.GA24842@rob-hp-laptop>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Friday 23 September 2016 08:11 PM, Rob Herring wrote:
> On Wed, Sep 14, 2016 at 10:42:03AM +0530, Kishon Vijay Abraham I wrote:
>> Add endpoint mode support to designware driver. This uses the
>> EP Core layer introduced recently to add endpoint mode support.
>> *Any* function driver can now use this designware device
>> to achieve the EP functionality.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  .../devicetree/bindings/pci/designware-pcie.txt    |   26 ++-
>>  drivers/pci/controller/Kconfig                     |    5 +
>>  drivers/pci/controller/Makefile                    |    1 +
>>  drivers/pci/controller/pcie-designware-ep.c        |  228 ++++++++++++++++++++
>>  drivers/pci/controller/pcie-designware.c           |   30 +++
>>  drivers/pci/controller/pcie-designware.h           |   45 ++++
>>  6 files changed, 324 insertions(+), 11 deletions(-)
>>  create mode 100644 drivers/pci/controller/pcie-designware-ep.c
>>
>> diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
>> index 6c5322c..bb0b789 100644
>> --- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
>> +++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
>> @@ -6,23 +6,27 @@ Required properties:
>>  - reg-names: Must be "config" for the PCIe configuration space.
>>      (The old way of getting the configuration address space from "ranges"
>>      is deprecated and should be avoided.)
>> -- #address-cells: set to <3>
>> -- #size-cells: set to <2>
>> -- device_type: set to "pci"
>> -- ranges: ranges for the PCI memory and I/O regions
>> -- #interrupt-cells: set to <1>
>> -- interrupt-map-mask and interrupt-map: standard PCI properties
>> -	to define the mapping of the PCIe interface to interrupt
>> +- #address-cells (only for host mode): set to <3>
>> +- #size-cells (only for host mode): set to <2>
>> +- device_type (only for host mode): set to "pci"
>> +- ranges (only for host mode): ranges for the PCI memory and I/O regions
>> +- num-ib-windows (only for EP mode): number of inbound address translation
>> +	windows
>> +- num-ob-windows (only for EP mode): number of outbound address translation
>> +	windows
>> +- #interrupt-cells (only for host mode): set to <1>
>> +- interrupt-map-mask and interrupt-map (only for host mode): standard PCI
>> +	properties to define the mapping of the PCIe interface to interrupt
> 
> It may be clearer to just document EP mode in a separate section even if 
> there's some duplication of properties. Other standard PCI binding 
> properties probably also don't apply.

right, will change this accordingly.

Thanks
Kishon
