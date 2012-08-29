Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:48675 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752628Ab2H2Nay (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 29 Aug 2012 09:30:54 -0400
Date: Wed, 29 Aug 2012 07:24:16 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: TJ <tj@iam.tj>
Cc: linux-pci@vger.kernel.org
Subject: Re: Limiting BAR resource  region size allocation (device claims
	2x what it needs) ?
Message-ID: <20120829132415.GA21160@parisc-linux.org>
References: <503E1027.6050104@iam.tj>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <503E1027.6050104@iam.tj>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 29, 2012 at 01:50:47PM +0100, TJ wrote:
> The CPU is 64-bit but the i945PM northbridge is 32-bit (so no physical > 4GB addressing). With PCI allocations as they are the system is limited to 2GB of RAM under Linux (3GB on Windows Vista).

According to the laptop specs, it's limited to 2GB RAM:

http://www.sony.co.uk/support/en/product/VGN-FE41Z/specifications

Personally, I'm not terribly excited about doing much work to enhance
a 6 year old laptop...

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
