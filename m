Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Bjorn Andersson <bjorn@kryo.se>
Subject: Re: [PATCH v5 3/5] PCI: qcom: Add Qualcomm PCIe controller driver
Date: Tue, 22 Dec 2015 00:04:22 +0100
Cc: kbuild test robot <lkp@intel.com>,
	Stanimir Varbanov <stanimir.varbanov@linaro.org>,
	kbuild-all@01.org, "linux-arm-msm" <linux-arm-msm@vger.kernel.org>,
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
	Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Bjorn Andersson <bjorn.andersson@sonymobile.com>,
	Stanimir Varbanov <svarbanov@mm-sol.com>
References: <1450442339-18765-4-git-send-email-stanimir.varbanov@linaro.org> <201512182111.1GLn2hxy%fengguang.wu@intel.com> <CAJAp7Ohgr7j7i=73R6Y_+GDa_4QZnhuPgB7AFdJGxNVJ_cVFsA@mail.gmail.com>
In-Reply-To: <CAJAp7Ohgr7j7i=73R6Y_+GDa_4QZnhuPgB7AFdJGxNVJ_cVFsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201512220004.22548.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday 21 December 2015, Bjorn Andersson wrote:
> I disagree with this "recommendation" as it's only outcome will be asymmetry.
> 
> I think this script should be changed to only warn if there's a single
> IS_ERR/PTR_ERR at the end of the function, not if there's a list of
> them and this would replace the last one.
> 

Agreed, looks like a false positive, and I think it's best to ignore the
warning here, but not change the script that seems reasonable in general.

	Arnd
