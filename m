Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:19642 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753966AbbFCViJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 3 Jun 2015 17:38:09 -0400
Date: Wed, 3 Jun 2015 21:37:52 +0000 (UTC)
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
cc: Keith Busch <keith.busch@intel.com>,
	Pavilion Storage <storagepavilion@gmail.com>,
	linux-nvme <linux-nvme@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Problems writing to intel P3700 NVMe drive
In-Reply-To: <CAErSpo5HkLA8Yh0QeBPXL_64GaO+VcSugNHmCLR_UT+6mdM3JA@mail.gmail.com>
Message-ID: <alpine.LNX.2.00.1506032132350.15930@localhost.lm.intel.com>
References: <CAFMq3wEyk9PMbD8Cgn5trJyDjaOKpMzR-TNzbx0zXN=Mms573Q@mail.gmail.com> <00c601d098cd$41255e30$c3701a90$@storageio.com> <CAFMq3wE7PzKs=dYxxUhFsHeTkR0CT8mh6NVfrk-9mKxdisoDTg@mail.gmail.com> <00cd01d098d1$94047010$bc0d5030$@storageio.com>
 <CAFMq3wEa=kxznE77oFdg03QBHqszmH5-Vvmmm9pW1nkPUZi_Og@mail.gmail.com> <CA+At7pWf6Ge3pc7=aeiqz=iWxtYJSPVdM_W2XW9pL4d22q432Q@mail.gmail.com> <000a01d098ee$b52ce0c0$1f86a240$@storageio.com> <CAFMq3wH67yMqWGcde77kiyWJ6_ieZjVyhc8L-oq1e_b4x5mS7w@mail.gmail.com>
 <alpine.LNX.2.00.1505282059400.15930@localhost.lm.intel.com> <alpine.LNX.2.00.1506032000570.15930@localhost.lm.intel.com> <CAErSpo5HkLA8Yh0QeBPXL_64GaO+VcSugNHmCLR_UT+6mdM3JA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 3 Jun 2015, Bjorn Helgaas wrote:
> On Wed, Jun 3, 2015 at 3:10 PM, Keith Busch <keith.busch@intel.com> wrote:
>> A while back, there were a few proposals on changing the pci driver's
>> default MPS tuning from the existing do-nothing policy to something
>> safe so end-users don't need to remember kernel parameters as described
>> below. Is this still active, or can we kick that back to life if not?
>
> I'd love to see some activity there.  Somebody else asked me about
> this a few weeks ago, and I sent him this list of some of the things I
> think are wrong with the current situation:

Thanks for the update. I got in contact with some comrades already working
on this, so we'll post an updated proposal when it's ready. This feature
is getting more attention with broader hot plug pci-e storage usage (among
other reasons), so I'm sure we'll give this its due consideration this time.
