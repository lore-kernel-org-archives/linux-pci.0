Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay6.synopsys.com ([198.182.37.59]:52232 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753334AbeD3Qbi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Apr 2018 12:31:38 -0400
Subject: Re: [PATCH 06/10] misc: pci_endpoint_test: Add MSI-X support
To: Alan Douglas <adouglas@cadence.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1524845816.git.gustavo.pimentel@synopsys.com>
 <633ea6faef782de5ea753bffe5028aceff09115a.1524845816.git.gustavo.pimentel@synopsys.com>
 <SN6PR07MB45124A237879C78453495C50D8820@SN6PR07MB4512.namprd07.prod.outlook.com>
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <3485fade-56fd-0078-a330-41187445c984@synopsys.com>
Date: Mon, 30 Apr 2018 17:30:20 +0100
MIME-Version: 1.0
In-Reply-To: <SN6PR07MB45124A237879C78453495C50D8820@SN6PR07MB4512.namprd07.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Alan,

On 30/04/2018 16:35, Alan Douglas wrote:
> Hi Gustavo,
> 
> On April 27, 2018, 4:57 p.m. Gustavo Pimentel wrote:
>> Add MSI-X support and update driver documentation accordingly.
>>
>> Add new driver parameter to allow interruption type selection.
>>
>> Modify the Legacy/MSI/MSI-X test process, by:
>>  - Add and use a specific register located in a BAR, which defines the interrupt
>> type is been triggered.
>>  - Move the interrupt ID number from the command section to a register
>> located in a BAR.
>>
>> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>> ---
>>  Documentation/misc-devices/pci-endpoint-test.txt |   3 +
>>  drivers/misc/pci_endpoint_test.c                 | 121 +++++++++++++++--------
>>  drivers/pci/endpoint/functions/pci-epf-test.c    |  78 +++++++++++----
>>  3 files changed, 143 insertions(+), 59 deletions(-)
>>
> In testing these changes  I found that pci_epc_raise_irq() also needs to be
> updated in pci-epc-core.c, since it has interrupt_num parameter as u8

Yes, indeed. I updated it together with the pci-epc.h file.
Thanks Alan, well spotted!

Regards,
Gustavo

> 
> Thanks,
> Alan
> 
