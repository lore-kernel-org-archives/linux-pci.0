Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34203 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751711AbcDVA0Y (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 21 Apr 2016 20:26:24 -0400
MIME-Version: 1.0
In-Reply-To: <CAMxnaaXN7YwEDNGDR1aRbOqhj_2JFyQAiCSjqvTa500x_xRmLA@mail.gmail.com>
References: <1460111790-92836-1-git-send-email-mika.westerberg@linux.intel.com>
	<CAJZ5v0ic6YpYtM4cymLJ4oV2-J4CK4MxFi9-6bWNADD-QY3B6A@mail.gmail.com>
	<20160421131224.GY1725@lahna.fi.intel.com>
	<2823801.fOoJOI22FZ@vostro.rjw.lan>
	<CAMxnaaXN7YwEDNGDR1aRbOqhj_2JFyQAiCSjqvTa500x_xRmLA@mail.gmail.com>
Date: Fri, 22 Apr 2016 02:26:22 +0200
Message-ID: <CAJZ5v0hwmyPz8J2YFc-fS51BpBkh6+TrtnZ1WJRhbDzsdrbqGA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] PCI: Add runtime PM support for PCIe ports
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Andreas Noever <andreas.noever@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Qipeng Zha <qipeng.zha@intel.com>,
	Qi Zheng <qi.zheng@intel.com>, Dave Airlie <airlied@gmail.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 22, 2016 at 1:25 AM, Andreas Noever
<andreas.noever@gmail.com> wrote:
> On Thu, Apr 21, 2016 at 9:19 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> On Thursday, April 21, 2016 04:12:24 PM Mika Westerberg wrote:
>>> On Wed, Apr 20, 2016 at 10:23:33PM +0200, Rafael J. Wysocki wrote:
>>> > Breaking any systems that work today is not an option.  if that
>>> > happens, the commit that has done that is a clear candidate for
>>> > reverting.
>>>
>>> Understood, thanks.
>>>
>>> BTW, do you have any preference regarding the cut-off date?
>>
>> Some time around when machines with Windows 10 started to ship should be
>> relatively safe.
>>
>> I guess we can just pick a reasonable date in the initial patch and then
>> try to move it back to the past subsequently and see if that breaks things
>> for anyone.
>
> Maybe add a boot option to overwrite the heuristic (in both
> directions) to allow people to test this on older machines and
> pinpoint breakage on newer machines?

Yes, a kernel command line override would be fine by me.
