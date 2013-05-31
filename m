Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usmamail.tilera.com ([12.216.194.151]:58740 "EHLO
	USMAMAIL.TILERA.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138Ab3EaUMe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 31 May 2013 16:12:34 -0400
Message-ID: <51A90430.8010609@tilera.com>
Date: Fri, 31 May 2013 16:12:32 -0400
From: Chris Metcalf <cmetcalf@tilera.com>
MIME-Version: 1.0
To: Jiang Liu <liuj97@gmail.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Jiang Liu <jiang.liu@huawei.com>,
	"Rafael J . Wysocki" <rjw@sisk.pl>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Gu Zheng <guz.fnst@cn.fujitsu.com>,
	Toshi Kani <toshi.kani@hp.com>,
	Myron Stowe <myron.stowe@redhat.com>,
	Yijing Wang <wangyijing@huawei.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH v3, part1 04/10] PCI: mark pci_scan_bus_parented() as
 __deprecated
References: <1369489718-25869-1-git-send-email-jiang.liu@huawei.com> <1369489718-25869-5-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1369489718-25869-5-git-send-email-jiang.liu@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 5/25/2013 9:48 AM, Jiang Liu wrote:
> Mark pci_scan_bus_parented() as __deprecated and clean up outdated
> comments.
>
> Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
> Cc: Chris Metcalf <cmetcalf@tilera.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Thierry Reding <thierry.reding@avionic-design.de>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pci@vger.kernel.org

Acked-by: Chris Metcalf <cmetcalf@tilera.com> [for tile]

Boy, that's one stale comment - it was put in internally in our tree back in 2008 when we were still on 2.6.18.

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com

