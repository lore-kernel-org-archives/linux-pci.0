Return-Path: <SRS0=2g0o=Q4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7614AC43381
	for <linux-pci@archiver.kernel.org>; Thu, 21 Feb 2019 15:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E5B12075A
	for <linux-pci@archiver.kernel.org>; Thu, 21 Feb 2019 15:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbfBUPib (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:38:31 -0500
Received: from bmailout3.hostsharing.net ([176.9.242.62]:33011 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfBUPib (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Feb 2019 10:38:31 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 099DC100DA1A9;
        Thu, 21 Feb 2019 16:38:29 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id B37034D2EB; Thu, 21 Feb 2019 16:38:28 +0100 (CET)
Date:   Thu, 21 Feb 2019 16:38:28 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc:     bhelgaas@google.com, austin_bolen@dell.com,
        alex_gagniuc@dellteam.com, keith.busch@intel.com,
        Shyam_Iyer@Dell.com, okaya@kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH RFC v2 0/4] PCI: pciehp: Do not turn off slot if presence
 comes up after link
Message-ID: <20190221153828.vd5uufymaut5j6o2@wunner.de>
References: <20190220012031.10741-1-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220012031.10741-1-mr.nuke.me@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 19, 2019 at 07:20:26PM -0600, Alexandru Gagniuc wrote:
> This series has two solutions for this problem, and is intended to
> serve as a bikeshedding point for which is better:
>  1. Try to wait for PDS _before_ loading the driver
>  2. Load as usual, and recognize the delayed PDS event as such
> 
> I think (2) is more generic and elegant, but a lot of people seem to
> like something similar to (1).

Either solution LGTM, by now I've also become accustomed to your
preferred solution (2) (i.e. patch [2/4]), so I'm deferring this
question to Bjorn.


> (*) ECN was approved in Nov 2018, and is normative spec text. A lot of
> the leaked PCIe 4.0 specs do not have this change.

I thought it will be incorporated into 5.0, which is why it's missing
in all 4.0 specs?

Thanks,

Lukas
