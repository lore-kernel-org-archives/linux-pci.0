Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp3.tech.numericable.fr ([82.216.111.39]:37445 "EHLO
	smtp3.tech.numericable.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943AbbH1Uhv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 28 Aug 2015 16:37:51 -0400
Subject: Re: [PATCH] PCI: Disable async suspend/resume for Jmicron chip
To: Bjorn Helgaas <bhelgaas@google.com>
References: <1438047747.1856.12.camel@rzhang1-mobl4>
 <1440750106.5982.2.camel@rzhang1-mobl4> <55E0A8BB.6020904@laposte.net>
 <2907359.7nsusuUeG0@linux-tez8> <55E0AD63.1@laposte.net>
 <CAErSpo56H99N_H3ffkYkwvdz92_HtB-9wJyWG9qGqgT6xCkwNQ@mail.gmail.com>
Cc: Jay <MyMailClone@t-online.de>, Zhang Rui <rui.zhang@intel.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	Chuansheng Liu <chuansheng.liu@intel.com>,
	Tejun Heo <tj@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Aaron Lu <aaron.lu@intel.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
From: Barto <mister.freeman@laposte.net>
Message-ID: <55E0C652.2000706@laposte.net>
Date: Fri, 28 Aug 2015 22:36:34 +0200
MIME-Version: 1.0
In-Reply-To: <CAErSpo56H99N_H3ffkYkwvdz92_HtB-9wJyWG9qGqgT6xCkwNQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I tested this patch on kernel 4.1.6, it's ok, no bugs, good job



Le 28/08/2015 21:19, Bjorn Helgaas a écrit :

> If you want to test this before v4.3-rc1, here it is:
> 
> https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=pci/misc&id=b95b73e30dfee0b96a3ecbb96c66486705701b9c
> 
> My plan is to merge this during the v4.3 merge window, so it will
> appear in v4.3.  I see that I probably should have added a stable tag
> as well.
> 
> Bjorn
> 
