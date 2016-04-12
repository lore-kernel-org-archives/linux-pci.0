Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:36587 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933812AbcDLS24 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Apr 2016 14:28:56 -0400
Received: by mail-io0-f196.google.com with SMTP id s2so3758713iod.3
        for <linux-pci@vger.kernel.org>; Tue, 12 Apr 2016 11:28:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <570827D5.5060201@ti.com>
References: <570827D5.5060201@ti.com>
Date: Tue, 12 Apr 2016 13:28:55 -0500
Message-ID: <CAA8O7CpAB18JOC6ri9xf_hnrKqRAjv5TdPO1cEHfd+98BhhV7A@mail.gmail.com>
Subject: Re: Hot reset in downstream direction (RC to EP)
From: L H <swdevgid@gmail.com>
To: Murali Karicheri <m-karicheri2@ti.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I've never observed a hot reset during enumeration.  One of the
possible triggers for the RC to issue a hot reset is after receipt of
a fatal AER message (assuming AER is enabled).

Lance

On Fri, Apr 8, 2016 at 4:51 PM, Murali Karicheri <m-karicheri2@ti.com> wrote:
> I see that hot reset is something the RC port initiate to have EP reset
> through link management.
>
> ==========================================================================
> PCIe reset sequences – The PCI Express protocol specifies a hot reset
> mechanism, where downstream components reset through link notification.
> Root ports should validate that this mechanism can be applied and the
> hot reset indication is properly detected by a remote device.
> Endpoint applications should determine the level of chip reset desired
> in case of hot reset detection on the link to validate proper functionality.
> ===========================================================================
>
> Does this happen during the enumeration? As this goes in in band, the EP's
> link should be up. Can someone tell me what are the triggering points for
> this from RC to EP? Does Linux RC support this? It is supposed to a bit
> in RC's bridge configuration space that triggers this reset.
>
> --
> Murali Karicheri
> Linux Kernel, Keystone
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
