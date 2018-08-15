Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35464 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729347AbeHOTsp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Aug 2018 15:48:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id g1-v6so1699818wru.2
        for <linux-pci@vger.kernel.org>; Wed, 15 Aug 2018 09:55:48 -0700 (PDT)
Date: Wed, 15 Aug 2018 19:55:45 +0300
In-Reply-To: <1534340781-19194-1-git-send-email-adouglas@cadence.com>
References: <1534340781-19194-1-git-send-email-adouglas@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [PATCH v2 0/5] Add MSI-X support for cadence EP driver
To: Alan Douglas <adouglas@cadence.com>, bhelgaas@google.com
CC: kishon@ti.com, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org, gustavo.pimentel@synopsys.com,
        cyrille.pitchen@bootlin.com, stelford@cadence.com
From: Ramon Fried <ramon.fried@gmail.com>
Message-ID: <615023FB-D8BA-4F12-BC2B-EDDBBDA39148@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On August 15, 2018 4:46:21 PM GMT+03:00, Alan Douglas <adouglas@cadence=2Ec=
om> wrote:
>The patch implements MSI-X support in the cadence endpoint driver=2E
>
>This patch depends on on Gustavo Pimentel's patch series adding MSI-X
>support for EP ("Add MSI-X support on pcitest tool")=20
>
>It also adds fixes for MSI issues discovered during testing of MSI-X
>  - Use AXI region 0 for interrupt signalling
>  - Write MSI and MSI-X with 32bit value rather than 16bit
>  - Check for masking before sending MSI or MSI-X
>  - Check link is up before sending IRQ
>
Hi=2E=20
AFAIK the BIOS allocates physical memory for the bars=2E Assuming that the=
 MSIx bar is only mapped after kernel boots on the endpoint, could it be to=
o late?=20

Do we need to trigger re-enumeration of the PCI bus from host side when wo=
rking with this as an endpoint?=20

Thanks,=20
Ramon=20
>Changes since v1:
>  - Rebased on 4=2E18-rc1
>  - Update commit log to mark first 4 patches as fixes
>  - Correct formatting issues pointed out by checkpatch --strict
>
>Alan Douglas (5):
>  PCI: cadence: Use AXI region 0 to signal interrupts from EP
>  PCI: cadence: Write MSI data with 32bits
>  PCI: cadence: Check whether MSI is masked before sending it
>  PCI: cadence: Check link is up before sending IRQ from EP
>  PCI: cadence: Add MSI-X capability to EP driver
>
>drivers/pci/controller/pcie-cadence-ep=2Ec | 131
>+++++++++++++++++++++++++++++--
> drivers/pci/controller/pcie-cadence=2Eh    |   1 +
> 2 files changed, 125 insertions(+), 7 deletions(-)


--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
