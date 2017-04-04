Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 4 Apr 2017 14:03:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: kys@microsoft.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        vkuznets@redhat.com, jasowang@redhat.com,
        leann.ogasawara@canonical.com, marcelo.cerri@canonical.com,
        sthemmin@microsoft.com
Subject: Re: [PATCH 0/2] pci-hyperv: Some miscellaneous fixes
Message-ID: <20170404190331.GD27692@bhelgaas-glaptop.roam.corp.google.com>
References: <1490378800-26907-1-git-send-email-kys@exchange.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1490378800-26907-1-git-send-email-kys@exchange.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 24, 2017 at 11:06:40AM -0700, kys@exchange.microsoft.com wrote:
> From: K. Y. Srinivasan <kys@microsoft.com>
> 
> Some miscellaneous fixes.
> 
> K. Y. Srinivasan (2):
>   pci-hyperv: Fix a bug in specifying CPU affinity
>   pci-hyperv: Fix an atomic bug
> 
>  drivers/pci/host/pci-hyperv.c |   13 +++++++++----
>  1 files changed, 9 insertions(+), 4 deletions(-)

I applied these with Long's reviewed-by to pci/host-hv for v4.12 with the
following subject lines:

  PCI: hv: Specify CPU_AFFINITY_ALL for MSI affinity when >= 32 CPUs
  PCI: hv: Allocate interrupt descriptors with GFP_ATOMIC

There were two copies of [1/2], which makes this error-prone.  I applied
the second one that defines CPU_AFFINITY_ALL.

They're both marked for stable, but without any clue about when the
problems were introduced or how serious they are, I did not queue them for
v4.11.  If you want them in v4.11, please supply those additional details.

Bjorn
