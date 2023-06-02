Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3649C7EE29
	for <linux-pci@archiver.kernel.org>; Fri,  2 Jun 2023 11:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234978AbjFBLtV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 2 Jun 2023 07:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235014AbjFBLtN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Jun 2023 07:49:13 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AC510D5
        for <linux-pci@vger.kernel.org>; Fri,  2 Jun 2023 04:48:42 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9745d99cfccso128575166b.1
        for <linux-pci@vger.kernel.org>; Fri, 02 Jun 2023 04:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685706521; x=1688298521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zjhhtMDiVxTVno+SPO1SHJkYSl5NdViRdJrBhSZBSq0=;
        b=D1n/ahAjHoJwmX1Pd+G0DOzH8PHh8fuZj+RlDGayhTmxtwTHa90OhfHxAfNOWrwmFA
         YBmrShea8Wc5NueobvdT5Gd3H3LoOTy3MPZf+tcOQ/zqfw/cRcbUv0OFKGzS1VCqTAPY
         osO6Sqj4WwFOHNhf4mTDuGNdUlStL43Ta0c6lel1IOoBuVjM5NOmjqeTSgWALErCEAu6
         mnkoyuZSYcRsEKhg/cjW1twH/CJze1HlNAo96GHbtQvUjO1K8RIWv7UfAnIiqXbOZbq9
         ETqSFttf24CcT+GqrmYPtc8CPv0SXnjhQ7kCdewQqSJ2QHozViMBIrE0hkjuFD7N+06M
         7s6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685706521; x=1688298521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zjhhtMDiVxTVno+SPO1SHJkYSl5NdViRdJrBhSZBSq0=;
        b=dRvlYBTUqGq0EJmd5vgZWWc/zliUW3JKnnspba4OUp0x6/AOF3sS0fBsCvL5nVvj4Z
         jbwzDPRvuqCByxgiM4rgAiZ1+GMFswC9bDWlGXTcqk1JEeDZyvRxrUlfSD5kgBGQb5sH
         DwcZWe5/nffGSelKhzR6Za1f1Z3X7Et6/fKke5BE5T96KMAT3HKVGOcYgFQMqo1pkDJb
         xfGSGUvw/p/HM9ZN1Baf/YJP/A07+SUkmXDxEfHbDbEfDEDxW4ldn6NX4lPqMIkofjZS
         Tp5iRR4iBlMEvalVnrKc4nZUehJ0JCk48jya5L0IZ/tkUEYytrDpNgOHkb7UqCiLFIKx
         mjsg==
X-Gm-Message-State: AC+VfDw0MbICGcBWOPTlHm0SQkA2V1J4fCGk1BpJLmuA3Bh7Eia1D0tz
        Wxp8iaJoAVWr4I3RcaKBpxSQ
X-Google-Smtp-Source: ACHHUZ4FH+Poh79HPfqj3RwtHxqHDNDnhHxHGHZkuRDhzM9YGJ0QeJyjLnAVcUfFGHl2vbdOaKfpuw==
X-Received: by 2002:a17:907:748:b0:94e:116:8581 with SMTP id xc8-20020a170907074800b0094e01168581mr11513927ejb.5.1685706521632;
        Fri, 02 Jun 2023 04:48:41 -0700 (PDT)
Received: from localhost.localdomain ([117.217.186.79])
        by smtp.gmail.com with ESMTPSA id qu25-20020a170907111900b00974530bb44dsm658924ejb.183.2023.06.02.04.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 04:48:41 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dlemoal@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v6 6/9] PCI: qcom-ep: Add support for Link down notification
Date:   Fri,  2 Jun 2023 17:17:53 +0530
Message-Id: <20230602114756.36586-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230602114756.36586-1-manivannan.sadhasivam@linaro.org>
References: <20230602114756.36586-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support to pass Link down notification to Endpoint function driver
so that the LINK_DOWN event can be processed by the function.

Reviewed-by: Kishon Vijay Abraham I <kishon@kernel.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 19b32839ea26..4ce01ff7527c 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -569,6 +569,7 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
 	if (FIELD_GET(PARF_INT_ALL_LINK_DOWN, status)) {
 		dev_dbg(dev, "Received Linkdown event\n");
 		pcie_ep->link_status = QCOM_PCIE_EP_LINK_DOWN;
+		pci_epc_linkdown(pci->ep.epc);
 	} else if (FIELD_GET(PARF_INT_ALL_BME, status)) {
 		dev_dbg(dev, "Received BME event. Link is enabled!\n");
 		pcie_ep->link_status = QCOM_PCIE_EP_LINK_ENABLED;
-- 
2.25.1

