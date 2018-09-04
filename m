Return-Path: <SRS0=19xT=LS=linux.intel.com=mika.westerberg@kernel.org>
Return-Path: <SRS0=19xT=LS=linux.intel.com=mika.westerberg@kernel.org>
Date: Tue, 4 Sep 2018 09:43:07 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Daniel Drake <drake@endlessm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Linux Upstreaming Team <linux@endlessm.com>,
	nouveau@lists.freedesktop.org, Linux PM <linux-pm@vger.kernel.org>,
	Peter Wu <peter@lekensteyn.nl>, kherbst@redhat.com,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Keith Busch <keith.busch@intel.com>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCH] PCI: add prefetch quirk to work around Asus/Nvidia
 suspend issues
Message-ID: <20180904064307.GM2283@lahna.fi.intel.com>
References: <20180831073057.14626-1-drake@endlessm.com>
 <20180831191225.GA43106@bhelgaas-glaptop.roam.corp.google.com>
 <CAD8Lp45CKCHxTg91zF9bWztqbAwLzgAUpNEHQ6ouKu2PkJT8SQ@mail.gmail.com>
 <20180903121209.GC2283@lahna.fi.intel.com>
 <CAD8Lp46M-raneN+6bjGakTq_yd6wGjuPiKDyOoqpO8VXyDBrfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAD8Lp46M-raneN+6bjGakTq_yd6wGjuPiKDyOoqpO8VXyDBrfQ@mail.gmail.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 04, 2018 at 09:52:02AM +0800, Daniel Drake wrote:
> # cat /proc/mtrr
> reg00: base=0x0c0000000 ( 3072MB), size= 1024MB, count=1: uncachable
> reg01: base=0x0a0000000 ( 2560MB), size=  512MB, count=1: uncachable
> reg02: base=0x090000000 ( 2304MB), size=  256MB, count=1: uncachable
> reg03: base=0x08c000000 ( 2240MB), size=   64MB, count=1: uncachable
> reg04: base=0x08b800000 ( 2232MB), size=    8MB, count=1: uncachable
> 
> # cat /sys/kernel/debug/x86/pat_memtype_list
> PAT memtype list:
> write-back @ 0x84a23000-0x84a24000
> write-back @ 0x8ad34000-0x8ad60000
> write-back @ 0x8ad5f000-0x8ad66000
> write-back @ 0x8ad5f000-0x8ad60000
> write-back @ 0x8ad65000-0x8ad6a000
> write-back @ 0x8ad69000-0x8ad6b000
> write-back @ 0x8ad6a000-0x8ad6c000
> write-back @ 0x8ad6b000-0x8ad6e000
> write-back @ 0x8ad9c000-0x8ad9d000
> write-back @ 0x8adce000-0x8adcf000
> write-back @ 0x8adcf000-0x8add0000
> write-back @ 0x8adcf000-0x8add2000
> write-back @ 0x8add3000-0x8add4000
> write-back @ 0x8ae04000-0x8ae05000
> write-back @ 0x8b208000-0x8b209000
> write-combining @ 0xc0000000-0xd0000000
> write-combining @ 0xd0000000-0xe0000000
> write-combining @ 0xe0000000-0xe0040000
> write-combining @ 0xe0040000-0xe0050000
> write-combining @ 0xe0050000-0xe0051000
> write-combining @ 0xe0051000-0xe0151000
> write-combining @ 0xe0151000-0xe0191000
> write-combining @ 0xe0191000-0xe01a1000
> write-combining @ 0xe01a1000-0xe01b1000
> write-combining @ 0xe01b1000-0xe01c1000
> write-combining @ 0xe01c1000-0xe01c3000
> write-combining @ 0xe01c3000-0xe01c5000
> write-combining @ 0xe01c5000-0xe01cd000
> write-combining @ 0xe01cd000-0xe01d5000
> write-combining @ 0xe01d5000-0xe01dd000
> write-combining @ 0xe01dd000-0xe01e5000
> write-combining @ 0xe01e5000-0xe01ed000
> write-combining @ 0xe01ed000-0xe01f5000
> write-combining @ 0xe01f5000-0xe01fd000
> write-combining @ 0xe01fd000-0xe0205000
> write-combining @ 0xe0205000-0xe020d000
> write-combining @ 0xe020d000-0xe0215000
> uncached-minus @ 0xed000000-0xed200000
> write-combining @ 0xed800000-0xee000000
> uncached-minus @ 0xee000000-0xef000000
> uncached-minus @ 0xef200000-0xef400000
> uncached-minus @ 0xef400000-0xef401000
> uncached-minus @ 0xef404000-0xef405000
> uncached-minus @ 0xef510000-0xef520000
> uncached-minus @ 0xef528000-0xef52c000
> uncached-minus @ 0xef533000-0xef534000
> uncached-minus @ 0xef533000-0xef534000
> uncached-minus @ 0xef533000-0xef534000
> uncached-minus @ 0xef534000-0xef535000
> uncached-minus @ 0xef534000-0xef535000
> uncached-minus @ 0xef534000-0xef535000
> uncached-minus @ 0xef535000-0xef536000
> uncached-minus @ 0xef537000-0xef538000
> uncached-minus @ 0xef538000-0xef539000
> uncached-minus @ 0xef538000-0xef539000
> uncached-minus @ 0xef538000-0xef539000
> uncached-minus @ 0xef539000-0xef53a000
> uncached-minus @ 0xef539000-0xef53a000
> uncached-minus @ 0xef539000-0xef53a000
> uncached-minus @ 0xef53a000-0xef53b000
> uncached-minus @ 0xf0000000-0xf8000000
> uncached-minus @ 0xf00e0000-0xf00e1000
> uncached-minus @ 0xf0100000-0xf0101000
> uncached-minus @ 0xf0101000-0xf0102000
> uncached-minus @ 0xfdac0000-0xfdad0000
> uncached-minus @ 0xfdae0000-0xfdaf0000
> uncached-minus @ 0xfdaf0000-0xfdb00000
> uncached-minus @ 0xfdc43000-0xfdc44000
> uncached-minus @ 0xfe000000-0xfe001000
> uncached-minus @ 0xfe000000-0xfe001000
> uncached-minus @ 0xfed00000-0xfed01000
> uncached-minus @ 0xfed15000-0xfed16000
> uncached-minus @ 0xfed40000-0xfed41000
> uncached-minus @ 0xfed90000-0xfed91000
> uncached-minus @ 0xfed91000-0xfed92000
> 
> Is that the info you were looking for?

Yes, can you check if the failing device BAR is included in any of the
above entries? If not then it is probably not related.
