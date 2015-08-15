Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:37002 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752174AbbHOOjp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 15 Aug 2015 10:39:45 -0400
Received: by wibhh20 with SMTP id hh20so45179153wib.0
        for <linux-pci@vger.kernel.org>; Sat, 15 Aug 2015 07:39:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3296684.6OYqAkrTIu@linux-tez8>
References: <1438047747.1856.12.camel@rzhang1-mobl4> <1438133951.1856.23.camel@rzhang1-mobl4>
 <20150814201752.GG26431@google.com> <3296684.6OYqAkrTIu@linux-tez8>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Sat, 15 Aug 2015 09:39:24 -0500
Message-ID: <CAErSpo6zcgK=Hdgq+vVNMjMHS2WkYqpVR3Vppqi7R87xSjWMJg@mail.gmail.com>
Subject: Re: [PATCH] PCI: Disable async suspend/resume for Jmicron chip
To: Jay <MyMailClone@t-online.de>
Cc: Zhang Rui <rui.zhang@intel.com>, Tejun Heo <tj@kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	Chuansheng Liu <chuansheng.liu@intel.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Aaron Lu <aaron.lu@intel.com>,
	Barto <mister.freeman@laposte.net>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jay,

On Sat, Aug 15, 2015 at 7:49 AM, Jay <MyMailClone@t-online.de> wrote:
> Am Freitag, 14. August 2015, 15:17:52 schrieb Bjorn Helgaas:
> ...
>> Since you didn't say anything like that, I assume the patch in comment
>> #72 of bug #81551 (https://bugzilla.kernel.org/attachment.cgi?id=156301)
>> would work as well.  That has the advantage that it wouldn't penalize
>> non-storage controllers.
>
> The problem was introduced with 3.15 and the kernel is almost at 4.2 now.
>
> A general solution for the JMicron-AHCI/PATA-controllers is still missing
> although available since late September 2014. It was tested by Barto.
>
> Seems what I wrote in comment #76 wasn't completely wrong:
> https://bugzilla.kernel.org/show_bug.cgi?id=81551#c76
>
> So this may be an opportunity to reconsider the approach to solving
> things like this.

I don't understand your point, except to acknowledge that we are
imperfect, have limited resources, and make many mistakes in
diagnosing problems and communicating solutions.  Do you have a
proposal for a better approach?

The patch that Barto tested in late September 2014
(https://bugzilla.kernel.org/show_bug.cgi?id=81551#c66) is exactly the
patch from comment #72 that I mentioned as possibly being a better
solution.

That patch wouldn't involve me at all, since it doesn't touch PCI.
Zhang is proposing a PCI change, so I'm asking for a clear changelog.

A changelog is a "write-once, read-many" situation.  It's very
important that it be concise and clear, and it's worth having the
expert spend extra time writing the log to make it easier for the many
novices that will read it in the future.

Bjorn
