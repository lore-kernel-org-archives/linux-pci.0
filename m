Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FABC7EE26
	for <linux-pci@archiver.kernel.org>; Mon, 15 May 2023 05:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjEOFPL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 May 2023 01:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233762AbjEOFPE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 May 2023 01:15:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C6C1FDF
        for <linux-pci@vger.kernel.org>; Sun, 14 May 2023 22:15:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB19061ECE
        for <linux-pci@vger.kernel.org>; Mon, 15 May 2023 05:15:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7739FC433A7;
        Mon, 15 May 2023 05:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684127702;
        bh=iVcdjFERh5b0ycRPSffd3KxvUks7UmPDLWnMaGMnmE0=;
        h=From:To:Subject:Date:From;
        b=meD8rbFVpIdrFJKJ2M/dinF9rjCz0CIPNo+r7s6XOh5IA1Od6FhCEjxPSxDz2GHTr
         0bITZ1IMu9QGOpZU6ZEnwPp8aD9FHBTobtlwNo0qyq5miENejFfsV40kK7JFlyeNMV
         NIZISxg9kG9KX3twboby5y5II7Zddf8S2bLV/L2BKYjeN/Rq0A/bFMgimaM4l14NNc
         ml8Ta1EqoxKYyNr1SGKLeSILpAMUV16OCtpKjx/VMuKG9aVNZG2MJJJ8TZx33SDJw1
         U51BReTQxiwc5EPfgxN+Neb51eLVh/gogPbxwPjaePqPvEfGRTsO6rRKzYF39XnbWK
         cr6DbZCQGSZ2Q==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/2] Fixup changes to pci_epf_type_add_cfs()
Date:   Mon, 15 May 2023 14:14:58 +0900
Message-Id: <20230515051500.574127-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

A couple of patches to improve and document the changes to
pci_epf_type_add_cfs() done with patch
893f14fed7d3 ("PCI: endpoint: Move pci_epf_type_add_cfs() code").

Damien Le Moal (2):
  PCI: endpoint: Improve pci_epf_type_add_cfs()
  PCI: endpoint: Add kdoc description of pci_epf_type_add_cfs()

 drivers/pci/endpoint/pci-ep-cfs.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

-- 
2.40.1

