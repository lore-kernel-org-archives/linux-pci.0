Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nikam.ms.mff.cuni.cz ([195.113.20.16]:44491 "EHLO
	nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754875AbbDGNEK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 7 Apr 2015 09:04:10 -0400
Date: Tue, 7 Apr 2015 14:57:19 +0200
From: Martin Mares <mj@ucw.cz>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"David S. Miller" <davem@davemloft.net>,
	Hans Verkuil <hans.verkuil@cisco.com>,
	Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
	Alexei Starovoitov <ast@plumgrid.com>,
	stephen hemminger <stephen@networkplumber.org>,
	Masahiro Yamada <yamada.m@jp.panasonic.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	linux-api@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] pci: export class IDs from pci_ids.h
Message-ID: <mj+md-20150407.125023.43354.nikam@ucw.cz>
References: <1427714755-16873-1-git-send-email-mst@redhat.com>
 <20150402205347.GA10892@google.com>
 <20150402232804-mutt-send-email-mst@redhat.com>
 <CAErSpo7Wtg2QTznd7RpqXrGO7BL7OekE89iH6CvuXsC6gyVXWg@mail.gmail.com>
 <20150405132041-mutt-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150405132041-mutt-send-email-mst@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello!

> That's a good idea. Martin, could you please answer the following:
> assuming that linux exported linux/pci_ids.h providing class
> IDs that are currently in /usr/include/pci/header.h
> in a header /usr/include/linux/pci_ids.h,
> would libpci be open to replacing part of
> /usr/include/pci/header.h with #include <linux/pci_ids.h>,
> assuming that a solution for old systems that lack this
> header is also provided?

Please remember that libpci is cross-platform. Your proposal would make it
use <linux/pci_ids.h> on Linux and provide its own definitions on all other
systems, which is likely to bring less consistency, not more.

I do not see any point in using kernel headers for things, which are unrelated
to the kernel.

> pciutils does nothing with this value itself, it's possible for a distro
> to ship a wrong header, and no one will notice. OTOH Linux will break if
> it's wrong.  In fact there are 3 values libpci does appear to use
> internally:
> PCI_CLASS_BRIDGE_HOST
> PCI_CLASS_DISPLAY_VGA
> PCI_CLASS_BRIDGE_PCI
> 
> I'm guessing others are re-exported for the benefit of
> applications using libpci.

Exactly. And I expect that it will be quite similar with the kernel --
most classes defined in <linux/pci_ids.h> are not likely to be used anywhere
in the kernel.

				Martin
