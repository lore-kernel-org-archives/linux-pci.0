Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ve0-f180.google.com ([209.85.128.180]:40852 "EHLO
	mail-ve0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086AbaCHSRy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 8 Mar 2014 13:17:54 -0500
Received: by mail-ve0-f180.google.com with SMTP id jz11so5440258veb.39
        for <linux-pci@vger.kernel.org>; Sat, 08 Mar 2014 10:17:53 -0800 (PST)
MIME-Version: 1.0
From: Andy Lutomirski <luto@amacapital.net>
Date: Sat, 8 Mar 2014 10:17:33 -0800
Message-ID: <CALCETrX0tn7WjTqnuQ5v+ZUJoJO2bbSb-ykzX5A3yssXKys8fg@mail.gmail.com>
Subject: sfc 0000:05:00.0 eth4: pci_enable_pcie_error_reporting failed (-5)
To: Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
	Network Development <netdev@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I think this is because my machine sets the FIRMWARE_FIRST flag.
Should this message be downgraded to KERN_INFO or even KERN_DEBUG?

--Andy
