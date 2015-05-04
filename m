Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <55478F1A.3000401@mm-sol.com>
Date: Mon, 04 May 2015 18:24:10 +0300
From: Stanimir Varbanov <svarbanov@mm-sol.com>
MIME-Version: 1.0
To: Kishon Vijay Abraham I <kishon@ti.com>
CC: Rob Herring <robh+dt@kernel.org>,
	Kumar Gala <galak@codeaurora.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Grant Likely <grant.likely@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	Mathieu Olivari <mathieu@codeaurora.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 2/5] phy: qcom: Add Qualcomm PCIe PHY
References: <1430743338-10441-1-git-send-email-svarbanov@mm-sol.com> <1430743338-10441-3-git-send-email-svarbanov@mm-sol.com> <554783CD.50708@ti.com>
In-Reply-To: <554783CD.50708@ti.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/04/2015 05:35 PM, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Monday 04 May 2015 06:12 PM, Stanimir Varbanov wrote:
>> Add a PCIe PHY driver used by PCIe host controller driver
>> on Qualcomm SoCs like Snapdragon 805.
>>
>> Signed-off-by: Stanimir Varbanov <svarbanov@mm-sol.com>
>> ---
>>   drivers/phy/Kconfig         |    9 ++
>>   drivers/phy/Makefile        |    1 +
>>   drivers/phy/phy-qcom-pcie.c |  291
>> +++++++++++++++++++++++++++++++++++++++++++
> 
> Why do you need a new PHY driver for this? Why not use the existing QCOM
> PHY driver. I can see the registers used here in phy-qcom-ufs-qmp-14nm.h?

I agree that on first glance there are similarities, but I'm not sure
does the PHYs are the same IP blocks. Or at least they are different
revisions which have too many differences. So trying to combine them
will lead to more code than now.

Either way I will try to understand how many the differences are.

-- 
regards,
Stan
