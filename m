Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53517 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751659AbbC3LmB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 30 Mar 2015 07:42:01 -0400
Date: Mon, 30 Mar 2015 13:41:28 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
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
Subject: Re: [PATCH 01/86] pci: export pci_ids.h
Message-ID: <20150330134002-mutt-send-email-mst@redhat.com>
References: <20150330083707-mutt-send-email-mst@redhat.com>
 <20150330065522.GA10105@kroah.com>
 <20150330085617-mutt-send-email-mst@redhat.com>
 <20150330075331.GA17823@kroah.com>
 <20150330101830-mutt-send-email-mst@redhat.com>
 <20150330100744.GA16291@kroah.com>
 <20150330123051-mutt-send-email-mst@redhat.com>
 <20150330105707.GA17979@kroah.com>
 <20150330130020-mutt-send-email-mst@redhat.com>
 <20150330113516.GA19501@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150330113516.GA19501@kroah.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 30, 2015 at 01:35:16PM +0200, Greg KH wrote:
> On Mon, Mar 30, 2015 at 01:19:14PM +0200, Michael S. Tsirkin wrote:
> > Why there much more that two packages, I can find
> > at least 5 copies in the wild. Why? I think it's because it's part of
> > linux ABI that doesn't have matching headers. People are asked to build
> > their own, so of course they copy each other.
> > 
> > Once linux exports these headers everyone can stop
> > duplicating each other and others, and just use linux headers too.
> 
> As I'm not the PCI maintainer anymore, I'll let Bjorn decide about this.
> 
> But, your original patch series isn't ok, we don't want to export the
> pci vendor/device ids to userspace, that isn't the job of the kernel to
> do so.  If we should be exporting the pci class and config structures or
> not is Bjorn's decision.
> 
> greg k-h


I sent v2 doing exactly that.
Thanks a lot for the review.

-- 
MST
