Return-Path: <SRS0=vJ1S=YJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580AEC4360C
	for <linux-pci@archiver.kernel.org>; Wed, 16 Oct 2019 08:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36CBC21D7B
	for <linux-pci@archiver.kernel.org>; Wed, 16 Oct 2019 08:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391261AbfJPIEc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 16 Oct 2019 04:04:32 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:39902 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727671AbfJPIEc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Oct 2019 04:04:32 -0400
Received: from [167.98.27.226] (helo=[10.35.5.173])
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iKeII-0007Qq-GH; Wed, 16 Oct 2019 09:04:30 +0100
Subject: Re: [PATCH] PCI: sysfs: remove pci_bridge_groups and pcie_dev_groups
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@lists.codethink.co.uk,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191015140059.18660-1-ben.dooks@codethink.co.uk>
 <20191016062831.GB6537@infradead.org>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
Message-ID: <8481ae38-ff7b-b00e-6cf3-dc672eccf07c@codethink.co.uk>
Date:   Wed, 16 Oct 2019 09:04:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191016062831.GB6537@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 16/10/2019 07:28, Christoph Hellwig wrote:
> On Tue, Oct 15, 2019 at 03:00:59PM +0100, Ben Dooks wrote:
>> The pci_bridge_groups and pcie_dev_groups objects are
>> not exported and not used at-all, so remove them to
>> fix the following warnings from sparse:
>>
>> drivers/pci/pci-sysfs.c:1546:30: warning: symbol 'pci_bridge_groups' was not declared. Should it be static?
>> drivers/pci/pci-sysfs.c:1555:30: warning: symbol 'pcie_dev_groups' was not declared. Should it be static?
> 
> But now pci_bridge_group is unused, and if you remove that the
> attributes, etc..

Ok, thanks for spotting, i've removed those too.

I've no idea why we're not getting compiler warnings for this.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
