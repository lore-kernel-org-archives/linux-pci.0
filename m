Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37257 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964803AbbLQNSr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 17 Dec 2015 08:18:47 -0500
Received: by mail-wm0-f41.google.com with SMTP id p187so21052095wmp.0
        for <linux-pci@vger.kernel.org>; Thu, 17 Dec 2015 05:18:47 -0800 (PST)
Subject: Re: [PATCH v4 3/5] PCI: qcom: Add Qualcomm PCIe controller driver
To: Bjorn Helgaas <helgaas@kernel.org>,
	Stanimir Varbanov <stanimir.varbanov@linaro.org>
References: <1449149725-27607-1-git-send-email-stanimir.varbanov@linaro.org>
 <1449149725-27607-4-git-send-email-stanimir.varbanov@linaro.org>
 <20151216215304.GB27791@localhost>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Bjorn Andersson <bjorn.andersson@sonymobile.com>
From: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <5672B633.6030503@linaro.org>
Date: Thu, 17 Dec 2015 15:18:43 +0200
MIME-Version: 1.0
In-Reply-To: <20151216215304.GB27791@localhost>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn, thanks for the comments!

On 12/16/2015 11:53 PM, Bjorn Helgaas wrote:
> On Thu, Dec 03, 2015 at 03:35:22PM +0200, Stanimir Varbanov wrote:
>> From: Stanimir Varbanov <svarbanov@mm-sol.com>
>>
>> The PCIe driver reuse the Designware common code for host
>> and MSI initialization, and also program the Qualcomm
>> application specific registers.
>>
>> Signed-off-by: Stanimir Varbanov <svarbanov@mm-sol.com>
>> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
>> ---
>>  MAINTAINERS                  |    7 +
>>  drivers/pci/host/Kconfig     |   10 +
>>  drivers/pci/host/Makefile    |    1 +
>>  drivers/pci/host/pcie-qcom.c |  624 ++++++++++++++++++++++++++++++++++++++++++
> 
>> +#define PCIE20_CAP				0x70
>> +#define PCIE20_CAP_LINKCTRLSTATUS		(PCIE20_CAP + 0x10)
>> +#define PCIE20_CAP_LINKCTRLSTATUS_LINK_UP	BIT(29)
> 
> This looks like it could be referring to a standard PCIe Capability;
> could you use the existing PCI_EXP_LNKSTA and PCI_EXP_LNKSTA_DLLLA
> symbols here?  And readw() instead of readl()?

Yes, that is possible but I still need to keep PCIE20_CAP capabilities
offset.

> 
>> +static int qcom_pcie_enable_link_training(struct qcom_pcie *pcie)
>> +{
>> +	struct device *dev = pcie->dev;
>> +	u32 val;
>> +	int ret;
>> +
>> +	/* enable link training */
>> +	val = readl(pcie->elbi + PCIE20_ELBI_SYS_CTRL);
>> +	val |= PCIE20_ELBI_SYS_CTRL_LT_ENABLE;
>> +	writel(val, pcie->elbi + PCIE20_ELBI_SYS_CTRL);
>> +
>> +	/* wait for up to 100ms for the link to come up */
>> +	ret = readl_poll_timeout(pcie->elbi + PCIE20_ELBI_SYS_STTS, val,
>> +				 val & XMLH_LINK_UP, LINKUP_DELAY_US,
>> +				 LINKUP_TIMEOUT_US);
>> +
>> +	if (ret < 0 || !dw_pcie_link_up(&pcie->pp)) {
>> +		dev_err(dev, "link initialization failed\n");
>> +		return -ETIMEDOUT;
>> +	}
>> +
>> +	return 0;
>> +}
> 
> This looks a lot like the *_establish_link() functions in other
> DesignWare-based drivers.  Can you make it look even more similar,
> e.g., by renaming it to qcom_pcie_establish_link() and maybe moving
> some of the PHY functionality here?
> 
> readl_poll_timeout() is nice and avoids the hand-coded timeout loop
> the other drivers use.  But is there benefit in checking for
> XMLH_LINK_UP, or could you simply poll dw_pcie_link_up() like the
> others do?  If it's sufficient, I'd prefer using dw_pcie_link_up()
> by itself because it's a little more generic.

OK I will modify the code to use dw_pcie_link_up() and ensure that this
check is sufficient.

-- 
regards,
Stan
