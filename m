Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp3.tech.numericable.fr ([82.216.111.39]:43045 "EHLO
	smtp3.tech.numericable.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751725AbbH1Sv2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 28 Aug 2015 14:51:28 -0400
Subject: Re: [PATCH] PCI: Disable async suspend/resume for Jmicron chip
To: Jay <MyMailClone@t-online.de>
References: <1438047747.1856.12.camel@rzhang1-mobl4>
 <1440750106.5982.2.camel@rzhang1-mobl4> <55E0A8BB.6020904@laposte.net>
 <2907359.7nsusuUeG0@linux-tez8>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>, chuansheng.liu@intel.com,
	Tejun Heo <tj@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Aaron Lu <aaron.lu@intel.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
From: Barto <mister.freeman@laposte.net>
Message-ID: <55E0AD63.1@laposte.net>
Date: Fri, 28 Aug 2015 20:50:11 +0200
MIME-Version: 1.0
In-Reply-To: <2907359.7nsusuUeG0@linux-tez8>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> 
> And are you sure you are already at kernel 4.6.1? ;)
> 
> Jay
> 

sorry, I meant "kernel 4.1.6", not 4.6.1 ;)

so I will wait the final version of this patch
