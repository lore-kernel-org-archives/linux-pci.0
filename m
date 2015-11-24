Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58846 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751292AbbKXSuB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 24 Nov 2015 13:50:01 -0500
Date: Tue, 24 Nov 2015 12:49:57 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mathias Krause <minipli@googlemail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Sasha Levin <sasha.levin@oracle.com>,
	Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH v2] PCI: Prevent out of bounds access in numa_node
 override - part 2
Message-ID: <20151124184957.GB27957@localhost>
References: <1447095627-12798-1-git-send-email-minipli@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1447095627-12798-1-git-send-email-minipli@googlemail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 09, 2015 at 08:00:27PM +0100, Mathias Krause wrote:
> Commit 1266963170f5 ("PCI: Prevent out of bounds access in numa_node
> override") missed that the user provided node could also be negative.
> Handle this case as well to avoid out-of-bounds accesses to the
> node_states[] array.  However, allow the special value -1, i.e.
> NUMA_NO_NODE, to be able to set the 'no specific node' configuration.
> 
> Fixes: 1266963170f5 ("PCI: Prevent out of bounds access in numa_node...")
> Signed-off-by: Mathias Krause <minipli@googlemail.com>
> Cc: Sasha Levin <sasha.levin@oracle.com>
> Cc: Prarit Bhargava <prarit@redhat.com>
> Cc: stable@vger.kernel.org	# v3.19+

Applied as tweaked below to for-linus for v4.4, thanks!  As written,
if NUMA_NO_NODE were defined as -2, we would incorrectly accept -1.
Let me know if you disagree with my fix.

> ---
> v2: allow NUMA_NO_NODE
> 
>  drivers/pci/pci-sysfs.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 92618686604c..6e9818227b19 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -216,7 +216,10 @@ static ssize_t numa_node_store(struct device *dev,
>  	if (ret)
>  		return ret;
>  
> -	if (node >= MAX_NUMNODES || !node_online(node))
> +	if (node < NUMA_NO_NODE || node >= MAX_NUMNODES)
> +		return -EINVAL;
> +
> +	if (node != NUMA_NO_NODE && !node_online(node))
>  		return -EINVAL;
>  
>  	add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);



commit 2a35194c5a45fbb9ca1d88bc56804dfb51a75233
Author: Mathias Krause <minipli@googlemail.com>
Date:   Mon Nov 9 20:00:27 2015 +0100

    PCI: Prevent out of bounds access in numa_node override
    
    Commit 1266963170f5 ("PCI: Prevent out of bounds access in numa_node
    override") missed that the user-provided node could also be negative.
    Handle this case as well to avoid out-of-bounds accesses to the
    node_states[] array.  However, allow the special value -1, i.e.
    NUMA_NO_NODE, to be able to set the 'no specific node' configuration.
    
    [bhelgaas: remove assumption that NUMA_NO_NODE == -1]
    Fixes: 1266963170f5 ("PCI: Prevent out of bounds access in numa_node override")
    Fixes: 63692df103e9 ("PCI: Allow numa_node override via sysfs")
    Signed-off-by: Mathias Krause <minipli@googlemail.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    CC: Sasha Levin <sasha.levin@oracle.com>
    CC: Prarit Bhargava <prarit@redhat.com>
    CC: stable@vger.kernel.org	# v3.19+

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 9261868..50f4747 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -216,7 +216,12 @@ static ssize_t numa_node_store(struct device *dev,
 	if (ret)
 		return ret;
 
-	if (node >= MAX_NUMNODES || !node_online(node))
+	if (node < 0 || node >= MAX_NUMNODES) {
+		if (node != NUMA_NO_NODE)
+			return -EINVAL;
+	}
+
+	if (node != NUMA_NO_NODE && !node_online(node))
 		return -EINVAL;
 
 	add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
