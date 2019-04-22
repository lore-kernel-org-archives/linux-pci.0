Return-Path: <SRS0=L200=SY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201C3C10F11
	for <linux-pci@archiver.kernel.org>; Mon, 22 Apr 2019 17:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4EF3214AF
	for <linux-pci@archiver.kernel.org>; Mon, 22 Apr 2019 17:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfDVROx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 22 Apr 2019 13:14:53 -0400
Received: from ale.deltatee.com ([207.54.116.67]:40818 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbfDVROx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Apr 2019 13:14:53 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hIcWp-0001ME-RJ; Mon, 22 Apr 2019 11:14:52 -0600
To:     Eric Pilmore <epilmore@gigaio.com>,
        linux-ntb <linux-ntb@googlegroups.com>, linux-pci@vger.kernel.org
Cc:     S Taylor <staylor@gigaio.com>, D Meyer <dmeyer@gigaio.com>
References: <CAOQPn8sX2G-Db-ZiFpP2SMKbkQnPyk63UZijAY0we+DoZsmDtQ@mail.gmail.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <a5a2d312-f6af-f20f-0594-98a7f80c7a9d@deltatee.com>
Date:   Mon, 22 Apr 2019 11:14:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAOQPn8sX2G-Db-ZiFpP2SMKbkQnPyk63UZijAY0we+DoZsmDtQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: dmeyer@gigaio.com, staylor@gigaio.com, linux-pci@vger.kernel.org, linux-ntb@googlegroups.com, epilmore@gigaio.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: AMD IO_PAGE_FAULT w/NTB on Write ops?
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-04-20 3:06 a.m., Eric Pilmore wrote:
> What we have found is that the Xeon based host can successfully ioread
> to this mapped shared buffer, but whenever it attempts an iowrite to
> this region, it results in an IO_PAGE_FAULT on the AMD based host:
> 
> AMD-Vi: Event logged [IO_PAGE_FAULT device=23:01.2 domain=0x0000
> address=0x00000000fde1c18c flags=0x0070]
> 
> Going in the opposite direction there are no issues, i.e. the AMD
> based host can successfully ioread/iowrite to the mapped in buffer
> exported by the Xeon host.  Or if both hosts are Xeon's, then
> everything works fine also.
> 
> I have looked high and low, and have not been able to interpret what
> the "flags=0x0070" represent. I assume they are indicating some write
> permission error, but was wondering if anybody here might know?

See the AMD IOMMU spec[1]. Figure 51. 0x0070 indicates the PE, RW and PR
bits are set which means a Write request to a present page was denied
because the peripheral did not have permission.

> More importantly, does anybody know why the AMD IOMMU might seemingly
> default to not allow Write operations to the exported memory? Is there
> some additional BIOS or kernel boot parameter setting that needs to be
> set?

Yeah, I don't think the IOMMU defaults to allow write operations to
exported memory. That would be extremely broken....

> lspci on the AMD hosts of the external PCI-e switch:
>    23:00.0 PCI bridge: PMC-Sierra Inc. Device 8536
>    23:00.1 Bridge: PMC-Sierra Inc. Device 8536
> 
> The 23:00.1 BDF is the NTB bridge. The BDF (23:01.2) in the error
> message represents the "NTB translated" BDF of the request that came
> from the peer, i.e. the 01.2 is the proxy-id. Is there a chance that
> this proxy-id is causing some confusion for the AMD IOMMU?

I suspect the proxy IDs are the problem. On Intel hardware, we had to
add support so that it allowed requests for all proxy IDs for a given
device. We probably have to do something similar to the AMD IOMMU driver.

My guess is that the reason writes work and not reads is because the
write TLPs are posted and thus the switch doesn't apply the Proxy ID
seeing it doesn't expect a completion. Thus the IOMMU sees the TLPs as
coming from a permitted peripheral and doesn't complain.

Logan

[1] https://www.amd.com/system/files/TechDocs/48882_IOMMU.pdf
