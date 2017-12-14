Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lelnx194.ext.ti.com ([198.47.27.80]:24262 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751875AbdLNL0F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Dec 2017 06:26:05 -0500
Subject: Re: [PATCH v4 0/3] Fix find_first_zero_bit() usage
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Niklas Cassel <niklas.cassel@axis.com>
References: <20171212141634.5985-1-niklas.cassel@axis.com>
 <20171214105116.GA1442@e107981-ln.cambridge.arm.com>
CC: <linux-pci@vger.kernel.org>, Niklas Cassel <niklass@axis.com>,
        <linux-kernel@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <6b9203a8-7182-e8ab-6d81-bfa7ceba6005@ti.com>
Date: Thu, 14 Dec 2017 16:55:55 +0530
MIME-Version: 1.0
In-Reply-To: <20171214105116.GA1442@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo,

On Thursday 14 December 2017 04:21 PM, Lorenzo Pieralisi wrote:
> Hi Kishon,
> 
> On Tue, Dec 12, 2017 at 03:16:31PM +0100, Niklas Cassel wrote:
>> find_first_zero_bit()'s parameter 'size' is defined in bits,
>> not in bytes.
>>
>> Calling find_first_zero_bit() with the wrong size unit
>> will lead to insidious bugs.
>>
>> Fix all uses of find_first_zero_bit() called with
>> sizeof() as size argument in drivers/pci.
>>
>> Also had to fix broken error handling in pci_epc_epf_link()
>> in order to do proper error handling for find_first_zero_bit().
>>
>> Niklas Cassel (3):
>>   PCI: designware-ep: Fix find_first_zero_bit() usage
>>   PCI: endpoint: Fix error handling in pci_epc_epf_link()
>>   PCI: endpoint: Fix find_first_zero_bit() usage
>>
>>  drivers/pci/dwc/pcie-designware-ep.c | 34 ++++++++++++++++++++++++++--------
>>  drivers/pci/dwc/pcie-designware.h    |  8 ++++++--
>>  drivers/pci/endpoint/pci-ep-cfs.c    | 13 ++++++++-----
>>  3 files changed, 40 insertions(+), 15 deletions(-)
> 
> I would need your ACK asap to queue this series.

Sorry for the delay. I had a comment on the 2nd patch.

Thanks
Kishon
