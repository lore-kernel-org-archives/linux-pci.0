Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:44696 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075AbbHFQS2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 6 Aug 2015 12:18:28 -0400
Message-ID: <55C388CF.4090501@roeck-us.net>
Date: Thu, 06 Aug 2015 09:18:23 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v3] PCI: Only enable IO window if supported
References: <1438308908-12259-1-git-send-email-linux@roeck-us.net>	<CAE9FiQXuTKmXXCFsKUiMK43U+LpOzfa3oV0iNWS+Jh879EDNsw@mail.gmail.com>	<CAE9FiQVGhfbFW5-5deYcU2bDWE9k0-4+V+cepwdqZ661sLWOFA@mail.gmail.com>	<55C2C4F4.1040600@roeck-us.net>	<CAE9FiQXtSDBFy1rf4TPHwD-JjoB+5Wii1MBMBfGTaNosqnRJGg@mail.gmail.com>	<55C2E79E.3090809@roeck-us.net> <CAE9FiQVDwX_-bX9sH2qv3thkKzOosFR3WvkUYWM=TsU-4oOSzA@mail.gmail.com>
In-Reply-To: <CAE9FiQVDwX_-bX9sH2qv3thkKzOosFR3WvkUYWM=TsU-4oOSzA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 08/06/2015 08:58 AM, Yinghai Lu wrote:
> On Wed, Aug 5, 2015 at 9:50 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>> If I understand you correctly, we might need to change the code
>> in pci_read_bridge_io() as follows.
>>
>> From
>>
>>          if (!(child->bus_flags & PCI_BUS_FLAGS_SUPPORTS_IO))
>>                  return;
>>
>> to something like
>>
>>          if (!(child->bus_flags & PCI_BUS_FLAGS_SUPPORTS_IO)) {
>>                  if (dev->transparent)
>>                          return;
>>                  child->bus_flags |= PCI_BUS_FLAGS_SUPPORTS_IO;
>>          }
>>
> Then how about: the root bus really does not support IO PORT resource.
>

Ok, I admit that I am lost. Earlier it seemed that you were concerned about
this case, where no io window is available or a bus doesn't support io,
but a non-transparent child does. Now you seem to say that the non-transparent
child would not be able to support IO either.

For my education, can you list the possible options, and how you suggest
to solve them ? I can see the following situations.

- root supports IO, but has no io window assigned
- root does not support IO and has or has not an IO window assigned
- a bridge does not support IO

For the transparent case, each of those should result in all children
not even trying to assign an IO window, which is what we want,
and what my patc set tries to do.

How should those cases be handled for non-transparent bridges ?

Thanks,
Guenter

