Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from resqmta-po-05v.sys.comcast.net ([96.114.154.164]:34397 "EHLO
	resqmta-po-05v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752696AbbCFBp5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 5 Mar 2015 20:45:57 -0500
Message-ID: <54F9107D.4000000@pobox.com>
Date: Thu, 05 Mar 2015 18:27:09 -0800
From: Robert White <rwhite@pobox.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: NULL Pointer in 3.x during PCI bus enumeration
References: <54EB81B2.4050904@pobox.com> <54F10D0F.9080309@pobox.com> <CAErSpo7NB25yNaHu8VOujUN1NUTyr4FM+jUA8gsbVSx0ZC1USg@mail.gmail.com>
In-Reply-To: <CAErSpo7NB25yNaHu8VOujUN1NUTyr4FM+jUA8gsbVSx0ZC1USg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

It took me a while to get back into the lab and scrape together a 
working subsystem to collect the data you wanted.

Link to bug...

https://bugzilla.kernel.org/show_bug.cgi?id=94361

--Rob.


On 02/28/2015 02:33 PM, Bjorn Helgaas wrote:
> On Fri, Feb 27, 2015 at 4:34 PM, Robert White <rwhite@pobox.com> wrote:
>> Eh, wrong mailing list the first time...?
>
> Yep, I browse linux-kernel sometimes, but not enough to catch
> everything.  Anyway, thanks a lot for the problem report.
>
> Would you mind opening a bug report at http://bugzilla.kernel.org,
> drivers/pci component, and attaching
>
>    - a completely dmesg log from your most recent kernel (it probably
> doesn't boot, which it makes it hard to get an actual dmesg log; a
> complete console log with "ignore_loglevel" is fine, too).
>    - complete "lspci -vv" output from a working system (v2.x is fine).
>
> Thanks,
>    Bjorn
>

