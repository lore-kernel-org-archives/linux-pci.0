Return-Path: <SRS0=eCDn=PJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D88C43387
	for <linux-pci@archiver.kernel.org>; Tue,  1 Jan 2019 06:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EB2F21783
	for <linux-pci@archiver.kernel.org>; Tue,  1 Jan 2019 06:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbfAAGU7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 1 Jan 2019 01:20:59 -0500
Received: from dfwrgout.huawei.com ([206.16.17.72]:2061 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727453AbfAAGU7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Jan 2019 01:20:59 -0500
Received: from DFWEML703-CAH.china.huawei.com (unknown [172.18.9.221])
        by Forcepoint Email with ESMTP id ED5C087E15F02;
        Tue,  1 Jan 2019 00:20:55 -0600 (CST)
Received: from SJCEML701-CHM.china.huawei.com (10.208.112.40) by
 DFWEML703-CAH.china.huawei.com (10.193.5.177) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 31 Dec 2018 22:20:57 -0800
Received: from SJCEML521-MBS.china.huawei.com ([169.254.2.185]) by
 SJCEML701-CHM.china.huawei.com ([169.254.3.129]) with mapi id 14.03.0415.000;
 Mon, 31 Dec 2018 22:20:49 -0800
From:   Eric Wehage <Eric.Wehage@huawei.com>
To:     Bjorn Helgaas <helgaas@kernel.org>, yu <kkndyu@gmail.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Logan Gunthorpe" <logang@deltatee.com>,
        Stephen Bates <sbates@raithlin.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: RE: How to force RC to forward p2p TLPs
Thread-Topic: How to force RC to forward p2p TLPs
Thread-Index: AQHUnx5arrCTMaIaJ0ieNs1Uu8mqA6WZ9IxA
Date:   Tue, 1 Jan 2019 06:20:48 +0000
Message-ID: <DD8FB053C05D2D4DB8AA6C93326178785997FDDC@sjceml521-mbs.china.huawei.com>
References: <CADayL-pxr_dpJykyiTeQDO13XmKPoKUs544zVrB2taHTVEx9Pw@mail.gmail.com>
 <20181229022923.GA159477@google.com>
In-Reply-To: <20181229022923.GA159477@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.212.247.199]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There is no method to force an RC to forward requests p2p. RC's are also not required to support p2p and whether they do or not is implementation specific. There is also currently no PCIe based standard to determine whether an RC supports p2p or in what capacity. Also, even if p2p is supported, it might not be supported in a system that enables Virtualization (the Virtualization would have to setup p2p tables to allow it).

There is currently a PCIe ECR that has been submitted, but is undergoing review, that defines a PCIe capability for bridge devices (Root Ports and Switch Downstream Ports) that would allow them to advertise what level of p2p is supported by the device.

Eric Wehage
Huawei Principal Engineer, PCIe

-----Original Message-----
From: Bjorn Helgaas [mailto:helgaas@kernel.org] 
Sent: Friday, December 28, 2018 6:29 PM
To: yu <kkndyu@gmail.com>
Cc: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; Logan Gunthorpe <logang@deltatee.com>; Stephen Bates <sbates@raithlin.com>; Jonathan Cameron <jonathan.cameron@huawei.com>; Eric Wehage <Eric.Wehage@huawei.com>; Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: Re: How to force RC to forward p2p TLPs

[+cc Logan, Stephen, Jonathan, Eric, Alex]

On Sat, Dec 22, 2018 at 12:50:19PM +0800, yu wrote:
> Hi all,
> 
> We have a PCIE card which has a PEX8732 switch on-board,  and there 
> are two endpoint SOCs like graphic decoder behind the switch, and by 
> default the ACS is enabled in 8732.
> 
> We use the p2p DMA to transfer data between these two endpoint SOCs, 
> and if the host server is not enable ACS in BIOS, the p2p works well, 
> but when ACS is enabled in BIOS, the p2p is always failed. With the 
> help of a protocol analyzer, we can see that the TLP is redirected to 
> RC, and RC just discard it.
> 
> I tried to find how to make RC forward redirected TLP to its original 
> target, but nothing found, it seems this is highly related to the RC 
> vendors.
> 
> In the PCIE 4.0 spec, the section of the RC behavior of the p2p 
> request redirect  said that ''implementation-specific logic within the 
> RC that determines whether the request is directed towards its 
> original target, or blocked as an ACS Violation error. the algorithms 
> and specific controls for making this determination are not 
> architected by this spec''.
> 
> 
> So is there some spec or document to describe how to set the RC? Any 
> suggestion is appreciated.

Not that I'm aware of, but the folks I cc'd would know a lot more about this area.

Bjorn
