Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:52934 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041Ab3LBSsc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Dec 2013 13:48:32 -0500
Date: Mon, 02 Dec 2013 13:48:29 -0500 (EST)
Message-Id: <20131202.134829.2041194874847967680.davem@davemloft.net>
To: mchan@broadcom.com
Cc: rjw@rjwysocki.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-pci@vger.kernel.org, bhelgaas@google.com, nsujir@broadcom.com
Subject: Re: [PATCH] PCI / tg3: Give up chip reset and carrier loss
 handling if PCI device is not present
From: David Miller <davem@davemloft.net>
In-Reply-To: <1385930359.6988.7.camel@LTIRV-MCHAN1.corp.ad.broadcom.com>
References: <7807315.7cU9KldDtM@vostro.rjw.lan>
	<1385930359.6988.7.camel@LTIRV-MCHAN1.corp.ad.broadcom.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: "Michael Chan" <mchan@broadcom.com>
Date: Sun, 1 Dec 2013 12:39:19 -0800

> I'm not familiar with the DS1.  Does the tg3 device get removed through
> tg3_remove_one() in this case?  What happens when you reconnect the DS1?

Michael, is Rafael's explanation sufficient for you?
