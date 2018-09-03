Return-Path: <SRS0=vpWX=LR=endlessm.com=drake@kernel.org>
Return-Path: <SRS0=vpWX=LR=endlessm.com=drake@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180831191225.GA43106@bhelgaas-glaptop.roam.corp.google.com>
References: <20180831073057.14626-1-drake@endlessm.com> <20180831191225.GA43106@bhelgaas-glaptop.roam.corp.google.com>
From: Daniel Drake <drake@endlessm.com>
Date: Mon, 3 Sep 2018 16:56:32 +0800
Message-ID: <CAD8Lp45CKCHxTg91zF9bWztqbAwLzgAUpNEHQ6ouKu2PkJT8SQ@mail.gmail.com>
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
> If true, this sounds like some sort of erratum, so it would be good to
> get some input from Intel, and I cc'd a few Intel folks.

Yes, it would be great to get their input.

> It's interesting that all the systems below are from Asus.  That makes
> me think there's some BIOS or SMM connection, e.g., SMM traps the
> register write and does something magic.

Is there a way I can check if there is a SMM trap active for this address?

> Does this problem happen after a full system suspend/resume, or does
> it happen after runtime suspend of only the GPU?  Or runtime suspend
> of only the GPU and the upstream bridge?

runtime suspend/resume works fine. It only happens after S3 suspend.

> Can we tell whether Windows rewrites this register unconditionally at
> resume-time?  If so, it may be more robust for Linux to do the same.
> The whole thing is black magic, which I hate, but if it's our only
> choice, it may be better to have this applied everywhere so we don't
> keep stubbing our toes on new systems that require the quirk.

Any suggestions for how to make this happen? Booting windows in
virt-manager (hoping that I could then spy on PCI config space reg
accesses), I don't see an option for S3 suspend, but I'll keep looking
into this.

Thanks
Daniel
