Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <201512182111.1GLn2hxy%fengguang.wu@intel.com>
References: <1450442339-18765-4-git-send-email-stanimir.varbanov@linaro.org>
	<201512182111.1GLn2hxy%fengguang.wu@intel.com>
Date: Sun, 20 Dec 2015 15:10:49 -0800
Message-ID: <CAJAp7Ohgr7j7i=73R6Y_+GDa_4QZnhuPgB7AFdJGxNVJ_cVFsA@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] PCI: qcom: Add Qualcomm PCIe controller driver
From: Bjorn Andersson <bjorn@kryo.se>
To: kbuild test robot <lkp@intel.com>
Cc: Stanimir Varbanov <stanimir.varbanov@linaro.org>,
	kbuild-all@01.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
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
	Stanimir Varbanov <svarbanov@mm-sol.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 18, 2015 at 5:44 AM, kbuild test robot <lkp@intel.com> wrote:
> Hi Stanimir,
>
> [auto build test WARNING on next-20151218]
> [also build test WARNING on v4.4-rc5]
> [cannot apply to pci/next robh/for-next v4.4-rc5 v4.4-rc4 v4.4-rc3]
>
> url:    https://github.com/0day-ci/linux/commits/Stanimir-Varbanov/Qualcomm-PCIe-driver-and-designware-fixes/20151218-205427
>
>
> coccinelle warnings: (new ones prefixed by >>)
>
>>> drivers/pci/host/pcie-qcom.c:188:1-3: WARNING: PTR_ERR_OR_ZERO can be used
>    drivers/pci/host/pcie-qcom.c:220:1-3: WARNING: PTR_ERR_OR_ZERO can be used
>
> Please review and possibly fold the followup patch.
>

I disagree with this "recommendation" as it's only outcome will be asymmetry.

I think this script should be changed to only warn if there's a single
IS_ERR/PTR_ERR at the end of the function, not if there's a list of
them and this would replace the last one.

Regards,
Bjorn
