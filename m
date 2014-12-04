Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.citrix.com ([66.165.176.89]:48317 "EHLO SMTP.CITRIX.COM"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753850AbaLDLaR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 4 Dec 2014 06:30:17 -0500
Message-ID: <548045C6.2040104@citrix.com>
Date: Thu, 4 Dec 2014 11:30:14 +0000
From: David Vrabel <david.vrabel@citrix.com>
MIME-Version: 1.0
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
	<boris.ostrovsky@oracle.com>
Subject: Re: [PATCH v5 9/9] xen/pciback: Implement PCI reset slot or bus with
 'do_flr' SysFS attribute
References: <1417642834-20350-1-git-send-email-konrad.wilk@oracle.com> <1417642834-20350-10-git-send-email-konrad.wilk@oracle.com>
In-Reply-To: <1417642834-20350-10-git-send-email-konrad.wilk@oracle.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/12/14 21:40, Konrad Rzeszutek Wilk wrote:
> 
> Instead of doing all this complex dance, we depend on the toolstack
> doing the right thing. As such implement the 'do_flr' SysFS attribute
> which 'xl' uses when a device is detached or attached from/to a guest.
> It bypasses the need to worry about the PCI lock.

No.  Get pciback to add its own "reset" sysfs file (as I have repeatedly
proposed).

David
