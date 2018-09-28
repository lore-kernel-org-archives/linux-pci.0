Return-Path: <SRS0=ex/N=MK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F8BC43382
	for <linux-pci@archiver.kernel.org>; Fri, 28 Sep 2018 16:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 833F420868
	for <linux-pci@archiver.kernel.org>; Fri, 28 Sep 2018 16:57:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 833F420868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbeI1XW0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 28 Sep 2018 19:22:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39066 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbeI1XW0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Sep 2018 19:22:26 -0400
Received: from localhost (unknown [88.128.83.59])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B04B6E83;
        Fri, 28 Sep 2018 16:57:44 +0000 (UTC)
Date:   Fri, 28 Sep 2018 18:52:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Peter Anemone <peter.anemone@gmail.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>
Subject: Re: [GIT PULL] PCI fixes for v4.19
Message-ID: <20180928165246.GA12008@kroah.com>
References: <20180927193154.GA30598@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927193154.GA30598@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 27, 2018 at 02:31:54PM -0500, Bjorn Helgaas wrote:
> PCI fixes:
> 
>   - Fix ACPI hotplug issue that causes black screen crash at boot (Mika
>     Westerberg)
> 
>   - Fix DesignWare "scheduling while atomic" issues (Jisheng Zhang)
> 
>   - Add PPC contacts to MAINTAINERS for PCI core error handling (Bjorn
>     Helgaas)
> 
>   - Sort Mobiveil MAINTAINERS entry (Lorenzo Pieralisi)
> 
> 
> The following changes since commit 7876320f88802b22d4e2daf7eb027dd14175a0f8:
> 
>   Linux 4.19-rc4 (2018-09-16 11:52:37 -0700)
> 
> are available in the Git repository at:
> 
>   ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.19-fixes-2

Now pulled, thanks.

greg k-h
