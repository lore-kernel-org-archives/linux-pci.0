Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:59039 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019Ab3LQAx5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 Dec 2013 19:53:57 -0500
Received: by mail-ig0-f171.google.com with SMTP id c10so5101356igq.4
        for <linux-pci@vger.kernel.org>; Mon, 16 Dec 2013 16:53:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1386558448.5159.10.camel@pasglop>
References: <20131009163304.62b439a9@endymion.delvare> <CAErSpo6ikaTXXvWzX_Z0=mabwD4aedoLoSVjsd+_E5kV9YJpuA@mail.gmail.com>
 <CAE9FiQWGWPVO0W5e9qtbMx7PTEKDq8kUPi1RRT8tucMEy7prYw@mail.gmail.com> <1386558448.5159.10.camel@pasglop>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 16 Dec 2013 17:53:36 -0700
Message-ID: <CAErSpo5_jutwqr=5OuD3rT_v8fyMzGbdq0P3PUJmSMMDpqAbPQ@mail.gmail.com>
Subject: Re: [PATCH] PCI/portdrv: Set master earlier
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Yinghai Lu <yinghai@kernel.org>, Jean Delvare <jdelvare@suse.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Dec 8, 2013 at 8:07 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Sat, 2013-12-07 at 19:26 -0800, Yinghai Lu wrote:
>> BenH mentioned that get_port_device_capability have some problem on
>> powerpc and will return null.
>
> Well, it has problems on anything that doesn't have ACPI :-)
>
> I don't care what the "right" fix is but we need to makes sure nobody
> does a pci_enable_device() on a bridge and doesn't also enable bus
> master, otherwise the bridge bus master will never be set. This is what
> was happening an breaking us.

I assume there's nothing more I need to do here.  If there is, please
let me know.

Bjorn
