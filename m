Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:35302 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751325AbdGQUPL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jul 2017 16:15:11 -0400
Date: Mon, 17 Jul 2017 15:15:08 -0500
From: Rob Herring <robh@kernel.org>
To: Varadarajan Narayanan <varada@codeaurora.org>
Cc: bhelgaas@google.com, mark.rutland@arm.com, svarbanov@mm-sol.com,
        kishon@ti.com, sboyd@codeaurora.org, vivek.gautam@codeaurora.org,
        fengguang.wu@intel.com, weiyongjun1@huawei.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/7] dt-bindings: phy: qmp: Add output-clock-names
Message-ID: <20170717201508.2sng5aywcxsitisb@rob-hp-laptop>
References: <1500293043-1887-1-git-send-email-varada@codeaurora.org>
 <1500293043-1887-2-git-send-email-varada@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1500293043-1887-2-git-send-email-varada@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 17, 2017 at 05:33:57PM +0530, Varadarajan Narayanan wrote:
> The phy outputs a clock that will act as the parent for
> the phy's pipe clock. Add the name of this clock to the
> lane's DT node.
> 
> Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
