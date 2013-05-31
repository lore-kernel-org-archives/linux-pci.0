Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:61363 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751800Ab3EaDd7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 May 2013 23:33:59 -0400
Date: Fri, 31 May 2013 12:33:55 +0900
From: Tejun Heo <tj@kernel.org>
To: Shane Huang <shane.huang@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jean Delvare <khali@linux-fr.org>, linux-pci@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH 1/3] pci_ids: put Hudson-2 device IDs together
Message-ID: <20130531033355.GA31965@mtj.dyndns.org>
References: <1369999039-1983-1-git-send-email-shane.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1369999039-1983-1-git-send-email-shane.huang@amd.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 31, 2013 at 07:17:19PM +0800, Shane Huang wrote:
> To put all AMD Hudson-2 device IDs together for better maintenance.
> 
> Signed-off-by: Shane Huang <shane.huang@amd.com>

Bjorn, how should we route these patches?  The second will conflict
with the first.  If it's okay, I can take the first two through libata
tree.

Thanks.

-- 
tejun
