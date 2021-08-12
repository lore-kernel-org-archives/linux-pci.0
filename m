Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F24C432BE
	for <linux-pci@archiver.kernel.org>; Thu, 12 Aug 2021 11:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 220AF61058
	for <linux-pci@archiver.kernel.org>; Thu, 12 Aug 2021 11:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236646AbhHLLCp (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 12 Aug 2021 07:02:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:34064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235696AbhHLLCn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Aug 2021 07:02:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA9EA60EE2;
        Thu, 12 Aug 2021 11:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628766138;
        bh=+BsAMfqctJLMF9AnopT7K/xpTPc/l9B0E0fPKxuXqac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wzqfp7OMYik3b9zpVdxFNoMOtal+Ox4AdESiPR0emse1d1WVYKFRHdxIU+DMWw/Uq
         rBAE75U5HdFe+zLdXIrWU7+ziV9F3rhsroRExPRU7wVUwb3xRrclfCViU6J58ES6O3
         A+/nXu/CXz7qXvDFuuN5BMo9wjB9fz3o5C3gZ7Qo=
Date:   Thu, 12 Aug 2021 13:02:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Barry Song <21cnbao@gmail.com>
Cc:     rafael@kernel.org, bhelgaas@google.com, maz@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linuxarm@huawei.com,
        robin.murphy@arm.com, will@kernel.org, lorenzo.pieralisi@arm.com,
        dwmw@amazon.co.uk, Barry Song <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH v2 0/2] msi: extend msi_irqs sysfs entries to platform
 devices
Message-ID: <YRT/uGklgx2Wmd5v@kroah.com>
References: <20210812105341.51657-1-21cnbao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210812105341.51657-1-21cnbao@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 12, 2021 at 10:53:39PM +1200, Barry Song wrote:
> From: Barry Song <song.bao.hua@hisilicon.com>
> 
> Just like pci devices have msi_irqs which can be used by userspace irq affinity
> tools or applications to bind irqs, platform devices also widely support msi
> irqs.
> For platform devices, for example ARM SMMU, userspaces also care about its msi
> irqs as applications can know the mapping between devices and irqs and then
> make smarter decision on handling irq affinity. For example, for SVA mode,
> it is better to pin io page fault to the numa node applications are running
> on. Otherwise, io page fault will get a remote page from the node iopf happens
> rather than from the node applications are running on.
> 
> The first patch extracts the sysfs populate/destory code from PCI to
> MSI core. The 2nd patch lets platform-msi export msi_irqs entry so that
> userspace can know the mapping between devices and irqs for platform
> devices.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
