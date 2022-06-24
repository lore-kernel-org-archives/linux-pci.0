Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45ABEC433EF
	for <linux-pci@archiver.kernel.org>; Fri, 24 Jun 2022 09:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiFXJUM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 24 Jun 2022 05:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiFXJUM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jun 2022 05:20:12 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA3662C1F;
        Fri, 24 Jun 2022 02:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656062411; x=1687598411;
  h=from:to:cc:subject:date:message-id;
  bh=+at1ion0jmCaEHaPRNIPCsavul3diOXNgKtClF5ocZU=;
  b=Adi6wZZ7o9HuFKom+rjX/WWavS36ZGZonpPtVWmIIJJ1TIjLUi2y3zFA
   JHcVuG0gnZIXXYM+eG/bTAU/rWDtMbLf/WFwnr6qETA3QER28HyywcQkW
   4yBJc4+CiekM124XY8RRsKj3iCt5xZi8gczC/G5MDpVjO77CR/FSkXUvC
   0=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 24 Jun 2022 02:20:11 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 24 Jun 2022 02:20:09 -0700
X-QCInternal: smtphost
Received: from hu-krichai-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.110.37])
  by ironmsg01-blr.qualcomm.com with ESMTP; 24 Jun 2022 14:49:54 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 627803CDE; Fri, 24 Jun 2022 14:49:54 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_hemantk@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        manivannan.sadhasivam@linaro.org, swboyd@chromium.org,
        dmitry.baryshkov@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: [PATCH v1 0/3] PCI: qcom: sc7280: add missing clocks
Date:   Fri, 24 Jun 2022 14:49:48 +0530
Message-Id: <1656062391-14567-1-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add missing pcie clocks support.

Krishna chaitanya chundru (3):
  PCI: qcom: Add missing sc7280 clocks in PCIe driver
  dt-bindings: pci: QCOM sc7280 add missing clocks.
  arm64: dts: qcom: sc7280: Add missing pcie clocks

 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 2 ++
 arch/arm64/boot/dts/qcom/sc7280.dtsi                 | 4 ++++
 drivers/pci/controller/dwc/pcie-qcom.c               | 3 +++
 3 files changed, 9 insertions(+)

-- 
2.7.4

