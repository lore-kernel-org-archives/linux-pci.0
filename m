Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40195 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754719AbbJGQFC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 7 Oct 2015 12:05:02 -0400
Date: Wed, 7 Oct 2015 11:04:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sasha Levin <sasha.levin@oracle.com>
Cc: Prarit Bhargava <prarit@redhat.com>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: prevent out of bounds access in numa_node override
Message-ID: <20151007160458.GA27633@localhost>
References: <1443995369-11399-1-git-send-email-sasha.levin@oracle.com>
 <20151006193627.GE29420@localhost>
 <561428CE.2040601@redhat.com>
 <56152725.10809@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56152725.10809@oracle.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 07, 2015 at 10:07:33AM -0400, Sasha Levin wrote:
> > On 10/06/2015 03:36 PM, Bjorn Helgaas wrote:
> >> Hi Sasha,
> >>
> >> On Sun, Oct 04, 2015 at 05:49:29PM -0400, Sasha Levin wrote:
> >>> Commit 63692df1 ("PCI: Allow numa_node override via sysfs") didn't check that
> >>> the numa node provided by userspace is valid. Passing a node number too high
> >>> would attempt to access invalid memory and trigger a kernel panic.
> >>>
> >>> Fixes: 63692df1 ("PCI: Allow numa_node override via sysfs")
> >>> Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
> >>> ---
> >>>  drivers/pci/pci-sysfs.c |    2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> >>> index 312f23a..e9abca8 100644
> >>> --- a/drivers/pci/pci-sysfs.c
> >>> +++ b/drivers/pci/pci-sysfs.c
> >>> @@ -216,7 +216,7 @@ static ssize_t numa_node_store(struct device *dev,
> >>>  	if (ret)
> >>>  		return ret;
> >>>  
> >>> -	if (!node_online(node))
> >>> +	if (node > MAX_NUMNODES || !node_online(node))
> >>
> >> This needs to be "node >= MAX_NUMNODES", doesn't it?  I'll fix it up if
> >> you agree.
> 
> Yup, you're right.

OK, applied to for-linus for v4.3 as follows.  Thanks a lot, Sasha!


commit 0f7b9ad7477f7ce9b30e9ab0048f6e726f11a08a
Author: Sasha Levin <sasha.levin@oracle.com>
Date:   Sun Oct 4 17:49:29 2015 -0400

    PCI: Prevent out of bounds access in numa_node override
    
    63692df103e9 ("PCI: Allow numa_node override via sysfs") didn't check that
    the numa node provided by userspace is valid.  Passing a node number too
    high would attempt to access invalid memory and trigger a kernel panic.
    
    Fixes: 63692df103e9 ("PCI: Allow numa_node override via sysfs")
    Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    CC: stable@vger.kernel.org	# v3.19+

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 312f23a..9261868 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -216,7 +216,7 @@ static ssize_t numa_node_store(struct device *dev,
 	if (ret)
 		return ret;
 
-	if (!node_online(node))
+	if (node >= MAX_NUMNODES || !node_online(node))
 		return -EINVAL;
 
 	add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
