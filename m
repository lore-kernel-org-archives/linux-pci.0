Return-Path: <SRS0=kckM=ZT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94F2C432C0
	for <linux-pci@archiver.kernel.org>; Wed, 27 Nov 2019 23:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2E0321736
	for <linux-pci@archiver.kernel.org>; Wed, 27 Nov 2019 23:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574896680;
	bh=//40V4fSc4lXvHL58wupi3lwZqm45NgkvQDQ3VkamMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d69SLh2fXnPKzjAnpmxyu83C+RYdA1yHys/icpThp91iTYBs3jatNWkWG9ZRhrD33
	 H6sWu0R4JAnIkoFC85nFzmnVXEFdtYrMWBAYrF5MoIUTcxhfsDy6UIYjndCTM1qvGZ
	 D2a8ee/q/py9i15oYiFeb4LnRM6GUepVp0k8khb0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfK0XSA (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 27 Nov 2019 18:18:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:58836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726947AbfK0XSA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 Nov 2019 18:18:00 -0500
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12CA7215F1;
        Wed, 27 Nov 2019 23:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574896679;
        bh=//40V4fSc4lXvHL58wupi3lwZqm45NgkvQDQ3VkamMw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bAOklVl6GGrR6C5a81ChGj7rBv7n8jiCb1iH6LLH2TRsghl5Af9gPqR2O9WHv4KEP
         EkD6uuttbv6TVN3FrAOAbdc8m2GtOrG7oyKlCxT8rgOV+wGmvhTE/tjLc2mi4IrKH0
         kFp+Xtx/ijCUxG2JPDavXrpARKDT/9yWVf/AbolI=
Date:   Thu, 28 Nov 2019 08:17:52 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Kexin Chen <kexinchen7@gmail.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: pci_bus_read_config constantly took 1.3 seconds
Message-ID: <20191127231752.GA1880@redsun51.ssa.fujisawa.hgst.com>
References: <CAB5NJVdt3As=U5M-RRs-aQwVbAUeaXR8hj5+v=zw6EUePQkotQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB5NJVdt3As=U5M-RRs-aQwVbAUeaXR8hj5+v=zw6EUePQkotQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 26, 2019 at 04:46:25PM -0800, Kexin Chen wrote:
> I'm Kexin. I'm working on Linux nvme system. Some of my test triggered
> PCI AER uncorrectable errors leading to slow pci_bus_read_config_XXX,
> which took 1.3 seconds for every access. This caused a lot of CPU
> scheduling issues, for example, 'Thread not rescheduled for xxx ms
> after irq xxx' or 'Softirq x took xxx ms', and finally kernel reboot
> due to soft lockup. Definitely there's hardware issue, but could
> kernel take some actions to avoid kernel from crashing and exit this
> gracefully ? My current system is using 4.4.182.

Unless the pci layer is reading some config space that it really should
know not to access, there really isn't anything the kernel can do here
if we're really waiting on hardware to complete the transaction. The
hardware just has to function correctly.

There are some types of AERs that do indicate the kernel may avoid
accessing some config space, and it's been improved since 4.4 For example,
we don't try reading upstream ports that are the source of an ERR_FATAL
because the link can't be considered reliable. You may want to try a
more recent stable to see if any of those improvements apply to your case.
