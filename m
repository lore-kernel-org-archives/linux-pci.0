Return-Path: <SRS0=2mbU=OH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D434C43441
	for <linux-pci@archiver.kernel.org>; Wed, 28 Nov 2018 21:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C312081B
	for <linux-pci@archiver.kernel.org>; Wed, 28 Nov 2018 21:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqbADwpP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6C312081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbeK2IXA (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 29 Nov 2018 03:23:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:39902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726188AbeK2IXA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Nov 2018 03:23:00 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15B3D2081B;
        Wed, 28 Nov 2018 21:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543440001;
        bh=Au0ai4isniIf5LJsBVixFVvOARWAsmlxT498yS1vRd4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gqbADwpPqICXEn59VIxTzaIH8LJlKno/OvyFtj/ivrkDQfyYEsdNBnA2HzULPDFSP
         pFs8jpjuispc88Sl8B9WjYWH88bTpFuSp00jJLwjJzTXmZpfc70i0In1ok/309dabb
         p70SnfiFZfHgASn9qCMNo3F1zbje9jxG3k0domy4=
Date:   Wed, 28 Nov 2018 15:19:59 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     bjorn@helgaas.com
Cc:     linux-pci@vger.kernel.org, Mertarg10@gmail.com,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Fwd: [Bug 201647] New: Intel Wireless card 3165 does not get
 detected but bluetooth works
Message-ID: <20181128211959.GB178809@google.com>
References: <bug-201647-193951@https.bugzilla.kernel.org/>
 <CABhMZUXc4FS-f52ZDsErEhbkm_jjEz+kn75YO5Tuvp42Qm+1xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABhMZUXc4FS-f52ZDsErEhbkm_jjEz+kn75YO5Tuvp42Qm+1xw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Emmanuel, LKML]

On Fri, Nov 09, 2018 at 03:43:06PM -0600, Bjorn Helgaas wrote:
> ---------- Forwarded message ---------
> From: <bugzilla-daemon@bugzilla.kernel.org>
> Date: Fri, Nov 9, 2018 at 4:10 AM
> Subject: [Bug 201647] New: Intel Wireless card 3165 does not get
> detected but bluetooth works
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=201647
> 
>             Bug ID: 201647
>            Summary: Intel Wireless card 3165 does not get detected but
>                     bluetooth works
>            Product: Drivers
>            Version: 2.5
>     Kernel Version: 4.19.1
>           Hardware: Intel
>                 OS: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: high
>           Priority: P1
>          Component: PCI
>           Assignee: drivers_pci@kernel-bugs.osdl.org
>           Reporter: Mertarg10@gmail.com
>         Regression: No
> 
> This bug affects most of the devices with a Celeron N4000 and an
> Intel wifi 3165 Ac adapter.
> 
> When using Linux wifi is not working however, Bluetooth is working
> fine.  Also, Bluetooth part of this chip is connected via btusb and
> the wifi part of this chip is connected via PCIe.

Can you attach a screenshot of the Windows 10 device manager info for
the wifi adapter to the bugzilla?  If you can get a raw hex dump of
its config space, that would be awesome.

Also attach a copy of your kernel .config file (typically in /boot/).

My only guess is that maybe the system keeps wifi completely powered
down and uses hotplug to add it when needed.  [1] mentions wifi being
on pcibus 1 under Windows.  Your lspci does show bridge 00:13.0
leading to bus 01, but Linux doesn't find any devices on bus 01.

Hotplug could be done via either acpiphp (ACPI mediated hotplug) or
pciehp (native PCIe hotplug).  Your dmesg shows you do have acpiphp.

I can't tell about pciehp (your .config will show that), but I think
pciehp will only claim bridges where SltCap contains HotPlug+, and
yours shows HotPlug-, so I don't think pciehp will do anything on your
system.

Even if the system does use hotplug, I don't know what mechanism the
OS would use to wake up the device, since we don't know it even
exists.  I guess there could be some magic switch accessible via USB.
But if that were the case, I'm sure Emmanuel would know about it.

[1] https://www.chinamobilemag.de/forum/hardware/3779-teclast-f5-linux-erkennt-kein-wlan-intel-3165-in-ubuntu-18-04-1.html?start=10
