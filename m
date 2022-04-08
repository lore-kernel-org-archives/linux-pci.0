Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C02C433EF
	for <linux-pci@archiver.kernel.org>; Fri,  8 Apr 2022 14:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236682AbiDHOdA (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 8 Apr 2022 10:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236915AbiDHOcz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Apr 2022 10:32:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E9E2D37CD02;
        Fri,  8 Apr 2022 07:30:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF470113E;
        Fri,  8 Apr 2022 07:30:51 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.11.200])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A5843F73B;
        Fri,  8 Apr 2022 07:30:48 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org,
        Chuanjia Liu <chuanjia.liu@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        linux-pci@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] PCI: mediatek: Fix refcount leak in mtk_pcie_subsys_powerup
Date:   Fri,  8 Apr 2022 15:30:48 +0100
Message-Id: <164942823614.23463.14514504733320823500.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220309091953.5630-1-linmq006@gmail.com>
References: <20220309091953.5630-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 9 Mar 2022 09:19:52 +0000, Miaoqian Lin wrote:
> The of_find_compatible_node() function returns a node pointer with
> refcount incremented, We should use of_node_put() on it when done
> Add the missing of_node_put() to release the refcount.
> 
> 

Applied to pci/mediatek, thanks!

[1/1] PCI: mediatek: Fix refcount leak in mtk_pcie_subsys_powerup
      https://git.kernel.org/lpieralisi/pci/c/214e0d8fe4

Thanks,
Lorenzo
