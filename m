Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:44224 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752200AbaCXRL2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 24 Mar 2014 13:11:28 -0400
Received: by mail-ie0-f170.google.com with SMTP id rd18so5846010iec.15
        for <linux-pci@vger.kernel.org>; Mon, 24 Mar 2014 10:11:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAMxnaaVQLuExn_aEzY7QrxHiJ8Y0ZmG-EcDCuXyxH=rUdm-B6A@mail.gmail.com>
References: <CAMxnaaVQLuExn_aEzY7QrxHiJ8Y0ZmG-EcDCuXyxH=rUdm-B6A@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 24 Mar 2014 11:11:05 -0600
Message-ID: <CAErSpo5yOEqHZmWZ3j8NQs_DapmkegDTm8uLJCS2uCKvTvtT6Q@mail.gmail.com>
Subject: Re: how to trigger pcieport runtime suspend?
To: Andreas Noever <andreas.noever@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux PM list <linux-pm@vger.kernel.org>,
	Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Rafael, Pavel, linux-pm]

On Sun, Mar 23, 2014 at 12:16 PM, Andreas Noever
<andreas.noever@gmail.com> wrote:
> The pcieport driver defines runtime_suspend and runtime_resume methods
> (pcie_port_runtime_suspend/resume in portdrv_pci.c). I am trying to
> trigger that code. But I cannot get power/runtime_usage to drop to
> zero.
>
> Initially power/runtime_usage is set to 2. The 2 comes (imho) from:
> pci_pm_init -> pm_runtime_forbid
> local_pci_probe -> pm_runtime_get_sync
>
> The pm_runtime_forbid can be undone with echo auto > power/control,
> but the second one seems to never go away. local_pci_probe spots the
> following comment:
> "If the driver supports runtime PM, it should call
> pm_runtime_put_noidle() in its probe routine and
> pm_runtime_get_noresume() in its remove routine." I cannot find any
> such calls in the pcieport driver (or in the port service drivers).
>
> What am I missing?
>
> Thanks,
> Andreas
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
