Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:36969 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660AbcBASl3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 1 Feb 2016 13:41:29 -0500
Received: by mail-ig0-f181.google.com with SMTP id 5so18354568igt.0
        for <linux-pci@vger.kernel.org>; Mon, 01 Feb 2016 10:41:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1454300093.10542.3.camel@redhat.com>
References: <CAJ2oMhL-oL68ZOLsFEn3uGE=O9sMjcwPDH6oznLhG15xnzSQtQ@mail.gmail.com>
	<1454300093.10542.3.camel@redhat.com>
Date: Mon, 1 Feb 2016 20:41:28 +0200
Message-ID: <CAJ2oMh+MjG8frrE3DjHBtwrsG1vGwMcDzQQ8f-n0q-YBS04DZg@mail.gmail.com>
Subject: Re: Q: Relation between lanes to devices and to BARs
From: Ran Shalit <ranshalit@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 1, 2016 at 6:14 AM, Alex Williamson
<alex.williamson@redhat.com> wrote:
> On Sun, 2016-01-31 at 02:15 -0500, Ran Shalit wrote:
>> Hello,
>>
>> I am new to pci express drivers, and would please like to ask a question.
>> We develop a linux driver for a PCIe device board with 4 lanes.
>> 1. Is it expected that this will be recognized as a single device or
>> multiple device ?
>
> It depends whether your device is multifunction.
>

It is a video capture & output deivce, (video4linux), so I guess it
means it has single functionality (video).' and therefore will aprear
as a single device.


>> 2. Is it that each lane rales to a different BAR or there is no
>> connection between these two ?
>
> No relation, all PCI/e devices have the same set of standard BARs
> available to them.
>

Thanks,
So it probably means that there is no added complexity in terms of
device driver with multi lanes PCIe (compared to single lane).


Thank you,
Ran
