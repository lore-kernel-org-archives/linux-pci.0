Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:36020 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752822AbdJTKsG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Oct 2017 06:48:06 -0400
Subject: Re: [PATCH 08/10] PCI: dwc: artpec6: add support for endpoint mode
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Jesper Nilsson <jespern@axis.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        "Xiaowei Song" <songxiaowei@hisilicon.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Duc Dang <dhdang@apm.com>
CC: <linux-arm-kernel@axis.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20171013160914.3220-1-niklas.cassel@axis.com>
 <20171013160914.3220-9-niklas.cassel@axis.com>
 <db0685b5-6078-1c6b-093d-f160f74e85bf@ti.com>
From: Niklas Cassel <niklas.cassel@axis.com>
Message-ID: <2c2968eb-39f6-7b1e-0e6b-97e00c2e8cbf@axis.com>
Date: Fri, 20 Oct 2017 12:48:00 +0200
MIME-Version: 1.0
In-Reply-To: <db0685b5-6078-1c6b-093d-f160f74e85bf@ti.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/18/2017 10:46 AM, Kishon Vijay Abraham I wrote:
> Hi Niklas,
> 
> On Friday 13 October 2017 09:39 PM, Niklas Cassel wrote:
>> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
>> ---
>>  .../devicetree/bindings/pci/axis,artpec6-pcie.txt  |   3 +-
>>  drivers/pci/dwc/Kconfig                            |  41 +++--
>>  drivers/pci/dwc/Makefile                           |   4 +-
>>  drivers/pci/dwc/pcie-artpec6.c                     | 202 ++++++++++++++++++++-
>>  4 files changed, 233 insertions(+), 17 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt b/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt
>> index 4e4aee4439ea..33eef7ae5a23 100644
>> --- a/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt
>> +++ b/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt
>> @@ -4,7 +4,8 @@ This PCIe host controller is based on the Synopsys DesignWare PCIe IP
>>  and thus inherits all the common properties defined in designware-pcie.txt.
>>  
>>  Required properties:
>> -- compatible: "axis,artpec6-pcie", "snps,dw-pcie"
>> +- compatible: "axis,artpec6-pcie", "snps,dw-pcie" for ARTPEC-6 in RC mode;
>> +	      "axis,artpec6-pcie-ep", "snps,dw-pcie" for ARTPEC-6 in EP mode;
> 
> If "snps,dw-pcie" is used for both RC and EP mode, how do we differentiate
> between the modes?

Hello Kishon,

Most DWC core based PCIe controllers have the following text in their
DT binding:
"This PCIe host controller is based on the Synopsys DesignWare PCIe IP
and thus inherits all the common properties defined in designware-pcie.txt."

It seems like DRA7xx is one of few DWC core based bindings that does
not include this text.

However, I can see that you've added "EP mode:" and "RC mode:" headings
to designware-pcie.txt.

But still the top of the file says:
Required properties:
- compatible: should contain "snps,dw-pcie" to identify the core.



However, I don't think there's necessarily any contradiction here,
since axis,artpec6-pcie.txt says:

compatible: "axis,artpec6-pcie", "snps,dw-pcie" for ARTPEC-6 in RC mode;
compatible: "axis,artpec6-pcie-ep", "snps,dw-pcie" for ARTPEC-6 in EP mode;

And according to:
https://elinux.org/Device_Tree_Usage#Understanding_the_compatible_Property

The first string in the list specifies the exact device.
The following strings represent other devices that the device is compatible
with.

Their example is:

The compatible property for the MPC8349 serial device should therefore be:
compatible = "fsl,mpc8349-uart", "ns16550".
In this case, fsl,mpc8349-uart specifies the exact device, and ns16550 states
that it is register-level compatible with a National Semiconductor 16550 UART.

The exact device is "axis,artpec6-pcie-ep", but it is register compatible with
"snps,dw-pcie".

But perhaps Rob Herring could correct me if I'm wrong.


Regards,
Niklas
