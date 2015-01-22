Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:43952 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752522AbbAVOox (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 22 Jan 2015 09:44:53 -0500
Received: by mail-lb0-f175.google.com with SMTP id 10so697418lbg.6
        for <linux-pci@vger.kernel.org>; Thu, 22 Jan 2015 06:44:52 -0800 (PST)
MIME-Version: 1.0
Reply-To: pricardofc@gmail.com
In-Reply-To: <CAH9N0t9sMWhvJk-s9mzWf+FQUaFHeGNGbTLaVXx+0GhTcLQJbA@mail.gmail.com>
References: <CAH9N0t9sMWhvJk-s9mzWf+FQUaFHeGNGbTLaVXx+0GhTcLQJbA@mail.gmail.com>
Date: Thu, 22 Jan 2015 14:44:52 +0000
Message-ID: <CAH9N0t94=tywH+k6b0Qnq9cQVUnA+w9KnUnUMn6X=zgP9R3z9Q@mail.gmail.com>
Subject: ATCA PCI express hot add remove
From: Paulo Fortuna Carvalho <pricardofc@gmail.com>
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello.
I can add and remove an ATCA card with a PCIExpress endpoint. UDEV device
manager runs hotplug scripts ok and device files are created and removed
from system accdordingly. I'm trying now to run a script that on remove
kills running applications using a certain device before it is removed from
system. To do so I implement in my .rules file an entry regarding "remove"
that calls a script to perform that task. My problem is that before script
runs the device node is no longer there and my system crashes. Do you have
any idea on how can I run my script stopping the applications before device
remove procedure occurs?
Paulo.
