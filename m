Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v6 5/7] PCI: dwc: qcom: Use block IP version for
 operations
To: Varadarajan Narayanan <varada@codeaurora.org>, bhelgaas@google.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kishon@ti.com,
        sboyd@codeaurora.org, vivek.gautam@codeaurora.org,
        fengguang.wu@intel.com, weiyongjun1@huawei.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <1501482857-14100-1-git-send-email-varada@codeaurora.org>
 <1501482857-14100-6-git-send-email-varada@codeaurora.org>
From: Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <285396b4-cadb-6f4a-8cca-d781503b9d49@mm-sol.com>
Date: Wed, 2 Aug 2017 21:34:22 +0300
MIME-Version: 1.0
In-Reply-To: <1501482857-14100-6-git-send-email-varada@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On 31.07.2017 09:34, Varadarajan Narayanan wrote:
> Presently, when support for a new SoC is added, the driver ops
> structures and functions are versioned with plain 1, 2, 3 etc.
> Instead use the block IP version number.
> 
> Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
> ---
>   drivers/pci/dwc/pcie-qcom.c | 133 +++++++++++++++++++++++---------------------
>   1 file changed, 71 insertions(+), 62 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pcie-qcom.c b/drivers/pci/dwc/pcie-qcom.c

<cut>

> +/*
> + * Declare one of_device_id entry
> + * c - Compatible string
> + * d - Associated data
> + * w - SoC wrapper version (ignored)
> + * s - Synopsys core version (ignored)
> + */
> +#define QCOM_DECL(c, d, w, s) { .compatible = c, .data = &d }

Please don't introduce this macro, just add a comment with qcom version 
and corresponding synopsys version.

regards,
Stan
