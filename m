Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAC1AzdfFjPrfvg2iBYXY5JDKhbVH3LPQdh5LzyjMaBFSNDBi6Q@mail.gmail.com>
References: <1436565766-21820-1-git-send-email-jordan_hargrave@dell.com>
	<20150713093518.7e869d07@endymion.delvare>
	<CAC1AzdfFjPrfvg2iBYXY5JDKhbVH3LPQdh5LzyjMaBFSNDBi6Q@mail.gmail.com>
Date: Mon, 13 Jul 2015 10:11:43 -0500
Message-ID: <CAC1AzddMRd4qHXfFO=_rJ-p3R=4A5oBbE99zuSgWOq2EL8MrLg@mail.gmail.com>
Subject: Re: [PATCH] Add support for reading SMBIOS Slot number for PCI devices
From: Jordan Hargrave <jharg93@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Jordan Hargrave <Jordan_Hargrave@dell.com>
Content-Type: text/plain; charset=UTF-8
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 13, 2015 at 2:35 AM, Jean Delvare <jdelvare@suse.de> wrote:
>
> Hi Jordan,
>
 On Fri, 10 Jul 2015 17:02:46 -0500, Jordan Hargrave wrote:
 > From: Jordan Hargrave <Jordan_Hargrave@dell.com>
> >
> > There currently isn't an easy way to determine which PCI devices belong
> > to
> > system slots.  This patch adds support to read SMBIOS Type 9 (System
> > Slots).
>
> I'm wondering, can't you use dmidecode or libsmbios to retrieve the
> same information?
>
> --
> Jean Delvare
> SUSE L3 Support

You can but it's as not easy to determine the slot number for leaf
devices on bridges.  Eventually planning on using this for pulling
slot number for identifying network cards and disk numbering for
systemd
