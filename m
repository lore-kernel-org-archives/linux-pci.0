Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1on0138.outbound.protection.outlook.com ([157.56.110.138]:9502
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755665AbbFLSUZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 12 Jun 2015 14:20:25 -0400
Date: Fri, 12 Jun 2015 11:20:13 -0700
From: Guenter Roeck <groeck@juniper.net>
To: Rajat Jain <rajatxjain@gmail.com>
CC: Yijing Wang <wangyijing@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: Use a local mutex instead of pci_bus_sem to avoid
 deadlock
Message-ID: <20150612182013.GA4455@svl-evodev-groeck.juniper.net>
References: <1434021134-6519-1-git-send-email-wangyijing@huawei.com>
 <557A9661.8030603@huawei.com>
 <CAA93t1ooSY2keDigmUPpO7LzvT12YwQjpxH0b1xA508LL+VWdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <CAA93t1ooSY2keDigmUPpO7LzvT12YwQjpxH0b1xA508LL+VWdg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 12, 2015 at 11:12:35AM -0700, Rajat Jain wrote:
> [+Guenter]
> 
> Looks good to me. Unfortunately, I do not have the hardware anymore to test
> it :-(
> 
> Guenter: Do you have it, or know some body who has and wants to test this?
> 
I'll dig up the patch and test it.

Guenter
