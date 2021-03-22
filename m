Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C2EC433C1
	for <linux-pci@archiver.kernel.org>; Mon, 22 Mar 2021 14:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 138726197F
	for <linux-pci@archiver.kernel.org>; Mon, 22 Mar 2021 14:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhCVOYM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 22 Mar 2021 10:24:12 -0400
Received: from foss.arm.com ([217.140.110.172]:32842 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229822AbhCVOYL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Mar 2021 10:24:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F2051042;
        Mon, 22 Mar 2021 07:24:11 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.55.31])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 72E0F3F719;
        Mon, 22 Mar 2021 07:24:09 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Daire McNamara <daire.mcnamara@microchip.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        'Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH -next] PCI: microchip: Make some symbols static
Date:   Mon, 22 Mar 2021 14:24:03 +0000
Message-Id: <161642302807.9419.2910747814005134018.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210308094842.3588847-1-weiyongjun1@huawei.com>
References: <20210308094842.3588847-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 8 Mar 2021 09:48:42 +0000, 'Wei Yongjun wrote:
> The sparse tool complains as follows:
> 
> drivers/pci/controller/pcie-microchip-host.c:304:18: warning:
>  symbol 'pcie_event_to_event' was not declared. Should it be static?
> drivers/pci/controller/pcie-microchip-host.c:310:18: warning:
>  symbol 'sec_error_to_event' was not declared. Should it be static?
> drivers/pci/controller/pcie-microchip-host.c:317:18: warning:
>  symbol 'ded_error_to_event' was not declared. Should it be static?
> drivers/pci/controller/pcie-microchip-host.c:324:18: warning:
>  symbol 'local_status_to_event' was not declared. Should it be static?
> 
> [...]

Applied to pci/microchip, thanks!

[1/1] PCI: microchip: Make some symbols static
      https://git.kernel.org/lpieralisi/pci/c/2c61f32124

Thanks,
Lorenzo
