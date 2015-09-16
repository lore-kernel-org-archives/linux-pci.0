Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:62492 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751112AbbIPFHc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 16 Sep 2015 01:07:32 -0400
Subject: Re: [Bugfix 0/3] Convert eata driver to a normal PCI device driver
To: Arthur Marsh <arthur.marsh@internode.on.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>
References: <CAErSpo4oignSpK-LCLO=deW_FZ-V58GUhBxJ5uvmXe4DYo4WdA@mail.gmail.com>
 <1442200140-30808-1-git-send-email-jiang.liu@linux.intel.com>
 <55F6EF40.50403@internode.on.net> <55F78306.3000802@linux.intel.com>
 <55F7C691.8000406@internode.on.net>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-scsi@vger.kernel.org, x86@kernel.org
From: Jiang Liu <jiang.liu@linux.intel.com>
Message-ID: <55F8F90D.2050703@linux.intel.com>
Date: Wed, 16 Sep 2015 13:07:25 +0800
MIME-Version: 1.0
In-Reply-To: <55F7C691.8000406@internode.on.net>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/9/15 15:19, Arthur Marsh wrote:
> 
> 
> Jiang Liu wrote on 15/09/15 12:01:
> 
>> HI Arthur,
>>     Really appreciate your help to test the patches. That's
>> a good sign we have moved forward a bit:)
>>     For kexec, it's always challenging to me. So could you
>> please help to provide full dmesg logs with working kernels
>> so I could try to figure out the order among scsi and PCI devices.
>> It may be shutdown order related.
>> Thanks!
>> Gerry
> 
> OK, attached is the dmesg output from the 4.2.0 kernel where kexec worked.
Hi Arthur,
	Could you please also help to capture the log messages
of kexec, I need to those log messages to figure out the order
to shutdown PCI devices and scsi devices during kexec.
Thanks!
Gerry
