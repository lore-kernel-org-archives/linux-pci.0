Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:54668 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751586AbdHQIb1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Aug 2017 04:31:27 -0400
Date: Thu, 17 Aug 2017 14:01:17 +0530
From: Varadarajan Narayanan <varada@codeaurora.org>
To: Stanimir Varbanov <svarbanov@mm-sol.com>
Cc: bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        kishon@ti.com, sboyd@codeaurora.org, vivek.gautam@codeaurora.org,
        fengguang.wu@intel.com, weiyongjun1@huawei.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        smuthayy <smuthayy@codeaurora.org>
Subject: Re: [PATCH v6 7/7] PCI: dwc: qcom: Add support for IPQ8074 PCIe
 controller
Message-ID: <20170817083116.GA9649@codeaurora.org>
References: <1501482857-14100-1-git-send-email-varada@codeaurora.org>
 <1501482857-14100-8-git-send-email-varada@codeaurora.org>
 <710f8933-df3a-7666-f5c5-861dd9761dba@mm-sol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <710f8933-df3a-7666-f5c5-861dd9761dba@mm-sol.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Stanimir,

> Hi,
>
> Thanks for the patch.
>
> On 31.07.2017 09:34, Varadarajan Narayanan wrote:
> >Add support for the IPQ8074 PCIe controller.  IPQ8074 supports
> >Gen 1/2, one lane, two PCIe root complex with support for MSI and
> >legacy interrupts, and it conforms to PCI Express Base 2.1
> >specification.
> >
> >The core init is the similar to the existing SoC, however the
> >clocks and reset lines differ.
> >
> >Signed-off-by: smuthayy <smuthayy@codeaurora.org>
> >Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>

<snip>

> >+static int qcom_pcie_2_3_3_reset(struct qcom_pcie *pcie)
> >+{
> >+	struct qcom_pcie_resources_2_3_3 *res = &pcie->res.v2_3_3;
> >+	int i, ret;
> >+
> >+	for (i = 0; i < ARRAY_SIZE(res->rst); i++) {
> >+		ret = reset_control_assert(res->rst[i]);
> >+		if (ret) {
> >+			dev_err(pcie->pci->dev,
> >+				"%s: reset assert failed for %d\n",
> >+				__func__, i);
> >+			return ret;
> >+		}
> >+	}
> >+
> >+	msleep(20);
>
> Could you explain why we need to wait for 20ms.
>
> >+
> >+	for (i = 0; i < ARRAY_SIZE(res->rst); i++) {
> >+		ret = reset_control_deassert(res->rst[i]);
> >+		if (ret) {
> >+			dev_err(pcie->pci->dev,
> >+				"%s: reset deassert failed for %d\n",
> >+				__func__, i);
> >+			return ret;
> >+		}
> >+	}
> >+
> >+	msleep(20);
>
> Same comment as above.

<snip>

Sorry about the delay. I tried to contact the hardware folks
to get more clarity about these delays. However, I haven't
received any response from them till now. Unfortunately, the
PCIe link doesn't come up without these delays.

I was able to get the PCIe link with the above delays
reduced to 2ms. I have posted v7 of these patches addressing
your other comments and the above delays reduced to 2ms. Can
you please review and provide your feedback.

If everything else (other than these delays) is ok, can this
patch be accepted? Meanwhile, I will follow up with the
hardware folks and based on their response post a patch that
removes the delay or provides a proper explanation for these
delays.

Please let me know.

Thanks
Varada

--
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
