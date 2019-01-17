Return-Path: <SRS0=Lbw5=PZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671C7C43387
	for <linux-pci@archiver.kernel.org>; Thu, 17 Jan 2019 15:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E13520652
	for <linux-pci@archiver.kernel.org>; Thu, 17 Jan 2019 15:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfAQPcL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 17 Jan 2019 10:32:11 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:50999 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfAQPcL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Jan 2019 10:32:11 -0500
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id 37C8C185AB;
        Thu, 17 Jan 2019 16:32:09 +0100 (CET)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id PhmqNlTYOiv4; Thu, 17 Jan 2019 16:32:07 +0100 (CET)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
        by bastet.se.axis.com (Postfix) with ESMTPS id D96CC185A1;
        Thu, 17 Jan 2019 16:32:06 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB9701E08A;
        Thu, 17 Jan 2019 16:32:06 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ACFB21E07E;
        Thu, 17 Jan 2019 16:32:06 +0100 (CET)
Received: from seth.se.axis.com (unknown [10.0.2.172])
        by boulder03.se.axis.com (Postfix) with ESMTP;
        Thu, 17 Jan 2019 16:32:06 +0100 (CET)
Received: from lnxartpec.se.axis.com (lnxartpec.se.axis.com [10.88.4.9])
        by seth.se.axis.com (Postfix) with ESMTP id 9ED3A3135;
        Thu, 17 Jan 2019 16:32:06 +0100 (CET)
Received: by lnxartpec.se.axis.com (Postfix, from userid 10564)
        id 91ED880B46; Thu, 17 Jan 2019 16:32:06 +0100 (CET)
Date:   Thu, 17 Jan 2019 16:32:06 +0100
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, sudeep.dutt@intel.com,
        ashutosh.dixit@intel.com, gregkh <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-ntb@googlegroups.com, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>
Subject: Re: [PATCH 0/8] Virtio-over-PCIe on non-MIC
Message-ID: <20190117153206.2flxqb26tbdrwp4z@axis.com>
References: <20190116163253.23780-1-vincent.whitchurch@axis.com>
 <CAK8P3a2ifu9X+SXgoDPSFMYwnKr=Yex8_tD4qRimcOQAhuEa8Q@mail.gmail.com>
 <20190117105441.eqediwlekofp2srg@axis.com>
 <CAK8P3a2HtSJCLVdLcs=f0b5wv-k-6E_Z4Pt3Yp_kazUZh-Ek9A@mail.gmail.com>
 <20190117151906.odvozs6kz3uvx32y@axis.com>
 <20190117152142.GB20359@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117152142.GB20359@infradead.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-TM-AS-GCONF: 00
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 17, 2019 at 07:21:42AM -0800, Christoph Hellwig wrote:
> On Thu, Jan 17, 2019 at 04:19:06PM +0100, Vincent Whitchurch wrote:
> > On the RC, a vop-host-backend driver (PCI driver) sets up some shared
> > memory area which the RC and the endpoint can use to communicate the
> > location of the MIC device descriptors and other information such as the
> > MSI address.  It implements vop callbacks to allow the vop framework to
> > obtain the address of the MIC descriptors and send/receive interrupts
> > to/from the guest.
> 
> Why would we require any work on the RC / host side?  A properly
> setup software controlled virtio device should just show up as a
> normal PCIe device, and the virtio-pci device should bind to it.

If I understand you correctly, I think you're talking about the RC
running the virtio drivers and the endpoint implementing the virtio
device?  This vop stuff is used for the other way around: the virtio
device is implement on the RC and the endpoint runs the virtio drivers.
