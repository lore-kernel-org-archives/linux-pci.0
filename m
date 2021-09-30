Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687C2C433F5
	for <linux-pci@archiver.kernel.org>; Thu, 30 Sep 2021 11:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A2576187A
	for <linux-pci@archiver.kernel.org>; Thu, 30 Sep 2021 11:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350298AbhI3LG4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 30 Sep 2021 07:06:56 -0400
Received: from foss.arm.com ([217.140.110.172]:52598 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350289AbhI3LG4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Sep 2021 07:06:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CE48106F;
        Thu, 30 Sep 2021 04:05:13 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.49.184])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 748B23F793;
        Thu, 30 Sep 2021 04:05:11 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: endpoint: Use sysfs_emit() in "show" functions
Date:   Thu, 30 Sep 2021 12:05:04 +0100
Message-Id: <163299989046.29725.1874130931282872320.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <1630472957-26857-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1630472957-26857-1-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 1 Sep 2021 14:09:17 +0900, Kunihiko Hayashi wrote:
> Convert sprintf() in sysfs "show" functions to sysfs_emit() in order to
> check for buffer overruns in sysfs outputs.
> 
> 

Applied to pci/endpoint, thanks!

[1/1] PCI: endpoint: Use sysfs_emit() in "show" functions
      https://git.kernel.org/lpieralisi/pci/c/a2258831d1

Thanks,
Lorenzo
