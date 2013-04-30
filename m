Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:65463 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752441Ab3D3GFc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 30 Apr 2013 02:05:32 -0400
Received: by mail-ob0-f178.google.com with SMTP id 16so130603obc.23
        for <linux-pci@vger.kernel.org>; Mon, 29 Apr 2013 23:05:32 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 30 Apr 2013 14:05:31 +0800
Message-ID: <CAAh6nkkFDt+N5MWAq4qEmKqLxkTmgKh4VXGauY8R_QUOxp4cFg@mail.gmail.com>
Subject: About the acpiphp sub-driver dependecy in drivers/pci/hotplug/Makefile
From: Gavin Guo <tuffkidtt@gmail.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jiang Liu <jiang.liu@huawei.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Yinghai Lu <yinghai@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi all,

I saw the following lines in drivers/pci/hotplug/Makefile.

# native drivers should be linked before acpiphp in order to allow the
# native driver to attempt to bind first. We can then fall back to
# generic support.

If there is any need to remove these lines. Since the acpiphp is no
longer have the sub-driver dependency issue, right?

Gavin Guo
