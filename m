Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:36737 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753943AbbICBDa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 2 Sep 2015 21:03:30 -0400
Received: by ioii196 with SMTP id i196so40789646ioi.3
        for <linux-pci@vger.kernel.org>; Wed, 02 Sep 2015 18:03:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <loom.20150902T084450-322@post.gmane.org>
References: <loom.20150831T091131-859@post.gmane.org>
	<CAE9FiQWNA1BEGom757xtbc0zFjFqZ9uqKwj2kM7EFDDKXEL6fw@mail.gmail.com>
	<loom.20150901T110001-176@post.gmane.org>
	<CAE9FiQUxU2FCxFKQ=6ZdnJL8fU-YxAOjQmMSAP_YBG1gEG+ntA@mail.gmail.com>
	<loom.20150902T084450-322@post.gmane.org>
Date: Wed, 2 Sep 2015 18:03:29 -0700
Message-ID: <CAE9FiQWgrymUN07D5rFr0XVrF1Ays606JaWQCfH47Av0cv8q0g@mail.gmail.com>
Subject: Re: PCI rescan : can't assign mem
From: Yinghai Lu <yinghai@kernel.org>
To: Peio <peio@azkarate.eu>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 2, 2015 at 12:01 AM, Peio <peio@azkarate.eu> wrote:
> Yinghai Lu <yinghai <at> kernel.org> writes:
>> and 00:02.0 use almost all
>>
>> [    0.278221] pci 0000:00:02.0: reg 0x10: [mem 0x90000000-0x903fffff]
>> [    0.278239] pci 0000:00:02.0: reg 0x18: [mem 0x80000000-0x8fffffff
> pref]
>>
>> so we have no chance to allocate MMIO to 00:1c.0
>>
>
> Any workaround?.

boot with pci=nocrs ?

>
> Is the BIOS responsible for allocating memory resources in Linux?.

The resource range for root bus. As BIOS may need to set other registers to make
them effective.

> Perhaps changing some BIOS parameter ACPI related?.

Try to get BIOS update.

> If I change BIOS parameters I'll need a fresh install or the actual kernel
> reconigzes changes?.
should not.
