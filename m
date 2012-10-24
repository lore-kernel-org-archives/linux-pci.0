Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:61200 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935311Ab2JXSC0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 24 Oct 2012 14:02:26 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so642714wgb.1
        for <linux-pci@vger.kernel.org>; Wed, 24 Oct 2012 11:02:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1351098875.19172.21.camel@misato.fc.hp.com>
References: <1351058750-4275-1-git-send-email-tangchen@cn.fujitsu.com>
 <1351058750-4275-3-git-send-email-tangchen@cn.fujitsu.com> <1351098875.19172.21.camel@misato.fc.hp.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 24 Oct 2012 12:02:04 -0600
Message-ID: <CAErSpo7KRTY+M1gSO7s_PGRPkXABK6x9CQsaMXbZ__C11mmTWQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Improve container_notify_cb() to support container hot-remove.
To: Toshi Kani <toshi.kani@hp.com>
Cc: Tang Chen <tangchen@cn.fujitsu.com>, yinghai@kernel.org,
	lenb@kernel.org, jiang.liu@huawei.com, izumi.taku@jp.fujitsu.com,
	isimatu.yasuaki@jp.fujitsu.com, mihailm@parallels.com,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 24, 2012 at 11:14 AM, Toshi Kani <toshi.kani@hp.com> wrote:
> On Wed, 2012-10-24 at 14:05 +0800, Tang Chen wrote:

>> +             result = container_device_remove(device);
>> +             if (result) {
>> +                     printk(KERN_WARNING "Failed to remove container\n");
>
> Please use pr_warn().

I think you should use dev_warn() and similar when possible.  In a
year or two, the text "Failed to remove container" all by itself in a
dmesg log is not going to mean anything to anybody except you, and it
doesn't give any clue where to start looking for issues.

I also have a larger question.  I'm not sure if
drivers/acpi/container.c does anything important in the first place.
The code in it looks an awful lot like the code in
drivers/acpi/processor_driver.c, drivers/acpi/acpi_memhotplug.c, and
drivers/pci/hotplug/acpiphp_glue.c.

To me, it looks like container.c (as well as the other places I
mentioned) is an attempt to compensate for the lack of hotplug support
in the ACPI core.  If the ACPI core had generic hotplug support, e.g.,
if it handled BUS_CHECK, DEVICE_CHECK, and EJECT_REQUEST notifications
and turned those into the appropriate calls to driver .add()/.start()
and .remove() methods, would we need container.c at all?

Bjorn
