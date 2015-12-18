Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 18 Dec 2015 21:44:15 +0800
From: kbuild test robot <lkp@intel.com>
To: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc: kbuild-all@01.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Russell King <linux@arm.linux.org.uk>,
	Rob Herring <robh+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Bjorn Andersson <bjorn.andersson@sonymobile.com>,
	Stanimir Varbanov <svarbanov@mm-sol.com>,
	Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: Re: [PATCH v5 3/5] PCI: qcom: Add Qualcomm PCIe controller driver
Message-ID: <201512182111.1GLn2hxy%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1450442339-18765-4-git-send-email-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Stanimir,

[auto build test WARNING on next-20151218]
[also build test WARNING on v4.4-rc5]
[cannot apply to pci/next robh/for-next v4.4-rc5 v4.4-rc4 v4.4-rc3]

url:    https://github.com/0day-ci/linux/commits/Stanimir-Varbanov/Qualcomm-PCIe-driver-and-designware-fixes/20151218-205427


coccinelle warnings: (new ones prefixed by >>)

>> drivers/pci/host/pcie-qcom.c:188:1-3: WARNING: PTR_ERR_OR_ZERO can be used
   drivers/pci/host/pcie-qcom.c:220:1-3: WARNING: PTR_ERR_OR_ZERO can be used

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
