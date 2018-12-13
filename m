Return-Path: <SRS0=IRPw=OW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC4DC65BAE
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 09:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50CA02075B
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 09:24:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50CA02075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbeLMJYJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 13 Dec 2018 04:24:09 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:16563 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726578AbeLMJYJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Dec 2018 04:24:09 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EE3D19F5E350;
        Thu, 13 Dec 2018 17:24:05 +0800 (CST)
Received: from localhost (10.202.226.46) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.408.0; Thu, 13 Dec 2018
 17:23:56 +0800
Date:   Thu, 13 Dec 2018 09:23:48 +0000
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Logan Gunthorpe <logang@deltatee.com>
CC:     Eric Wehage <Eric.Wehage@huawei.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        Linuxarm <linuxarm@huawei.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [RFC] Proposed PCI ECR for description of Advanced Peer to Peer
 Capabilities
Message-ID: <20181213092348.00004105@huawei.com>
In-Reply-To: <41f870ad-2255-4840-34b1-eff0d20b993d@deltatee.com>
References: <20181210115653.0000615a@huawei.com>
        <45b01572-7d53-c3d0-9a9b-77917ffe6171@deltatee.com>
        <DD8FB053C05D2D4DB8AA6C933261787859975862@sjceml521-mbs.china.huawei.com>
        <f00c1a70-b022-0fd7-71dd-b9d37b916ef7@deltatee.com>
        <DD8FB053C05D2D4DB8AA6C9332617878599788A2@sjceml521-mbs.china.huawei.com>
        <41f870ad-2255-4840-34b1-eff0d20b993d@deltatee.com>
Organization: Huawei
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.46]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 10 Dec 2018 12:39:36 -0700
Logan Gunthorpe <logang@deltatee.com> wrote:

> On 2018-12-10 12:36 p.m., Eric Wehage wrote:
> > There are 5 TLP types described in each of the three P2P Routes. I'm
> > not sure that anyone would care about Message Bandwidth, so I
> > could simply add 3 bits to each Route register indicating whether the
> > P2P route bandwidth supports the same or more bandwidth than if it
> > targeted DRAM.
> > 
> > The three RO/HWInit bits for each route register would be:
> > - P2P Memory Read Bandwidth is equal to or greater than to Main
> >    Memory
> > - P2P Memory Write Bandwidth is equal to or greater than to Main
> >    Memory
> > - P2P Memory AtomicOp Bandwidth is equal to or greater than to Main
> >    Memory  
> 
> Yeah! That sounds great. Thanks.
> 
> Logan

Updated ECR and presentation at:
Presentation: https://drive.google.com/open?id=1fgwz8w32K2ju9aIySP8RXwQwUAcT9icF
ECR: https://drive.google.com/open?id=1cHn4OHgTJpa0KkiVab_CyK1NMjPap3MM

A few small editorial bits and pieces.

The main change is making the Memory Read, Memory Write and Atomic capabilities
in addition to indicating they support peer to peer at all, can now give an
indication of supporting 'same bandwidth as to system memory'.

Note that from a PCI viewpoint system memory really means anything beyond the
host so caches etc are all rolled into that term.

Thanks,

Eric and Jonathan

