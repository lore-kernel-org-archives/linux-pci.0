Return-Path: <SRS0=u0zl=SM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F115C10F11
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 21:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 771462084B
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 21:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbfDJV7s (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 10 Apr 2019 17:59:48 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60658 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725982AbfDJV7s (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Apr 2019 17:59:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5BC6374;
        Wed, 10 Apr 2019 14:59:47 -0700 (PDT)
Received: from [192.168.1.123] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E28E3F718;
        Wed, 10 Apr 2019 14:59:45 -0700 (PDT)
Subject: Re: [pci:pci/enumeration 6/6] drivers/pci/of.c:40
 pci_set_bus_of_node() error: we previously assumed 'bus->self' could be null
 (see line 34)
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@01.org,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        kbuild-all@01.org, linux-pci@vger.kernel.org,
        Grant Likely <grant.likely@linaro.org>
References: <20190410194901.GE31633@kadam>
 <20190410212112.GH256045@google.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <f33dcbf9-83df-9a6d-1092-0b7fcf79c7c0@arm.com>
Date:   Wed, 10 Apr 2019 22:59:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190410212112.GH256045@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2019-04-10 10:21 pm, Bjorn Helgaas wrote:
> On Wed, Apr 10, 2019 at 10:49:01PM +0300, Dan Carpenter wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/enumeration
>> head:   60ea7f5dd97ed9949e6fbf67e93c9b2c38cc9eb7
>> commit: 60ea7f5dd97ed9949e6fbf67e93c9b2c38cc9eb7 [6/6] PCI: OF: Support "external-facing" property
>>
>> smatch warnings:
>> drivers/pci/of.c:40 pci_set_bus_of_node() error: we previously assumed 'bus->self' could be null (see line 34)
> 
> Yep, that looks like a problem.  I dropped these for now:
> 
>    60ea7f5dd97e PCI: OF: Support "external-facing" property
>    6201cf80200c dt-bindings: Add "external-facing" PCIe port property

I guess we don't expect to see this property on the host bridge device 
itself (hence the need to extend the DT description down to the root 
port(s)), so in theory we should only crash here if the firmware got the 
binding wrong, but I agree that's something definitely worth being 
robust against.

Robin.

>> # https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?id=60ea7f5dd97ed9949e6fbf67e93c9b2c38cc9eb7
>> git remote add pci https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
>> git remote update pci
>> git checkout 60ea7f5dd97ed9949e6fbf67e93c9b2c38cc9eb7
>> vim +40 drivers/pci/of.c
>>
>> 98d9f30c82 Benjamin Herrenschmidt 2011-04-11  31
>> 98d9f30c82 Benjamin Herrenschmidt 2011-04-11  32  void pci_set_bus_of_node(struct pci_bus *bus)
>> 98d9f30c82 Benjamin Herrenschmidt 2011-04-11  33  {
>> 98d9f30c82 Benjamin Herrenschmidt 2011-04-11 @34  	if (bus->self == NULL)
>> 98d9f30c82 Benjamin Herrenschmidt 2011-04-11  35  		bus->dev.of_node = pcibios_get_phb_of_node(bus);
>> 98d9f30c82 Benjamin Herrenschmidt 2011-04-11  36  	else
>> 98d9f30c82 Benjamin Herrenschmidt 2011-04-11  37  		bus->dev.of_node = of_node_get(bus->self->dev.of_node);
>> 60ea7f5dd9 Jean-Philippe Brucker  2019-04-02  38
>> 60ea7f5dd9 Jean-Philippe Brucker  2019-04-02  39  	if (of_get_property(bus->dev.of_node, "external-facing", NULL))
>> 60ea7f5dd9 Jean-Philippe Brucker  2019-04-02 @40  		bus->self->untrusted = true;
>> 98d9f30c82 Benjamin Herrenschmidt 2011-04-11  41  }
>> 98d9f30c82 Benjamin Herrenschmidt 2011-04-11  42
>>
>> ---
>> 0-DAY kernel test infrastructure                Open Source Technology Center
>> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
