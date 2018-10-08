Return-Path: <SRS0=j7M/=MU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0011EC65C20
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 21:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97E6C214C5
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 21:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="u/cXxb1v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97E6C214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbeJIEnw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 9 Oct 2018 00:43:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:37970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726503AbeJIEnw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Oct 2018 00:43:52 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C525A2054F;
        Mon,  8 Oct 2018 21:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539034208;
        bh=bu2yKsX+/qtztl0uMkcQuhNz+L7a5PM4LiidNXCSTAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u/cXxb1vp8rm90gcaYaz+Gr8cqNWzOSKrzAOoW8Y7AYdPAgUrNHLz+C+VGYzzM+XZ
         V6/+L/goFr12rYUZTUeqL9wRIo15mJTaGe3gqVMRZQODJxXB923WTqBT0ctC0UaIQB
         UDZVT0YLXDutmZ1kgay9MYXRAykBus/tPYf/hkv8=
Date:   Mon, 8 Oct 2018 16:30:06 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Keith Busch <keith.busch@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-pci@vger.kernel.org, linaro-kernel@lists.linaro.org,
        linux-next@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-build-reports@lists.linaro.org
Subject: Re: next-20181008 build: 2 failures 22 warnings (next-20181008)
Message-ID: <20181008213006.GP120535@bhelgaas-glaptop.roam.corp.google.com>
References: <E1g9cV0-0008Sg-4U@optimist>
 <20181008212021.GB4440@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008212021.GB4440@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 08, 2018 at 10:20:21PM +0100, Mark Brown wrote:
> On Mon, Oct 08, 2018 at 09:51:30PM +0100, Build bot for Mark Brown wrote:
> 
> Today's -next fails to build an arm allmodconfig caused by:
> 
> > 	arm-allmodconfig
> > ../drivers/pci/pcie/aer_inject.c:444:6: error: 'struct pt_regs' has no member named 'ip'
> 
> introduced in e3fbcc7c4b130(PCI/AER: Covertly inject errors with ftrace
> hooks).  This field is not present on arm.

I dropped e3fbcc7c4b130 and related patches already, so this should be gone
in my current "next" branch (18b4baa4d9fc).
