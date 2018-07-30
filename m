Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726740AbeG3Ptm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Jul 2018 11:49:42 -0400
Date: Mon, 30 Jul 2018 09:14:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@kernel.org>
Cc: Rajat Jain <rajatja@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <keith.busch@intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Sinan Kaya <okaya@codeaurora.org>,
        Frederick Lawler <fred@fredlawl.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mayurkumar.patel@intel.com, rajatxjain@gmail.com,
        Richard Hughes <rhughes@redhat.com>,
        Carlos Garnacho <cgarnach@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pali Rohar <pali.rohar@gmail.com>,
        Takashi Iwai <tiwai@suse.de>,
        Andy Whitcroft <apw@canonical.com>,
        Colin Ian King <colin.king@canonical.com>
Subject: Re: [PATCH v2] pci/aspm: Remove CONFIG_PCIEASPM_DEBUG
Message-ID: <20180730141428.GK173328@bhelgaas-glaptop.roam.corp.google.com>
References: <20180508230148.121852-1-rajatja@google.com>
 <20180510233912.96454-1-rajatja@google.com>
 <20180727202619.GD173328@bhelgaas-glaptop.roam.corp.google.com>
 <5a102163-73bc-c596-8266-186e222e7ceb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5a102163-73bc-c596-8266-186e222e7ceb@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jul 28, 2018 at 05:16:13PM -0700, Sinan Kaya wrote:
> On 7/27/2018 1:26 PM, Bjorn Helgaas wrote:
> > - A link can lead to a multi-function device, and the spec allows
> >      those functions to have different ASPM settings (see PCIe r4.0,
> >      sec 5.4.1).  With the sysfs files at the upstream end of the link,
> >      we have no way to configure those functions individually.
> 
> Even though we can set them individually, there is only one PCIe link
> for single function as well as multi-function devices.
> 
> It would be a user mistake to allow individual PCIe functions with
> different ASPM policies. (maybe, we should enforce it if we are not
> doing it already).

It's true that multi-function devices share a single PCIe link.

However, the end of sec 5.4.1 does make it clear that the functions
need not have the same ASPM configuration, and it gives rules for how
those different settings should affect the shared link.  Since it
mentions different ASPM Control fields for the different functions, I
assume the policy combining those per-function settings into the
single link behavior must be implemented in the hardware.

Obviously we don't support per-function ASPM settings today.  I don't
know whether there's any value in supporting them or not, but putting
the control files at the upstream end basically precludes us from ever
supporting them.

Bjorn
