Return-Path: <SRS0=zVIF=MH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C7CC43382
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 22:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E87220877
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 22:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="y5PPDBsQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E87220877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725806AbeIZE2E (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 26 Sep 2018 00:28:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:33286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725762AbeIZE2E (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Sep 2018 00:28:04 -0400
Received: from [10.80.45.152] (unknown [71.69.156.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3A3920867;
        Tue, 25 Sep 2018 22:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537913902;
        bh=uaOzapQBju5gF5JLNB91MTUYz3qQtuOha5URQiiuHQk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=y5PPDBsQbRh3jAeZbRPb9wqtWj3sZRZfzFdALaQ2J56Mdh3BMruU1Ab7pY9+hq+Yc
         9YSX80h4TMhYb+yPjhtKKHC3LXWe9xc20FDLJqegNRmRcbS1m8fDEVrqjbLr0dzjy0
         lrcnlkuKoNRCt8oacpn1RTZlqcLFf7zFG2jO8GzY=
Subject: Re: [PATCH v4 6/6] PCI: Expose reset type to users of pci_reset_bus()
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, alex.williamson@redhat.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Peter Xu <peterx@redhat.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
References: <20180919163037.13497-1-okaya@kernel.org>
 <20180919163037.13497-7-okaya@kernel.org>
 <20180925205408.GD80129@bhelgaas-glaptop.roam.corp.google.com>
 <e89e160b-74dc-d912-5999-685069262b30@kernel.org>
 <20180925215656.GF80129@bhelgaas-glaptop.roam.corp.google.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <8596bfbb-d18a-7616-e223-e9f700909858@kernel.org>
Date:   Tue, 25 Sep 2018 18:18:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180925215656.GF80129@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/25/2018 5:56 PM, Bjorn Helgaas wrote:
>> Use PCI_RESET_LINK when you need link to retrain.
> There are no callers using this.  Is this intended specifically for
> the case of "the hardware wasn't smart enough to train at the correct
> speed, so we fiddled things and want to retrain"?
> 

Yup, I'll go ahead and change the hfi1 driver to use PCI_RESET_LINK
as originally planned so that there is an actual user.

These constants are intended to be used by the user of pci_reset
APIs. I think it makes sense to keep them there as well. I see
your point that PCI_RESET_LINK was not used. We should also make the hfi1
follow the rules.

> Maybe it doesn't need to be exposed in include/linux/pci.h and could
> be defined internally in drivers/pci/pci.c if it's needed there?
> 

see above.

>> Use PCI_RESET_SLOT when you know that this system is hotplug capable
>> by calling probe functions.
> I raise my eyebrows at this because (a) a driver generally can't tell
> whether hotplug is supported and (b) even if the driver does know,
> what is the benefit to the driver to specify this?  What probe
> functions does this refer to?  If I'm a driver writer, I really can't
> tell what I'm supposed to do with this guidance.  If I'm supposed to
> call a probe function, what is it, when should I call it, and what
> should I do with the result?  Am I supposed to know whether hotplug is
> supported?  Why would I care?

That was the whole reason why I hid the secondary bus reset API from the
user and folded into pci_reset_bus() so that PCI core can deal with hotplug
internally and can go to hotplug reset or bus reset internally.

User just calls pci_reset_bus().

I fully agree with your assessment but there are also exceptions like VFIO
where the code finds out which particular devices are part of a slot hierarchy
and for each one it checks that VFIO ownership has been claimed.
(Alex, please correct me if I'm not getting this right. I just read
200 lines of code in VFIO)

		/* Can we do a slot or bus reset or neither? */
		if (!pci_probe_reset_slot(vdev->pdev->slot))
			slot = true;
		else if (pci_probe_reset_bus(vdev->pdev->bus))
			return -ENODEV;

		ret = vfio_pci_for_each_slot_or_bus(vdev->pdev,
						    vfio_pci_fill_devs,
						    &fill, slot);



> 
> I'm sure you have good answers for all these questions; I just don't
> know what they are:)
> 
>> Use PCI_RESET_BUS when you know that this system is not hotplug capable
>> and this endpoint will never be used in such a system.
> How can a driver know this?  And what's the benefit of being specific?

There is really no benefit but there are drivers making assumptions about
the type of platform they want to run like supporting single segment only
etc.

PCI_RESET_BUS gives you direct access to secondary bus reset. If you are
calling this directly, you are responsible for saving and restoring state
like the hfi1 driver and need to ensure that this card will never work
on a hotplug capable system. If not, you are ...ed.

That's why, I'm suggesting that most users will use PCI_RESET_LINK so
that code works on all platforms.

> 
>> I can capture this into the commit message.
> I think it needs to be more accessible, e.g., comments near the constants
> and/or the function declaration.  We shouldn't expect users of the
> interface to dig through the changelogs for it.
> 

I can work on this once we agree if this is the way to go. I was responding
to Alex's request to have a contact between the PCI core and the drivers
because there are some driver that are more intelligent about the PCI tree
than a simple endpoint driver.


