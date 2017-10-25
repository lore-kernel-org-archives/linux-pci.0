Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp-out4.electric.net ([192.162.216.194]:64685 "EHLO
        smtp-out4.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750862AbdJYLT5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Oct 2017 07:19:57 -0400
Received: from 1e7Jiz-0000lP-W2 by out4a.electric.net with emc1-ok (Exim 4.87)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1e7Jj0-0000rS-Vg
        for linux-pci@vger.kernel.org; Wed, 25 Oct 2017 04:19:54 -0700
Received: from [156.67.243.126] (helo=AcuExch.aculab.com)
        by out4a.electric.net with esmtps (TLSv1:AES128-SHA:128)
        (Exim 4.87)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1e7Jiz-0000lP-W2
        for linux-pci@vger.kernel.org; Wed, 25 Oct 2017 04:19:53 -0700
From: David Laight <David.Laight@ACULAB.COM>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Recovering from driver-detected 'surprise removal'
Date: Wed, 25 Oct 2017 11:20:12 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD00A2675@AcuExch.aculab.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Is there an easy way for a driver get a pcie device removed
(as in echo 1 > /sys/devices/pcixxx/xxxx/remove)
and then force a rescan of the bus?

Clearly it could ask a daemon to do it - but finding the
correct entry in /sys/devices isn't entirely trivial.
(Or rather I don't know the trival way... )

The initial trigger would be a read returning ~0u.
But other things can be done to confirm the error.
eg: Reading config space and getting all zeros for the BARs
    indicating that the endpoint has reset itself.

	David
