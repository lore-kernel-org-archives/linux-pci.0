Return-Path: <SRS0=x0pv=LU=endlessm.com=drake@kernel.org>
Return-Path: <SRS0=x0pv=LU=endlessm.com=drake@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180831191225.GA43106@bhelgaas-glaptop.roam.corp.google.com>
References: <20180831073057.14626-1-drake@endlessm.com> <20180831191225.GA43106@bhelgaas-glaptop.roam.corp.google.com>
From: Daniel Drake <drake@endlessm.com>
Date: Thu, 6 Sep 2018 17:02:39 +0800
Message-ID: <CAD8Lp45z-rGaZeh8Cu6eMF03RCVtKdz4Z8+L4QQzO1+JX-L1yg@mail.gmail.com>
Subject: Re: [PATCH] PCI: add prefetch quirk to work around Asus/Nvidia
 suspend issues
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Linux Upstreaming Team <linux@endlessm.com>, nouveau@lists.freedesktop.org,
	Linux PM <linux-pm@vger.kernel.org>, Peter Wu <peter@lekensteyn.nl>, kherbst@redhat.com,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Keith Busch <keith.busch@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>, Jon Derrick <jonathan.derrick@intel.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Sat, Sep 1, 2018 at 3:12 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> Can we tell whether Windows rewrites this register unconditionally at
> resume-time?  If so, it may be more robust for Linux to do the same.
> The whole thing is black magic, which I hate, but if it's our only
> choice, it may be better to have this applied everywhere so we don't
> keep stubbing our toes on new systems that require the quirk.

Checked this with qemu adding a PCI-to-PCI bridge (ioh3420).

$ qemu-system-x86_64 -enable-kvm -M q35,accel=kvm -m 2G -vga qxl -cpu
host -hda testimg.img -device
ioh3420,id=rp1,bus=pcie.0,addr=1c.0,port=1 -trace events=events.txt

events.txt has:
pci_cfg_read
pci_cfg_write

Logged cfg space accesses during boot:
https://gist.github.com/dsd/135fb255cb2b237567d8ea2d6bfc6917#file-boot-txt

Suspend:
https://gist.github.com/dsd/135fb255cb2b237567d8ea2d6bfc6917#file-suspend-txt

Resume:
https://gist.github.com/dsd/135fb255cb2b237567d8ea2d6bfc6917#file-resume-txt

Notably during resume, the prefetch-related registers get rewritten:
  pci_cfg_write ioh3420 28:0 @0x24 <- 0xfeb0fea0
  pci_cfg_write ioh3420 28:0 @0x28 <- 0x0
  pci_cfg_write ioh3420 28:0 @0x2c <- 0x0

This happened even though there was nothing behind the bridge.
Windows failed to resume in this test (black screen) but the traced
register writes seem indicative enough.

Peter Wu confirms the same results in a similar experiment:
https://marc.info/?l=linux-pci&m=153616336225386&w=2

I'll look into creating a new patch that unconditionally reprograms
the PCI bridge prefetch stuff on resume.

Thanks
Daniel
