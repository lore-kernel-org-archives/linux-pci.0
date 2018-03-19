Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 19 Mar 2018 13:51:19 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Myron Stowe <myron.stowe@redhat.com>,
        Paul Menzel <pmenzel+linux-pci@molgen.mpg.de>,
        Andreas Noever <andreas.noever@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 0/2] PCI: Update quirk timing
Message-ID: <20180319185119.GD77194@bhelgaas-glaptop.roam.corp.google.com>
References: <152103417018.167541.3290752859388672112.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <152103417018.167541.3290752859388672112.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 14, 2018 at 08:30:26AM -0500, Bjorn Helgaas wrote:
> This is a minor update of a patch I posted earlier [1] when Paul
> reported an unreasonably long time spent in PCI quirks during boot
> [2].  This doesn't fix the slow quirks, but might help find them.
> 
> We previously printed the time taken by each quirk if "initcall_debug"
> was specified.  With these patches, we'll print it even without
> "initcall_debug" if the quirk takes longer than 10ms.
> 
> I did notice one quirk (quirk_apple_poweroff_thunderbolt()) in the
> suspend path that sleeps for 300ms, so this will probably make suspend
> noisier on Apple systems.
> 
> [1] https://lkml.kernel.org/r/20171228212723.GB211339@bhelgaas-glaptop.roam.corp.google.com
> [2] https://lkml.kernel.org/r/44cada166e42007d27b4c3e3aa0744d7@molgen.mpg.de
> 
> ---
> 
> Bjorn Helgaas (2):
>       PCI: Report quirk timings with pci_info() instead of pr_debug()
>       PCI: Report quirks that take more than 10ms
> 
> 
>  drivers/pci/quirks.c |   24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)

Applied to pci/misc for v4.17.
