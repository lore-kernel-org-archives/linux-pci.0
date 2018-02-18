Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-db5eur01on0107.outbound.protection.outlook.com ([104.47.2.107]:27920
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751549AbeBRVpw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 18 Feb 2018 16:45:52 -0500
Date: Mon, 19 Feb 2018 00:45:40 +0300
From: "viktor.prutyanov" <viktor.prutyanov@virtuozzo.com>
To: Martin Mares <mj@ucw.cz>
Cc: <linux-pci@vger.kernel.org>, dmonakhov@openvz.org
Subject: Re: [PATCH v2 0/2] lspci: Add support of JSON output format
Message-ID: <20180219004540.47d0fa1f@virtuozzo.com>
In-Reply-To: <mj+md-20180215.103138.21596.nikam@ucw.cz>
References: <20180214160741.8958-1-viktor.prutyanov@virtuozzo.com>
        <mj+md-20180215.103138.21596.nikam@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

=D0=92 Thu, 15 Feb 2018 11:32:55 +0100
Martin Mares <mj@ucw.cz> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> Hello!
>=20
> > This collection of patches adds support of printing PCI info in
> > JSON format =20
>=20
> First of all, I would really like to hear the reasons behind that --
> especially why the current machine-readable format is not sufficient.
>=20
> Generally, adding 1000 lines of code which duplicate a lot of existing
> logic should have a strong reason.
>=20
> 				Have a nice fortnight

Hello!

Because current machine-readable format is very limited and it is
difficult to extend it to support verbosity options.

JSON is defacto standard structured format. The key JSON's advantage is
good portability and extensibility and rich toolchain support. Almost
every modern utility has JSON format support for output, for example
lsblk and lscpu.

For example here is how structured -vv output looks like:
$ ./lspci -Jvv | python -m json.tool

JSON has nice tool called 'jq' which is basically Swiss-knife parser.
For example you can output some fields you need as tsv:
$ ./lspci -J -vv | jq -r '.[][] | [.Slot, .Device, .IRQ] | @tsv'

...
00:14.0	8 Series USB xHCI HC	41
03:00.0	RTL8411B PCI Express Card Reader	43
04:00.0	GK107M [GeForce GT 750M] 255
...

Or let's reformat part of input structure to another structure you need:
$ ./lspci -Jvv | jq '.[][3] | {dev:.Device, class:.Class, irq:.IRQ}'

{
  "dev": "Haswell-ULT HD Audio Controller",
  "class": "Audio device",
  "irq": "48"
}

The patch is large mostly because current lspci use add-hoc output
approach. So patch add skeleton which construct structured object
separately from printing. Objects can later be easily extended to
support new fields and output formats (not only JSON).
