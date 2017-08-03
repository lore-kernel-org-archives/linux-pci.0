Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:38141 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751884AbdHCXi7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2017 19:38:59 -0400
Date: Thu, 3 Aug 2017 18:38:56 -0500
From: Rob Herring <robh@kernel.org>
To: Varadarajan Narayanan <varada@codeaurora.org>
Cc: bhelgaas@google.com, mark.rutland@arm.com, svarbanov@mm-sol.com,
        kishon@ti.com, sboyd@codeaurora.org, vivek.gautam@codeaurora.org,
        fengguang.wu@intel.com, weiyongjun1@huawei.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v6 2/7] dt-bindings: phy: qmp: Add support for QMP phy in
 IPQ8074
Message-ID: <20170803233856.zpjuhdbzfafhdtmr@rob-hp-laptop>
References: <1501482857-14100-1-git-send-email-varada@codeaurora.org>
 <1501482857-14100-3-git-send-email-varada@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1501482857-14100-3-git-send-email-varada@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 31, 2017 at 12:04:12PM +0530, Varadarajan Narayanan wrote:
> IPQ8074 uses QMP phy controller that provides support to PCIe and
> USB. Adding dt binding information for the same.
> 
> Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
