Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:33852 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751152AbdAWPCy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Jan 2017 10:02:54 -0500
MIME-Version: 1.0
In-Reply-To: <20170123145204.5lablvhf7m2hf3na@rob-hp-laptop>
References: <20170119163631.10668-1-andrew.smirnov@gmail.com>
 <20170119163631.10668-4-andrew.smirnov@gmail.com> <20170123145204.5lablvhf7m2hf3na@rob-hp-laptop>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Mon, 23 Jan 2017 07:02:52 -0800
Message-ID: <CAHQ1cqEFS-XEfm7=QP6hCLARan3eQ5VT6Ucq3HPsCzYoodHqtA@mail.gmail.com>
Subject: Re: [PATCH 3/3] PCI: imx6: Add code to support i.MX7D
To: Rob Herring <robh@kernel.org>
Cc: linux-pci@vger.kernel.org, Andrey Yurovsky <yurovsky@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 23, 2017 at 6:52 AM, Rob Herring <robh@kernel.org> wrote:
> On Thu, Jan 19, 2017 at 08:36:31AM -0800, Andrey Smirnov wrote:
>> Add various bits of code needed to support i.MX7D variant of the IP.
>>
>> Cc: yurovsky@gmail.com
>> Cc: Richard Zhu <hongxing.zhu@nxp.com>
>> Cc: Lucas Stach <l.stach@pengutronix.de>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: Fabio Estevam <festevam@gmail.com>
>> Cc: Shawn Guo <shawnguo@kernel.org>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Lee Jones <lee.jones@linaro.org>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: devicetree@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>> ---
>>  .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |   6 +-
>>  drivers/pci/host/pci-imx6.c                        | 188 ++++++++++++++++++---
>>  include/linux/mfd/syscon/imx7-gpc.h                |  18 ++
>>  include/linux/mfd/syscon/imx7-iomuxc-gpr.h         |   4 +
>>  include/linux/mfd/syscon/imx7-src.h                |  18 ++
>>  5 files changed, 208 insertions(+), 26 deletions(-)
>>  create mode 100644 include/linux/mfd/syscon/imx7-gpc.h
>>  create mode 100644 include/linux/mfd/syscon/imx7-src.h
>>
>> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
>> index 83aeb1f..20b9382 100644
>> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
>> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
>> @@ -4,7 +4,8 @@ This PCIe host controller is based on the Synopsis Designware PCIe IP
>>  and thus inherits all the common properties defined in designware-pcie.txt.
>>
>>  Required properties:
>> -- compatible: "fsl,imx6q-pcie", "fsl,imx6sx-pcie", "fsl,imx6qp-pcie"
>> +- compatible: "fsl,imx6q-pcie", "fsl,imx6sx-pcie",
>> +           "fsl,imx6qp-pcie", "fsl,imx7d-pcie"
>
> Please reformat to one valid combination per line.

Noted for v2, thanks.
