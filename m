Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:50616 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759520Ab3D3LaQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 30 Apr 2013 07:30:16 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Gavin Guo <tuffkidtt@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jiang Liu <jiang.liu@huawei.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: About the acpiphp sub-driver dependecy in drivers/pci/hotplug/Makefile
Date: Tue, 30 Apr 2013 13:38:19 +0200
Message-ID: <1866616.Hv3VGVdRpd@vostro.rjw.lan>
In-Reply-To: <CAAh6nkkFDt+N5MWAq4qEmKqLxkTmgKh4VXGauY8R_QUOxp4cFg@mail.gmail.com>
References: <CAAh6nkkFDt+N5MWAq4qEmKqLxkTmgKh4VXGauY8R_QUOxp4cFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, April 30, 2013 02:05:31 PM Gavin Guo wrote:
> Hi all,
> 
> I saw the following lines in drivers/pci/hotplug/Makefile.
> 
> # native drivers should be linked before acpiphp in order to allow the
> # native driver to attempt to bind first. We can then fall back to
> # generic support.
> 
> If there is any need to remove these lines. Since the acpiphp is no
> longer have the sub-driver dependency issue, right?

Yes, I think they should be removed.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
