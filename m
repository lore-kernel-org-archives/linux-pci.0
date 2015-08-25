Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:36867 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755956AbbHYUur (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Aug 2015 16:50:47 -0400
Received: by widdq5 with SMTP id dq5so25970586wid.0
        for <linux-pci@vger.kernel.org>; Tue, 25 Aug 2015 13:50:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQVMTpcWxg2Qw_DpPN4PpA4NkkDowOchrs6Wui_yOp-sgA@mail.gmail.com>
References: <1438047747.1856.12.camel@rzhang1-mobl4> <20150825024941.GA25829@google.com>
 <CAE9FiQVMTpcWxg2Qw_DpPN4PpA4NkkDowOchrs6Wui_yOp-sgA@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 25 Aug 2015 15:50:25 -0500
Message-ID: <CAErSpo41irSW890bW+EueFwTzjCHYnKLX=15=XDPxLdWUv38QA@mail.gmail.com>
Subject: Re: [PATCH] PCI: Disable async suspend/resume for Jmicron chip
To: Yinghai Lu <yinghai@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	Chuansheng Liu <chuansheng.liu@intel.com>,
	Tejun Heo <tj@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Aaron Lu <aaron.lu@intel.com>, Jay <MyMailClone@t-online.de>,
	Barto <mister.freeman@laposte.net>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 25, 2015 at 3:21 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Mon, Aug 24, 2015 at 7:49 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> commit 09981db5b0c9a6865aa39126b71bc87718577e4b
>> Author: Zhang Rui <rui.zhang@intel.com>
>> Date:   Mon Aug 24 15:27:11 2015 -0500
>>
>>     PCI: Disable async suspend/resume for JMicron multi-function SATA/AHCI
>>
>> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_JMICRON, PCI_ANY, PCI_CLASS_STORAGE_IDE, 8, quirk_jmicron_async_suspend);
>> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_JMICRON, PCI_ANY, PCI_CLASS_STORAGE_SATA_AHCI, 0, quirk_jmicron_async_suspend);
>
> s/PCI_ANY/PCI_ANY_ID/g

Done, thanks.
