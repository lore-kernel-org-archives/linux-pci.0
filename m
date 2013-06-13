Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <51B9467B.7080902@huawei.com>
References: <CAErSpo6v0mj9=Q13d=G4hho0mb9XTcsmefzke9fROYmZ7oBWxQ@mail.gmail.com>
 <CAE9FiQVqKag2TGah7x_1MAJ+c0UWgywgM_jKUoOnh+rq3bwBhg@mail.gmail.com>
 <CAE9FiQVMgdj5edbR4qZny29fV9-bW_We_G4Wpn_yruDLQZiQiQ@mail.gmail.com>
 <20130329032200.GA11990@google.com> <CAE9FiQVu5QyxaKsYzzQoroQD=TvsziHzDOtoeg=FvhZ8HyN5yw@mail.gmail.com>
 <CAErSpo7ChfRiEn0eR1rf-mVheUS9Yf8f+j4n78PJcGYh+yMVgA@mail.gmail.com>
 <CAE9FiQXkDg7Y336S=DXoms44=5HLaiUx=sWviupz1fJmaDUEzQ@mail.gmail.com>
 <CAE9FiQU5c=ztzbskNnYFFKF9V5zO+jnRcMBCivLxA1F3fSfX5w@mail.gmail.com>
 <20130401235256.GA31966@google.com> <CAE9FiQV8cPh-s6=EQu_cZTtn86+NwZE5KuGMhf43aOhzkL=hwA@mail.gmail.com>
 <CAErSpo7Jni1ZSf_W=vB3kqsucPpoepa2Q5g=77a6D3FaPwe9LA@mail.gmail.com>
 <CAE9FiQWjQXwiTWju6cBc_o25jy_wmZ1u+Pifh1wdnxtV=i5ENw@mail.gmail.com>
 <CAErSpo7=a-wX6BLbm_O1nUMMrQHOgtSm3xZHKuRqaz8rnKSbRA@mail.gmail.com>
 <CAE9FiQUbw7OUhRB+gKMxkuE9+nm9097+mwZ2z4adO8Hv_NjF1Q@mail.gmail.com>
 <CAErSpo7gL3Ds9oq8ZZ4zdt1uHy9xbkWJE+Ja=-0QXFQECjr40A@mail.gmail.com> <51B9467B.7080902@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 13 Jun 2013 07:57:31 -0600
Message-ID: <CAErSpo5j52u-6YNVa2K3usC4qjbz99iyHY1SKvrsJSQRkzM0CA@mail.gmail.com>
Subject: Re: [PATCH] PCI: Remove not needed check in disable aspm link
To: "Jiang Liu (Gerry)" <jiang.liu@huawei.com>
Cc: Yinghai Lu <yinghai@kernel.org>,
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

On Wed, Jun 12, 2013 at 10:11 PM, Jiang Liu (Gerry)
<jiang.liu@huawei.com> wrote:
> Hi Bjorn,
>     I'm working on several acpiphp related bugfixes, and feel some
> are materials for 3.10 too. Actually we have identified four bugs
> related to dock station support on Sony VAIO VPCZ23A4R laptop.
> I will try to send out patchset to address these bugs tonight.
> Seems we really need to rethink about acpiphp and pciehp now.

We certainly need more rework in acpiphp and pciehp.  But unless it's
an obvious fix for a serious regression, I'm doubtful about putting it
in 3.10.  rc6 is imminent and it's not the time to be putting
significant changes in.

I don't know the details of the dock issues, but you might not need to
be in a huge rush about them.

Bjorn
