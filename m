Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:38712 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755557AbbGUQ6F (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jul 2015 12:58:05 -0400
Received: by iggf3 with SMTP id f3so112585356igg.1
        for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2015 09:58:04 -0700 (PDT)
Date: Tue, 21 Jul 2015 11:57:59 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Jordan Hargrave <jharg93@gmail.com>
Cc: Jean Delvare <jdelvare@suse.de>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Jordan Hargrave <Jordan_Hargrave@dell.com>
Subject: Re: [PATCH] Add support for reading SMBIOS Slot number for PCI
 devices
Message-ID: <20150721165759.GD21967@google.com>
References: <1436565766-21820-1-git-send-email-jordan_hargrave@dell.com>
 <20150713093518.7e869d07@endymion.delvare>
 <CAC1AzdfFjPrfvg2iBYXY5JDKhbVH3LPQdh5LzyjMaBFSNDBi6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAC1AzdfFjPrfvg2iBYXY5JDKhbVH3LPQdh5LzyjMaBFSNDBi6Q@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 13, 2015 at 09:57:32AM -0500, Jordan Hargrave wrote:
> On Mon, Jul 13, 2015 at 2:35 AM, Jean Delvare <jdelvare@suse.de> wrote:
> 
> > Hi Jordan,
> >
> > On Fri, 10 Jul 2015 17:02:46 -0500, Jordan Hargrave wrote:
> > > From: Jordan Hargrave <Jordan_Hargrave@dell.com>
> > >
> > > There currently isn't an easy way to determine which PCI devices belong
> > to
> > > system slots.  This patch adds support to read SMBIOS Type 9 (System
> > Slots).
> >
> > I'm wondering, can't you use dmidecode or libsmbios to retrieve the
> > same information?
> >
> > --
> > Jean Delvare
> > SUSE L3 Support
> >
> 
> You can but it's as not easy to determine the slot number for leaf devices
> on bridges.  Eventually planning on using this for pulling slot number for
> identifying network cards and disk numbering for systemd

Can you outline the problems with using dmidecode or libsmbios?
