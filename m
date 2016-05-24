Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:39048 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752409AbcEXB3J (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 23 May 2016 21:29:09 -0400
Subject: Re: [PATCH 2/2] pci: Add PCIe driver for Rockchip Soc
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
	Bjorn Helgaas <bhelgaas@google.com>
References: <1463740105-7061-1-git-send-email-shawn.lin@rock-chips.com>
 <1463740156-7148-1-git-send-email-shawn.lin@rock-chips.com>
 <8520D5D51A55D047800579B094147198258ACE47@XAP-PVEXMBX01.xlnx.xilinx.com>
Cc: shawn.lin@rock-chips.com, Heiko Stuebner <heiko@sntech.de>,
	Wenrui Li <wenrui.li@rock-chips.com>,
	Rob Herring <robh+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Doug Anderson <dianders@chromium.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-rockchip@lists.infradead.org"
	<linux-rockchip@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <0f470ba9-78ac-4822-2cd0-6f028123271d@rock-chips.com>
Date: Tue, 24 May 2016 09:28:55 +0800
MIME-Version: 1.0
In-Reply-To: <8520D5D51A55D047800579B094147198258ACE47@XAP-PVEXMBX01.xlnx.xilinx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bharat,

On 2016/5/23 23:15, Bharat Kumar Gogada wrote:
>> +
>> +	irq = platform_get_irq_byname(pdev, "pcie-sys");
>> +	if (irq < 0) {
>> +		dev_err(dev, "missing pcie_sys IRQ resource\n");
>> +		return -EINVAL;
>> +	}
>> +	err = devm_request_irq(dev, irq, rockchip_pcie_subsys_irq_handler,
>> +			       IRQF_SHARED, "pcie-sys", port);
>> +	if (err) {
>> +		dev_err(dev, "failed to request pcie subsystem irq\n");
>> +		return err;
>> +	}
>> +
>> +	port->irq = platform_get_irq_byname(pdev, "pcie-legacy");
>> +	if (port->irq < 0) {
>> +		dev_err(dev, "missing pcie_legacy IRQ resource\n");
>> +		return -EINVAL;
>> +	}
>> +	err = devm_request_irq(dev, port->irq,
>> +			       rockchip_pcie_legacy_int_handler,
>> +			       IRQF_SHARED,
>> +			       "pcie-legacy",
>> +			       port);
>> +	if (err) {
>> +		dev_err(&pdev->dev, "failed to request pcie-legacy irq\n");
>> +		return err;
>> +	}
>> +
>> +	irq = platform_get_irq_byname(pdev, "pcie-client");
>> +	if (irq < 0) {
>> +		dev_err(dev, "missing pcie-client IRQ resource\n");
>> +		return -EINVAL;
>> +	}
>> +	err = devm_request_irq(dev, irq, rockchip_pcie_client_irq_handler,
>> +			       IRQF_SHARED, "pcie-client", port);
>> +	if (err) {
>> +		dev_err(dev, "failed to request pcie client irq\n");
>> +		return err;
>> +	}
>> +
>
> All of the above interrupt number details are being obtained from device tree, why not move above API's to rockchip_pcie_parse_dt.

Ok, I will move these above into parse_dt function.

>
>> +	port->dev = dev;
>> +	err = rockchip_pcie_parse_dt(port);
>> +	if (err) {
>> +		dev_err(dev, "Parsing DT failed\n");
>> +		return err;
>> +	}
>> +
>> +	pcie_write(port, 0x6040000, PCIE_RC_CONFIG_BASE + 0x8);
>> +	pcie_write(port, 0x0, PCIE_CORE_CTRL_MGMT_BASE + 0x300);
>> +
>> +	pcie_write(port, (RC_REGION_0_ADDR_TRANS_L +
>> RC_REGION_0_PASS_BITS),
>> +		   PCIE_CORE_AXI_CONF_BASE);
>> +	pcie_write(port, RC_REGION_0_ADDR_TRANS_H,
>> +		   PCIE_CORE_AXI_CONF_BASE + 0x4);
>> +	pcie_write(port, 0x0080000a, PCIE_CORE_AXI_CONF_BASE + 0x8);
>> +	pcie_write(port, 0x00000000, PCIE_CORE_AXI_CONF_BASE + 0xc);
>
> Why not move the above steps to rockchip_pcie_init_port function ?
> Please use macros instead of using values.

okay, will improve them.

Thanks for comment.

>
>
>


-- 
Best Regards
Shawn Lin

