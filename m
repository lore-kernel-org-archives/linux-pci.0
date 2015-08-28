Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:33893 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752994AbbH1UyY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 28 Aug 2015 16:54:24 -0400
Received: by wiyy7 with SMTP id y7so10266359wiy.1
        for <linux-pci@vger.kernel.org>; Fri, 28 Aug 2015 13:54:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55E0C652.2000706@laposte.net>
References: <1438047747.1856.12.camel@rzhang1-mobl4> <1440750106.5982.2.camel@rzhang1-mobl4>
 <55E0A8BB.6020904@laposte.net> <2907359.7nsusuUeG0@linux-tez8>
 <55E0AD63.1@laposte.net> <CAErSpo56H99N_H3ffkYkwvdz92_HtB-9wJyWG9qGqgT6xCkwNQ@mail.gmail.com>
 <55E0C652.2000706@laposte.net>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 28 Aug 2015 15:54:03 -0500
Message-ID: <CAErSpo5_Y=HYXwoC43Uu-GWPHy9UoXY6+f+04PAz4gWP2h_48w@mail.gmail.com>
Subject: Re: [PATCH] PCI: Disable async suspend/resume for Jmicron chip
To: Barto <mister.freeman@laposte.net>
Cc: Jay <MyMailClone@t-online.de>, Zhang Rui <rui.zhang@intel.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	Chuansheng Liu <chuansheng.liu@intel.com>,
	Tejun Heo <tj@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Aaron Lu <aaron.lu@intel.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 28, 2015 at 3:36 PM, Barto <mister.freeman@laposte.net> wrote:
> I tested this patch on kernel 4.1.6, it's ok, no bugs, good job

Thanks, I added your Tested-by and a stable tag for v3.15+.

> Le 28/08/2015 21:19, Bjorn Helgaas a écrit :
>
>> If you want to test this before v4.3-rc1, here it is:
>>
>> https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=pci/misc&id=b95b73e30dfee0b96a3ecbb96c66486705701b9c
>>
>> My plan is to merge this during the v4.3 merge window, so it will
>> appear in v4.3.  I see that I probably should have added a stable tag
>> as well.
>>
>> Bjorn
>>
