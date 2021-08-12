Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1F7C4338F
	for <linux-pci@archiver.kernel.org>; Thu, 12 Aug 2021 06:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6914C60720
	for <linux-pci@archiver.kernel.org>; Thu, 12 Aug 2021 06:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbhHLGq2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 12 Aug 2021 02:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbhHLGq1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Aug 2021 02:46:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E2AC061765
        for <linux-pci@vger.kernel.org>; Wed, 11 Aug 2021 23:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tCUhEwxONxwl2dtWLeLqvDeI+cMrrsBA9i6z2UiPp40=; b=u8ESGKVYpeOtFIFQemmm9DCrfA
        TYtnHsyj36ZLGaeFAy2+tlmByL30V3l685HQQXfBD33LiKqaYIqCJQvvWZMYiBEiw0NvIK+fO+OuW
        +SbNtMFcIG4MVciTdfjlUQAGTzSQRZjt5lfiV93FCFIDkOO41AtSuo2xCOdn6oVLlZZRGaUwZBit/
        +/XciT+x+euNOxRTszJuJYLfhEMib540AxcPnKLiN5Vr6/1eg+lEuLxzhgbvr9jGexTwPZU1r0M+4
        kqP552r6i7mUHHs63VuBo+PxtRwGjY9ZNtAIojqVwsdm0XC0RwfwFFDSAbNOcQ9aEpu9dbitvBgtS
        iWgkXeWQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mE4S4-00EFfY-7p; Thu, 12 Aug 2021 06:44:43 +0000
Date:   Thu, 12 Aug 2021 07:44:28 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Uwe Kleine-K??nig <u.kleine-koenig@pengutronix.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v3 1/8] PCI: Simplify pci_device_remove()
Message-ID: <YRTDTKxaGknLnW0w@infradead.org>
References: <20210811080637.2596434-1-u.kleine-koenig@pengutronix.de>
 <20210811080637.2596434-2-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811080637.2596434-2-u.kleine-koenig@pengutronix.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 11, 2021 at 10:06:30AM +0200, Uwe Kleine-K??nig wrote:
> When the driver core calls pci_device_remove() there is a driver that bound
> the device and so pci_dev->driver is never NULL.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
