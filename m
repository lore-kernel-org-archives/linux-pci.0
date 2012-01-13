Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:35682 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753535Ab2AMX23 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jan 2012 18:28:29 -0500
Received: by ghbg16 with SMTP id g16so1160221ghb.19
        for <linux-pci@vger.kernel.org>; Fri, 13 Jan 2012 15:28:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20120113163922.GH7380@ram-ThinkPad-T61>
References: <1323247984-15281-1-git-send-email-yinghai@kernel.org>
	<1323247984-15281-3-git-send-email-yinghai@kernel.org>
	<20120113163922.GH7380@ram-ThinkPad-T61>
Date: Fri, 13 Jan 2012 15:28:29 -0800
Message-ID: <CAE9FiQWTVA=LDViVyfSXX6thgGv4TzOpqidVyG6FAdWQqAMWEg@mail.gmail.com>
Subject: Re: [PATCH 2/5] PCI: Try to assign required+option size at first
From: Yinghai Lu <yinghai@kernel.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 13, 2012 at 8:39 AM, Ram Pai <linuxram@us.ibm.com> wrote:
> On Wed, Dec 07, 2011 at 12:53:01AM -0800, Yinghai Lu wrote:
>
>        I am worried that this approach will resurface old bug
> https://bugzilla.kernel.org/show_bug.cgi?id=15960

will ask them to test for-pci2 branch.

>
>        With your approach; on a system with not enough resources to satisfy
> all the devices, when you fail to allocate 'required+optional' in the first
> round and fall back to assigning only the 'required' resources, you can get the
> reassignment order wrong, thus not allocate resources to devices for which the
> BIOS had originally allocated resources, and hence end up disabling the device.

so even required can not be satisfied?

Thanks

Yinghai
