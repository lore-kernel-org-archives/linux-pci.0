Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:33510 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752588AbbHYUVI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Aug 2015 16:21:08 -0400
Received: by iods203 with SMTP id s203so201514070iod.0
        for <linux-pci@vger.kernel.org>; Tue, 25 Aug 2015 13:21:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150825024941.GA25829@google.com>
References: <1438047747.1856.12.camel@rzhang1-mobl4>
	<20150825024941.GA25829@google.com>
Date: Tue, 25 Aug 2015 13:21:07 -0700
Message-ID: <CAE9FiQVMTpcWxg2Qw_DpPN4PpA4NkkDowOchrs6Wui_yOp-sgA@mail.gmail.com>
Subject: Re: [PATCH] PCI: Disable async suspend/resume for Jmicron chip
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Zhang Rui <rui.zhang@intel.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	Chuansheng Liu <chuansheng.liu@intel.com>,
	Tejun Heo <tj@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Aaron Lu <aaron.lu@intel.com>, MyMailClone@t-online.de,
	mister.freeman@laposte.net, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 24, 2015 at 7:49 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> commit 09981db5b0c9a6865aa39126b71bc87718577e4b
> Author: Zhang Rui <rui.zhang@intel.com>
> Date:   Mon Aug 24 15:27:11 2015 -0500
>
>     PCI: Disable async suspend/resume for JMicron multi-function SATA/AHCI
>
> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_JMICRON, PCI_ANY, PCI_CLASS_STORAGE_IDE, 8, quirk_jmicron_async_suspend);
> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_JMICRON, PCI_ANY, PCI_CLASS_STORAGE_SATA_AHCI, 0, quirk_jmicron_async_suspend);

s/PCI_ANY/PCI_ANY_ID/g
