Return-Path: <SRS0=XHdA=MO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35243C64EBC
	for <linux-pci@archiver.kernel.org>; Tue,  2 Oct 2018 21:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F40DE206B2
	for <linux-pci@archiver.kernel.org>; Tue,  2 Oct 2018 21:27:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F40DE206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rockbox.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbeJCEMX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 3 Oct 2018 00:12:23 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:19904 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbeJCEMW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Oct 2018 00:12:22 -0400
Received: from smtp2.mailbox.org (unknown [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id AFE2649571;
        Tue,  2 Oct 2018 23:26:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id 4tXfhGBJRgZo; Tue,  2 Oct 2018 23:26:57 +0200 (CEST)
Subject: Re: [PATCH v3] PCI: Reprogram bridge prefetch registers on resume
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Daniel Drake <drake@endlessm.com>,
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
 <7b0a5388-5b3a-a6e0-347f-94f87fc2e540@rockbox.org>
 <20181002200350.GC120535@bhelgaas-glaptop.roam.corp.google.com>
From:   Thomas Martitz <kugel@rockbox.org>
Organization: Rockbox
Message-ID: <0b3bc158-b836-7b44-ef09-7c124f479c58@rockbox.org>
Date:   Tue, 2 Oct 2018 23:26:35 +0200
MIME-Version: 1.0
In-Reply-To: <20181002200350.GC120535@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 02.10.18 um 22:03 schrieb Bjorn Helgaas:
> Hi Thomas,
> 
> On Mon, Oct 01, 2018 at 04:25:06PM +0200, Thomas Martitz wrote:
>> Am 01.10.18 um 06:57 schrieb Daniel Drake:
>>> On Sun, Sep 30, 2018 at 5:07 AM Thomas Martitz <kugel@rockbox.org> wrote:
>>>> The latest iteration does not work on my HP system. The GPU fails to
>>>> power up just like the unpatched kernel.
>>>
>>> That's weird, I would not expect a behaviour change in the latest
>>> patch. pci_restore_config_dword() has some debug messages, could you
>>> please make them visible and show logs again?
>>> Also remind us of the PCI device address of the parent bridge (lspci -vt)
>>
>> I'll follow up with more the requested information on bugzilla
>> (Link: https://bugzilla.kernel.org/show_bug.cgi?id=201069).
>>
>> On a quick re-check, it seems to depend on if I used the eGPU before
>> the initial suspend. If I run glxgears (with DRI_PRIME=1) before suspend it
>> seems fine.
> 
> Does the patch ([1]) make things *worse* compared to v4.19-rc5?
> 

No, certainly not. It does look like a different issue since resuming now
works at least if I used the eGPU in some way before suspend 
(DRI_PRIME=1 glxgears seems to be enough, I assume glxinfo would work as 
well).

Without the patch resuming the eGPU does not work whatsoever.

Please ship the patch. I'll hopefully sort this other issue out.

Best regards.

