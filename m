Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20120919135322.85c608fa.izumi.taku@jp.fujitsu.com>
References: <20120918151215.59ea763b.izumi.taku@jp.fujitsu.com>
	<CAE9FiQVRGK-Of1RuvFZRtuT-yZ7LGDD_oNWr2ier2aaUqrugmA@mail.gmail.com>
	<CAE9FiQW3pyFFt714yuG-BzuK55eUjN4ojhNZ6LvwGqGWuAtMYQ@mail.gmail.com>
	<20120919135322.85c608fa.izumi.taku@jp.fujitsu.com>
Date: Wed, 19 Sep 2012 23:19:29 -0700
Message-ID: <CAE9FiQX33Ef5s3t=i+VBH1XvTObPPV3Eb4QnsvCDvPeu=9uK7Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] acpi,pci: hostbridge hotplug support
From: Yinghai Lu <yinghai@kernel.org>
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	linux-acpi@vger.kernel.org, kaneshige.kenji@jp.fujitsu.com,
	jiang.liu@huawei.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 18, 2012 at 9:53 PM, Taku Izumi <izumi.taku@jp.fujitsu.com> wrote:
> On Tue, 18 Sep 2012 11:57:59 -0700
>> also current acpiphp only have root bridge add notification.
>> and your code do not add any code for remove notification.
>>
>> So how to you test your code with removal path?
>
>  You were saying how to hot-remove hostbridge ?
>  I tested by ejecting ACPI container which includes hostbridge.
>  acpiphp is not the only way to hotplug hostbridge, so I ommit acpiphp
>  work from this patchset. This patchset is core part.

yes.

so acpi root for pci root bus will have parent? I did not think about.

I reordered my patchset and put updated version for your patch 8 into it.

http://git.kernel.org/?p=linux/kernel/git/yinghai/linux-yinghai.git;a=commitdiff;h=3db33bb8b94f3b03dfa097eafb00649643cd893a

the whole tree:

	git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git
for-pci-root-bus-hotplug

Thanks

Yinghai
