Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:45668 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752197AbcKNOE6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2016 09:04:58 -0500
MIME-Version: 1.0
In-Reply-To: <1479122155-13393-3-git-send-email-srinivas.kandagatla@linaro.org>
References: <1479122155-13393-1-git-send-email-srinivas.kandagatla@linaro.org> <1479122155-13393-3-git-send-email-srinivas.kandagatla@linaro.org>
From: Vivek Gautam <vivek.gautam@codeaurora.org>
Date: Mon, 14 Nov 2016 19:34:54 +0530
Message-ID: <CAFp+6iEJ4wPsLhY9-5mUqnMqTkcerQgJ=2qp4iKYkzvHO0_hgA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] PCI: qcom: add support to msm8996 PCIE controller
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: svarbanov@mm-sol.com, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        "robh+dt" <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 14, 2016 at 4:45 PM, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
> This patch adds support to msm8996/apq8096 pcie, MSM8996 supports
> Gen 1/2, One lane, 3 pcie root-complex with support to MSI and
> legacy interrupts and it conforms to PCI Express Base 2.1 specification.
>
> This patch adds post_init callback to qcom_pcie_ops, as this is pcie
> pipe clocks are only setup after the phy is powered on.
> It also adds ltssm_enable callback as it is very much different to other
> supported SOCs in the driver.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---

Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>


Thanks

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
