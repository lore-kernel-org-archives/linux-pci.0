Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53]:39458 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754051AbaJJOh6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Oct 2014 10:37:58 -0400
Received: by mail-qg0-f53.google.com with SMTP id a108so3926612qge.40
        for <linux-pci@vger.kernel.org>; Fri, 10 Oct 2014 07:37:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5437A958.3000201@maya.org>
References: <20140923210318.498dacbd@dualc.maya.org> <1411502866.24563.8.camel@ul30vt.home>
 <5437A958.3000201@maya.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 10 Oct 2014 08:37:37 -0600
Message-ID: <CAErSpo5kkk4itqqmCMU=08-XMcDknur8VY++F3A2LajdvTptOA@mail.gmail.com>
Subject: Re: Hard and silent lock up since linux 3.14 with PCIe pass through (vfio)
To: Andreas Hartmann <andihartmann@freenet.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 10, 2014 at 3:39 AM, Andreas Hartmann
<andihartmann@freenet.de> wrote:
> shortly: I retested w/ qemu 2.1.0 and Linux 3.17.0 - no change in behaviour.
>
> Alex Williamson wrote:
>> On Tue, 2014-09-23 at 21:03 +0200, Andreas Hartmann wrote:
>>> Hello!
>>>
>>> Since long time now, I'm using w/o any problem PCIe pass through with a
>>> Gigabyte GA-990XA-UD3/GA-990XA-UD3 mainboard (AMD 990X chipset) and
>>> enabled IOMMU with vfio-pci.
>>>
>>> The last kernel working w/o any problem is kernel 3.13.7 (I didn't use
>>> .8 and .9, but I do not think they would have been problematic).
>>>
>>> Since 3.14.19 (I didn't test any 3.14 kernel before) I'm encountering a
>>> hard and silent lock up of the complete machine when starting the VM
>>> with the PCIe card passed through.

Since we're not really making any progress on this yet, would it be
possible to bisect it?  We already know that 3.13.7 works and 3.14.19
fails, and "git bisect start v3.14 v3.13" says it's about 13 steps.  I
know that's still quite a bit of work, but at least it sounds like the
problem is easy to reproduce.

Bjorn
