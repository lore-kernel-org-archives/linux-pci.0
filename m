Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1405C433DB
	for <linux-pci@archiver.kernel.org>; Mon, 29 Mar 2021 15:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9464D61964
	for <linux-pci@archiver.kernel.org>; Mon, 29 Mar 2021 15:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhC2PDo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 29 Mar 2021 11:03:44 -0400
Received: from foss.arm.com ([217.140.110.172]:54526 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229655AbhC2PDN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Mar 2021 11:03:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07590142F;
        Mon, 29 Mar 2021 08:03:13 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.51.224])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22AF73F694;
        Mon, 29 Mar 2021 08:03:12 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3] PCI: mediatek: Configure FC and FTS for functions other than 0
Date:   Mon, 29 Mar 2021 16:03:04 +0100
Message-Id: <161703017046.25709.10524533647443450444.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <c529dbfc066f4bda9b87edbdbf771f207e69b84e.1604510053.git.ryder.lee@mediatek.com>
References: <c529dbfc066f4bda9b87edbdbf771f207e69b84e.1604510053.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 5 Nov 2020 04:58:33 +0800, Ryder Lee wrote:
> PCI_FUNC(port->slot << 3)" is always 0, so previously
> mtk_pcie_startup_port() only configured FC credits and FTs for
> function 0.
> 
> Compute "func" correctly so we also configure functions other than
> 0. This affects MT2701 and MT7623.

Applied to pci/mediatek, thanks!

[1/1] PCI: mediatek: Configure FC and FTS for functions other than 0
      https://git.kernel.org/lpieralisi/pci/c/31ec9c2746

Thanks,
Lorenzo
