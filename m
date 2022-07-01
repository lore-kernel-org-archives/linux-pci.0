Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72C6CCA485
	for <linux-pci@archiver.kernel.org>; Fri,  1 Jul 2022 14:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbiGAON5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 1 Jul 2022 10:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbiGAONz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Jul 2022 10:13:55 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CBE38DAD;
        Fri,  1 Jul 2022 07:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656684835; x=1688220835;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=fBOzsvR5JRD3AwA365AJxC5GtJB0Gphjxcl+Ez06QxM=;
  b=NGWAL3MW8YlsjLwxtyruxAMGRCvW0QZi6VF5n8Uo2mKmbskWuQki9az+
   RWH8NW4yh8UdoUeyfXnbwF+MA+k+jdLwCOtP04TVYcCqSfCa/FdFtv5/9
   GgC9npFNHtfKenJbOhWgqkEcLYu3lPD9HfzlB3uirXLQ+c6LMo+8CsR0a
   A=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 01 Jul 2022 07:13:55 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 01 Jul 2022 07:13:53 -0700
X-QCInternal: smtphost
Received: from hu-krichai-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.110.37])
  by ironmsg02-blr.qualcomm.com with ESMTP; 01 Jul 2022 19:43:31 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 720BE424D; Fri,  1 Jul 2022 19:43:30 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        quic_vbadigan@quicinc.com, quic_hemantk@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, manivannan.sadhasivam@linaro.org,
        swboyd@chromium.org, dmitry.baryshkov@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: [PATCH v3 0/2] PCI: Restrict pci transactions after pci suspend
Date:   Fri,  1 Jul 2022 19:43:17 +0530
Message-Id: <1656684800-31278-1-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1656495214-4028-1-git-send-email-quic_krichai@quicinc.com>
References: <1656495214-4028-1-git-send-email-quic_krichai@quicinc.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If the endpoint device state is D0 and irq's are not freed, then
kernel try to mask interrupts in system suspend path by writing
in to the vector table (for MSIX interrupts) and config space (for MSI's).

These transactions are initiated in the pm suspend after pcie clocks got
disabled as part of platform driver pm  suspend call. Due to it, these
transactions are resulting in un-clocked access and eventually to crashes.

So added a logic in qcom driver to restrict these unclocked access.
And updated the logic to check the link state before masking
or unmasking the interrupts.

Krishna chaitanya chundru (2):
  PCI: qcom: Add system PM support
  PCI: qcom: Restrict pci transactions after pci suspend

 drivers/pci/controller/dwc/pcie-designware-host.c |  14 ++-
 drivers/pci/controller/dwc/pcie-qcom.c            | 114 +++++++++++++++++++++-
 2 files changed, 124 insertions(+), 4 deletions(-)

-- 
2.7.4

