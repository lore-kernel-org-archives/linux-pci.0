Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:35597 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758235Ab2IJXoR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 10 Sep 2012 19:44:17 -0400
Received: by lbbgj3 with SMTP id gj3so1593664lbb.19
        for <linux-pci@vger.kernel.org>; Mon, 10 Sep 2012 16:44:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120909082717.63E5011FBF5@bugzilla.kernel.org>
References: <bug-18412-41252@https.bugzilla.kernel.org/> <20120909082717.63E5011FBF5@bugzilla.kernel.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 10 Sep 2012 17:43:53 -0600
Message-ID: <CAErSpo6mqXN=ujr=gBkHg0wmgf46ta2NaMuST3k8nOftGth7OA@mail.gmail.com>
Subject: Re: [Bug 18412] Intel DP43BF requires "pci=assign-busses" to discover
 some devices
To: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Cc: vl.homutov@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Sep 9, 2012 at 2:27 AM,  <bugzilla-daemon@bugzilla.kernel.org> wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=18412
>
> --- Comment #14 from VL <vl.homutov@gmail.com>  2012-09-09 08:27:17 ---
>> Given the [bus 20-08] range, I suspect that the patch in comment #9 may fix it,
>> and that's something we could apply.  Can you try just that patch on top of a
>> 3.5 or 3.6-rc4 kernel?
>
> yes, this patch fixes the problem.

Yinghai, you put the following (whitespace damaged) patch in the
bugzilla, and VL says it fixes his sytem.  He has a P2P bridge with
secondary > subordinate:

    pci 0000:00:1e.0: PCI bridge to [bus 20-08] (subtractive decode)

The current kernel doesn't probe behind this bridge, so it doesn't
find a couple devices.  With the patch below, we reassign the
secondary bus number from 20 to 08, so we do find those devices.

I'm slightly concerned that if we apply a patch like this, it removes
one way a BIOS could hide devices from the OS.  But maybe we don't
need to worry about that.  We have to configure hot-added P2P bridges
from scratch, so maybe we should be aggressive about fixing bridges
like this, too.

Are you comfortable enough with this patch to post it with a Signed-off-by?

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 3cdba8b..a8f1bf6 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -729,7 +729,8 @@ int __devinit pci_scan_bridge(struct pci_bus *bus,
struct pci_dev *dev, int max,

 	/* Check if setup is sensible at all */
 	if (!pass &&
-	    (primary != bus->number || secondary <= bus->number)) {
+	    (primary != bus->number || secondary <= bus->number ||
+	     secondary > subordinate)) {
 		dev_dbg(&dev->dev, "bus configuration invalid, reconfiguring\n");
 		broken = 1;
 	}
