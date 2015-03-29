Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1427644146.2715.16.camel@perches.com>
Subject: Re: [PATCH 01/86] pci: export pci_ids.h
From: Joe Perches <joe@perches.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"David S. Miller" <davem@davemloft.net>,
	Hans Verkuil <hans.verkuil@cisco.com>,
	Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
	Alexei Starovoitov <ast@plumgrid.com>,
	stephen hemminger <stephen@networkplumber.org>,
	Masahiro Yamada <yamada.m@jp.panasonic.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andy Lutomirski <luto@amacapital.net>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Stephane Eranian <eranian@google.com>,
	Huang Rui <ray.huang@amd.com>,
	Peter Neubauer <pneubauer@bluerwhite.org>,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-api@vger.kernel.org
Date: Sun, 29 Mar 2015 08:49:06 -0700
In-Reply-To: <1427635734-24786-2-git-send-email-mst@redhat.com>
References: <1427635734-24786-1-git-send-email-mst@redhat.com>
	 <1427635734-24786-2-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, 2015-03-29 at 15:37 +0200, Michael S. Tsirkin wrote:
> The macros in pci_ids.h are pretty useful for userspace
> using the pci sysfs interface.
[]
>  include/linux/pci_ids.h      | 2998 +-----------------------------------------
>  include/uapi/linux/pci_ids.h | 2997 +++++++++++++++++++++++++++++++++++++++++

Hello Michael.

When sending patches, please use "git format-patch -M"


