Return-Path: <SRS0=L200=SY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79564C10F11
	for <linux-pci@archiver.kernel.org>; Mon, 22 Apr 2019 13:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 494E820874
	for <linux-pci@archiver.kernel.org>; Mon, 22 Apr 2019 13:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555938498;
	bh=OE4Uyda6pp9S086SNamKpeWxD6ARSUpU/OWOpUwXii4=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Tc2Z7UjzW6zlLVM4VIOt+s6GshnXqDylHAj5V6ouGI3RuaEw/5vwjUwv6k5IMXQv8
	 BCrHJy7Nm+0gjMF6PYzOXwpGEn/5z661ysiGn7R2Tl9eww/D24ueJvDZgUZJ937ELm
	 ZuK8Y7a2weZFKZm4Zicbr8JQEnZ6kJpHH3NKef+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfDVNIR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 22 Apr 2019 09:08:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:47012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbfDVNIR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Apr 2019 09:08:17 -0400
Received: from localhost (50-82-46-41.client.mchsi.com [50.82.46.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 960FA20859;
        Mon, 22 Apr 2019 13:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555938495;
        bh=OE4Uyda6pp9S086SNamKpeWxD6ARSUpU/OWOpUwXii4=;
        h=Date:From:To:Cc:Subject:From;
        b=YmDnEgK/CJeBar11/fjiHBOK05AIv+g33sYeNoIqN+vNuAF5gbNqqRobUfqRh0/Wy
         G3NVLDtiTMM4OA3yeWLXFtIheCzC4lxX4E5MNUStLoApVHka7zzrwwNuSS0BodXcBi
         ihE/kh7F2y92TKOldBBexlPT+BSTrsW4izvpa6qc=
Date:   Mon, 22 Apr 2019 08:08:14 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     Keijo Vaara <ferdasyn@rocketmail.com>,
        Jean Delvare <jdelvare@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [Bug 203297] Synaptics touchpad TM-3127 functionality broken by PCI
 runtime power management patch on 4.20.2
Message-ID: <20190422130814.GJ173520@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=203297

Regression, suspected but as yet unconfirmed cause:

  c5eb1190074c ("PCI / PM: Allow runtime PM without callback functions")

backported to 4.20 stable as 39e1be324c2f.

Keijo Vaara <ferdasyn@rocketmail.com> reported:

> After upgrading from 4.20.1 to 4.20.2 Synaptics touchpad TM-3127 on HP
> 250 G5 is recognized in all logs like normal, but PCI runtime power
> management seems to keep it from working shortly after module
> initialization. Issuing "modprobe -r psmouse && modprobe psmouse" fixes
> the issue but the device stops working again if inactive for a second or
> so. This is likely caused by https://lkml.org/lkml/2019/1/11/615.
> 
> Possible workarounds known to work:
> 1) Forcing psmouse module to use imps protocol works, but disables most
> of the touchpad functionality such as two finger scrolling.
> 2) Disabling PCI runtime power management for the device (f.e. using tlp
> RUNTIME_PM_ON_BAT=on fixes the issue)
> 3) Downgrade kernel to 4.20.1
> 
> The bug has been reported by multiple users with different software
> setups, all with HP laptops (see
> https://bbs.archlinux.org/viewtopic.php?id=243677 for more info).
> 
> The suspect commit from kernel log:
> 
> commit 39e1be324c2f9048b013aaa190acf91b3f23b1a8
> Author: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Date:   Tue Oct 23 14:45:52 2018 +0300
> 
>     PCI / PM: Allow runtime PM without callback functions
>     
>     commit c5eb1190074cfb14c5d9cac692f1912eecf1a5e4 upstream.
>     
>     a9c8088c7988 ("i2c: i801: Don't restore config registers on runtime PM")
>     nullified the runtime PM suspend/resume callback pointers while keeping the
>     runtime PM enabled.
>     
>     This caused the SMBus PCI device to stay in D0 with
>     /sys/devices/.../power/runtime_status showing "error" when the runtime PM
>     framework attempted to autosuspend the device.  This is due to PCI bus
>     runtime PM, which checks for driver runtime PM callbacks and returns
>     -ENOSYS if they are not set.
>     
>     Since i2c-i801.c doesn't need to do anything device-specific for runtime
>     PM, Jean Delvare proposed this be fixed in the PCI core rather than adding
>     dummy runtime PM callback functions in the PCI drivers.
>     
>     Change pci_pm_runtime_suspend()/pci_pm_runtime_resume() so they allow
>     changing the PCI device power state during runtime PM transitions even if
>     the driver supplies no runtime PM callbacks.
>     
>     This fixes the runtime PM regression on i2c-i801.c.
>     
>     It is not obvious why the code previously required the runtime PM
>     callbacks.  The test has been there since the code was introduced by
>     6cbf82148ff2 ("PCI PM: Run-time callbacks for PCI bus type").
>     
>     On the other hand, a similar change was done to generic runtime PM
>     callbacks in 05aa55dddb9e ("PM / Runtime: Lenient generic runtime pm
>     callbacks").
>     
>     Fixes: a9c8088c7988 ("i2c: i801: Don't restore config registers on runtime PM")
>     Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>     Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Reviewed-by: Jean Delvare <jdelvare@suse.de>
>     Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>     Cc: stable@vger.kernel.org      # v4.18+
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
