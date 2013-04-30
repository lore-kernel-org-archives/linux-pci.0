Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:59372 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932711Ab3D3TH6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 30 Apr 2013 15:07:58 -0400
Date: Tue, 30 Apr 2013 12:14:14 -0700
From: Bin Gao <bin.gao@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"x86@kernel.org" <x86@kernel.org>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: x86/pci/mrst: force all pci config toward 0:0:0, 0:2:0 and 0:3:0
 to type 1
Message-ID: <20130430191414.GA30073@bingao-desk1.fm.intel.com>
References: <20130430072147.GA37866@bingao-desk1.fm.intel.com>
 <CAErSpo6sY_BejDqgO1Qsko7qH+oKn+wAbu5MnhE8zQeQCc7Qng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo6sY_BejDqgO1Qsko7qH+oKn+wAbu5MnhE8zQeQCc7Qng@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 30, 2013 at 11:32:03AM -0600, Bjorn Helgaas wrote:
> On Tue, Apr 30, 2013 at 1:21 AM, Bin Gao <bin.gao@linux.intel.com> wrote:
> > x86/pci/mrst: force all pci config access toward 0:0:0, 0:2:0 and 0:3:0 to type 1
> >
> > For real pci devices 0:0:0, 0:2:0 and 0:3:0, there is either no pci shim, or
> > no guarantee of data correctness of offset 256-4k. So for whatever reason,
> > Linux kernel should not do MMCFG pci config access to those devices. Instead,
> > always use type 1 for those devices.
> >
> > Signed-off-by: Bin Gao <bin.gao@linux.intel.com>

Thanks.
