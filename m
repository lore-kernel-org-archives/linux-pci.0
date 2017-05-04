Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:34870 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751879AbdEDM7G (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 May 2017 08:59:06 -0400
Received: by mail-wm0-f51.google.com with SMTP id w64so17707174wma.0
        for <linux-pci@vger.kernel.org>; Thu, 04 May 2017 05:59:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1493883171.10737.12.camel@ni.com>
References: <1492408237-16598-1-git-send-email-vee.khee.wong@ni.com>
 <CAErSpo5R+Fy+be06tg0sQtvaR=6QzqJn5k1M=NE=tPgDzNnUAA@mail.gmail.com> <1493883171.10737.12.camel@ni.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 4 May 2017 07:58:44 -0500
Message-ID: <CAErSpo634Sje2E2F_9KcZ8YixxqrGA3+sxP7QiywKU6CV+Lc4A@mail.gmail.com>
Subject: Re: [PATCH] pci-sysfs: Make PCI bridge attribute visible in sysfs
To: Vee Khee Wong <vee.khee.wong@ni.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Hearn <jonathan.hearn@ni.com>,
        "Ram.Amrani@cavium.com" <Ram.Amrani@cavium.com>,
        Hui Chun Ong <hui.chun.ong@ni.com>,
        "shhuiw@foxmail.com" <shhuiw@foxmail.com>,
        "rajatja@google.com" <rajatja@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "jonathan.yong@intel.com" <jonathan.yong@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 4, 2017 at 2:32 AM, Vee Khee Wong <vee.khee.wong@ni.com> wrote:
>
>
> On Mon, 2017-04-17 at 10:41 -0500, Bjorn Helgaas wrote:
>> On Mon, Apr 17, 2017 at 12:50 AM, Wong Vee Khee <vee.khee.wong@ni.com
>> > wrote:
>> >
>> > From: vwong <vee.khee.wong@ni.com>
>> >
>> > Export the PCIe link attributes of PCI bridges to sysfs.
>> This needs justification for *why* we should export these via sysfs.
>>
>> Some of these things, e.g., secondary/subordinate bus numbers, are
>> already visible to non-privileged users via "lspci -v".
>>
> We need to expose these attributes via sysfs due to several reasons
> listed below:
>
> 1) PCIe capabilities info such as Maximum/Actual link width and link speed only visible to privileged users via "lspci -vvv". The software that my team is working on need to get PCIe link information as non-root user.
>
> 2) From a client perspective, it require a lot of overhead parsing output of lspci to get PCIe capabilities. Our application is only interested in getting PCIe bridges but lspci print info for all PCIe devices.

I'm looking for a revised patch that incorporates the justification in
the changelog and addresses the code comments I made.

Bjorn
