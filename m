Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usmamail.tilera.com ([12.216.194.151]:7997 "EHLO
	USMAMAIL.TILERA.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754939Ab2HAVHZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 1 Aug 2012 17:07:25 -0400
Message-ID: <50199A8C.1070500@tilera.com>
Date: Wed, 1 Aug 2012 17:07:24 -0400
From: Chris Metcalf <cmetcalf@tilera.com>
MIME-Version: 1.0
To: Jiang Liu <liuj97@gmail.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Don Dutile <ddutile@redhat.com>,
	Jiang Liu <jiang.liu@huawei.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	"Rafael J . Wysocki" <rjw@sisk.pl>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Yijing Wang <wangyijing@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 14/32] PCI/tile: use PCIe capabilities access functions
 to simplify implementation
References: <1343836477-7287-1-git-send-email-jiang.liu@huawei.com> <1343836477-7287-15-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1343836477-7287-15-git-send-email-jiang.liu@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 8/1/2012 11:54 AM, Jiang Liu wrote:
> From: Jiang Liu <jiang.liu@huawei.com>
>
> Use PCIe capabilities access functions to simplify PCIe tile implementation.
>
> Signed-off-by: Jiang Liu <liuj97@gmail.com>
> ---
>  arch/tile/kernel/pci.c |   25 +++++--------------------
>  1 file changed, 5 insertions(+), 20 deletions(-)

Acked-by: Chris Metcalf <cmetcalf@tilera.com>

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com

