Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18AA3C433EF
	for <linux-pci@archiver.kernel.org>; Wed, 29 Jun 2022 09:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbiF2JeC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 29 Jun 2022 05:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbiF2JeB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 05:34:01 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7933B00B;
        Wed, 29 Jun 2022 02:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656495240; x=1688031240;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=P4AGhikg620X38VfSmRxFDdGgI2V4TsuWo+pgD/SRbs=;
  b=C5IADQ+lIoOmhUI85w/Xmi7gXKonghtApt37qcqd84svCex5pZQEzzAY
   6zqhjG1Vnn3BkIWc08KiUwIM1pWOZLakTNdoEWlrXou22QR0I4wGvScLa
   khv/nWJRtPNxXvxxaNZUqoPhgkR0mAHurQ7U6fuiokNnNJi2XInKFRf7u
   Q=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 29 Jun 2022 02:34:00 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 29 Jun 2022 02:33:58 -0700
X-QCInternal: smtphost
Received: from hu-krichai-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.110.37])
  by ironmsg01-blr.qualcomm.com with ESMTP; 29 Jun 2022 15:03:39 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 628F5421D; Wed, 29 Jun 2022 15:03:39 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_hemantk@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        manivannan.sadhasivam@linaro.org, swboyd@chromium.org,
        dmitry.baryshkov@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: [PATCH v2 0/2] PCI: Restrict pci transactions after pci suspend
Date:   Wed, 29 Jun 2022 15:03:32 +0530
Message-Id: <1656495214-4028-1-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1656055682-18817-1-git-send-email-quic_krichai@quicinc.com>
References: <1656055682-18817-1-git-send-email-quic_krichai@quicinc.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If the endpoint device state is D0 and irq's are not freed, then
kernel try to mask interrupts by writing in to the vector
table (for MSIX interrupts) and config space (for MSI's).

These transactions are initiated after clocks are getting disabled
as part of PM suspend call. Due to it, these transactions are
resulting in un-clocked access and eventual to crashes.

So added a logic in qcom driver to restrict the unclocked access.
And updated the logic to check the link state before masking
or unmasking the interrupts.

Krishna chaitanya chundru (2):
  PCI: qcom: Add system PM support
  PCI: qcom: Restrict pci transactions after pci suspend

 drivers/pci/controller/dwc/pcie-designware-host.c |  14 ++-
 drivers/pci/controller/dwc/pcie-qcom.c            | 116 +++++++++++++++++++++-
 2 files changed, 126 insertions(+), 4 deletions(-)

-- 
2.7.4

