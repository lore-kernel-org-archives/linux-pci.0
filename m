Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 7 Oct 2015 11:09:16 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Prarit Bhargava <prarit@redhat.com>
Cc: Sasha Levin <sasha.levin@oracle.com>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: prevent out of bounds access in numa_node override
Message-ID: <20151007160916.GB27633@localhost>
References: <1443995369-11399-1-git-send-email-sasha.levin@oracle.com>
 <20151006193627.GE29420@localhost>
 <561428CE.2040601@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <561428CE.2040601@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Prarit,

On Tue, Oct 06, 2015 at 04:02:22PM -0400, Prarit Bhargava wrote:
> On 10/06/2015 03:36 PM, Bjorn Helgaas wrote:
> > On Sun, Oct 04, 2015 at 05:49:29PM -0400, Sasha Levin wrote:
> >> Commit 63692df1 ("PCI: Allow numa_node override via sysfs") didn't check that
> >> the numa node provided by userspace is valid. Passing a node number too high
> >> would attempt to access invalid memory and trigger a kernel panic.
> >>
> >> Fixes: 63692df1 ("PCI: Allow numa_node override via sysfs")
> >> Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
> >> ---
> >>  drivers/pci/pci-sysfs.c |    2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> >> index 312f23a..e9abca8 100644
> >> --- a/drivers/pci/pci-sysfs.c
> >> +++ b/drivers/pci/pci-sysfs.c
> >> @@ -216,7 +216,7 @@ static ssize_t numa_node_store(struct device *dev,
> >>  	if (ret)
> >>  		return ret;
> >>  
> >> -	if (!node_online(node))
> >> +	if (node > MAX_NUMNODES || !node_online(node))
> > 
> > This needs to be "node >= MAX_NUMNODES", doesn't it?  I'll fix it up if
> > you agree.
> 
> Not a strenuous objection, but I don't see much bound checking using
> MAX_NUMNODES in the kernel outside of the core numa area.  Is fixing
> node_online() with bounds checking a better option here so that other callers
> get the fix?  I would have thought that calling node_online() with node >
> MAX_NUMNODES should be safe to call.

Yes, that would certainly be an option.  I don't feel super strongly
either way, but one argument in favor of Sasha's approach is that the
validation of user input is nice and obvious right at the point where
we process the input.

Bjorn
