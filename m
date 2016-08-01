Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:38107 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755112AbcHAS7L (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 1 Aug 2016 14:59:11 -0400
Received: by mail-wm0-f53.google.com with SMTP id o80so257791669wme.1
        for <linux-pci@vger.kernel.org>; Mon, 01 Aug 2016 11:59:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160801125448.4bff0200@t450s.home>
References: <CAH=XD5_0RV_o0vpx1v3dXEadzdNTwFYhevH70XNFBG-1jBnYzQ@mail.gmail.com>
 <20160801125448.4bff0200@t450s.home>
From: Kallol Biswas <kallol@nucleodyne.com>
Date: Mon, 1 Aug 2016 11:59:01 -0700
Message-ID: <CAH=XD58ubyVJ=VoSb34yM0m5VgL9=m5rm_iqXU5x+LkqKhnLMw@mail.gmail.com>
Subject: Re: how to initialize a PCI device via specific B:D.F
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Just experimenting with PCIe Fabric and running into unkown issues.

Thanks for feedback, I will update when I find a good way to solve this.

Thanks,
Kallol

On Mon, Aug 1, 2016 at 11:54 AM, Alex Williamson
<alex.williamson@redhat.com> wrote:
> On Mon, 1 Aug 2016 11:29:58 -0700
> Kallol Biswas <kallol@nucleodyne.com> wrote:
>
>> Hi,
>>     I have exposed a realtek PF via an additional switch to a host CPU.
>>
>> The host CPU can now view the device via two paths. One, in regular
>> path and another via the additional switch. The device has two B:D.Fs
>> assigned to it.
>>
>> How can I tell the Realtek driver to configure the device only via new path?
>>
>> Bind/unbind may not work, as I do not want to initialize the device
>> via the regular path.
>
> In general this sounds like a horrible idea, how can the OS know that
> these two paths reach the same device?  What about the BAR resources of
> the device, can they be valid for both paths?  The kernel is going
> to try to allocate separate resources for each path.  Even if you make
> the rtl driver only attach once, you better try to pick the BDF that the
> kernel scanned and programmed resources for most recently.
>
> If I had to hack something together for this, my first thought would be
> to use pci-stub to claim both devices via the vendor:device IDs.  Then
> use a boot script that would "echo 1 > remove" for both devices in
> sysfs, then hopefully find a "rescan" in sysfs far enough downstream
> via the path you want that you can rediscover only the desired BDF,
> then bind that device to the rtl driver.  (I hope you don't intend to
> ship any products this way).  Thanks,
>
> Alex
