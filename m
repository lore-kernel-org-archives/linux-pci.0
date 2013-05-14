Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ve0-f175.google.com ([209.85.128.175]:37216 "EHLO
	mail-ve0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797Ab3ENRFS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 May 2013 13:05:18 -0400
Received: by mail-ve0-f175.google.com with SMTP id cz11so917022veb.20
        for <linux-pci@vger.kernel.org>; Tue, 14 May 2013 10:05:16 -0700 (PDT)
Date: Tue, 14 May 2013 13:05:28 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiang Liu <liuj97@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Jiang Liu <jiang.liu@huawei.com>,
	"Rafael J . Wysocki" <rjw@sisk.pl>,
	Gu Zheng <guz.fnst@cn.fujitsu.com>,
	Toshi Kani <toshi.kani@hp.com>,
	Myron Stowe <myron.stowe@redhat.com>,
	Yijing Wang <wangyijing@huawei.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2, part 2 01/18] PCI: introduce hotplug-safe PCI bus
 iterators
Message-ID: <20130514170528.GA4030@kroah.com>
References: <1368550322-1045-1-git-send-email-jiang.liu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1368550322-1045-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 15, 2013 at 12:51:45AM +0800, Jiang Liu wrote:
> +EXPORT_SYMBOL(pci_bus_exists);

EXPORT_SYMBOL_GPL()?  Same for the other new exports?

thanks,

greg k-h
