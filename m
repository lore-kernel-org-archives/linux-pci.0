Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA723C43334
	for <linux-pci@archiver.kernel.org>; Wed, 29 Jun 2022 14:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbiF2Omu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 29 Jun 2022 10:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232873AbiF2Omt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 10:42:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1576839148;
        Wed, 29 Jun 2022 07:42:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A056661F1F;
        Wed, 29 Jun 2022 14:42:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 019EAC341C8;
        Wed, 29 Jun 2022 14:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656513768;
        bh=PsvsAFLo4acqW6iOMnciGMRanznvLepywsZhB5eq3i4=;
        h=From:To:Cc:Subject:Date:From;
        b=e5tLIlcy04h6SG1pog8HsuRRLl2eXSxQ027Zo2g7ekO1DOgM9N2KIqM/6WBR2PAbP
         J9G5UlZ6SHQoFG8WxoQY+Z626iJRNuR0/c4IoCnHehRL69EQl5FRq9ANHnKLeBrJjt
         yokpg78uLAnOyOCCONBPlptgTdDFxW1SXZ81pjaHooRhS50xbl9Ic3VOXj4D76cnRh
         nbTw3c0g3RQuz7jaN56Z03bkCzY5IOJB4mGc9E+SX48FNRCc/g3hnU29fNQJUQ5eOv
         DcpZ4l+ZEOuzo08hoh3Ye5/K0BVifgBvwgCh4Mirm5xEPAqJ4V8E9OiM4XefZOSu4+
         0nZvMoZO+ldww==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o6Ytz-00058T-KO; Wed, 29 Jun 2022 16:42:47 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 0/2] PCI: qcom: Drop unused post_deinit callback
Date:   Wed, 29 Jun 2022 16:41:22 +0200
Message-Id: <20220629144124.19693-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series drops the badly named post_deinit callback which is unused
after merging the PIPE clock series:

	https://lore.kernel.org/all/20220608105238.2973600-1-dmitry.baryshkov@linaro.org/

Included is also a related error-label cleanup.

It seems the above series will need to be rebased on the recently posted
DBI fixes, and then these can go on top.

Note that these patches also depend on the patch adding support for
modular builds which should be ready to be merged:

	https://lore.kernel.org/all/20220519094646.23009-1-johan+linaro@kernel.org/

Johan


Changes in v2
 - keep the post_init() callback which is being repurposed for DBI
   accesses

Johan Hovold (2):
  PCI: qcom: Drop unused post_deinit callback
  PCI: qcom: Rename host-init error label

 drivers/pci/controller/dwc/pcie-qcom.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

-- 
2.35.1

