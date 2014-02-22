Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51408 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751132AbaBVJWi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 22 Feb 2014 04:22:38 -0500
Date: Sat, 22 Feb 2014 10:24:26 +0100
From: Alexander Gordeev <agordeev@redhat.com>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: linux-kernel@vger.kernel.org,
	Himanshu Madhani <himanshu.madhani@qlogic.com>,
	Rajesh Borundia <rajesh.borundia@qlogic.com>,
	Shahed Shaikh <shahed.shaikh@qlogic.com>,
	linux-driver@qlogic.com, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH net-next 28/35] qlcnic: Use pci_enable_msix_range()
 instead of pci_enable_msix()
Message-ID: <20140222092425.GA27897@dhcp-26-207.brq.redhat.com>
References: <cover.1392717502.git.agordeev@redhat.com>
 <cb8eb41f672c62d1149c375bdaf97ca3328703f9.1392717503.git.agordeev@redhat.com>
 <1393029870.15717.71.camel@deadeye.wl.decadent.org.uk>
 <1393030127.15717.72.camel@deadeye.wl.decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1393030127.15717.72.camel@deadeye.wl.decadent.org.uk>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Feb 22, 2014 at 12:48:47AM +0000, Ben Hutchings wrote:
> Sorry, I'm confused and this does work.  But I wonder whether it is
> really an improvement over using the old API.

Slightly, as far as I am concerned - we just exchange tri-state oddity
to re-enable MSI-X oddity. We're not going to improve drivers that can
not work with any number of MSI-Xs from a range, like this one.

> Ben.

-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
