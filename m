Return-Path: <SRS0=IRPw=OW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C86C67839
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 16:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8BC820879
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 16:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8BC820879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbeLMQvx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 13 Dec 2018 11:51:53 -0500
Received: from ale.deltatee.com ([207.54.116.67]:57288 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727579AbeLMQvx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Dec 2018 11:51:53 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1gXUDF-0006NM-Pu; Thu, 13 Dec 2018 09:51:50 -0700
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     Eric Wehage <Eric.Wehage@huawei.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        Linuxarm <linuxarm@huawei.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20181210115653.0000615a@huawei.com>
 <45b01572-7d53-c3d0-9a9b-77917ffe6171@deltatee.com>
 <DD8FB053C05D2D4DB8AA6C933261787859975862@sjceml521-mbs.china.huawei.com>
 <f00c1a70-b022-0fd7-71dd-b9d37b916ef7@deltatee.com>
 <DD8FB053C05D2D4DB8AA6C9332617878599788A2@sjceml521-mbs.china.huawei.com>
 <41f870ad-2255-4840-34b1-eff0d20b993d@deltatee.com>
 <20181213092348.00004105@huawei.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <868a8d41-5854-41ca-8ae8-65d0bacda81e@deltatee.com>
Date:   Thu, 13 Dec 2018 09:51:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181213092348.00004105@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sbates@raithlin.com, linuxarm@huawei.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com, linux-pci@vger.kernel.org, Eric.Wehage@huawei.com, jonathan.cameron@huawei.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [RFC] Proposed PCI ECR for description of Advanced Peer to Peer
 Capabilities
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2018-12-13 2:23 a.m., Jonathan Cameron wrote:
> Updated ECR and presentation at:
> Presentation: https://drive.google.com/open?id=1fgwz8w32K2ju9aIySP8RXwQwUAcT9icF
> ECR: https://drive.google.com/open?id=1cHn4OHgTJpa0KkiVab_CyK1NMjPap3MM
> 
> A few small editorial bits and pieces.
> 
> The main change is making the Memory Read, Memory Write and Atomic capabilities
> in addition to indicating they support peer to peer at all, can now give an
> indication of supporting 'same bandwidth as to system memory'.
> 
> Note that from a PCI viewpoint system memory really means anything beyond the
> host so caches etc are all rolled into that term.

Looks good to me. Thanks,

Logan
