Return-Path: <SRS0=K8vK=UU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24DEC43613
	for <linux-pci@archiver.kernel.org>; Fri, 21 Jun 2019 14:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B79D4206B7
	for <linux-pci@archiver.kernel.org>; Fri, 21 Jun 2019 14:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfFUOdu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Jun 2019 10:33:50 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51086 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725985AbfFUOdu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Jun 2019 10:33:50 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 56FAA15A5690BFCC3BED;
        Fri, 21 Jun 2019 22:33:46 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Fri, 21 Jun 2019
 22:33:36 +0800
Subject: Re: [PATCH 4/5] bus: hisi_lpc: Add .remove method to avoid driver
 unbind crash
To:     Bjorn Helgaas <helgaas@kernel.org>
References: <1561026716-140537-1-git-send-email-john.garry@huawei.com>
 <1561026716-140537-5-git-send-email-john.garry@huawei.com>
 <20190621135619.GE82584@google.com>
CC:     <xuwei5@huawei.com>, <linuxarm@huawei.com>, <arm@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <joe@perches.com>, <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
From:   John Garry <john.garry@huawei.com>
Message-ID: <919b0b6f-1c37-47d5-1853-cb297d68aae7@huawei.com>
Date:   Fri, 21 Jun 2019 15:33:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190621135619.GE82584@google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/06/2019 14:56, Bjorn Helgaas wrote:
>>
>> > +static void hisi_lpc_acpi_remove(struct device *hostdev)
>> > +{
>> > +	struct acpi_device *adev = ACPI_COMPANION(hostdev);
>> > +	struct acpi_device *child;
>> > +
>> > +	device_for_each_child(hostdev, NULL, hisi_lpc_acpi_remove_subdev);
>> > +
>> > +	list_for_each_entry(child, &adev->children, node)

Hi Bjorn,

>> > +		acpi_device_clear_enumerated(child);
> There are only two other non-ACPI core callers of
> acpi_device_clear_enumerated() (i2c and spi).  That always makes me
> wonder if we're getting too deep in ACPI internals.

It's no coincidence that i2c and spi are the only other two non-ACPI 
core callers. For getting ACPI support for the hisi-lpc driver, we 
modeled the driver to have the same ACPI enumeration method as i2c and 
spi hosts. That is, allow the host driver to enumerate the child devices.

You can check drivers/acpi/scan.c::acpi_device_enumeration_by_parent() 
for where we make the check on the host and how it is used.

Thanks,
John

>
>> > +}
>> > +
>> >  /*
>> >   * hisi_lpc_acpi_probe - probe children for ACPI FW
>> >   * @hostdev: LPC host device pointer
>> > @@ -555,8 +566,7 @@ static int hisi_lpc_acpi_probe(struct device *hostdev)
>> >  	return 0;
>> >
>> >  fail:
>> > -	device_for_each_child(hostdev, NULL,
>> > -			      hisi_lpc_acpi_remove_subdev);
>> > +	hisi_lpc_acpi_remove(hostdev);
>> >  	return ret;


