Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFE0C4332F
	for <linux-pci@archiver.kernel.org>; Thu, 10 Nov 2022 21:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiKJVRq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 10 Nov 2022 16:17:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiKJVRp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2022 16:17:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347B0B860
        for <linux-pci@vger.kernel.org>; Thu, 10 Nov 2022 13:17:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2EB03B823A0
        for <linux-pci@vger.kernel.org>; Thu, 10 Nov 2022 21:17:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96CABC433D6;
        Thu, 10 Nov 2022 21:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668115060;
        bh=ewK+IMHN6pyJJWCbPRVC2x/7JztPQnx3kDR/GxOzwhA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e1z+moiQX9sK8rd49TQlrPqExZIF1imaoyHb15xlNfkXwpnHRa2Qppfz4cFIZwkIK
         YUjUkeJwEPGZFf8Es+uKtwMlaqlFMI9W1msVJ1r69Ln47dk44pBbdiMCdgFOpEG8zJ
         NIRtXfWJXrfeOrcRrlAYsHIJL5PaI1AgENWjr3nqjhKgGYggwG3ddIU/TF0YlDPZfx
         Jt8S5ahk/UAQKfQNX/mOVvwVEM/oTnpMbx7dJJbJpBLGuj9mspK4vMKmBOrkuin7xW
         oYaThm0NnwN/xAcclPQAv9GbU9RVxMjVIMKruy33x2akSzOjO9q+EpgwHEMtGY0UE4
         STyJQJoBXnMdA==
Received: by pali.im (Postfix)
        id BDDA2856; Thu, 10 Nov 2022 22:17:37 +0100 (CET)
Date:   Thu, 10 Nov 2022 22:17:37 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Jonathan Derrick <jonathan.derrick@linux.dev>
Cc:     Vidya Sagar <vidyas@nvidia.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v2 0/7] PCIe Hotplug Slot Emulation driver
Message-ID: <20221110211737.nsalcmwgsjl5zeva@pali>
References: <20221110195015.207-1-jonathan.derrick@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110195015.207-1-jonathan.derrick@linux.dev>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 10 November 2022 12:50:08 Jonathan Derrick wrote:
> The main intent of posting v2 is to help Vidya further along with his
> GPIO-based hotplug driver. I have no direct need for a DLLSC-based emulated
> mode, and I'm not certain the model is appropriate. The GPIO-based model could
> modify some of the logic in patch 6 to check for GPIO instead of DLLSC.

This approach for GPIO-based model introduce also a new hotplug driver
HOTPLUG_PCI_PCIE_EMUL. But if you implement all callbacks of the
pci-bridge-emul.c for standard PCIe hotplug capability then you do not
need this new HOTPLUG_PCI_PCIE_EMUL at all. Existing HOTPLUG_PCI_PCIE
driver would work without any issue. I have already implemented DLLSC
basics for pci-mvebu.c and pci-aardvark.c controller drivers, patches
are on the mailing list. I can help implementing it in other PCIe
controller driver.
