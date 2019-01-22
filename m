Return-Path: <SRS0=s1t5=P6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6ACC282C3
	for <linux-pci@archiver.kernel.org>; Tue, 22 Jan 2019 18:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CA5320870
	for <linux-pci@archiver.kernel.org>; Tue, 22 Jan 2019 18:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548183522;
	bh=JUmDj1SwyTkyOg03HuCFLs9I4QqkQmw6gcXy0XweXFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iUyicFTYD9UyCG1roMQiQlgBs8GV5t/aCICtNhfY1gHPjspyi2U+SSyEHEYwA2UR1
	 T00YCEREGd7hyiPsMz0odbspJP0srd8wjHZU5LHhY5d2EY+KfnpYsVoHvI2vp7KLJF
	 1PRQwbIpJa48os7Ip3JoR00J9nvFgkBmS0cxVbBU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbfAVS6l (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 22 Jan 2019 13:58:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:38428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbfAVS6l (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Jan 2019 13:58:41 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7677921726;
        Tue, 22 Jan 2019 18:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548183520;
        bh=JUmDj1SwyTkyOg03HuCFLs9I4QqkQmw6gcXy0XweXFM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dNvX9DoOwG6+ZfGq5xKGXIPbLPBN9kuBkVpDG9w3Iw6A7NzvROTCgbBNfLYeqpjYo
         y/fQuHLr/iqEGcRnO2KiyTB1hBS2yhoGJ3tUR+oZi1VvcYYtnK1BZyU80NyiYb4jaD
         Ne9BKKTqdbBaqnuWZHaVAjZNUH8AwS4mpXQZeNXc=
Date:   Tue, 22 Jan 2019 12:58:38 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     xuyandong <xuyandong2@huawei.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yinghai Lu <yinghai@kernel.org>,
        Jesse Barnes <jbarnes@virtuousgeek.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Ofer Hayut <ofer@lightbitslabs.com>,
        Roy Shterman <roys@lightbitslabs.com>,
        Keith Busch <keith.busch@intel.com>,
        "Wangzhou (B)" <wangzhou1@hisilicon.com>
Subject: Re: [PATCH v3] PCI: avoid bridge feature re-probing on hotplug
Message-ID: <20190122185838.GB14636@google.com>
References: <20181218004455.20186-1-mst@redhat.com>
 <20190119201259.GA87988@google.com>
 <7CECC2DFC21538489F72729DF5EFB4D909EC77D4@dggemm501-mbs.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7CECC2DFC21538489F72729DF5EFB4D909EC77D4@dggemm501-mbs.china.huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 22, 2019 at 05:31:10AM +0000, xuyandong wrote:
> Hi Bjorn and Michael
> 
> After trying to reproduce the problem for a whole day, the bug did not show up
> any more. So I think the new patch does solve this problem.

Thank you very much for testing this!

I'd like to give you the appropriate credit in the changelog, but I don't
know exactly how your name should be spelled and capitalized.  Is the
following what you want?  If not, let me know and I'll correct it.

  Reported-by: xuyandong <xuyandong2@huawei.com>
  Tested-by: xuyandong <xuyandong2@huawei.com>

Bjorn
