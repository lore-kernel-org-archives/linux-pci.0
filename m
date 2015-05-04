Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41018 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751079AbbEDOg4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 4 May 2015 10:36:56 -0400
Message-ID: <554783CD.50708@ti.com>
Date: Mon, 4 May 2015 20:05:57 +0530
From: Kishon Vijay Abraham I <kishon@ti.com>
MIME-Version: 1.0
To: Stanimir Varbanov <svarbanov@mm-sol.com>,
	Rob Herring <robh+dt@kernel.org>,
	Kumar Gala <galak@codeaurora.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Grant Likely <grant.likely@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	Mathieu Olivari <mathieu@codeaurora.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 2/5] phy: qcom: Add Qualcomm PCIe PHY
References: <1430743338-10441-1-git-send-email-svarbanov@mm-sol.com> <1430743338-10441-3-git-send-email-svarbanov@mm-sol.com>
In-Reply-To: <1430743338-10441-3-git-send-email-svarbanov@mm-sol.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Monday 04 May 2015 06:12 PM, Stanimir Varbanov wrote:
> Add a PCIe PHY driver used by PCIe host controller driver
> on Qualcomm SoCs like Snapdragon 805.
>
> Signed-off-by: Stanimir Varbanov <svarbanov@mm-sol.com>
> ---
>   drivers/phy/Kconfig         |    9 ++
>   drivers/phy/Makefile        |    1 +
>   drivers/phy/phy-qcom-pcie.c |  291 +++++++++++++++++++++++++++++++++++++++++++

Why do you need a new PHY driver for this? Why not use the existing QCOM PHY 
driver. I can see the registers used here in phy-qcom-ufs-qmp-14nm.h?

Thanks
Kishon

