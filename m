Return-Path: <SRS0=Zfon=AB=gmail.com=oza.pawandeep@kernel.org>
Return-Path: <SRS0=Zfon=AB=gmail.com=oza.pawandeep@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170831133951.GA8154@bhelgaas-glaptop.roam.corp.google.com>
References: <1504155029-24729-1-git-send-email-oza.oza@broadcom.com> <20170831133951.GA8154@bhelgaas-glaptop.roam.corp.google.com>
From: Oza Pawandeep <oza.pawandeep@gmail.com>
Date: Thu, 31 Aug 2017 22:29:01 +0530
Message-ID: <CAK1A=4wznHsh=drYNrEEhaaJQrksWjkB8K_mOutgxFPh1CVdPg@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] PCI hotplug feature
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Oza Pawandeep <oza.oza@broadcom.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com, Andy Gospodarek <gospo@broadcom.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 31, 2017 at 7:09 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Thu, Aug 31, 2017 at 10:20:26AM +0530, Oza Pawandeep wrote:
>> These patches bring in PCI hotplug support for iproc family chipsets.
>>
>> It includes DT binding documentation and, the implementation in
>> iproc pcie RC driver.
>>
>> Changes since v5:
>> [RESEND]
>
> Not sure what the point of resending this as v6 was, since v5 was
> posted 6 minutes earlier and you don't mention any changes in v6?

My apologies,
It looked to me that v5 went out twice, might be confusing.

Hence sent out v6.

Regards,
Oza.
>
>> Changes since v4:
>> Rebased to pci-next
>> Added; Acked-by: Rob Herring <robh@kernel.org>
>>
>> Changes since v3:
>> Resend. just to be in sync previous in-flight patches.
>>
>> Changes since v2:
>> Addressed Rob Herring's comments.
>> Changed subject to "dt-bindings: PCI:..."
>> Made generic PCI hotplug properties 'slot-pluggable' and 'prsnt-gpios'
>> Rebased the patches on top of Lorenzo's patches.
>>
>> Oza Pawandeep (3):
>>   dt-bindings: PCI: Add PCI hotplug property
>>   dt-bindings: PCI iproc: Implement optional property prsnt-gpios
>>   PCI: iproc: Implement PCI hotplug support
>>
>>  .../devicetree/bindings/pci/brcm,iproc-pcie.txt    |  14 ++
>>  Documentation/devicetree/bindings/pci/pci.txt      |  15 ++
>>  drivers/pci/host/pcie-iproc-platform.c             |   3 +
>>  drivers/pci/host/pcie-iproc.c                      | 166 ++++++++++++++++++---
>>  drivers/pci/host/pcie-iproc.h                      |   7 +
>>  5 files changed, 187 insertions(+), 18 deletions(-)
>>
>> --
>> 1.9.1
>>
