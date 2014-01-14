Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 14 Jan 2014 14:44:19 -0800
From: David Cohen <david.a.cohen@linux.intel.com>
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org
Cc: bhelgaas@google.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Add Clovertrail and Merrifeld support to Intel MID
Message-ID: <20140114224419.GB9834@psi-dev26.jf.intel.com>
References: <1387224459-25746-1-git-send-email-david.a.cohen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1387224459-25746-1-git-send-email-david.a.cohen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 16, 2013 at 12:07:35PM -0800, David Cohen wrote:
> Hi,
> 
> I've a bunch of Intel MID patches under review but it seems they are becoming
> old and start to need changes.
> I gathered an up-to-date version of all of them in this single patch set.
> 
> This series implements support of Clovertrail and Merrifield to Intel MID.
> It also removes the unwanted X86_MDFLD option since *all* Intel MID platforms
> should be supported through CONFIG_X86_INTEL_MID option.
> 
> This makes obsolete the following patches:
> https://lkml.org/lkml/2013/10/18/480
> https://lkml.org/lkml/2013/10/22/533
> http://lkml.indiana.edu/hypermail/linux/kernel/1311.1/02937.html

Ping :)
Any comments on this whole patch set?

Br, David Cohen

> 
> Br, David
> 
> ---
> David Cohen (3):
>   x86: intel-mid: move Medfield code out of intel-mid.c core file
>   x86: intel-mid: add Merrifield platform support
>   x86: intel-mid: remove deprecated X86_MDFLD and X86_WANT_INTEL_MID
>     configs
> 
> Kuppuswamy Sathyanarayanan (1):
>   x86: intel-mid: add Clovertrail platform support
> 
>  arch/x86/Kconfig                                   |  29 +-----
>  arch/x86/include/asm/intel-mid.h                   |  48 +++++++++-
>  arch/x86/pci/intel_mid_pci.c                       |   6 +-
>  arch/x86/platform/intel-mid/Makefile               |   4 +-
>  arch/x86/platform/intel-mid/intel-mid.c            |  64 +++++++------
>  arch/x86/platform/intel-mid/intel_mid_weak_decls.h |  19 ++++
>  arch/x86/platform/intel-mid/mfld.c                 |  75 +++++++++++++++
>  arch/x86/platform/intel-mid/mrfl.c                 | 103 +++++++++++++++++++++
>  arch/x86/platform/intel-mid/sfi.c                  |  34 +++++--
>  9 files changed, 317 insertions(+), 65 deletions(-)
>  create mode 100644 arch/x86/platform/intel-mid/intel_mid_weak_decls.h
>  create mode 100644 arch/x86/platform/intel-mid/mfld.c
>  create mode 100644 arch/x86/platform/intel-mid/mrfl.c
> 
> -- 
> 1.8.4.2
