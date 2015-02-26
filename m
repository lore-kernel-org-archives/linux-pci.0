Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:38786 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822AbbBZGCn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Feb 2015 01:02:43 -0500
Received: by iecrd18 with SMTP id rd18so11381477iec.5
        for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2015 22:02:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20150226002833.GS6220@google.com>
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
	<20150226002833.GS6220@google.com>
Date: Wed, 25 Feb 2015 22:02:42 -0800
Message-ID: <CAE9FiQXgX4iJSvgRaBq9Xk-0jWZHPmshU8dgWyqKsNOG1zgXJA@mail.gmail.com>
Subject: Re: [problem] mpt2sas load fails with LSISAS2008
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Paul Johnson <pjay@nwtrail.com>,
	linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 25, 2015 at 4:28 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Thu, Feb 19, 2015 at 03:40:41PM -0800, Paul Johnson wrote:
>
> Right now, all I know is "mpt2sas worked in 3.4, it stopped working in
> 3.4.1, and this patch fixes it."
>
> What I don't know is what changed in 3.4.1 to break it.

We enable auto detection to enable realloc automatically for SRIOV case.

and after pci realloc pci bar for lsi get new assigned values.

assume even 3.4 if passing pci=realloc will make lsi card stop working.

Thanks

Yinghai
