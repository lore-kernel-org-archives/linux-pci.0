Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:33525 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932839AbbIDPmH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 4 Sep 2015 11:42:07 -0400
Received: by wiclk2 with SMTP id lk2so26868359wic.0
        for <linux-pci@vger.kernel.org>; Fri, 04 Sep 2015 08:42:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <loom.20150904T072156-908@post.gmane.org>
References: <loom.20150831T091131-859@post.gmane.org> <CAE9FiQWNA1BEGom757xtbc0zFjFqZ9uqKwj2kM7EFDDKXEL6fw@mail.gmail.com>
 <loom.20150901T110001-176@post.gmane.org> <CAE9FiQUxU2FCxFKQ=6ZdnJL8fU-YxAOjQmMSAP_YBG1gEG+ntA@mail.gmail.com>
 <loom.20150902T084450-322@post.gmane.org> <CAE9FiQWgrymUN07D5rFr0XVrF1Ays606JaWQCfH47Av0cv8q0g@mail.gmail.com>
 <loom.20150903T080202-734@post.gmane.org> <loom.20150903T113710-656@post.gmane.org>
 <CAErSpo6KYCM99H5J0JvYymNmbn-O1NfVwo4Lp7B=2cXCFQwnOw@mail.gmail.com> <loom.20150904T072156-908@post.gmane.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 4 Sep 2015 10:41:46 -0500
Message-ID: <CAErSpo7M8Ahaps00An2qXQWdMpq38batxxXrVSwDBqvHjsm8rA@mail.gmail.com>
Subject: Re: PCI rescan : can't assign mem [SOLVED]
To: Peio <peio@azkarate.eu>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 4, 2015 at 12:32 AM, Peio <peio@azkarate.eu> wrote:
> Bjorn Helgaas <bhelgaas <at> google.com> writes:
>
>> This is a workaround, not a solution.  It is not safe to use
>> "pci=nocrs" in general because it can break things related to resource
>> assignment, including hot-add of new devices.
>>
>> I haven't looked at the problem in detail, but if the BIOS gives us a
>> _CRS with host bridge windows that are too small to accommodate all
>> your devices, there's really nothing the kernel can do about it.  You
>> just have to regard it as a limitation of that platform.
>>
>> Bjorn
>>
> I'm sure itsn't a platform limitation, a BIOS issue assigning resources
> instead.

Yep.  I include the BIOS in "the platform" because it's something we
have no control over.

> Anyway, It's a closed system, without hot-add or not own devices.
>
> I suspect this workaround is fine to me.

OK.  I didn't phrase the risk very well.  When we use "pci=nocrs",
we're ignoring the host bridge apertures the BIOS tells us about.
That means Linux may assign resources outside of those apertures to
PCI devices.  They *might* work, but there's no guarantee that they
will.  This can affect devices present at boot as well as hot-added
ones.

If we were really smart, we might emit a warning when we assigned
resources outside of the apertures, but that's probably more work than
it's worth.

If the workaround works for you, that's great and you should keep
using it.  I just don't want to propagate the idea that "pci=nocrs" is
the general solution for anything.   Ideally, a user should not have
to use kernel parameters except for debugging or to work around
hardware or firmware problems.

Bjorn
