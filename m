Return-Path: <SRS0=mSZn=2T=fb.com=prvs=424240a948=wzhang@kernel.org>
Return-Path: <SRS0=mSZn=2T=fb.com=prvs=424240a948=wzhang@kernel.org>
From: Wei Zhang <wzhang@fb.com>
To: Logan Gunthorpe <logang@deltatee.com>, Bjorn Helgaas <helgaas@kernel.org>
CC: Keith Busch <keith.busch@intel.com>, Myron Stowe <myron.stowe@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas
	<bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jonathan
 Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew
 Morton <akpm@linux-foundation.org>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Guenter Roeck
	<linux@roeck-us.net>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ryusuke Konishi
	<konishi.ryusuke@lab.ntt.co.jp>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        Kurt Schwemmer
	<kurt.schwemmer@microsemi.com>,
        Stephen Bates <stephen.bates@microsemi.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 0/4] New Microsemi PCI Switch Management Driver
Date: Fri, 10 Mar 2017 00:21:49 +0000
Message-ID: <48F91B98-32A0-43CB-9F03-A617242AEE55@fb.com>
References: <1488497074-14186-1-git-send-email-logang@deltatee.com>
 <20170309195531.GB19517@bhelgaas-glaptop.roam.corp.google.com>
 <e01826a0-6c81-6bce-b633-5033da66f401@deltatee.com>
In-Reply-To: <e01826a0-6c81-6bce-b633-5033da66f401@deltatee.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

VGhpcyBpcyBncmVhdCEgIFRoYW5rcyBCam9ybiBhbmQgTG9nYW4gZm9yIGdldHRpbmcgdGhpcyBk
cml2ZXJzIHVwc3RyZWFtZWQhDQoNCi1XZWkNCg0KLS0NCndlaSB6aGFuZyB8IHNvZnR3YXJlIGVu
Z2luZWVyIHwgZmFjZWJvb2sNCnd6aGFuZ0BmYi5jb20gfCAoNDA4KSA0NjAtNDgwMw0KDQpPbiAz
LzkvMTcsIDExOjU2IEFNLCAiTG9nYW4gR3VudGhvcnBlIiA8bG9nYW5nQGRlbHRhdGVlLmNvbT4g
d3JvdGU6DQoNCiAgICANCiAgICANCiAgICBPbiAwOS8wMy8xNyAxMjo1NSBQTSwgQmpvcm4gSGVs
Z2FhcyB3cm90ZToNCiAgICA+IEFwcGxpZWQgdG8gcGNpL3N3aXRjaHRlYyBmb3IgdjQuMTIsIHRo
YW5rcyENCiAgICANCiAgICBHcmVhdCEgVGhhbmtzIHNvIG11Y2ghDQogICAgDQogICAgTG9nYW4N
CiAgICANCiAgICANCg0K
