Return-Path: <SRS0=uLpe=T5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1994C072B1
	for <linux-pci@archiver.kernel.org>; Wed, 29 May 2019 00:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF2B521734
	for <linux-pci@archiver.kernel.org>; Wed, 29 May 2019 00:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z419y0UT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbfE2A5O (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 28 May 2019 20:57:14 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45688 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfE2A5O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 May 2019 20:57:14 -0400
Received: by mail-pg1-f194.google.com with SMTP id w34so238021pga.12
        for <linux-pci@vger.kernel.org>; Tue, 28 May 2019 17:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=TIHClBNyag0L2IIjZvas+5fQgJZRiADZDrSo9Rpuzjc=;
        b=Z419y0UTgNOS3NEzaVGmRcSalqcIzAw4v7OzgeIYLJ1qRRRkzTHKbf8p9WY0SqV0iw
         IQCe5SoI7tjyP5OLAZyXum67oUmCHRZB4iCQMb20Z9ms1cxcTW3eR+7HNIXlCvMswreX
         lOdDpV1reb1XscQB2tzUFWV1N7NruUYVmLrF6HruSFERybcLi/6GgYdNaD1G/iS7oHX9
         mCCBkZuk+qOQlhoYsFIw+CFTIOipyEa1Vn0fMo4MZCfsUS5oXl6XUQBm22Ba2iZerkOb
         Xa2jDPQz+QjpFSAWmGS4bSriD2O8iEE8/8PJMt9In1B/NBwKhPWE/2SbM7/SfKI9siSn
         m6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TIHClBNyag0L2IIjZvas+5fQgJZRiADZDrSo9Rpuzjc=;
        b=QpwD7BOWI/PgaPePfDb3SEEM4OuiRgQMnSyfA08YyinI/ddmauR1PzlhftpXRQzk8s
         xSidQr7lBCzeI36kveDn/4CVAKRJTBi/0qFY5ENu6+Hh2MtS53PBVpWTKwjzUdWg4Scm
         dcRdUOaNYDREtZhkgZPUM78yyWe7WuZrw1yoSeTbhuCocwLwId+qQQjfApEQgo+mUXzk
         d51MeQJ4ue7IpQrYqoJnWMXBIabVE/oSx1mq+Z8wzGZFalOx2ZrDqR5UFqKYzCBcl1S1
         tN0a4Su/F76YDeR4MhnXc1SvFqn0qrTGPIY2AL5C3PdbHnXYMwBwTxokotyYd1Ea0oXa
         PTUw==
X-Gm-Message-State: APjAAAVWezvlkeJh5WXQ/HqTpAFI2nXvDX6O5/gYm4a+NquPDTp/jPSL
        urITCda45cuJxT+fNehR+UX+Sg==
X-Google-Smtp-Source: APXvYqwc4b2O0tqTNNFfF3dXihl0d5z90Q+aDqiXaBem1Iou4jnX6XYanSFT9Sml6bgFd3DvPi1+oA==
X-Received: by 2002:a65:4c07:: with SMTP id u7mr131114656pgq.93.1559091433802;
        Tue, 28 May 2019 17:57:13 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id p16sm15434824pff.35.2019.05.28.17.57.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 17:57:13 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/3] Qualcomm QCS404 PCIe support
Date:   Tue, 28 May 2019 17:57:07 -0700
Message-Id: <20190529005710.23950-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series adds support for the PCIe controller in the Qualcomm QCS404
platform.

Bjorn Andersson (3):
  PCI: qcom: Use clk_bulk API for 2.4.0 controllers
  dt-bindings: PCI: qcom: Add QCS404 to the binding
  PCI: qcom: Add QCS404 PCIe controller support

 .../devicetree/bindings/pci/qcom,pcie.txt     |  25 +++-
 drivers/pci/controller/dwc/pcie-qcom.c        | 113 ++++++++----------
 2 files changed, 75 insertions(+), 63 deletions(-)

-- 
2.18.0

