Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAErSpo7gL3Ds9oq8ZZ4zdt1uHy9xbkWJE+Ja=-0QXFQECjr40A@mail.gmail.com>
References: <CAErSpo6v0mj9=Q13d=G4hho0mb9XTcsmefzke9fROYmZ7oBWxQ@mail.gmail.com>
	<CAE9FiQU7cDzJdHxmqhJNgc9UCsRLgvCFQpv8+fLxD79pLEUC5A@mail.gmail.com>
	<CAErSpo4ncW8rkcpDiccORZedj30m7jRmpXK+amfDGn_wjwt7EA@mail.gmail.com>
	<CAE9FiQVqKag2TGah7x_1MAJ+c0UWgywgM_jKUoOnh+rq3bwBhg@mail.gmail.com>
	<CAE9FiQVMgdj5edbR4qZny29fV9-bW_We_G4Wpn_yruDLQZiQiQ@mail.gmail.com>
	<20130329032200.GA11990@google.com>
	<CAE9FiQVu5QyxaKsYzzQoroQD=TvsziHzDOtoeg=FvhZ8HyN5yw@mail.gmail.com>
	<CAErSpo7ChfRiEn0eR1rf-mVheUS9Yf8f+j4n78PJcGYh+yMVgA@mail.gmail.com>
	<CAE9FiQXkDg7Y336S=DXoms44=5HLaiUx=sWviupz1fJmaDUEzQ@mail.gmail.com>
	<CAE9FiQU5c=ztzbskNnYFFKF9V5zO+jnRcMBCivLxA1F3fSfX5w@mail.gmail.com>
	<20130401235256.GA31966@google.com>
	<CAE9FiQV8cPh-s6=EQu_cZTtn86+NwZE5KuGMhf43aOhzkL=hwA@mail.gmail.com>
	<CAErSpo7Jni1ZSf_W=vB3kqsucPpoepa2Q5g=77a6D3FaPwe9LA@mail.gmail.com>
	<CAE9FiQWjQXwiTWju6cBc_o25jy_wmZ1u+Pifh1wdnxtV=i5ENw@mail.gmail.com>
	<CAErSpo7=a-wX6BLbm_O1nUMMrQHOgtSm3xZHKuRqaz8rnKSbRA@mail.gmail.com>
	<CAE9FiQUbw7OUhRB+gKMxkuE9+nm9097+mwZ2z4adO8Hv_NjF1Q@mail.gmail.com>
	<CAErSpo7gL3Ds9oq8ZZ4zdt1uHy9xbkWJE+Ja=-0QXFQECjr40A@mail.gmail.com>
Date: Wed, 12 Jun 2013 22:47:08 -0700
Message-ID: <CAE9FiQWDDqcUwNDfOgBKOLrm7K811P=foK3-ZavFEkdUj=bSDg@mail.gmail.com>
Subject: Re: [PATCH] PCI: Remove not needed check in disable aspm link
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jiang Liu <jiang.liu@huawei.com>,
	Roman Yepishev <roman.yepishev@gmail.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 12, 2013 at 8:50 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Wed, Jun 12, 2013 at 1:41 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>
> I think you're saying that in systems that support both acpiphp and
> pciehp, we should be using pciehp, but we currently use acpiphp.  If
> so, that's certainly a bug.  How serious is it?  Is it a disaster if
> we use acpiphp until we can resolve this cleanly?  Are there a lot of
> systems that claim to support acpiphp but it doesn't actually work?

No sure. To make acpiphp would need more expertise in bios.
Normally BIOS vendor would have half done work there, and will need
OEM or system vendor have someone to make it work ....
You would not want to read asl code in DSDT to help them out.
That is not something that we can control.

Yinghai
