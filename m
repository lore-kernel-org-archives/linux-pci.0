Return-Path: <SRS0=N/Da=QW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDBEC43381
	for <linux-pci@archiver.kernel.org>; Fri, 15 Feb 2019 01:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4655B21B68
	for <linux-pci@archiver.kernel.org>; Fri, 15 Feb 2019 01:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550195887;
	bh=fY2PUK1KWg9MwIzIgOCRLy89m1t5lCZfaeD0YO6mRrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Mqx0t40KXDkEH56emDoyQh6YVS+AGi2Ibk2+DQwxwZYPaq4+s7TMmRV5NmvWtQ9Eh
	 uW9+rg8JbBQaER6y2jYeFOM4elr6yV7Z0JwBfAut0207NPMrRY1/0g3uPLwEsR7SXN
	 zPQbwra9XJQB+doUqXLP3KwN2drpjDwHZGqxR5ww=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731160AbfBOB6G (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 14 Feb 2019 20:58:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:40562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbfBOB6G (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 Feb 2019 20:58:06 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AAA32192D;
        Fri, 15 Feb 2019 01:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550195885;
        bh=fY2PUK1KWg9MwIzIgOCRLy89m1t5lCZfaeD0YO6mRrk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NLTXtVEFcrz725yoV25ZE25C31JjJwZ7yhKhv6MGuZ2mdwNT+1QEksR9nGd21qSmp
         nQxnEP/U8f3e8bRRJzX9k6UhYRsUsscI4SRwrNux6qpgDthSzi5xHItW718FDSo3q9
         RarnLOLlJPzaXwEPAh1/46UhaLLyvGVp6EaskDJU=
Date:   Thu, 14 Feb 2019 20:58:04 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Maya Nakamura <m.maya.nakamura@gmail.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, kys@microsoft.com,
        sthemmin@microsoft.com, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, mikelley@microsoft.com,
        Alexander.Levin@microsoft.com, linux-kernel@vger.kernel.org,
        driverdev-devel@linuxdriverproject.org, haiyangz@microsoft.com,
        vkuznets@redhat.com, marcelo.cerri@canonical.com
Subject: Re: [PATCH v3 0/2] PCI: hv: Refactor hv_irq_unmask() to use hv_vpset
 and cpumask_to_vpset()
Message-ID: <20190215015804.GM69686@sasha-vm>
References: <cover.1548745212.git.m.maya.nakamura@gmail.com>
 <20190213151549.GA417@e107981-ln.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190213151549.GA417@e107981-ln.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 13, 2019 at 03:15:49PM +0000, Lorenzo Pieralisi wrote:
>On Mon, Jan 28, 2019 at 11:15:37PM -0800, Maya Nakamura wrote:
>> This patchset removes a duplicate definition of VP set (hv_vp_set) and
>> uses the common definition (hv_vpset) that is used in other places. It
>> changes the order of the members in struct hv_pcibus_device due to
>> flexible array in hv_vpset.
>>
>> It also removes the duplicate implementation of cpumask_to_vpset(), uses
>> the shared implementation, and exports hv_max_vp_index, which is
>> required by cpumask_to_vpset().
>>
>> Maya Nakamura (2):
>>   PCI: hv: Replace hv_vp_set with hv_vpset
>>   PCI: hv: Refactor hv_irq_unmask() to use cpumask_to_vpset()
>>
>>  arch/x86/hyperv/hv_init.c           |  1 +
>>  drivers/pci/controller/pci-hyperv.c | 59 +++++++++++++----------------
>>  2 files changed, 28 insertions(+), 32 deletions(-)
>
>I need a maintainer ACK to merge this series.

Acked-by: Sasha Levin <sashal@kernel.org>

--
Thanks,
Sasha
