Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9306C43381
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 19:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F6320685
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 19:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729963AbfCYTIi (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 15:08:38 -0400
Received: from ale.deltatee.com ([207.54.116.67]:36390 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729898AbfCYTIi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Mar 2019 15:08:38 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1h8UxP-00011R-JZ; Mon, 25 Mar 2019 13:08:28 -0600
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kselftest@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
        Joerg Roedel <joro@8bytes.org>,
        Allen Hubbe <allenbh@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Eric Pilmore <epilmore@gigaio.com>
References: <20190322000645.15580-1-logang@deltatee.com>
 <20190322000645.15580-10-logang@deltatee.com>
 <20190322164743.GN251185@google.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <ef64a491-cfad-5192-3b2f-515206036440@deltatee.com>
Date:   Mon, 25 Mar 2019 13:08:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190322164743.GN251185@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: epilmore@gigaio.com, fancer.lancer@gmail.com, dave.jiang@intel.com, allenbh@gmail.com, joro@8bytes.org, jdmason@kudzu.us, linux-kselftest@vger.kernel.org, iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, helgaas@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v3 09/10] NTB: Add MSI interrupt support to ntb_transport
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-03-22 10:47 a.m., Bjorn Helgaas wrote:
> Hi Logan,
> 
> Drive-by nits:

Thanks Bjorn! I've updated my patches for v4 which I'll send out in a
week or two.

Logan
