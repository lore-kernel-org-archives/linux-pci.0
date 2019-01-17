Return-Path: <SRS0=Lbw5=PZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8E4C43387
	for <linux-pci@archiver.kernel.org>; Thu, 17 Jan 2019 22:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7074C20868
	for <linux-pci@archiver.kernel.org>; Thu, 17 Jan 2019 22:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbfAQWR6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 17 Jan 2019 17:17:58 -0500
Received: from ale.deltatee.com ([207.54.116.67]:44976 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727819AbfAQWR6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Jan 2019 17:17:58 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1gkFyr-000871-SN; Thu, 17 Jan 2019 15:17:46 -0700
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        gregkh <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-ntb@googlegroups.com, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>
References: <20190116163253.23780-1-vincent.whitchurch@axis.com>
 <CAK8P3a2ifu9X+SXgoDPSFMYwnKr=Yex8_tD4qRimcOQAhuEa8Q@mail.gmail.com>
 <20190117105441.eqediwlekofp2srg@axis.com>
 <CAK8P3a2HtSJCLVdLcs=f0b5wv-k-6E_Z4Pt3Yp_kazUZh-Ek9A@mail.gmail.com>
 <20190117151906.odvozs6kz3uvx32y@axis.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <62e5f3e7-e2e3-c6ce-b8f6-99a5342c1494@deltatee.com>
Date:   Thu, 17 Jan 2019 15:17:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190117151906.odvozs6kz3uvx32y@axis.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: allenbh@gmail.com, dave.jiang@intel.com, jdmason@kudzu.us, linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com, kishon@ti.com, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, ashutosh.dixit@intel.com, sudeep.dutt@intel.com, arnd@arndb.de, vincent.whitchurch@axis.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 0/8] Virtio-over-PCIe on non-MIC
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-01-17 8:19 a.m., Vincent Whitchurch wrote:
> On the endpoint, the PCIe endpoint driver sets up (hardcoded) BARs and
> memory regions as required to allow the endpoint and the root complex to
> access each other's memory.

This statement describes NTB hardware pretty well. In essence that's
what an NTB device is: a BAR that maps to a window in other hosts memory.

Right now the entire NTB upstream software stack (ntb_transport and
ntb_netdev) is specific to that ecosystem and only exposes a network
device so the hosts can communicate. This code works but has some issues
and was never able to perform at full PCIe line speeds (which everyone
expects). So it's not clear to me if anyone is doing anything real with
it. The companies that are working on NTB, that I'm aware of, have
mostly done their own out-of-tree stuff.

It would be interesting to unify ntb_transport with the virtio stack
because I suspect they do very similar things right now and there's a
lot more devices above virtio than just a network device. However, the
main problem people working on NTB face (besides performance) is trying
to get multi-host working in a general and sensible way given that the
hardware typically has limited BAR resources (among other limitations).

Logan
