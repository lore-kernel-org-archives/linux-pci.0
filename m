Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34362 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751804AbdHCXjr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2017 19:39:47 -0400
Date: Thu, 3 Aug 2017 18:39:45 -0500
From: Rob Herring <robh@kernel.org>
To: Varadarajan Narayanan <varada@codeaurora.org>
Cc: bhelgaas@google.com, mark.rutland@arm.com, svarbanov@mm-sol.com,
        kishon@ti.com, sboyd@codeaurora.org, vivek.gautam@codeaurora.org,
        fengguang.wu@intel.com, weiyongjun1@huawei.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v6 6/7] dt-bindings: pci: qcom: Add support for IPQ8074
Message-ID: <20170803233945.dsgtxv3omx2uyhsf@rob-hp-laptop>
References: <1501482857-14100-1-git-send-email-varada@codeaurora.org>
 <1501482857-14100-7-git-send-email-varada@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1501482857-14100-7-git-send-email-varada@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 31, 2017 at 12:04:16PM +0530, Varadarajan Narayanan wrote:
> Add support for the IPQ8074 PCIe controller.  IPQ8074 supports Gen 1/2, one
> lane, two PCIe root complex with support for MSI and legacy interrupts, and
> it conforms to PCI Express Base 2.1 specification.
> 
> Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie.txt          | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
