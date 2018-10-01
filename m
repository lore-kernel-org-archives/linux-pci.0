Return-Path: <SRS0=/qR3=MN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712C6C43143
	for <linux-pci@archiver.kernel.org>; Mon,  1 Oct 2018 14:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ABC6208D9
	for <linux-pci@archiver.kernel.org>; Mon,  1 Oct 2018 14:25:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ABC6208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rockbox.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbeJAVDp (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Oct 2018 17:03:45 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:59078 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729182AbeJAVDp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Oct 2018 17:03:45 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 65E15499FC;
        Mon,  1 Oct 2018 16:25:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id 79zojJ75-bhP; Mon,  1 Oct 2018 16:25:31 +0200 (CEST)
Subject: Re: [PATCH v3] PCI: Reprogram bridge prefetch registers on resume
To:     Daniel Drake <drake@endlessm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        nouveau@lists.freedesktop.org, Linux PM <linux-pm@vger.kernel.org>,
        Peter Wu <peter@lekensteyn.nl>, kherbst@redhat.com,
        andy.shevchenko@linux.intel.com,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        David Miller <davem@davemloft.net>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        netdev <netdev@vger.kernel.org>, nic_swsd@realtek.com,
        rchang@marvell.com, Linux Kernel <linux-kernel@vger.kernel.org>
References: <20180913033745.11178-1-drake@endlessm.com>
 <20180918213244.GE13616@bhelgaas-glaptop.roam.corp.google.com>
 <20180927205247.GA18434@bhelgaas-glaptop.roam.corp.google.com>
 <3f8efcd6-7cd2-b41a-d984-28c9e1740d6c@rockbox.org>
 <CAD8Lp47uL3DQTBiVTduO1+Cg8px4CDpv26qVJsgT+RJ4WZx9oA@mail.gmail.com>
From:   Thomas Martitz <kugel@rockbox.org>
Organization: Rockbox
Message-ID: <7b0a5388-5b3a-a6e0-347f-94f87fc2e540@rockbox.org>
Date:   Mon, 1 Oct 2018 16:25:06 +0200
MIME-Version: 1.0
In-Reply-To: <CAD8Lp47uL3DQTBiVTduO1+Cg8px4CDpv26qVJsgT+RJ4WZx9oA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 01.10.18 um 06:57 schrieb Daniel Drake:
> On Sun, Sep 30, 2018 at 5:07 AM Thomas Martitz <kugel@rockbox.org> wrote:
>> The latest iteration does not work on my HP system. The GPU fails to
>> power up just like the unpatched kernel.
> 
> That's weird, I would not expect a behaviour change in the latest
> patch. pci_restore_config_dword() has some debug messages, could you
> please make them visible and show logs again?
> Also remind us of the PCI device address of the parent bridge (lspci -vt)
> 

I'll follow up with more the requested information on bugzilla
(Link: https://bugzilla.kernel.org/show_bug.cgi?id=201069).

On a quick re-check, it seems to depend on if I used the eGPU before
the initial suspend. If I run glxgears (with DRI_PRIME=1) before suspend 
it seems fine.

Best regards.
