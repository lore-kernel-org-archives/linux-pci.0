Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from na3sys010aog111.obsmtp.com ([74.125.245.90]:52888 "HELO
	na3sys010aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753540AbaHLWaX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 12 Aug 2014 18:30:23 -0400
Received: by mail-pa0-f47.google.com with SMTP id kx10so13787184pab.34
        for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2014 15:30:22 -0700 (PDT)
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] PCI: pciehp: Use ordered workqueue for HPC events
From: Sandeep S Mann <sandeep@purestorage.com>
In-Reply-To: <20140812213626.GA6333@google.com>
Date: Tue, 12 Aug 2014 15:30:21 -0700
Cc: linux-pci@vger.kernel.org, Rajat Jain <rajatxjain@gmail.com>
Message-Id: <361417F9-AEA8-4C83-BD04-D5DD8CD4A391@purestorage.com>
References: <1406933232-1560-1-git-send-email-sandeep@purestorage.com> <20140812213626.GA6333@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


> Did you find this by code inspection, or did you actually observe a
> problem?  If the latter, what were the symptoms?
> 
> shpchp does the same thing, so I assume it requires the same fix.

Hi Bjorn,

This issue was observed on a system, where I was experimenting with
pcie hot-plug and the device being hot plugged is not the most well
behaved.  It exhibits the following behavior:

  - Initialization of the device can take “relatively” long (order 100s ms)
  - On hot add the link presence can toggle before stabilizing

The toggle of device presence can generate multiple events on a single
hot plug, where one hot add event can lead to following events
ADD->REMOVE->ADD.  And given the device can take some time to initialize,
we can have three HP events being processed concurrently.

Also note this seen with surprise ADD and REMOVE.

S


