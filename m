Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:38823 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756093AbbBGWD2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 7 Feb 2015 17:03:28 -0500
Received: by iecvy18 with SMTP id vy18so8968238iec.5
        for <linux-pci@vger.kernel.org>; Sat, 07 Feb 2015 14:03:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAErSpo7yiW0gOuHhvjuge84EG_eoyezLPSLT20x=fKxnu2RDDQ@mail.gmail.com>
References: <1423011246-14429-1-git-send-email-yinghai@kernel.org>
	<CAErSpo6MV_obn_31J3zTSfR0ke7kNYdr0mxgyuMYstr5RJcQHA@mail.gmail.com>
	<CAE9FiQXsk3WK2K6nXrcFczY8oNhn=AiW--Ks7xT+0e_3Z-HHDg@mail.gmail.com>
	<CAErSpo7yiW0gOuHhvjuge84EG_eoyezLPSLT20x=fKxnu2RDDQ@mail.gmail.com>
Date: Sat, 7 Feb 2015 14:03:27 -0800
Message-ID: <CAE9FiQVp8tQ+0UtNy1KNksBfBDy_eTt46d_86w555budeFUzmg@mail.gmail.com>
Subject: Re: [PATCH] PCI: disable auto realloc detection for lsi devices
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	pjay@nwtrail.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Feb 7, 2015 at 1:12 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:

> It sounds like you think it's standard practice for BIOSes to disable
> and re-enable the link after programming BARs?  I'm not confident
> about that because I don't think there's anything in the spec that
> would suggest that.

That should be Firmware bug, it could save the BAR or bus info, and use them
to trap some operation from host.

I still remember that hotplug sometime does not with some LSI cards, as
firmware trap the pci conf access and not respond in time.
If I erase the firmware, the silicon always respond to host pci conf in time.

I think we can not say they violate the spec, but that is definitely not a good
practice of development.

Yinghai
