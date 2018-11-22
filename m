Return-Path: <SRS0=lMXa=OB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556B0C43441
	for <linux-pci@archiver.kernel.org>; Thu, 22 Nov 2018 02:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A62E2075B
	for <linux-pci@archiver.kernel.org>; Thu, 22 Nov 2018 02:13:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A62E2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730877AbeKVMvC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 22 Nov 2018 07:51:02 -0500
Received: from mail-sh2.amlogic.com ([58.32.228.45]:56728 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727713AbeKVMvC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Nov 2018 07:51:02 -0500
Received: from [10.18.29.147] (10.18.29.147) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Thu, 22 Nov
 2018 10:14:00 +0800
Subject: Re: [PATCH v5 1/2] dt-bindings: PCI: meson: add DT bindings for
 Amlogic Meson PCIe controller
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <yixun.lan@amlogic.com>, <robh@kernel.org>,
        <jianxin.pan@amlogic.com>, <devicetree@vger.kernel.org>,
        <khilman@baylibre.com>, <shawn.lin@rock-chips.com>,
        <pombredanne@nexb.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <qiufang.dai@amlogic.com>,
        <jian.hu@amlogic.com>, <liang.yang@amlogic.com>,
        <cyrille.pitchen@free-electrons.com>,
        <gustavo.pimentel@synopsys.com>, <carlo@caione.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <jbrunet@baylibre.com>,
        <yue.wang@amlogic.com>
References: <1539049990-30810-1-git-send-email-hanjie.lin@amlogic.com>
 <1539049990-30810-2-git-send-email-hanjie.lin@amlogic.com>
 <CAFBinCCChD-phwyb3hSzAjBmy09g35ijQa_chJX5HufuVnPjaw@mail.gmail.com>
From:   Hanjie Lin <hanjie.lin@amlogic.com>
Message-ID: <579c542e-1faa-abc4-df4a-3b1002d4f15f@amlogic.com>
Date:   Thu, 22 Nov 2018 10:14:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <CAFBinCCChD-phwyb3hSzAjBmy09g35ijQa_chJX5HufuVnPjaw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.29.147]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2018/11/20 4:12, Martin Blumenstingl wrote:
> Hello Hanjie, Hello Yue,
> 
> sorry for being late with my comment
> 
> On Tue, Oct 9, 2018 at 3:53 AM Hanjie Lin <hanjie.lin@amlogic.com> wrote:
>>
>> From: Yue Wang <yue.wang@amlogic.com>
>>
>> The Amlogic Meson PCIe host controller is based on the Synopsys DesignWare
>> PCI core. This patch adds documentation for the DT bindings in Meson PCIe
>> controller.
>>
>> Signed-off-by: Yue Wang <yue.wang@amlogic.com>
>> Signed-off-by: Hanjie Lin <hanjie.lin@amlogic.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> ---
>>  .../devicetree/bindings/pci/amlogic,meson-pcie.txt | 70 ++++++++++++++++++++++
>>  1 file changed, 70 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
>>
>> diff --git a/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt b/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
>> new file mode 100644
>> index 0000000..12b18f8
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
>> @@ -0,0 +1,70 @@
>> +Amlogic Meson AXG DWC PCIE SoC controller
>> +
>> +Amlogic Meson PCIe host controller is based on the Synopsys DesignWare PCI core.
>> +It shares common functions with the PCIe DesignWare core driver and
>> +inherits common properties defined in
>> +Documentation/devicetree/bindings/pci/designware-pci.txt.
>> +
>> +Additional properties are described here:
>> +
>> +Required properties:
>> +- compatible:
>> +       should contain "amlogic,axg-pcie" to identify the core.
>> +- reg:
>> +       should contain the configuration address space.
>> +- reg-names: Must be
>> +       - "elbi"        External local bus interface registers
>> +       - "cfg"         Meson specific registers
>> +       - "phy"         Meson PCIE PHY registers
> is this only the PCIe PHY registers or is it the registers of the PHY
> which supports USB3.0 and PCIe?
> buildroot_openlinux_kernel_4.9_fbdev_20180706 uses the following
> registers in the pcie_A node for the "phy" registers:
> 0x0 0xff646000 0x0 0x2000
> while the usb3_phy_v2 node uses:
> phy-reg = <0xff646000>;
> 

It's correct.
In Meson AXG chip, this phy is dedicated to pcie.
But in Meson G12 chip, this phy is shared by pcie and usb3.0, only one module
can own the phy at one time.


>> +       - "config"      PCIe configuration space
>> +- reset-gpios: The GPIO to generate PCIe PERST# assert and deassert signal.
>> +- clocks: Must contain an entry for each entry in clock-names.
>> +- clock-names: Must include the following entries:
>> +       - "pclk"       PCIe GEN 100M PLL clock
>> +       - "port"       PCIe_x(A or B) RC clock gate
>> +       - "general"    PCIe Phy clock
>> +       - "mipi"       PCIe_x(A or B) 100M ref clock gate
>> +- resets: phandle to the reset lines.
>> +- reset-names: must contain "phy" "port" and "apb"
>> +       - "phy"         Share PHY reset
>> +       - "port"        Port A or B reset
>> +       - "apb"         Share APB reset
>> +- device_type:
>> +       should be "pci". As specified in designware-pcie.txt
>> +
>> +
>> +Example configuration:
>> +
>> +       pcie: pcie@f9800000 {
>> +                       compatible = "amlogic,axg-pcie", "snps,dw-pcie";
>> +                       reg = <0x0 0xf9800000 0x0 0x400000
>> +                                       0x0 0xff646000 0x0 0x2000
>> +                                       0x0 0xff644000 0x0 0x2000
>> +                                       0x0 0xf9f00000 0x0 0x100000>;
>> +                       reg-names = "elbi", "cfg", "phy", "config";
> is the order of the reg-names correct?
> buildroot_openlinux_kernel_4.9_fbdev_20180706 uses 0xff646000 for the
> PHY (instead of 0xff646000) in mesong12a.dtsi and mesong12b.dtsi
> 

It's correct, because memory map of AXG is different from G12.
MESON AXG memory map:
pcie_B:   0xFF648000~0xFF649FFF
pcie_A:  0xFF646000~0xff647FFF
pcie_phy: 0xFF644000~0xFF645FFF

MESON G12 memory map:
pcie_A:  0xFF648000~0xff649fff
pcie_phy: 0xFF646000~0xFF647FFF

Thanks.

> 
> Regards
> Martin
> 
> .
> 
