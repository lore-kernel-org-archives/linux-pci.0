Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44]:36742 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752829AbbBZA2h (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Feb 2015 19:28:37 -0500
Received: by mail-qg0-f44.google.com with SMTP id j5so6150766qga.3
        for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2015 16:28:37 -0800 (PST)
Date: Wed, 25 Feb 2015 18:28:33 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Paul Johnson <pjay@nwtrail.com>
Cc: Yinghai Lu <yinghai@kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>
Subject: Re: [problem] mpt2sas load fails with LSISAS2008
Message-ID: <20150226002833.GS6220@google.com>
References: <CAE9FiQUT5j1PDw5c0X-k_E+0TbwCdrX1nbqk8rKzxAKxRLqvEg@mail.gmail.com>
 <54D160B5.70006@nwtrail.com>
 <CAE9FiQVjiCSj21eqevBOYz42o=aiPPMLM_g+65v8CJWgcdq=pg@mail.gmail.com>
 <54D6C6CB.6060904@nwtrail.com>
 <CAE9FiQW+z0GtUXCTnr42N7pQ-3xVTe_3EsmkAhWk7ehkZDq_Qw@mail.gmail.com>
 <54D7AE67.1090007@nwtrail.com>
 <CAErSpo4ZYfs9EhdZMXGdjbDY4WUfTNFz+CPBq-Gx3eQ563Fogw@mail.gmail.com>
 <54DB7F39.8030306@nwtrail.com>
 <CAErSpo6z1GmTkLQJDhBZxRU2wjCZiYsFBETi18vsYVNzOBi6VA@mail.gmail.com>
 <54E67479.3020906@nwtrail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <54E67479.3020906@nwtrail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 19, 2015 at 03:40:41PM -0800, Paul Johnson wrote:
> ...
> The 3.4.0 and 3.4.1 kernels I used came from here:
> http://kernel.ubuntu.com/~kernel-ppa/mainline/?C=N;O=D
> 
> A dmesg with the newer firmware and 3.19 from the same url is
> attached to the bug report
> https://bugzilla.kernel.org/show_bug.cgi?id=92351 as attachment:
> dmesg with 3.19 and LSI FW 18

Sorry, I haven't forgotten this, but I haven't had a chance to look at it
yet.  Yinghai, have you?  I'd like to have a better understanding of why we
are seeing the problem before we apply a workaround.

Right now, all I know is "mpt2sas worked in 3.4, it stopped working in 
3.4.1, and this patch fixes it."

What I don't know is what changed in 3.4.1 to break it.

Bjorn
