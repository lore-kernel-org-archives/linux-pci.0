Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:64536 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752135Ab2EQQRS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 17 May 2012 12:17:18 -0400
Received: by lbbgm6 with SMTP id gm6so1424823lbb.19
        for <linux-pci@vger.kernel.org>; Thu, 17 May 2012 09:17:16 -0700 (PDT)
MIME-Version: 1.0
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 17 May 2012 10:16:56 -0600
Message-ID: <CAErSpo6vBpY3P1WiofhhRehVn_06MiSWYaHoz4-bUnciSp1v_A@mail.gmail.com>
Subject: [Bug 43192] various ExpressCards are not recognized
To: Elmar Stellnberger <estellnb@gmail.com>
Cc: bugzilla-daemon@bugzilla.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=43192

Hi Elmar, can you attach a complete dmesg log and "lspci -vv" output
to the bugzilla?  Let's start with the system with native ExpressCard
interface, with an ExpressCard plugged in before booting the system.
