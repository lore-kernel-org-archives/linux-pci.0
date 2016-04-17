Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:35074 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951AbcDQPn3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 17 Apr 2016 11:43:29 -0400
MIME-Version: 1.0
In-Reply-To: <20160411085759.GA7088@leverpostej>
References: <1460238624-2086-1-git-send-email-zajec5@gmail.com>
	<20160411085759.GA7088@leverpostej>
Date: Sun, 17 Apr 2016 17:43:27 +0200
Message-ID: <CACna6rx4LP5n3KHwV4bGc0oeUM-PTS+2m29GCcxg=u1EujRmxg@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: iproc: Support DT property for ignoring aborts
 when probing
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Jon Mason <jonmason@broadcom.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11 April 2016 at 10:57, Mark Rutland <mark.rutland@arm.com> wrote:
> Please Cc the device tree mailing list (devicetree@vger.kernel.org) when
> sending device tree patches.

Sorry, I'll remember to do that in future.


> On Sat, Apr 09, 2016 at 11:50:23PM +0200, Rafał Miłecki wrote:
>> Some devices (e.g. Northstar ones) may have bridges that forward
>> harmless errors to the ARM core. In such case we need an option to
>> add a handler ignoring them.
>>
>> Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
>> ---
>>  .../devicetree/bindings/pci/brcm,iproc-pcie.txt         |  6 ++++++
>>  drivers/pci/host/pcie-iproc-platform.c                  |  2 ++
>>  drivers/pci/host/pcie-iproc.c                           | 17 +++++++++++++++++
>>  drivers/pci/host/pcie-iproc.h                           |  1 +
>>  4 files changed, 26 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
>> index 01b88f4..c91b20a 100644
>> --- a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
>> +++ b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
>> @@ -22,6 +22,12 @@ Optional properties:
>>
>>  - brcm,pcie-ob: Some iProc SoCs do not have the outbound address mapping done
>>  by the ASIC after power on reset. In this case, SW needs to configure it
>> +- brcm,pcie-hook-abort-handler: During PCI bus probing (device enumeration)
>> +  there can be errors that are expected and harmless. Unfortunately some bridges
>> +  can't be configured to ignore them and they forward them to the ARM core
>> +  triggering die().
>> +  This property should be set in such case, it will make driver add its own
>> +  handler ignoring such errors.
>
> Rather than describing what the kernel should do, this should describe
> the property of the hardware (e.g. this should be named something like
> brcm,spurious-probing-abort).

Florian pointed it to me too, I'll use a better property name if we
decide to go this way. Thanks for your comment.

-- 
Rafał
