Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 17 Aug 2017 10:17:06 -0500
From: Rob Herring <robh@kernel.org>
To: Varadarajan Narayanan <varada@codeaurora.org>
Cc: bhelgaas@google.com, mark.rutland@arm.com, svarbanov@mm-sol.com,
        kishon@ti.com, sboyd@codeaurora.org, vivek.gautam@codeaurora.org,
        fengguang.wu@intel.com, weiyongjun1@huawei.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v8 2/3] dt-bindings: pci: qcom: Add support for IPQ8074
Message-ID: <20170817151706.zu7ol2bg3cdqxntc@rob-hp-laptop>
References: <1502968858-28090-1-git-send-email-varada@codeaurora.org>
 <1502968858-28090-3-git-send-email-varada@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1502968858-28090-3-git-send-email-varada@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 17, 2017 at 04:50:57PM +0530, Varadarajan Narayanan wrote:
> Add support for the IPQ8074 PCIe controller.  IPQ8074 supports Gen 1/2, one
> lane, two PCIe root complex with support for MSI and legacy interrupts, and
> it conforms to PCI Express Base 2.1 specification.
> 
> Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie.txt          | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)

I acked this already. Please add acks when posting new versions.

Acked-by: Rob Herring <robh@kernel.org>
