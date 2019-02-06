Return-Path: <SRS0=okY7=QN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA345C282CB
	for <linux-pci@archiver.kernel.org>; Wed,  6 Feb 2019 01:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76FD52175B
	for <linux-pci@archiver.kernel.org>; Wed,  6 Feb 2019 01:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="BnlCa8lv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbfBFBBw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 5 Feb 2019 20:01:52 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:36578 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfBFBBv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Feb 2019 20:01:51 -0500
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 690EF24E2855;
        Tue,  5 Feb 2019 17:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1549414911; bh=WRm+NlFKL/HMLQZK/vcyhJnFrWM9FuCLqplQGDjlpMg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=BnlCa8lvJ6Mtb/jNCEuU9FoKDi3NBIAxS5Kxj1BqF8cRw3to5nhcVKgzN08RlaNjD
         YxPZr1i9yMdZjBveTsRcbuwBHyc/9ChX/WbsEF8u1VV1/p58GUu9AYZeFj0TiURpes
         iya2JpNnHlwaErb+zqk74a5wiR/g6XblB6LbysaktCeVZsVB/+VvrFqh3CrY/CjmG7
         aqv3CFMLctZDwmHjC7aQeiOaJhdsOC5gSPbwfCqf+8HG6t+BcUY85hBAhnYbhBk8XC
         WTN360dclUNVkZH+nrZ5Y6N41XXziHtsVM7YW6tbIIljcNci960shPNSKGi0xavk8k
         AtxxnKwpZNsag==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 09EF7A0079;
        Wed,  6 Feb 2019 01:01:50 +0000 (UTC)
Received: from US01WEHTC1.internal.synopsys.com (10.12.239.236) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 5 Feb 2019 17:01:40 -0800
Received: from [10.0.2.15] (10.12.81.173) by us01wehtc1.internal.synopsys.com
 (10.12.239.231) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 5 Feb
 2019 17:01:40 -0800
Subject: Re: [PATCH RESEND] PCI: Check for USB xHCI class for HAPS platform
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Thinh Nguyen <thinh.nguyen@synopsys.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Lukas F. Hartmann" <lukas@mntmn.com>,
        Trent Piepho <tpiepho@impinj.com>,
        John Youn <john.youn@synopsys.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>
References: <a28cfcee61f0842efe114c97b566bb3d967ba3d3.1549326366.git.thinhn@synopsys.com>
 <20190205233159.GC7268@google.com>
From:   John Youn <john.youn@synopsys.com>
Message-ID: <5d78ac08-0809-d219-ff7c-5cea5f7aba8b@synopsys.com>
Date:   Tue, 5 Feb 2019 17:01:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190205233159.GC7268@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.12.81.173]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 02/05/2019 03:32 PM, Bjorn Helgaas wrote:
> [+cc Richard, Lucas]
> 
> On Tue, Feb 05, 2019 at 01:04:28PM -0800, Thinh Nguyen wrote:
>> The Synopsys HAPS USB controller has a VID PID (16c3,abcd) that matches
>> to an existing PCIe controller. This quirk is intended for USB HAPS
>> devices only. To fix this, check for the PCI class USB xHCI to prevent
>> matching the PCIe controllers.
> 
> So there are at least three different parts with the same Vendor &
> Device ID ([16c3:abcd]):
> 
>    1) Synopsys HAPS USB3 controller
>    2) Synopsys PCIe IP in the NXP i.MX6QP (reported by Lukas)
>    3) Synopsys PCIe IP in the NXP i.MX7D (reported by Trent)
> 
> I don't know if Synopsys is to blame for 2 & 3, or if NXP was expected
> to change the Vendor ID when incorporating the Synopsys IP into the
> i.MX designs.  But even leaving the default Device ID of the PCIe IP
> the same as another Synopsys device was probably a bad idea.


Hi Bjorn,

 From talking with our PCIe folks, our best guess is a vendor
misconfiguration. The PCIe IP ships with a different PID by default
and does not collide with USB.

> dwc3-haps claims by Vendor & Device ID; it doesn't look at the Class
> Code.  What happens when it tries to claim the PCIe IP in i.MX?

We can add the class code to dwc3-haps to account for this.

John
