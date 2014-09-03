Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <54074B62.2000207@arm.com>
Date: Wed, 03 Sep 2014 18:09:54 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Sudeep Holla <sudeep.holla@arm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v4 01/11] cpumask: factor out show_cpumap into separate
 helper function
References: <1409763617-17074-1-git-send-email-sudeep.holla@arm.com> <1409763617-17074-2-git-send-email-sudeep.holla@arm.com> <CAErSpo6wOjh6PitcPudyZBVKy7vyEafNSzxgf5jSxFq+vrQHQQ@mail.gmail.com>
In-Reply-To: <CAErSpo6wOjh6PitcPudyZBVKy7vyEafNSzxgf5jSxFq+vrQHQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 03/09/14 18:05, Bjorn Helgaas wrote:
> On Wed, Sep 3, 2014 at 11:00 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> From: Sudeep Holla <sudeep.holla@arm.com>
>>
>> Many sysfs *_show function use cpu{list,mask}_scnprintf to copy cpumap
>> to the buffer aligned to PAGE_SIZE, append '\n' and '\0' to return null
>> terminated buffer with newline.
>>
>> This patch creates a new helper function cpumap_copy_to_buf in
>> cpumask.h and consolidates most of them using this new helper.
>>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: x86@kernel.org
>> Cc: linux-acpi@vger.kernel.org
>> Cc: linux-pci@vger.kernel.org
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com> (drivers/pci part)
>

Thanks.

> I assume you'll merge this via a non-PCI tree.
>

Yes, since it's widespread change, I prefer it to go through Greg's tree.

Regards,
Sudeep

