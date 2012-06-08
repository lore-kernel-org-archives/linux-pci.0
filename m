Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1339142492-13625-1-git-send-email-xudong.hao@intel.com>
References: <1339142492-13625-1-git-send-email-xudong.hao@intel.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 8 Jun 2012 10:31:19 -0700
Message-ID: <CAErSpo5DHQv0wuipPWGd5nwzui1C3-ucWCuppe0Zpww55u4pxQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] PCI: Enable LTR/OBFF before device is used by driver
To: Xudong Hao <xudong.hao@intel.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, avi@redhat.com, alex.williamson@redhat.com,
	ddutile@redhat.com, myron.stowe@redhat.com, xiantao.zhang@intel.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 8, 2012 at 1:01 AM, Xudong Hao <xudong.hao@intel.com> wrote:
> The series of patches enable LTR and OBFF before device is used by driver, and
> introduce a couple of functions to save/restore LTR latency value.
>
> Patch 1/4 introduce new function pci_obff_supported() as pci_ltr_support().
>
> Patch 2/4 enable LTR(Latency tolerance reporting) before device is used by
> driver.
>
> Patch 3/4 enable OBFF(optimized buffer flush/fill) before device is used by
> driver.
>
> Patch 4/4 introduce a couple of functions pci_save_ltr_value() and
> pci_restore_ltr_value() to save and restore LTR latency value, while device is
> reset.

We need some justification for these patches.  Why do we want them?
Do they improve performance?  Reduce power consumption?  How have they
been tested?  How can we be confident that these features work
correctly on hardware in the field?  Should or could the BIOS enable
them itself, based on OEM testing and desire to support these
features?
