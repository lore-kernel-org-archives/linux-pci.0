Return-Path: <SRS0=ZPBx=RJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0751C43381
	for <linux-pci@archiver.kernel.org>; Wed,  6 Mar 2019 21:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7353420854
	for <linux-pci@archiver.kernel.org>; Wed,  6 Mar 2019 21:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725783AbfCFVjh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 6 Mar 2019 16:39:37 -0500
Received: from ale.deltatee.com ([207.54.116.67]:43048 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfCFVjh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Mar 2019 16:39:37 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1h1eGD-0004fk-1g; Wed, 06 Mar 2019 14:39:33 -0700
To:     Serge Semin <fancer.lancer@gmail.com>,
        linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kselftest@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Allen Hubbe <allenbh@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Eric Pilmore <epilmore@gigaio.com>
References: <20190213175454.7506-1-logang@deltatee.com>
 <20190213175454.7506-11-logang@deltatee.com>
 <20190306204400.hzpizimya7fq6swi@mobilestation>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <284dae8b-4e8a-1d7b-e806-bf7fed2a39a7@deltatee.com>
Date:   Wed, 6 Mar 2019 14:39:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190306204400.hzpizimya7fq6swi@mobilestation>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: epilmore@gigaio.com, dave.jiang@intel.com, allenbh@gmail.com, joro@8bytes.org, bhelgaas@google.com, jdmason@kudzu.us, linux-kselftest@vger.kernel.org, iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, fancer.lancer@gmail.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v2 10/12] NTB: Introduce NTB MSI Test Client
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-03-06 1:44 p.m., Serge Semin wrote:
> Alas the test driver is not going to work with IDT NTB hardware,
> since it uses Spad only, which aren't supported by IDT devices. IDT NTB
> PCIe functions provide message registers to communicate with peers. See
> ntb_perf driver code for reference of portable driver design.
> 
> In order to make the test driver portable the following alterations
> are needed:
> 1) Add NTB Message register API usage together with Scratchpad+Doorbell.
> 2) When NTB MSI library is updated with functions like
> ntb_msi_peer_setup_mws()/ntb_msi_peer_clear_mws() they are needed to be
> utilized in the test driver as well to set a translation address on the
> peer side.

Per, the discussion on the previous email, we can update this later once
we actually have sensible infrastructure for it. The mess in ntb_perf is
not something I want to replicate and we don't have any interest in
creating a large amount of infrastructure to support hardware we don't
care about.

Logan
