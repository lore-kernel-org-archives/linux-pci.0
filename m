Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAB=NE6Vx97T2PhYnqANopvqn1Qptv4DO8deb9=Lqe9iQQx04Kg@mail.gmail.com>
References: <1432163293-20965-1-git-send-email-mcgrof@do-not-panic.com>
 <1432163293-20965-2-git-send-email-mcgrof@do-not-panic.com>
 <20150521223321.GG32152@google.com> <20150522002341.GM23057@wotan.suse.de>
 <20150526174008.GN32152@google.com> <20150527200402.GS23057@wotan.suse.de>
 <CAB=NE6Xyd-THK2385W7VfS358PSJfkfHRnjoZRJWP_LFrzOWJA@mail.gmail.com>
 <CAB=NE6Ut4QNmumYJku=At9QC==kAMzFZP-ANHWd3EWKY-tKHBA@mail.gmail.com>
 <CAErSpo4sHA-f83X1nW2QdLT9GdubFXCQ7UEJmSfFc5GBjj8FSA@mail.gmail.com> <CAB=NE6Vx97T2PhYnqANopvqn1Qptv4DO8deb9=Lqe9iQQx04Kg@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 19 Jun 2015 16:18:04 -0500
Message-ID: <CAErSpo7CNH1WpgqJCEU8EtxiFNp_PiQ3cBwnKiWQpUaD-fd4YA@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] pci: add pci_iomap_wc() variants
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@elte.hu>,
	Toshi Kani <toshi.kani@hp.com>,
	Christoph Hellwig <hch@infradead.org>,
	Tomi Valkeinen <tomi.valkeinen@ti.com>,
	Dave Airlie <airlied@linux.ie>,
	linux-fbdev <linux-fbdev@vger.kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>,
	Suresh Siddha <sbsiddha@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juergen Gross <jgross@suse.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Airlie <airlied@redhat.com>,
	Antonino Daplas <adaplas@gmail.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	venkatesh.pallipadi@intel.com,
	Stefan Bader <stefan.bader@canonical.com>,
	=?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <syrjala@sci.fi>,
	Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
	Borislav Petkov <bp@suse.de>, Davidlohr Bueso <dbueso@suse.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	=?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
	David Vrabel <david.vrabel@citrix.com>,
	Jan Beulich <jbeulich@suse.com>,
	=?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Andi Kleen <andi@firstfloor.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 19, 2015 at 4:06 PM, Luis R. Rodriguez
<mcgrof@do-not-panic.com> wrote:

> I hope to have provided a bit of new information to help you
> reconsider this series to go through you but since you seem to be fine
> for this to go through another tree and since I failed to notice that
> I should also get Arnd's Ack I am in hopes this might be able to go
> through Arnd's tree if not through you. Please let me know, in case I
> have to resubmit to Arnd.

If you want to have Arnd merge it, that's fine with me.

Bjorn
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
Please read the FAQ at  http://www.tux.org/lkml/
