Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:37314 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759763AbaD3XsM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 30 Apr 2014 19:48:12 -0400
Received: by mail-ig0-f173.google.com with SMTP id hn18so548577igb.6
        for <linux-pci@vger.kernel.org>; Wed, 30 Apr 2014 16:48:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQVRHAW3jXwnUSX96Jy3qbeQ8JcSGoPKANJjWYnNS1CTdw@mail.gmail.com>
References: <1398893606-22712-1-git-send-email-yinghai@kernel.org>
	<CAErSpo7aWM_BjXqEqgTk0uT4RbpZSqjGJOgOH_hWreoQicMU_A@mail.gmail.com>
	<CAE9FiQW1yFmgZRCWrhi5ccwxWfDZdR0vbQ1bA7zz-5Fa8TfN5A@mail.gmail.com>
	<CAErSpo4K_duSr7Y5OHVm+KMhso2csG=nTZ9v1V=ATVK76Rj=QQ@mail.gmail.com>
	<CAE9FiQVRHAW3jXwnUSX96Jy3qbeQ8JcSGoPKANJjWYnNS1CTdw@mail.gmail.com>
Date: Wed, 30 Apr 2014 16:48:11 -0700
Message-ID: <CAE9FiQW5O5ZXr3YnoR8q56AuLnOfeqSX3=FgSAw=S+twF7LCXQ@mail.gmail.com>
Subject: Re: [PATCH v3] pciehp: only wait command complete for real hotplug control
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rajat Jain <rajatxjain@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 30, 2014 at 4:21 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Wed, Apr 30, 2014 at 3:26 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>
>>> For intel: Nehalem, westmere, sndbridge, ivybridge.
>>>
>>> For nvidia, only according to boot log for old systems with chipset:
>>> ck804 and mcp55.
>>
>> I meant, do you have a reference to a section in the spec that talks
>> about how this works?
>>
>> So far all we have is folklore that was discovered by experimentation.
>>  It'd be nice to see the spec that says "CC is only used when changing
>> these listed bits."
>
> We will have doc from Intel about that. Hope it is not under NDA.

Intel published that yesterday.

http://www.intel.com/content/www/us/en/processors/xeon/xeon-e7-v2-spec-update.html
in section CF118.

Thanks

Yinghai
