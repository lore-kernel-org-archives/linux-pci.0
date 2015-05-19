Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 19 May 2015 17:41:43 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Stanimir Varbanov <svarbanov@mm-sol.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
	Rob Herring <robh+dt@kernel.org>,
	Kumar Gala <galak@codeaurora.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Grant Likely <grant.likely@linaro.org>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	Mathieu Olivari <mathieu@codeaurora.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 2/5] phy: qcom: Add Qualcomm PCIe PHY
Message-ID: <20150519224143.GS31666@google.com>
References: <1430743338-10441-1-git-send-email-svarbanov@mm-sol.com>
 <1430743338-10441-3-git-send-email-svarbanov@mm-sol.com>
 <554783CD.50708@ti.com>
 <55478F1A.3000401@mm-sol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55478F1A.3000401@mm-sol.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 04, 2015 at 06:24:10PM +0300, Stanimir Varbanov wrote:
> On 05/04/2015 05:35 PM, Kishon Vijay Abraham I wrote:
> > Hi,
> > 
> > On Monday 04 May 2015 06:12 PM, Stanimir Varbanov wrote:
> >> Add a PCIe PHY driver used by PCIe host controller driver
> >> on Qualcomm SoCs like Snapdragon 805.
> >>
> >> Signed-off-by: Stanimir Varbanov <svarbanov@mm-sol.com>
> >> ---
> >>   drivers/phy/Kconfig         |    9 ++
> >>   drivers/phy/Makefile        |    1 +
> >>   drivers/phy/phy-qcom-pcie.c |  291
> >> +++++++++++++++++++++++++++++++++++++++++++
> > 
> > Why do you need a new PHY driver for this? Why not use the existing QCOM
> > PHY driver. I can see the registers used here in phy-qcom-ufs-qmp-14nm.h?
> 
> I agree that on first glance there are similarities, but I'm not sure
> does the PHYs are the same IP blocks. Or at least they are different
> revisions which have too many differences. So trying to combine them
> will lead to more code than now.
> 
> Either way I will try to understand how many the differences are.

Ping, where are we with this?  Should I wait for something else, or are you
convinced there's enough difference to warrant a new PHY driver, Kishon?

Bjorn
