Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:35068 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750839AbaBMOq0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 13 Feb 2014 09:46:26 -0500
Date: Thu, 13 Feb 2014 14:46:03 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Yijing Wang <wangyijing@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	David Airlie <airlied@linux.ie>,
	dri-devel@lists.freedesktop.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.ozlabs.org, linux-pcmcia@lists.infradead.org,
	linux-pci@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH 2/6] PCI/arm: Use list_for_each_entry() for bus
	traversal
Message-ID: <20140213144603.GX26684@n2100.arm.linux.org.uk>
References: <1392297243-61848-1-git-send-email-wangyijing@huawei.com> <1392297243-61848-2-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1392297243-61848-2-git-send-email-wangyijing@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 13, 2014 at 09:13:59PM +0800, Yijing Wang wrote:
> Replace list_for_each() + pci_bus_b() with the simpler
> list_for_each_entry().
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
