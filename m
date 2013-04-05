Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:49791 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932572Ab3DEGrz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 5 Apr 2013 02:47:55 -0400
MIME-Version: 1.0
Date: Fri, 5 Apr 2013 12:17:54 +0530
Message-ID: <CAJ61zBAP3E6bSaKSm=qwxnMyY_BBkA9W=kOMg-QSv90wJc=iTw@mail.gmail.com>
Subject: [OT] LDD3 Query
From: Vijay Chauhan <kernel.vijay@gmail.com>
To: linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

I am new to Linux Device Driver and reading LDD3.

It mentions that the disadvantage of dynamic major number allocation
is that you can’t create the device nodes in
advance, because the major number assigned to your module will vary.

To solve this problem, it says that create a script to invoke insmod
and after calling insmod, reads /proc/devices in order to create the
special file(s).

My question is, is there no way to do it inside the module? How other
modules does?

---
Vijay
