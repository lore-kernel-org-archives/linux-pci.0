Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v4 3/5] PCI: qcom: Add Qualcomm PCIe controller driver
To: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <1449149725-27607-1-git-send-email-stanimir.varbanov@linaro.org>
 <1449149725-27607-4-git-send-email-stanimir.varbanov@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Bjorn Andersson <bjorn.andersson@sonymobile.com>
From: Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <566FCE27.2050705@mm-sol.com>
Date: Tue, 15 Dec 2015 10:24:07 +0200
MIME-Version: 1.0
In-Reply-To: <1449149725-27607-4-git-send-email-stanimir.varbanov@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/03/2015 03:35 PM, Stanimir Varbanov wrote:
> From: Stanimir Varbanov <svarbanov@mm-sol.com>
> 
> The PCIe driver reuse the Designware common code for host
> and MSI initialization, and also program the Qualcomm
> application specific registers.
> 
> Signed-off-by: Stanimir Varbanov <svarbanov@mm-sol.com>
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  MAINTAINERS                  |    7 +
>  drivers/pci/host/Kconfig     |   10 +
>  drivers/pci/host/Makefile    |    1 +
>  drivers/pci/host/pcie-qcom.c |  624 ++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 642 insertions(+)
>  create mode 100644 drivers/pci/host/pcie-qcom.c

Hi Bjorn, any chance to get this merged in 4.5 ?


-- 
regards,
Stan
