Return-Path: <SRS0=JnZd=SL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F5EC10F0E
	for <linux-pci@archiver.kernel.org>; Tue,  9 Apr 2019 23:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B6F320850
	for <linux-pci@archiver.kernel.org>; Tue,  9 Apr 2019 23:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfDIXcR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 9 Apr 2019 19:32:17 -0400
Received: from ale.deltatee.com ([207.54.116.67]:40612 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726606AbfDIXcR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Apr 2019 19:32:17 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hE0Dv-0005yk-9G; Tue, 09 Apr 2019 17:32:16 -0600
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Wesley Sheng <wesley.sheng@microchip.com>
Cc:     kurt.schwemmer@microsemi.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, wesleyshenggit@sina.com,
        kelvin.cao@microchip.com
References: <1554734088-5755-1-git-send-email-wesley.sheng@microchip.com>
 <1554734088-5755-2-git-send-email-wesley.sheng@microchip.com>
 <20190409223642.GD256045@google.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <634db3fa-286d-1136-b2af-1bf45501275f@deltatee.com>
Date:   Tue, 9 Apr 2019 17:32:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190409223642.GD256045@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: kelvin.cao@microchip.com, wesleyshenggit@sina.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, kurt.schwemmer@microsemi.com, wesley.sheng@microchip.com, helgaas@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 1/2] switchtec: Fix false maximum supported PCIe function
 number issue
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-04-09 4:36 p.m., Bjorn Helgaas wrote:
> Hi Wesley,
> 
> On Mon, Apr 08, 2019 at 10:34:47PM +0800, Wesley Sheng wrote:
>> The hardware supports up to 255 PFFs and the driver only supports 48, so
>> this patch updates the driver to support them all.
>> To be backward compatible, a new ioctl and corresponding data
>> structure are created, while keep the deprecated one.
> 
> The above is either one paragraph that needs to be rewrapped, or two
> paragraphs that need a blank line between.

Wesley can address this.

> What's a PFF?

PFF is really a concept internal to the Switchtec device. It stands for
PCIe Function Framework. Essentially, there is a bank of registers for
every PCIe Function (aka endpoint) in the switch. When I originally
wrote the driver, I assumed incorrectly there would only ever be one PFF
per port and the maximum number of ports for Switchtec parts is 48. In
fact, the hardware supports up to 255 and there are typically two PFFs
per upstream port (one for the port itself and one for the management
endpoint).

Logan



