Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 4 Sep 2012 14:45:18 +0100
From: Matthew Garrett <mjg@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-efi@vger.kernel.org, mfleming@intel.com, dwmw2@infradead.org
Subject: Re: [PATCH V3 1/4] EFI: Stash ROMs if they're not in the PCI BAR
Message-ID: <20120904134518.GF18151@srcf.ucam.org>
References: <1345739803-21017-1-git-send-email-mjg@redhat.com>
 <1345739803-21017-2-git-send-email-mjg@redhat.com>
 <CAErSpo4Y=z-sP6cjJSzCtD-Gsnrm6-CWWKJpqiScv6QdbzTeyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo4Y=z-sP6cjJSzCtD-Gsnrm6-CWWKJpqiScv6QdbzTeyA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 23, 2012 at 05:44:22PM -0600, Bjorn Helgaas wrote:
> On Thu, Aug 23, 2012 at 10:36 AM, Matthew Garrett <mjg@redhat.com> wrote:
> > EFI provides support for providing PCI ROMs via means other than the ROM
> > BAR. This support vanishes after we've exited boot services, so add support
> > for stashing copies of the ROMs in setup_data if they're not otherwise
> > available.
> 
> -ENO_SIGNED_OFF_BY
> 
> I'll add it if you confirm it.

Signed-off-by: Matthew Garrett <mjg@redhat.com>

-- 
Matthew Garrett | mjg59@srcf.ucam.org
