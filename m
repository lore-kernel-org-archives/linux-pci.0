Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:42098 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752016Ab3LOWMX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 15 Dec 2013 17:12:23 -0500
Received: by mail-ie0-f182.google.com with SMTP id as1so5551598iec.41
        for <linux-pci@vger.kernel.org>; Sun, 15 Dec 2013 14:12:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20131215170417.GB28799@kroah.com>
References: <20131215063123.GB26396@localhost> <20131215170417.GB28799@kroah.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Sun, 15 Dec 2013 15:12:03 -0700
Message-ID: <CAErSpo4Usujp5zJT83-88T71J8tObJgZ03i-wORqLputxQbdXg@mail.gmail.com>
Subject: Re: BUG: key ffff8800192a6ad0 not in .data!
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Fengguang Wu <fengguang.wu@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Dec 15, 2013 at 10:04 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Sun, Dec 15, 2013 at 02:31:23PM +0800, Fengguang Wu wrote:
>> Greetings,
>>
>> I got the below dmesg and the first bad commit is
>
> I thought this was already fixed in Bjorn's tree, but perhaps he hasn't
> merged in the one-liner for it...

Yes, this is fixed.  I actually dropped that MSI change temporarily
until we can fold in the memory leak fixes, so it is not currently in
linux-next.

Bjorn
