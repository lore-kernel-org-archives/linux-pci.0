Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:45929 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751194AbeGJKiD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jul 2018 06:38:03 -0400
Subject: Re: [PATCH v9 10/12] pci_endpoint_test: Add 2 ioctl commands
To: Alan Douglas <adouglas@cadence.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1531155252.git.gustavo.pimentel@synopsys.com>
 <185f0395d22083c04364cb81b4c2e2448fa89fb2.1531155252.git.gustavo.pimentel@synopsys.com>
 <MWHPR07MB35020A4BD96C8B34E9A0EB83D85B0@MWHPR07MB3502.namprd07.prod.outlook.com>
From: Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Message-ID: <afe07c2b-331e-3c08-fe0d-95bddf9d4e54@synopsys.com>
Date: Tue, 10 Jul 2018 11:35:44 +0100
MIME-Version: 1.0
In-Reply-To: <MWHPR07MB35020A4BD96C8B34E9A0EB83D85B0@MWHPR07MB3502.namprd07.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Alan,

On 10/07/2018 11:10, Alan Douglas wrote:
> On 09 July 2018 18:43 Gustavo Pimentel wrote:
>> Add MSI-X support and update driver documentation accordingly.
>>
>> Add 2 new IOCTL commands:
>>  - Allow to reconfigure driver IRQ type in runtime.
>>  - Allow to retrieve current driver IRQ type configured.
>>
>> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>> ---
>> Change v2->v3:
>>  - New patch file created base on the previous patch
>> "misc: pci_endpoint_test: Add MSI-X support" patch file following
>> Kishon's suggestion.
>> Change v3->v4:
>>  - Rebased to Lorenzo's master branch v4.18-rc1.
>> Change v4->v5:
>>  - Nothing changed, just to follow the patch set version.
>> Change v5->v6:
>>  - Moved PCITEST_SET_IRQTYPE and PCITEST_GET_IRQTYPE ioctl entries
>> from patch #10 to here.
>>  - Increased ioctl parameters range associated to
>> drivers/misc/pci_endpoint_test.c driver.
>> Change v6->v7:
>>  - irq_type variable update just before returning the function.
>> Change v7->v8:
>>  - Re-sending the patch series.
>> Change v8->v9:
>>  - Added a extra parameter to pci_endpoint_test_alloc_irq_vectors,
>> that specifies which irq type should be allocated.
>>
>>  Documentation/ioctl/ioctl-number.txt             |   2 +-
>>  Documentation/misc-devices/pci-endpoint-test.txt |   3 +
>>  drivers/misc/pci_endpoint_test.c                 | 176 +++++++++++++++++------
>>  include/uapi/linux/pcitest.h                     |   2 +
>>  4 files changed, 136 insertions(+), 47 deletions(-)
>>
>> diff --git a/Documentation/ioctl/ioctl-number.txt b/Documentation/ioctl/ioctl-number.txt
>> index 65259d4..c15c4f3 100644
>> --- a/Documentation/ioctl/ioctl-number.txt
>> +++ b/Documentation/ioctl/ioctl-number.txt
>> @@ -166,7 +166,7 @@ Code  Seq#(hex)	Include File		Comments
>>  'P'	all	linux/soundcard.h	conflict!
>>  'P'	60-6F	sound/sscape_ioctl.h	conflict!
>>  'P'	00-0F	drivers/usb/class/usblp.c	conflict!
>> -'P'	01-07	drivers/misc/pci_endpoint_test.c	conflict!
>> +'P'	01-09	drivers/misc/pci_endpoint_test.c	conflict!
>>  'Q'	all	linux/soundcard.h
>>  'R'	00-1F	linux/random.h		conflict!
>>  'R'	01	linux/rfkill.h		conflict!
>> diff --git a/Documentation/misc-devices/pci-endpoint-test.txt b/Documentation/misc-devices/pci-endpoint-test.txt
>> index fdfa0f6..58ccca4 100644
>> --- a/Documentation/misc-devices/pci-endpoint-test.txt
>> +++ b/Documentation/misc-devices/pci-endpoint-test.txt
>> @@ -28,6 +28,9 @@ ioctl
>>  	      to be tested should be passed as argument.
>>   PCITEST_MSIX: Tests message signalled interrupts. The MSI-X number
>>  	      to be tested should be passed as argument.
>> + PCITEST_SET_IRQTYPE: Changes driver IRQ type configuration. The IRQ type
>> +	      should be passed as argument (0: Legacy, 1:MSI, 2:MSI-X).
>> + PCITEST_GET_IRQTYPE: Gets driver IRQ type configuration.
> I've tested this latest set of patches with the cadence ep driver, which
> does not yet support MSI-X, and can confirm that setting, getting and using
> legacy and MSI IRQ type IRQs is working correctly.  Setting MSI-X fails, as
> expected.

Great, thanks for testing!

Regards,
Gustavo

> 
